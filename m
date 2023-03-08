Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB66C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCHWWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjCHWW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:22:29 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB599C3E18
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:22:06 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id BB8781F47D;
        Wed,  8 Mar 2023 22:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1678314125;
        bh=EIPaJWv023rNlEqoChViZWmZUchiBuffXffyXm/i4xA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrpdIBZlybbw59q+x7Wm5UIRJvFQLOKbdMVpbRfldySEOOHbow5tvmDDwbNIPFJHa
         JrJmp9STknqo+/eCAF9sS7qcckyzQD1aVGY1LTl4fvQmkyBNbSPEQmY0cFJx/c5N//
         zGw5cbKUt3AmLzuz099Td9a9XjtyOeGb/WfTEvRA=
Date:   Wed, 8 Mar 2023 22:22:05 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] fetch: pass --no-write-fetch-head to subprocesses
Message-ID: <20230308222205.M679514@dcvr>
References: <20230308100438.908471-1-e@80x24.org>
 <xmqqwn3rta2c.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn3rta2c.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > Subject: Re: [PATCH] fetch: pass --no-write-fetch-head to subprocesses
> 
> I read the title as saying that "git fetch --recurse-submodules
> --no-write-fetch-head" should propagate the latter option down to
> fetches done in submodules, but looking at the added test, you are
> addressing a different use case, aren't you?  Or are you covering
> both "fetch: honor --no-write-fetch-head when fetching from multiple
> remotes" and "fetch: pass --no-write-fetch-head down to submodules"?

Just multiple remotes, I hardly deal with submodules.

> > It seems a user would expect this option would work regardless
> > of whether it's fetching from a single remote or many.
> 
> This hints that it is only the latter, but if we are covering both
> 
>  (1) the title we have here may be alright.

Yes, I figured so.  I actually considered just using the title
and didn't really feel the need to add a message body

>  (2) the proposed log message should state the change affects both
>      (in a good way).

Updated.

>  (3) the other half may want to be tested in new test as well.

OK, updated t5526, hope it's portable.  I mimicked the
formatting style of each respective test so the diff itself
looks odd between changes to t5514 and t5526 :x

> Thanks.

v2: revised commit message body, test submodules in t5526
---8<---
Subject: [PATCH] fetch: pass --no-write-fetch-head to subprocesses

It seems a user would expect this option would work regardless
of whether it's fetching from a single remote, many remotes,
or recursing into submodules.

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/fetch.c             |  2 ++
 t/t5514-fetch-multiple.sh   |  7 +++++++
 t/t5526-fetch-submodules.sh | 13 +++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a09606b472..78513f1708 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1880,6 +1880,8 @@ static void add_options_to_argv(struct strvec *argv)
 		strvec_push(argv, "--ipv4");
 	else if (family == TRANSPORT_FAMILY_IPV6)
 		strvec_push(argv, "--ipv6");
+	if (!write_fetch_head)
+		strvec_push(argv, "--no-write-fetch-head");
 }
 
 /* Fetch multiple remotes in parallel */
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 54f422ced3..98f034aa77 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -58,6 +58,13 @@ test_expect_success 'git fetch --all' '
 	 test_cmp expect output)
 '
 
+test_expect_success 'git fetch --all --no-write-fetch-head' '
+	(cd test &&
+	rm -f .git/FETCH_HEAD &&
+	git fetch --all --no-write-fetch-head &&
+	test_path_is_missing .git/FETCH_HEAD)
+'
+
 test_expect_success 'git fetch --all should continue if a remote has errors' '
 	(git clone one test2 &&
 	 cd test2 &&
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index b9546ef8e5..8ffb300f2d 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -167,6 +167,19 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
 	verify_fetch_result actual.err
 '
 
+test_expect_success "fetch --recurse-submodules honors --no-write-fetch-head" '
+	(
+		cd downstream &&
+		fh=$(find . -name FETCH_HEAD -type f) &&
+		rm -f $fh &&
+		git fetch --recurse-submodules --no-write-fetch-head &&
+		for f in $fh
+		do
+			test_path_is_missing $f || return 1
+		done
+	)
+'
+
 test_expect_success "submodule.recurse option triggers recursive fetch" '
 	add_submodule_commits &&
 	(
