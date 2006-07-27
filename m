From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 3/4] Teach git-local-fetch the --stdin switch
Date: Thu, 27 Jul 2006 23:56:19 +0200
Message-ID: <20060727215619.24240.39537.stgit@machine>
References: <20060727215326.24240.20118.stgit@machine>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 23:56:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6DqK-0006lX-Nj
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 23:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWG0V4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWG0V4Y
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 17:56:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29390 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751318AbWG0V4X (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 17:56:23 -0400
Received: (qmail 24886 invoked from network); 27 Jul 2006 23:56:20 +0200
Received: from localhost (HELO ?62.24.88.241?) (xpasky@127.0.0.1)
  by localhost with SMTP; 27 Jul 2006 23:56:20 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060727215326.24240.20118.stgit@machine>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24350>

This makes it possible to fetch many commits (refs) at once, greatly
speeding up cg-clone.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-local-fetch.txt |    6 ++++++
 fetch.c                           |   40 +++++++++++++++++++++++++++++++++++++
 fetch.h                           |    6 ++++++
 local-fetch.c                     |   32 ++++++++++++++++++++----------
 4 files changed, 74 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-local-fetch.txt b/Documentation/git-local-fetch.txt
index 87abec1..bd19820 100644
--- a/Documentation/git-local-fetch.txt
+++ b/Documentation/git-local-fetch.txt
@@ -29,6 +29,12 @@ OPTIONS
         Writes the commit-id into the filename under $GIT_DIR/refs/<filename> on
         the local end after the transfer is complete.
 
+--stdin::
+	Instead of a commit id on the commandline (which is not expected in this
+	case), 'git-local-fetch' excepts lines on stdin in the format
+
+		<commit-id>['\t'<filename-as-in--w>]
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>
diff --git a/fetch.c b/fetch.c
index 281df61..2151c7b 100644
--- a/fetch.c
+++ b/fetch.c
@@ -7,6 +7,7 @@ #include "tree-walk.h"
 #include "tag.h"
 #include "blob.h"
 #include "refs.h"
+#include "strbuf.h"
 
 int get_tree = 0;
 int get_history = 0;
@@ -210,6 +211,45 @@ static int mark_complete(const char *pat
 	return 0;
 }
 
+int pull_targets_stdin(char ***target, const char ***write_ref)
+{
+	int targets = 0, targets_alloc = 0;
+	struct strbuf buf;
+	*target = NULL; *write_ref = NULL;
+	strbuf_init(&buf);
+	while (1) {
+		char *rf_one = NULL;
+		char *tg_one;
+
+		read_line(&buf, stdin, '\n');
+		if (buf.eof)
+			break;
+		tg_one = buf.buf;
+		rf_one = strchr(tg_one, '\t');
+		if (rf_one)
+			*rf_one++ = 0;
+
+		if (targets >= targets_alloc) {
+			targets_alloc = targets_alloc ? targets_alloc * 2 : 64;
+			*target = xrealloc(*target, targets_alloc * sizeof(**target));
+			*write_ref = xrealloc(*write_ref, targets_alloc * sizeof(**write_ref));
+		}
+		(*target)[targets] = strdup(tg_one);
+		(*write_ref)[targets] = rf_one ? strdup(rf_one) : NULL;
+		targets++;
+	}
+	return targets;
+}
+
+void pull_targets_free(int targets, char **target, const char **write_ref)
+{
+	while (targets--) {
+		free(target[targets]);
+		if (write_ref[targets])
+			free((char *) write_ref[targets]);
+	}
+}
+
 int pull(int targets, char **target, const char **write_ref,
          const char *write_ref_log_details)
 {
diff --git a/fetch.h b/fetch.h
index 75e48af..be48c6f 100644
--- a/fetch.h
+++ b/fetch.h
@@ -40,6 +40,12 @@ extern int get_recover;
 /* Report what we got under get_verbosely */
 extern void pull_say(const char *, const char *);
 
+/* Load pull targets from stdin */
+extern int pull_targets_stdin(char ***target, const char ***write_ref);
+
+/* Free up loaded targets */
+extern void pull_targets_free(int targets, char **target, const char **write_ref);
+
 /* If write_ref is set, the ref filename to write the target value to. */
 /* If write_ref_log_details is set, additional text will appear in the ref log. */
 extern int pull(int targets, char **target, const char **write_ref,
diff --git a/local-fetch.c b/local-fetch.c
index eb19f1a..84b68a6 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -8,8 +8,9 @@ #include "fetch.h"
 static int use_link = 0;
 static int use_symlink = 0;
 static int use_filecopy = 1;
+static int commits_on_stdin = 0;
 
-static char *path; /* "Remote" git repository */
+static const char *path; /* "Remote" git repository */
 
 void prefetch(unsigned char *sha1)
 {
@@ -194,7 +195,7 @@ int fetch_ref(char *ref, unsigned char *
 }
 
 static const char local_pull_usage[] =
-"git-local-fetch [-c] [-t] [-a] [-v] [-w filename] [--recover] [-l] [-s] [-n] commit-id path";
+"git-local-fetch [-c] [-t] [-a] [-v] [-w filename] [--recover] [-l] [-s] [-n] [--stdin] commit-id path";
 
 /* 
  * By default we only use file copy.
@@ -202,10 +203,11 @@ static const char local_pull_usage[] =
  * If -s is specified, then a symlink is attempted.
  * If -n is _not_ specified, then a regular file-to-file copy is done.
  */
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
-	const char *write_ref = NULL;
-	char *commit_id;
+	int commits;
+	const char **write_ref = NULL;
+	char **commit_id;
 	int arg = 1;
 
 	setup_git_directory();
@@ -230,20 +232,30 @@ int main(int argc, char **argv)
 		else if (argv[arg][1] == 'v')
 			get_verbosely = 1;
 		else if (argv[arg][1] == 'w')
-			write_ref = argv[++arg];
+			write_ref = &argv[++arg];
 		else if (!strcmp(argv[arg], "--recover"))
 			get_recover = 1;
+		else if (!strcmp(argv[arg], "--stdin"))
+			commits_on_stdin = 1;
 		else
 			usage(local_pull_usage);
 		arg++;
 	}
-	if (argc < arg + 2)
+	if (argc < arg + 2 - commits_on_stdin)
 		usage(local_pull_usage);
-	commit_id = argv[arg];
-	path = argv[arg + 1];
+	if (commits_on_stdin) {
+		commits = pull_targets_stdin(&commit_id, &write_ref);
+	} else {
+		commit_id = (char **) &argv[arg++];
+		commits = 1;
+	}
+	path = argv[arg];
 
-	if (pull(1, &commit_id, &write_ref, path))
+	if (pull(commits, commit_id, write_ref, path))
 		return 1;
 
+	if (commits_on_stdin)
+		pull_targets_free(commits, commit_id, write_ref);
+
 	return 0;
 }
