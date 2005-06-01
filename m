From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] One Git To Rule Them All - Prep 2
Date: Wed, 1 Jun 2005 01:59:56 -0400
Message-ID: <20050601055956.GA15845@port.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jun 01 07:58:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdMEQ-0001T4-UW
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 07:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVFAGAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 02:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFAGAQ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 02:00:16 -0400
Received: from c-67-163-246-116.hsd1.pa.comcast.net ([67.163.246.116]:15048
	"EHLO port.evillabs.net") by vger.kernel.org with ESMTP
	id S261284AbVFAF75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 01:59:57 -0400
Received: by port.evillabs.net (Postfix, from userid 500)
	id ED0DF4001; Wed,  1 Jun 2005 01:59:56 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

one-git prep patch 2/2

Make pull.c usable in one-git by making 'fetch' an overridable function pointer,
instead of an external function.

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

diff --git a/http-pull.c b/http-pull.c
--- a/http-pull.c
+++ b/http-pull.c
@@ -39,7 +39,7 @@ static size_t fwrite_sha1_file(void *ptr
 	return size;
 }
 
-int fetch(unsigned char *sha1)
+static int my_fetch(unsigned char *sha1)
 {
 	char *hex = sha1_to_hex(sha1);
 	char *filename = sha1_file_name(sha1);
@@ -98,6 +98,8 @@ int main(int argc, char **argv)
 	char *url;
 	int arg = 1;
 
+	fetch = my_fetch;
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;
diff --git a/local-pull.c b/local-pull.c
--- a/local-pull.c
+++ b/local-pull.c
@@ -11,7 +11,7 @@ static int use_filecopy = 1;
 
 static char *path;
 
-int fetch(unsigned char *sha1)
+static int my_fetch(unsigned char *sha1)
 {
 	static int object_name_start = -1;
 	static char filename[PATH_MAX];
@@ -87,6 +87,8 @@ int main(int argc, char **argv)
 	char *commit_id;
 	int arg = 1;
 
+	fetch = my_fetch;
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't')
 			get_tree = 1;
diff --git a/pull.c b/pull.c
--- a/pull.c
+++ b/pull.c
@@ -14,6 +14,14 @@ static const char commitS[] = "commit";
 static const char treeS[] = "tree";
 static const char blobS[] = "blob";
 
+int null_fetch(unsigned char *sha1)
+{
+	fprintf(stderr,"fetch() routine not implemented.\n");
+	return -1;
+}
+
+int (*fetch)(unsigned char *sha1) = null_fetch;
+
 void pull_say(const char *fmt, const char *hex) {
 	if (get_verbosely)
 		fprintf(stderr, fmt, hex);
diff --git a/pull.h b/pull.h
--- a/pull.h
+++ b/pull.h
@@ -2,7 +2,7 @@
 #define PULL_H
 
 /** To be provided by the particular implementation. **/
-extern int fetch(unsigned char *sha1);
+extern int (*fetch)(unsigned char *sha1);
 
 /** Set to fetch the target tree. */
 extern int get_tree;
diff --git a/rpull.c b/rpull.c
--- a/rpull.c
+++ b/rpull.c
@@ -6,7 +6,7 @@
 static int fd_in;
 static int fd_out;
 
-int fetch(unsigned char *sha1)
+static int my_fetch(unsigned char *sha1)
 {
 	int ret;
 	write(fd_out, sha1, 20);
@@ -22,6 +22,8 @@ int main(int argc, char **argv)
 	char *url;
 	int arg = 1;
 
+	fetch = my_fetch;
+
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
 			get_tree = 1;

