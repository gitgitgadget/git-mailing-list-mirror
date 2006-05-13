From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: [PATCH] Add "--branches" and "--tags" options to git-rev-parse.
Date: Sat, 13 May 2006 11:13:32 -0400
Message-ID: <BAYC1-PASMTP0299DC98A51B55188BDF96AEAD0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat May 13 17:19:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FevtW-0001bh-2h
	for gcvg-git@gmane.org; Sat, 13 May 2006 17:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWEMPS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 11:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWEMPS5
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 11:18:57 -0400
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:54328 "EHLO
	BAYC1-PASMTP02.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751288AbWEMPS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 11:18:56 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 13 May 2006 08:18:55 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 0B3F0644C17
	for <git@vger.kernel.org>; Sat, 13 May 2006 11:18:54 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060513111332.59e4c0c9.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 May 2006 15:18:56.0001 (UTC) FILETIME=[8D0E5710:01C676A0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"git branch" uses rev-parse and can become slow when there are many
tags.  Use the new "--branches" option of rev-parse to speed things up.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

 Documentation/git-rev-parse.txt |    6 ++++++
 git-branch.sh                   |    3 +--
 refs.c                          |   18 ++++++++++++++----
 refs.h                          |    2 ++
 rev-parse.c                     |    8 ++++++++
 5 files changed, 31 insertions(+), 6 deletions(-)

7898e1e58b18e992e3d90516fc9e6f3476a385ed
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8b95df0..c1da2bf 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -67,6 +67,12 @@ OPTIONS
 --all::
 	Show all refs found in `$GIT_DIR/refs`.
 
+--branches::
+	Show branch refs found in `$GIT_DIR/refs/heads`.
+
+--tags::
+	Show tag refs found in `$GIT_DIR/refs/tags`.
+
 --show-prefix::
 	When the command is invoked from a subdirectory, show the
 	path of the current directory relative to the top-level
diff --git a/git-branch.sh b/git-branch.sh
index ebcc898..134e68c 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -82,8 +82,7 @@ done
 
 case "$#" in
 0)
-	git-rev-parse --symbolic --all |
-	sed -ne 's|^refs/heads/||p' |
+	git-rev-parse --symbolic --branches |
 	sort |
 	while read ref
 	do
diff --git a/refs.c b/refs.c
index 275b914..9c29a73 100644
--- a/refs.c
+++ b/refs.c
@@ -114,7 +114,7 @@ int read_ref(const char *filename, unsig
 	return -1;
 }
 
-static int do_for_each_ref(const char *base, int (*fn)(const char *path, const unsigned char *sha1))
+static int do_for_each_ref(const char *base, int (*fn)(const char *path, const unsigned char *sha1), int trim)
 {
 	int retval = 0;
 	DIR *dir = opendir(git_path("%s", base));
@@ -146,7 +146,7 @@ static int do_for_each_ref(const char *b
 			if (stat(git_path("%s", path), &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				retval = do_for_each_ref(path, fn);
+				retval = do_for_each_ref(path, fn, trim);
 				if (retval)
 					break;
 				continue;
@@ -160,7 +160,7 @@ static int do_for_each_ref(const char *b
 				      "commit object!", path);
 				continue;
 			}
-			retval = fn(path, sha1);
+			retval = fn(path + trim, sha1);
 			if (retval)
 				break;
 		}
@@ -180,7 +180,17 @@ int head_ref(int (*fn)(const char *path,
 
 int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
-	return do_for_each_ref("refs", fn);
+	return do_for_each_ref("refs", fn, 0);
+}
+
+int for_each_tag(int (*fn)(const char *path, const unsigned char *sha1))
+{
+	return do_for_each_ref("refs/tags", fn, 10);
+}
+
+int for_each_branch(int (*fn)(const char *path, const unsigned char *sha1))
+{
+	return do_for_each_ref("refs/heads", fn, 11);
 }
 
 static char *ref_file_name(const char *ref)
diff --git a/refs.h b/refs.h
index 2625596..f270b62 100644
--- a/refs.h
+++ b/refs.h
@@ -7,6 +7,8 @@ #define REFS_H
  */
 extern int head_ref(int (*fn)(const char *path, const unsigned char *sha1));
 extern int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1));
+extern int for_each_tag(int (*fn)(const char *path, const unsigned char *sha1));
+extern int for_each_branch(int (*fn)(const char *path, const unsigned char *sha1));
 
 /** Reads the refs file specified into sha1 **/
 extern int get_ref_sha1(const char *ref, unsigned char *sha1);
diff --git a/rev-parse.c b/rev-parse.c
index 62e16af..4eb38de 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -255,6 +255,14 @@ int main(int argc, char **argv)
 				for_each_ref(show_reference);
 				continue;
 			}
+			if (!strcmp(arg, "--branches")) {
+				for_each_branch(show_reference);
+				continue;
+			}
+			if (!strcmp(arg, "--tags")) {
+				for_each_tag(show_reference);
+				continue;
+			}
 			if (!strcmp(arg, "--show-prefix")) {
 				if (prefix)
 					puts(prefix);
-- 
1.3.2.g419f
