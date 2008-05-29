From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH v2] rollback lock files on more signals than just SIGINT
Date: Thu, 29 May 2008 16:55:53 +0200
Message-ID: <E1K1jnV-0007HC-Om@fencepost.gnu.org>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org> <alpine.DEB.1.00.0805291341290.13507@racer.site.net> <483EAD69.9090001@gnu.org> <alpine.DEB.1.00.0805291456030.13507@racer.site.net> <483EBF1F.9000809@gnu.org> <alpine.DEB.1.00.0805291541430.13507@racer.site.net>
Cc: Git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 17:18:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1jq5-0004br-4f
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 17:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbYE2PN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 11:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753418AbYE2PN4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 11:13:56 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:47213 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbYE2PN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 11:13:56 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1K1jnV-0007HC-Om; Thu, 29 May 2008 11:12:09 -0400
In-Reply-To: <alpine.DEB.1.00.0805291541430.13507@racer.site.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83209>

Other signals are also common, for example SIGTERM and SIGHUP.
This patch modifies the lock file mechanism to catch more signals.
It also modifies http-push.c which was missing SIGTERM.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 http-push.c       |    1 +
 lockfile.c        |    3 +++
 t/t7502-commit.sh |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

	>> It would be curious at least to set the commit_style to COMMIT_NORMAL
	>> after creating the index_lock, and upgrade it to COMMIT_PARTIAL later
	>> on.  I contemplated that, and my patch is the simplest code that's 
	>> needed and works.
	> 
	> As I said, I think it is a regression, because you change code.  Your 
	> argument as to why leaves me desiring another solution.
	
	Ok, here it is.  But it's not what you were expecting. :-P

diff --git a/http-push.c b/http-push.c
index f173dcd..c93e781 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2277,6 +2277,7 @@ int main(int argc, char **argv)
 	signal(SIGINT, remove_locks_on_signal);
 	signal(SIGHUP, remove_locks_on_signal);
 	signal(SIGQUIT, remove_locks_on_signal);
+	signal(SIGTERM, remove_locks_on_signal);
 
 	/* Check whether the remote has server info files */
 	remote->can_update_info_refs = 0;
diff --git a/lockfile.c b/lockfile.c
index cfc7335..4023797 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -135,6 +135,9 @@ static int lock_file(struct lock_file *lk, const char *path)
 	if (0 <= lk->fd) {
 		if (!lock_file_list) {
 			signal(SIGINT, remove_lock_file_on_signal);
+			signal(SIGHUP, remove_lock_file_on_signal);
+			signal(SIGTERM, remove_lock_file_on_signal);
+			signal(SIGQUIT, remove_lock_file_on_signal);
 			atexit(remove_lock_file);
 		}
 		lk->owner = getpid();
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 3531a99..46ec1ce 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -212,4 +212,18 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 	test "`cat .git/result`" = "editor not started"
 '
 
+pwd=`pwd`
+cat > .git/FAKE_EDITOR << EOF
+#! /bin/sh
+# kill -TERM command added below.
+EOF
+
+test_expect_success 'a SIGTERM should break locks' '
+	echo >>negative &&
+	sh -c '\''
+	  echo kill -TERM $$ >> .git/FAKE_EDITOR
+	  GIT_EDITOR=.git/FAKE_EDITOR exec git commit -a'\'' && exit 1  # should fail
+	! test -f .git/index.lock
+'
+
 test_done
-- 
1.5.5
