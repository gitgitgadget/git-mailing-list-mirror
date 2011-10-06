From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] revert.c: defer writing CHERRY_PICK_HEAD till it is safe to do so
Date: Thu,  6 Oct 2011 10:34:01 -0400
Message-ID: <1317911641-47660-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 16:34:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBp1p-0003xP-Rk
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 16:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933Ab1JFOeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 10:34:16 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63842 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964930Ab1JFOeN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 10:34:13 -0400
Received: by ggnv2 with SMTP id v2so1755684ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Ft/KCpmRjEpbFTbtbWJTQwrkW0sL6H2RGF+tGKNhhFI=;
        b=wYCJug4rqw71ngk60nlTGRXOybX/k8KYuxawmr9l9g+C81GMOQvcvdEvYYh5VuQpc8
         nluiRjsPtGZAwSJCt8PS1AFuR3dQkkGO1lbNjEgwVatgckZv8r1t4v1X8cPbrSknrBKh
         xH6Ne59/mW/X4d0pZ+JWn1yH1Yo7bTg5ATz+U=
Received: by 10.236.77.233 with SMTP id d69mr3587503yhe.84.1317911652762;
        Thu, 06 Oct 2011 07:34:12 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id k31sm15251070ann.15.2011.10.06.07.34.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 07:34:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.6.g25c34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182955>

do_pick_commit() writes out CHERRY_PICK_HEAD before invoking merge (either
via do_recursive_merge() or try_merge_command()) on the assumption that if
the merge fails it is due to conflict. However, if the tree is dirty, the
merge may not even start, aborting before do_pick_commit() can remove
CHERRY_PICK_HEAD.

Instead, defer writing CHERRY_PICK_HEAD till after merge has returned.
At this point we know the merge has either succeeded or failed due
to conflict. In either case, we want CHERRY_PICK_HEAD to be written
so that it may be picked up by the subsequent invocation of commit.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin/revert.c                |    6 +++++-
 t/t3507-cherry-pick-conflict.sh |    7 +++++++
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3117776c2c..48526e1ef1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -384,6 +384,7 @@ static int do_pick_commit(void)
 	char *defmsg = NULL;
 	struct strbuf msgbuf = STRBUF_INIT;
 	int res;
+	int record_cherry_pick_head = 0;
 
 	if (no_commit) {
 		/*
@@ -477,7 +478,7 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, ")\n");
 		}
 		if (!no_commit)
-			write_cherry_pick_head();
+			record_cherry_pick_head = 1;
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -498,6 +499,9 @@ static int do_pick_commit(void)
 		free_commit_list(remotes);
 	}
 
+	if (record_cherry_pick_head)
+		write_cherry_pick_head();
+
 	if (res) {
 		error(action == REVERT
 		      ? _("could not revert %s... %s")
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 212ec54aaf..29890bf5ac 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -77,6 +77,13 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
+test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	echo foo > foo &&
+	test_must_fail git cherry-pick base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
 test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	(
-- 
1.7.7.6.g25c34
