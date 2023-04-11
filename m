Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D943C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 21:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjDKV6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 17:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKV6s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 17:58:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BC51727
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 14:58:47 -0700 (PDT)
Received: (qmail 13776 invoked by uid 109); 11 Apr 2023 21:58:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Apr 2023 21:58:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11026 invoked by uid 111); 11 Apr 2023 21:58:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Apr 2023 17:58:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Apr 2023 17:58:45 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Infinite loop + memory leak in annotate_refs_with_symref_info
Message-ID: <20230411215845.GA678138@coredump.intra.peff.net>
References: <39035D34-8548-44B0-BBBB-5C36B3876C4A@lophus.org>
 <20230411210633.GA626331@coredump.intra.peff.net>
 <20230411211604.GB626331@coredump.intra.peff.net>
 <ZDXPemH0d3YWnpjL@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDXPemH0d3YWnpjL@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2023 at 05:22:02PM -0400, Taylor Blau wrote:

> > Never mind. I was able to reproduce (I never used klaus, but it's
> > packaged for Debian, so it was pretty easy to do). And yes, the problem
> > still exists today. And bisection confirms it's from 2c6a403.
> 
> Yeah, same here. I hadn't used it either, but it's easily installable
> via pip, too. Indeed, you can see the value of *offset jumping backwards
> in `connect.c::parse_value_value()` (whose caller in this case is
> `connect.c::annotate_refs_with_symref_info()`).

Yep. And Jonas's suggested fix is the right thing. Assigning offset
directly _would_ be the right thing, since we are taking the distance
back to the beginning of the feature_list string. Except that earlier in
the function we incremented feature_list by the incoming value of
the offset!

Here's a test that demonstrates the problem (and passes with the
accompanying code change):

diff --git a/connect.c b/connect.c
index c0c8a38178..5e265ba9d7 100644
--- a/connect.c
+++ b/connect.c
@@ -616,7 +616,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 				if (lenp)
 					*lenp = 0;
 				if (offset)
-					*offset = found + len - feature_list;
+					*offset += found + len - feature_list;
 				return value;
 			}
 			/* feature with a value (e.g., "agent=git/1.2.3") */
@@ -628,7 +628,7 @@ const char *parse_feature_value(const char *feature_list, const char *feature, i
 				if (lenp)
 					*lenp = end;
 				if (offset)
-					*offset = value + end - feature_list;
+					*offset += value + end - feature_list;
 				return value;
 			}
 			/*
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 20d063fb9a..c8422d66e7 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -360,4 +360,39 @@ test_expect_success 'ls-remote prefixes work with all protocol versions' '
 	test_cmp expect actual.v2
 '
 
+test_expect_success 'v0 clients can handle multiple symrefs' '
+	# Git will not generate multiple symref entries for v0 these days, but it
+	# is technically allowed, and we did so until d007dbf7d6 (Revert
+	# "upload-pack: send non-HEAD symbolic refs", 2013-11-18). Test the
+	# client handling here by faking that older behavior.
+	#
+	# Note that our oid is hard-coded to always be sha1, and not using
+	# test_oid. Since our fake capabilities line does not have an
+	# object-format entry, the client will always use sha1 mode.
+	oid=1234567890123456789012345678901234567890 &&
+	symrefs="symref=refs/remotes/origin/HEAD:refs/remotes/origin/main" &&
+	symrefs="$symrefs symref=HEAD:refs/heads/main" &&
+
+	test-tool pkt-line pack >input.q <<-EOF &&
+	$oid HEADQ$symrefs
+	$oid refs/heads/main
+	$oid refs/remotes/origin/HEAD
+	$oid refs/remotes/origin/main
+	0000
+	EOF
+	q_to_nul <input.q >input &&
+
+	cat >expect <<-EOF &&
+	ref: refs/heads/main	HEAD
+	$oid	HEAD
+	$oid	refs/heads/main
+	ref: refs/remotes/origin/main	refs/remotes/origin/HEAD
+	$oid	refs/remotes/origin/HEAD
+	$oid	refs/remotes/origin/main
+	EOF
+
+	git ls-remote --symref --upload-pack="cat input; cat;:" . >actual &&
+	test_cmp expect actual
+'
+
 test_done


I was going to ask if Jonas wanted to wrap this up as a patch, but I
think that's pretty much it right there. :) I'll write up a commit
message for it later tonight.

I also wondered if we tested this multiple-symref case for protocol v2
(where it works fine), but it looks like we may not. There are earlier
tests which _would_ trigger it, but we force them into v0 mode, due to
b2f73b70b2 (t5512: compensate for v0 only sending HEAD symrefs,
2019-02-25). I think we really should be letting ls-remote use the
protocol it prefers (v2 by default, and v0 if the suite is run in that
mode), and the expected output should be adjusted based on the mode.
I'll see if I can do that as well, to make this a two-patch series.

-Peff
