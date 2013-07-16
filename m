From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 1/2] daemon/shell: refactor redirection of 0/1/2 from /dev/null
Date: Tue, 16 Jul 2013 11:27:36 +0200
Message-ID: <1fe4ff3df32aa1836ed3672e749f582047745bc9.1373966758.git.trast@inf.ethz.ch>
References: <7vtxjzlmaf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	"Dale R. Worley" <worley@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 16 11:27:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz1Xy-0006ho-3t
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 11:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169Ab3GPJ1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 05:27:38 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:6026 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968Ab3GPJ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 05:27:37 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:27:34 +0200
Received: from linux-k42r.v.cablecom.net (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 16 Jul
 2013 11:27:36 +0200
X-Mailer: git-send-email 1.8.3.2.998.g1d087bc
In-Reply-To: <7vtxjzlmaf.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230556>

Both daemon.c and shell.c contain logic to open FDs 0/1/2 from
/dev/null if they are not already open.  Move the function in daemon.c
to setup.c and use it in shell.c, too.

While there, remove a 'not' that inverted the meaning of the comment.
The point is indeed to *avoid* messing up.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 cache.h  |  2 ++
 daemon.c | 12 ------------
 setup.c  | 12 ++++++++++++
 shell.c  | 12 +++---------
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/cache.h b/cache.h
index dd0fb33..f007724 100644
--- a/cache.h
+++ b/cache.h
@@ -425,6 +425,8 @@ extern void verify_filename(const char *prefix,
 extern int set_git_dir_init(const char *git_dir, const char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
 
+extern void sanitize_stdfds(void);
+
 #define alloc_nr(x) (((x)+16)*3/2)
 
 /*
diff --git a/daemon.c b/daemon.c
index 6aeddcb..973ec38 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1047,18 +1047,6 @@ static int service_loop(struct socketlist *socklist)
 	}
 }
 
-/* if any standard file descriptor is missing open it to /dev/null */
-static void sanitize_stdfds(void)
-{
-	int fd = open("/dev/null", O_RDWR, 0);
-	while (fd != -1 && fd < 2)
-		fd = dup(fd);
-	if (fd == -1)
-		die_errno("open /dev/null or dup failed");
-	if (fd > 2)
-		close(fd);
-}
-
 #ifdef NO_POSIX_GOODIES
 
 struct credentials;
diff --git a/setup.c b/setup.c
index 94c1e61..88aab94 100644
--- a/setup.c
+++ b/setup.c
@@ -908,3 +908,15 @@ const char *resolve_gitdir(const char *suspect)
 		return suspect;
 	return read_gitfile(suspect);
 }
+
+/* if any standard file descriptor is missing open it to /dev/null */
+void sanitize_stdfds(void)
+{
+	int fd = open("/dev/null", O_RDWR, 0);
+	while (fd != -1 && fd < 2)
+		fd = dup(fd);
+	if (fd == -1)
+		die_errno("open /dev/null or dup failed");
+	if (fd > 2)
+		close(fd);
+}
diff --git a/shell.c b/shell.c
index 1429870..66350b2 100644
--- a/shell.c
+++ b/shell.c
@@ -147,7 +147,6 @@ int main(int argc, char **argv)
 	char *prog;
 	const char **user_argv;
 	struct commands *cmd;
-	int devnull_fd;
 	int count;
 
 	git_setup_gettext();
@@ -156,15 +155,10 @@ int main(int argc, char **argv)
 
 	/*
 	 * Always open file descriptors 0/1/2 to avoid clobbering files
-	 * in die().  It also avoids not messing up when the pipes are
-	 * dup'ed onto stdin/stdout/stderr in the child processes we spawn.
+	 * in die().  It also avoids messing up when the pipes are dup'ed
+	 * onto stdin/stdout/stderr in the child processes we spawn.
 	 */
-	devnull_fd = open("/dev/null", O_RDWR);
-	while (devnull_fd >= 0 && devnull_fd <= 2)
-		devnull_fd = dup(devnull_fd);
-	if (devnull_fd == -1)
-		die_errno("opening /dev/null failed");
-	close (devnull_fd);
+	sanitize_stdfds();
 
 	/*
 	 * Special hack to pretend to be a CVS server
-- 
1.8.3.2.998.g1d087bc
