From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Add "--branches", "--tags" and "--remotes" options to
 git-rev-parse.
Date: Sat, 13 May 2006 21:43:00 -0400
Message-ID: <BAYC1-PASMTP043948149786B7EE06DED3AEA20@CEZ.ICE>
References: <BAYC1-PASMTP0299DC98A51B55188BDF96AEAD0@CEZ.ICE>
	<7vd5ehu8og.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 14 03:48:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff5is-0003mt-G8
	for gcvg-git@gmane.org; Sun, 14 May 2006 03:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWENBs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 21:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWENBs1
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 21:48:27 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:10208 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932094AbWENBs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 May 2006 21:48:26 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 13 May 2006 18:48:25 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 75AAF644C17;
	Sat, 13 May 2006 21:48:24 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060513214300.4bfb01a2.seanlkml@sympatico.ca>
In-Reply-To: <7vd5ehu8og.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 May 2006 01:48:25.0939 (UTC) FILETIME=[7DB18230:01C676F8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


"git branch" uses "rev-parse --all" and becomes much too slow when
there are many tags (it scans all refs).  Use the new "--branches"
option of rev-parse to speed things up.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

On Sat, 13 May 2006 10:38:23 -0700
Junio C Hamano <junkio@cox.net> wrote:

> Makes sense perhaps.
> 
> I understand you added --tags for completeness.  Probably it
> would make sense to add --remotes if you are shooting for that.
> 

Hi Junio,

Here's an updated patch with --remotes as you asked.  I appened _ref to the
new functions to make it clear that for_each_remote didn't have anything to
do with remote files.  Also updated the "is_rev_argument" function which was
missed first time around.

On a related note, would it be okay to change "git tag -l" to produce a list
of tags without the "tags/" prefix in front of every tag as it does now?
Wanted to use the new "git rev-parse --tags" instead of "find" to produce 
the list but am not sure how important backward compatibility is in that case.

Sean

 Documentation/git-rev-parse.txt |    9 +++++++++
 git-branch.sh                   |    3 +--
 refs.c                          |   23 +++++++++++++++++++----
 refs.h                          |    3 +++
 rev-parse.c                     |   17 ++++++++++++++++-
 5 files changed, 48 insertions(+), 7 deletions(-)

260bda5eb4effca1a1dd33beb7f7e962d3eab602
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8b95df0..ab896fc 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -67,6 +67,15 @@ OPTIONS
 --all::
 	Show all refs found in `$GIT_DIR/refs`.
 
+--branches::
+	Show branch refs found in `$GIT_DIR/refs/heads`.
+
+--tags::
+	Show tag refs found in `$GIT_DIR/refs/tags`.
+
+--remotes::
+	Show tag refs found in `$GIT_DIR/refs/remotes`.
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
index 275b914..6c91ae6 100644
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
@@ -180,7 +180,22 @@ int head_ref(int (*fn)(const char *path,
 
 int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
-	return do_for_each_ref("refs", fn);
+	return do_for_each_ref("refs", fn, 0);
+}
+
+int for_each_tag_ref(int (*fn)(const char *path, const unsigned char *sha1))
+{
+	return do_for_each_ref("refs/tags", fn, 10);
+}
+
+int for_each_branch_ref(int (*fn)(const char *path, const unsigned char *sha1))
+{
+	return do_for_each_ref("refs/heads", fn, 11);
+}
+
+int for_each_remote_ref(int (*fn)(const char *path, const unsigned char *sha1))
+{
+	return do_for_each_ref("refs/remotes", fn, 13);
 }
 
 static char *ref_file_name(const char *ref)
diff --git a/refs.h b/refs.h
index 2625596..fa816c1 100644
--- a/refs.h
+++ b/refs.h
@@ -7,6 +7,9 @@ #define REFS_H
  */
 extern int head_ref(int (*fn)(const char *path, const unsigned char *sha1));
 extern int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1));
+extern int for_each_tag_ref(int (*fn)(const char *path, const unsigned char *sha1));
+extern int for_each_branch_ref(int (*fn)(const char *path, const unsigned char *sha1));
+extern int for_each_remote_ref(int (*fn)(const char *path, const unsigned char *sha1));
 
 /** Reads the refs file specified into sha1 **/
 extern int get_ref_sha1(const char *ref, unsigned char *sha1);
diff --git a/rev-parse.c b/rev-parse.c
index 62e16af..4e2d9fb 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -36,6 +36,7 @@ static int is_rev_argument(const char *a
 		"--all",
 		"--bisect",
 		"--dense",
+		"--branches",
 		"--header",
 		"--max-age=",
 		"--max-count=",
@@ -45,7 +46,9 @@ static int is_rev_argument(const char *a
 		"--objects-edge",
 		"--parents",
 		"--pretty",
+		"--remotes",
 		"--sparse",
+		"--tags",
 		"--topo-order",
 		"--date-order",
 		"--unpacked",
@@ -165,7 +168,7 @@ int main(int argc, char **argv)
 	int i, as_is = 0, verify = 0;
 	unsigned char sha1[20];
 	const char *prefix = setup_git_directory();
-	
+
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
@@ -255,6 +258,18 @@ int main(int argc, char **argv)
 				for_each_ref(show_reference);
 				continue;
 			}
+			if (!strcmp(arg, "--branches")) {
+				for_each_branch_ref(show_reference);
+				continue;
+			}
+			if (!strcmp(arg, "--tags")) {
+				for_each_tag_ref(show_reference);
+				continue;
+			}
+			if (!strcmp(arg, "--remotes")) {
+				for_each_remote_ref(show_reference);
+				continue;
+			}
 			if (!strcmp(arg, "--show-prefix")) {
 				if (prefix)
 					puts(prefix);
-- 
1.3.2.g575a1
