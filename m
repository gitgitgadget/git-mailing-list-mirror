From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] revert.c: defer writing CHERRY_PICK_HEAD till it is safe to do so
Date: Thu,  6 Oct 2011 13:48:35 -0400
Message-ID: <1317923315-54940-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:48:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBs3t-0004pE-Ld
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241Ab1JFRso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:48:44 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55104 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965192Ab1JFRsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:48:43 -0400
Received: by yxl31 with SMTP id 31so2848087yxl.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+qUc/9dkDoKfbxbgqKKbgpEVwle6UFp51w6VhEtBIyM=;
        b=DPbrO9neSO6UTnoOvci0Nk5rHxzMNHzY9O5w/2ZPReA7pd2g5B7rWQCxmfv6nKGwfP
         /hb5pjQnpMBRjksvahbWa8aVhIZx3CfYiurouGIeixrd60zhxO6HGB8MtQ+BcEP3v8We
         ADOk8QCgJ+RAWf8nEABK7JUsmTxoCOJ9v1jSY=
Received: by 10.236.185.37 with SMTP id t25mr5003291yhm.131.1317923322897;
        Thu, 06 Oct 2011 10:48:42 -0700 (PDT)
Received: from localhost (cpe-174-097-218-168.nc.res.rr.com. [174.97.218.168])
        by mx.google.com with ESMTPS id l31sm8638288yhi.15.2011.10.06.10.48.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 10:48:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.6.g25c34
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183000>

do_pick_commit() writes out CHERRY_PICK_HEAD before invoking merge (either
via do_recursive_merge() or try_merge_command()) on the assumption that if
the merge fails it is due to conflict. However, if the tree is dirty, the
merge may not even start, aborting before do_pick_commit() can remove
CHERRY_PICK_HEAD.

Instead, defer writing CHERRY_PICK_HEAD till after merge has returned.
At this point we know the merge has either succeeded or failed due
to conflict. In either case, we want CHERRY_PICK_HEAD to be written
so that it may be picked up by the subsequent invocation of commit.

Note that do_recursive_merge() aborts if the merge cannot start, while
try_merge_command() returns a non-zero value other than 1.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin/revert.c                |   10 ++++++++--
 t/t3507-cherry-pick-conflict.sh |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3117776c2c..a95b255c86 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -476,8 +476,6 @@ static int do_pick_commit(void)
 			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
 			strbuf_addstr(&msgbuf, ")\n");
 		}
-		if (!no_commit)
-			write_cherry_pick_head();
 	}
 
 	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
@@ -498,6 +496,14 @@ static int do_pick_commit(void)
 		free_commit_list(remotes);
 	}
 
+	/* If the merge was clean or if it failed due to conflict, we write
+	 * CHERRY_PICK_HEAD for the subsequent invocation of commit to use.
+	 * However, if the merge did not even start, then we don't want to
+	 * write it at all.
+	*/
+	if (action == CHERRY_PICK && !no_commit && (res == 0 || res == 1))
+		write_cherry_pick_head();
+
 	if (res) {
 		error(action == REVERT
 		      ? _("could not revert %s... %s")
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 212ec54aaf..7601d0b0d6 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -77,6 +77,21 @@ test_expect_success 'cherry-pick --no-commit does not set CHERRY_PICK_HEAD' '
 	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
 '
 
+test_expect_success 'cherry-pick w/dirty tree does not set CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	echo foo > foo &&
+	test_must_fail git cherry-pick base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
+test_expect_success \
+'cherry-pick --strategy=resolve w/dirty tree does not set CHERRY_PICK_HEAD' '
+	pristine_detach initial &&
+	echo foo > foo &&
+	test_must_fail git cherry-pick --strategy=resolve base &&
+	test_must_fail git rev-parse --verify CHERRY_PICK_HEAD
+'
+
 test_expect_success 'GIT_CHERRY_PICK_HELP suppresses CHERRY_PICK_HEAD' '
 	pristine_detach initial &&
 	(
-- 
1.7.7.6.g25c34
