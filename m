Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7120C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 17:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJCR2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 13:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJCR2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 13:28:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43BA3AE40
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 10:27:38 -0700 (PDT)
Received: (qmail 32432 invoked by uid 109); 3 Oct 2022 17:27:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Oct 2022 17:27:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27078 invoked by uid 111); 3 Oct 2022 17:27:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Oct 2022 13:27:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Oct 2022 13:27:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "Michael V. Scovetta" <michael.scovetta@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer: detect author name errors in
 read_author_script()
Message-ID: <YzsbiRcCEaJUGwdp@coredump.intra.peff.net>
References: <CADG3Mza_QU+ceTUsMYxJ3PzsEqi8M98oOBAzzz0GHRJ-F7vkpA@mail.gmail.com>
 <YzqhEcTDwMwa8dQX@coredump.intra.peff.net>
 <221003.86k05htf84.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221003.86k05htf84.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2022 at 11:40:52AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > +check_broken_author 'unknown key in author-script' '
> > +	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
> > +		>>.git/rebase-merge/author-script'
> > +
> > +
> > +test_done
> 
> Maybe I just have too much PTSD from dealing with shell quoting issues
> with this '"$script"" pattern when you need to pass arguments with
> spaces in it, or even quotes. Although it probably won't ever be an
> issue here.

Quoting-wise, it's the exact same as passing the snippet to
test_expect_success that we already do. Which, granted, is full of
horrors, but is well understood within our code base. The "$script" is
evaluated when we pass the snippet to test_expect_success, which sees
the expansion along with the rest of the script. The double-quotes
around it ensure that whitespace is retained.

There is one extra quirk here, which is that it must not end with a
newline, since we stick "&&" on it.

> +	# Avoid quoting issues
> +	write_script script.sh &&
> +
> +	test_expect_success "$title of '$script'" '
>  		# create conflicted state
>  		test_when_finished "git rebase --abort" &&
>  		git checkout -B tmp branch2 &&
>  		test_must_fail git rebase branch1 &&
>  
> -		# break author-script
> -		'"$script"' &&
> +		./script.sh >tmp &&
> +		mv tmp .git/rebase-merge/author-script &&

One of my goals was that the script be expanded inline so that
verbose-mode showed what the test was actually doing. But this hides it
behind a vague "script.sh". Maybe that's not important enough to merit
the admitted ugliness of the loop+function we have.

If we give that up, then a better option is probably to put the
before/after parts in functions, like:

diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
index e68aac4b36..b92a3ce46b 100755
--- a/t/t3438-rebase-broken-files.sh
+++ b/t/t3438-rebase-broken-files.sh
@@ -11,43 +11,49 @@ test_expect_success 'set up conflicting branches' '
 	test_commit two file
 '
 
-check_broken_author () {
-	title=$1; shift
-	script=$1; shift
-
-	test_expect_success "$title" '
-		# create conflicted state
-		test_when_finished "git rebase --abort" &&
-		git checkout -B tmp branch2 &&
-		test_must_fail git rebase branch1 &&
-
-		# break author-script
-		'"$script"' &&
-
-		# resolving notices broken author-script
-		echo resolved >file &&
-		git add file &&
-		test_must_fail git rebase --continue
-	'
+create_conflict () {
+	test_when_finished "git rebase --abort" &&
+	git checkout -B tmp branch2 &&
+	test_must_fail git rebase branch1
+}
+
+check_resolve_fails () {
+	echo resolved >file &&
+	git add file &&
+	test_must_fail git rebase --continue
 }
 
 for item in NAME EMAIL DATE
 do
-	check_broken_author "detect missing GIT_AUTHOR_$item" '
+	test_expect_success "detect missing GIT_AUTHOR_$item" '
+		create_conflict &&
+
 		grep -v $item .git/rebase-merge/author-script >tmp &&
-		mv tmp .git/rebase-merge/author-script'
+		mv tmp .git/rebase-merge/author-script &&
+
+		check_resolve_fails
+	'
 done
 
 for item in NAME EMAIL DATE
 do
-	check_broken_author "detect duplicate GIT_AUTHOR_$item" '
+	test_expect_success "detect duplicate GIT_AUTHOR_$item" '
+		create_conflict &&
+
 		grep -i $item .git/rebase-merge/author-script >tmp &&
-		cat tmp >>.git/rebase-merge/author-script'
+		cat tmp >>.git/rebase-merge/author-script &&
+
+		check_resolve_fails
+	'
 done
 
-check_broken_author 'unknown key in author-script' '
+test_expect_success 'unknown key in author-script' '
+	create_conflict &&
+
 	echo "GIT_AUTHOR_BOGUS=${SQ}whatever${SQ}" \
-		>>.git/rebase-merge/author-script'
+		>>.git/rebase-merge/author-script &&
 
+	check_resolve_fails
+'
 
 test_done

That makes the boilerplate shorter in the "-v" output but focuses on the
actual modification that breaks the author-script.

-Peff
