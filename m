From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/4] Make pull() take some implicit data as explicit arguments
Date: Thu, 27 Jul 2006 23:56:14 +0200
Message-ID: <20060727215614.24240.89387.stgit@machine>
References: <20060727215326.24240.20118.stgit@machine>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 23:56:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6DqF-0006lX-VF
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWG0V4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWG0V4S
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:56:18 -0400
Received: from w241.dkm.cz ([62.24.88.241]:27598 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751065AbWG0V4R (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:56:17 -0400
Received: (qmail 24855 invoked from network); 27 Jul 2006 23:56:15 +0200
Received: from localhost (HELO ?62.24.88.241?) (xpasky@127.0.0.1)
  by localhost with SMTP; 27 Jul 2006 23:56:15 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060727215326.24240.20118.stgit@machine>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24354>

Currently it's a bit weird that pull() takes a single argument
describing the commit but takes the write_ref from a global variable.
This makes it take that as a parameter as well, which might be nicer
for the libification in the future, but especially it will make for
nicer code when we implement pull()ing multiple commits at once.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 fetch.c       |    6 ++----
 fetch.h       |   11 ++++-------
 http-fetch.c  |    4 ++--
 local-fetch.c |    4 ++--
 ssh-fetch.c   |    4 ++--
 5 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fetch.c b/fetch.c
index 989d7a4..3255cc6 100644
--- a/fetch.c
+++ b/fetch.c
@@ -8,9 +8,6 @@ #include "tag.h"
 #include "blob.h"
 #include "refs.h"
 
-const char *write_ref = NULL;
-const char *write_ref_log_details = NULL;
-
 int get_tree = 0;
 int get_history = 0;
 int get_all = 0;
@@ -213,7 +210,8 @@ static int mark_complete(const char *pat
 	return 0;
 }
 
-int pull(char *target)
+int pull(char *target, const char *write_ref,
+         const char *write_ref_log_details)
 {
 	struct ref_lock *lock = NULL;
 	unsigned char sha1[20];
diff --git a/fetch.h b/fetch.h
index 841bb1a..7bda355 100644
--- a/fetch.h
+++ b/fetch.h
@@ -22,12 +22,6 @@ extern void prefetch(unsigned char *sha1
  */
 extern int fetch_ref(char *ref, unsigned char *sha1);
 
-/* If set, the ref filename to write the target value to. */
-extern const char *write_ref;
-
-/* If set additional text will appear in the ref log. */
-extern const char *write_ref_log_details;
-
 /* Set to fetch the target tree. */
 extern int get_tree;
 
@@ -46,6 +40,9 @@ extern int get_recover;
 /* Report what we got under get_verbosely */
 extern void pull_say(const char *, const char *);
 
-extern int pull(char *target);
+/* If write_ref is set, the ref filename to write the target value to. */
+/* If write_ref_log_details is set, additional text will appear in the ref log. */
+extern int pull(char *target, const char *write_ref,
+		const char *write_ref_log_details);
 
 #endif /* PULL_H */
diff --git a/http-fetch.c b/http-fetch.c
index dc286b7..963d439 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1216,6 +1216,7 @@ int fetch_ref(char *ref, unsigned char *
 
 int main(int argc, char **argv)
 {
+	const char *write_ref = NULL;
 	char *commit_id;
 	char *url;
 	char *path;
@@ -1250,7 +1251,6 @@ int main(int argc, char **argv)
 	}
 	commit_id = argv[arg];
 	url = argv[arg + 1];
-	write_ref_log_details = url;
 
 	http_init();
 
@@ -1268,7 +1268,7 @@ int main(int argc, char **argv)
 			alt->path_len = strlen(path);
 	}
 
-	if (pull(commit_id))
+	if (pull(commit_id, write_ref, url))
 		rc = 1;
 
 	http_cleanup();
diff --git a/local-fetch.c b/local-fetch.c
index 65a803a..308ed00 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -204,6 +204,7 @@ static const char local_pull_usage[] =
  */
 int main(int argc, char **argv)
 {
+	const char *write_ref = NULL;
 	char *commit_id;
 	int arg = 1;
 
@@ -240,9 +241,8 @@ int main(int argc, char **argv)
 		usage(local_pull_usage);
 	commit_id = argv[arg];
 	path = argv[arg + 1];
-	write_ref_log_details = path;
 
-	if (pull(commit_id))
+	if (pull(commit_id, write_ref, path))
 		return 1;
 
 	return 0;
diff --git a/ssh-fetch.c b/ssh-fetch.c
index a8a6cfb..aef3aa4 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -123,6 +123,7 @@ static const char ssh_fetch_usage[] =
   " [-c] [-t] [-a] [-v] [--recover] [-w ref] commit-id url";
 int main(int argc, char **argv)
 {
+	const char *write_ref = NULL;
 	char *commit_id;
 	char *url;
 	int arg = 1;
@@ -159,7 +160,6 @@ int main(int argc, char **argv)
 	}
 	commit_id = argv[arg];
 	url = argv[arg + 1];
-	write_ref_log_details = url;
 
 	if (setup_connection(&fd_in, &fd_out, prog, url, arg, argv + 1))
 		return 1;
@@ -167,7 +167,7 @@ int main(int argc, char **argv)
 	if (get_version())
 		return 1;
 
-	if (pull(commit_id))
+	if (pull(commit_id, write_ref, url))
 		return 1;
 
 	return 0;
