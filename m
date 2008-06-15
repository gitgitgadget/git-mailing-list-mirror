From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Make git reflog expire honour core.sharedRepository.
Date: Sun, 15 Jun 2008 23:37:42 +0200
Message-ID: <1213565862-23247-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, joerg@debian.org,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 23:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7zvr-00080Y-Kg
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 23:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbYFOVhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 17:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbYFOVhp
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 17:37:45 -0400
Received: from pan.madism.org ([88.191.52.104]:40055 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbYFOVho (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 17:37:44 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 973DD36034;
	Sun, 15 Jun 2008 23:37:43 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1F6B860E5C; Sun, 15 Jun 2008 23:37:42 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc3.149.gaacb0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85124>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-reflog.c       |    1 +
 t/t1301-shared-repo.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

 Some people like to have logAllRefUpdates even for bare repositories, and if
 shared, git-gc breaks them.

diff --git a/builtin-reflog.c b/builtin-reflog.c
index 897d1dc..430929f 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -308,6 +308,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		} else if (cmd->updateref && commit_ref(lock)) {
 			status |= error("Couldn't set %s", lock->ref_name);
 		}
+		adjust_shared_perm(log_file);
 	}
 	free(newlog_path);
 	free(log_file);
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 5e4252a..6c78c8b 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -83,4 +83,19 @@ do
 
 done
 
+test_expect_success 'git reflog expire honors core.sharedRepository' '
+	git config core.sharedRepository group &&
+	git reflog expire --all &&
+	actual="$(ls -l .git/logs/refs/heads/master)" &&
+	case "$actual" in
+	-rw-rw-*)
+		: happy
+		;;
+	*)
+		echo Ooops, .git/logs/refs/heads/master is not 0662 [$actual]
+		false
+		;;
+	esac
+'
+
 test_done
-- 
1.5.6.rc3.149.gaacb0.dirty
