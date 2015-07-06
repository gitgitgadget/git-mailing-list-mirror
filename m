From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/23] checkout: fix bug with --to and relative HEAD
Date: Mon,  6 Jul 2015 13:30:45 -0400
Message-ID: <1436203860-846-9-git-send-email-sunshine@sunshineco.com>
References: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 19:31:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCAF7-0007f6-7C
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 19:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbbGFRbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 13:31:41 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38848 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbbGFRbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 13:31:37 -0400
Received: by igrv9 with SMTP id v9so121038977igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9+RIr4XyVMrGUAxp4hWZYvv/5Dm+h2bbg+XfYCBNec8=;
        b=g+RSg4nTp2FyaGJPyWDKsICgN8RvqEeF+qW9pgh8ZBpcAlrmVAtfeHPYIERi50Dbp8
         HyRHMAWg344d5EBWXCFdOKp3Hmg0e9DZKFwMPzk3Zh8lfiiCGpFSv1ko+aoq3nbBGI4s
         wQNrnlHeoM6SXpvQ6hs7ilo25eZqF3GUCd+inryD0o8PMUDm6NrfOxVK6FmgK+gD+fmB
         3vOkiQUnlv9tZvVLCxy/JPwZ9Lqp52XMPYWmcU0O0PXUR6W6RTMhJ9+DcIewKYx7Ehjw
         cWPO4qzg0Hi2AMIed1gmjkSDB5vqviAIinHZW9ooJQrhl0LBYS5DgIVn8fM1HZSF8eUF
         ZwEg==
X-Received: by 10.50.3.6 with SMTP id 6mr48723364igy.28.1436203896719;
        Mon, 06 Jul 2015 10:31:36 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g18sm12861567iod.5.2015.07.06.10.31.35
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2015 10:31:36 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1436203860-846-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273416>

Given "git checkout --to <path> HEAD~1", the new worktree's HEAD should
begin life at the current branch's HEAD~1, however, it actually ends up
at HEAD~2. This happens because:

    1. git-checkout resolves HEAD~1

    2. to satisfy is_git_directory(), prepare_linked_worktree() creates
       a HEAD for the new worktree with the value of the resolved HEAD~1

    3. git-checkout re-invokes itself with the same arguments within the
       new worktree to populate the worktree

    4. the sub git-checkout resolves HEAD~1 relative to its own HEAD,
       which is the resolved HEAD~1 from the original invocation,
       resulting unexpectedly and incorrectly in HEAD~2 (relative to the
       original)

Fix this by unconditionally assigning the current worktree's HEAD as the
value of the new worktree's HEAD.

As a side-effect, this change also eliminates a dependence within
prepare_linked_checkout() upon 'struct branch_info'. The plan is to
eventually relocate "git checkout --to" functionality to "git worktree
add", and worktree.c won't have knowledge of 'struct branch_info', so
removal of this dependency is a step toward that goal.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c     | 16 ++++++++++++----
 t/t2025-checkout-to.sh | 10 ++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2079aa4..5ada22a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -863,6 +863,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	struct stat st;
 	struct child_process cp;
 	int counter = 0, len, ret;
+	unsigned char rev[20];
 
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -920,13 +921,20 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 		   real_path(get_git_common_dir()), name);
 	/*
 	 * This is to keep resolve_ref() happy. We need a valid HEAD
-	 * or is_git_directory() will reject the directory. Any valid
-	 * value would do because this value will be ignored and
-	 * replaced at the next (real) checkout.
+	 * or is_git_directory() will reject the directory. Moreover, HEAD
+	 * in the new worktree must resolve to the same value as HEAD in
+	 * the current tree since the command invoked to populate the new
+	 * worktree will be handed the branch/ref specified by the user.
+	 * For instance, if the user asks for the new worktree to be based
+	 * at HEAD~5, then the resolved HEAD~5 in the new worktree must
+	 * match the resolved HEAD~5 in the current tree in order to match
+	 * the user's expectation.
 	 */
+	if (!resolve_ref_unsafe("HEAD", 0, rev, NULL))
+		die(_("unable to resolve HEAD"));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
-	write_file(sb.buf, 1, "%s\n", sha1_to_hex(new->commit->object.sha1));
+	write_file(sb.buf, 1, "%s\n", sha1_to_hex(rev));
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
 	write_file(sb.buf, 1, "../..\n");
diff --git a/t/t2025-checkout-to.sh b/t/t2025-checkout-to.sh
index a8d9336..0fd731b 100755
--- a/t/t2025-checkout-to.sh
+++ b/t/t2025-checkout-to.sh
@@ -134,4 +134,14 @@ test_expect_success 'checkout with grafts' '
 	test_cmp expected actual
 '
 
+test_expect_success 'checkout --to from relative HEAD' '
+	test_commit a &&
+	test_commit b &&
+	test_commit c &&
+	git rev-parse HEAD~1 >expected &&
+	git checkout --to relhead HEAD~1 &&
+	git -C relhead rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.5.0.rc1.197.g417e668
