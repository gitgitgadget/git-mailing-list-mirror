Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D43202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 01:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423883AbdKRBKF (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 20:10:05 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:51386 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763026AbdKRBKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 20:10:04 -0500
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Nov 2017 20:10:04 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 8A192202F2;
        Sat, 18 Nov 2017 01:01:16 +0000 (UTC)
Date:   Sat, 18 Nov 2017 01:01:16 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v2] rebase: use mboxrd format to avoid split errors
Message-ID: <20171118010116.GA17169@starla>
References: <f54bea17-c245-c644-f974-ca2ac84901c6@redhat.com>
 <20171008213053.GA8568@starla>
 <6a036339-d57d-4cc8-acfc-4e1786763a80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a036339-d57d-4cc8-acfc-4e1786763a80@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I forgot about this for a while :x

Florian Weimer <fweimer@redhat.com> wrote:
> On 10/08/2017 11:30 PM, Eric Wong wrote:
> >diff --git a/git-rebase--am.sh b/git-rebase--am.sh
   <snip, identical change below>

> My context is slightly different, but I added the mboxrd options manually to
> both commands, and it fixes my test case.
> 
> I'm still wondering if I have to be on the lookout for similar issues with
> different strings.

I don't think theres other issues with different strings,
"From " lines are the one known ambiguity problem with mbox and
thus the reason mboxrd was created.

Below is an updated patch which adds a test case:

---------8<---------
Subject: [PATCH] rebase: use mboxrd format to avoid split errors

The mboxrd format allows the use of embedded "From " lines in
commit messages without being misinterpreted by mailsplit

Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Eric Wong <e@80x24.org>
---
 git-rebase--am.sh |  2 ++
 t/t3400-rebase.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 6e64d40d6f..14c50782e0 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -53,6 +53,7 @@ else
 
 	git format-patch -k --stdout --full-index --cherry-pick --right-only \
 		--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter \
+		--pretty=mboxrd \
 		$git_format_patch_opt \
 		"$revisions" ${restrict_revision+^$restrict_revision} \
 		>"$GIT_DIR/rebased-patches"
@@ -83,6 +84,7 @@ else
 	fi
 
 	git am $git_am_opt --rebasing --resolvemsg="$resolvemsg" \
+		--patch-format=mboxrd \
 		$allow_rerere_autoupdate \
 		${gpg_sign_opt:+"$gpg_sign_opt"} <"$GIT_DIR/rebased-patches"
 	ret=$?
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index f5fd15e559..8ac58d5ea5 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -255,4 +255,26 @@ test_expect_success 'rebase commit with an ancient timestamp' '
 	grep "author .* 34567 +0600$" actual
 '
 
+test_expect_success 'rebase with "From " line in commit message' '
+	git checkout -b preserve-from master~1 &&
+	cat >From_.msg <<EOF &&
+Somebody embedded an mbox in a commit message
+
+This is from so-and-so:
+
+From a@b Mon Sep 17 00:00:00 2001
+From: John Doe <nobody@example.com>
+Date: Sat, 11 Nov 2017 00:00:00 +0000
+Subject: not this message
+
+something
+EOF
+	>From_ &&
+	git add From_ &&
+	git commit -F From_.msg &&
+	git rebase master &&
+	git log -1 --pretty=format:%B >out &&
+	test_cmp From_.msg out
+'
+
 test_done
-- 
EW
