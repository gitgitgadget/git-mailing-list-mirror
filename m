From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git branch -m: forbid renaming of a symref
Date: Wed, 29 Oct 2008 01:05:27 +0100
Message-ID: <1225238727-12399-1-git-send-email-vmiklos@frugalware.org>
References: <20081028234541.GY24201@genesis.frugalware.org>
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 01:06:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuyZP-0008Tf-Fr
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 01:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYJ2AEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 20:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYJ2AEm
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 20:04:42 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:34459 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbYJ2AEm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 20:04:42 -0400
Received: from vmobile.example.net (dsl5401C246.pool.t-online.hu [84.1.194.70])
	by yugo.frugalware.org (Postfix) with ESMTPA id BE136446CCD;
	Wed, 29 Oct 2008 01:04:39 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 49AAC14E35; Wed, 29 Oct 2008 01:05:28 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20081028234541.GY24201@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99336>

There may be cases where one would really want to rename the symbolic
ref without changing its value, but "git branch -m" is not such a
use-case.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

This applies on top of 'mv/maint-branch-m-symref'.

 refs.c            |   29 +++++++++++++----------------
 t/t3200-branch.sh |    8 ++++----
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/refs.c b/refs.c
index b39e6f2..8a38e08 100644
--- a/refs.c
+++ b/refs.c
@@ -964,14 +964,14 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
 	const char *symref = NULL;
-	int is_symref = 0;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldref);
 
 	symref = resolve_ref(oldref, orig_sha1, 1, &flag);
 	if (flag & REF_ISSYMREF)
-		is_symref = 1;
+		return error("refname %s is a symbolic ref, renaming it is not supported",
+			oldref);
 	if (!symref)
 		return error("refname %s not found", oldref);
 
@@ -1035,20 +1035,17 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	}
 	logmoved = log;
 
-	if (!is_symref) {
-		lock = lock_ref_sha1_basic(newref, NULL, 0, NULL);
-		if (!lock) {
-			error("unable to lock %s for update", newref);
-			goto rollback;
-		}
-		lock->force_write = 1;
-		hashcpy(lock->old_sha1, orig_sha1);
-		if (write_ref_sha1(lock, orig_sha1, logmsg)) {
-			error("unable to write current sha1 into %s", newref);
-			goto rollback;
-		}
-	} else
-		create_symref(newref, symref, logmsg);
+	lock = lock_ref_sha1_basic(newref, NULL, 0, NULL);
+	if (!lock) {
+		error("unable to lock %s for update", newref);
+		goto rollback;
+	}
+	lock->force_write = 1;
+	hashcpy(lock->old_sha1, orig_sha1);
+	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+		error("unable to write current sha1 into %s", newref);
+		goto rollback;
+	}
 
 	return 0;
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fdeb1f5..25e9971 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -112,13 +112,13 @@ test_expect_success 'config information was renamed, too' \
 	"test $(git config branch.s.dummy) = Hello &&
 	 test_must_fail git config branch.s/s/dummy"
 
-test_expect_success 'renaming a symref' \
+test_expect_success 'renaming a symref is not allowed' \
 '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
-	git branch -m master2 master3 &&
-	git symbolic-ref refs/heads/master3 &&
+	test_must_fail git branch -m master2 master3 &&
+	git symbolic-ref refs/heads/master2 &&
 	test -f .git/refs/heads/master &&
-	! test -f .git/refs/heads/master2
+	! test -f .git/refs/heads/master3
 '
 
 test_expect_success \
-- 
1.6.0.2
