From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/23] checkout: fix bug with --to and relative HEAD
Date: Fri,  3 Jul 2015 20:17:17 -0400
Message-ID: <1435969052-540-9-git-send-email-sunshine@sunshineco.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 02:19:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBBAd-0000G5-M5
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 02:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbbGDAS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 20:18:58 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34293 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908AbbGDASe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 20:18:34 -0400
Received: by igcsj18 with SMTP id sj18so196949280igc.1
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ht4xsUkXc4SMO0IrWEaj4l4XtUZuboLywGoCK+gWJk=;
        b=f0vB2PmV2s3kRyqS8EQSPclEAd2u9N9YDjVwpGHIvcq3j8cJ1sHbuvkTElCPaGg9o4
         2dVXr2cqXSTrEnTUXAxdHc7jGLH+Kcb9Jwsc8eOYj3d4XpeKuRpnUs7+oBviT35YOfS9
         Pk4TtXdRJkcwd26R0y2sEmPqCi4PoJDM58w/nQmnvBQETFl8dyHLFBHuR45MeW44dFF6
         h72M0Xw2BY6a4x+cEaieGxWdoUpb3BlordIGl8vxUvhTT60nkGGEjeT0LsZ+shdTYuj1
         Me+fTdiaBXK5aChsHreSK0mI8eghQXp7i9IGUO3gCEtPrUlcv39WUZL8Rv3cVdsX+VU3
         Tlxg==
X-Received: by 10.50.78.199 with SMTP id d7mr26003795igx.18.1435969113519;
        Fri, 03 Jul 2015 17:18:33 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id z195sm7246110iod.33.2015.07.03.17.18.32
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jul 2015 17:18:33 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.197.g417e668
In-Reply-To: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273324>

Given "git checkout --to <path> HEAD~1", the new worktree's HEAD should
begin life at the current branch's HEAD~1, however, it actually ends up
at HEAD~2. The happens because:

    1. git-checkout resolves HEAD~1

    2. to satisfy is_git_directory, prepare_linked_worktree() creates a
       HEAD in the new worktree with the value of the resolved HEAD~1

    3. git-checkout re-invokes itself with the same arguments within the
       new worktree to populate the worktree

    4. the sub git-checkout resolves HEAD~1 relative to its own HEAD,
       which is the resolved HEAD~1 from the original invocation,
       resulting unexpectedly and incorrectly in HEAD~2 (relative to the
       original)

Fix this by unconditionally assigning the current worktree's HEAD as the
value of the new worktree's HEAD.

As a side-effect, this change also eliminates a dependence within
prepare_linked_checkout() upon 'struct branch_info'. The eventual plan
is to relocate "git checkout --to" functionality to "git worktree add",
and worktree.c won't have knowledge of 'struct branch_info', so removal
of this dependency is a step toward that goal.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/checkout.c     |  5 ++++-
 t/t2025-checkout-to.sh | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2079aa4..f5f953d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -863,6 +863,7 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	struct stat st;
 	struct child_process cp;
 	int counter = 0, len, ret;
+	unsigned char rev[20];
 
 	if (!new->commit)
 		die(_("no branch specified"));
@@ -924,9 +925,11 @@ static int prepare_linked_checkout(const struct checkout_opts *opts,
 	 * value would do because this value will be ignored and
 	 * replaced at the next (real) checkout.
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
