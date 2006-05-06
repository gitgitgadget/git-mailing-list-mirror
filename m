From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Fix users of prefix_path() to free() only when necessary
Date: Sun, 7 May 2006 00:02:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605070002310.6357@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun May 07 00:03:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcUrZ-0007EQ-Fc
	for gcvg-git@gmane.org; Sun, 07 May 2006 00:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWEFWCy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 May 2006 18:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWEFWCy
	(ORCPT <rfc822;git-outgoing>); Sat, 6 May 2006 18:02:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:20373 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932087AbWEFWCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 May 2006 18:02:54 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 19D282037;
	Sun,  7 May 2006 00:02:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 0DDCC2036;
	Sun,  7 May 2006 00:02:53 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id EDE571D47;
	Sun,  7 May 2006 00:02:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19676>


Unfortunately, prefix_path() sometimes returns a newly xmalloc()ed buffer,
and in other cases it returns a substring!

For example, when calling

	git update-index ./hello.txt

prefix_path() returns "hello.txt", but does not allocate a new buffer. The
original code only checked if the result of prefix_path() was different from
what was passed in, and thusly trigger a segmentation fault.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 checkout-index.c |    4 ++--
 update-index.c   |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/checkout-index.c b/checkout-index.c
index 64bdc3b..9876af6 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -278,7 +278,7 @@ int main(int argc, char **argv)
 			die("git-checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
 		checkout_file(p);
-		if (p != arg)
+		if (p < arg || p > arg + strlen(arg))
 			free((char*)p);
 	}
 
@@ -300,7 +300,7 @@ int main(int argc, char **argv)
 				path_name = buf.buf;
 			p = prefix_path(prefix, prefix_length, path_name);
 			checkout_file(p);
-			if (p != path_name)
+			if (p < path_name || p > path_name + strlen(path_name))
 				free((char *)p);
 			if (path_name != buf.buf)
 				free(path_name);
diff --git a/update-index.c b/update-index.c
index 7db67aa..f6b09a4 100644
--- a/update-index.c
+++ b/update-index.c
@@ -393,7 +393,7 @@ static void update_one(const char *path,
 		die("Unable to process file %s", path);
 	report("add '%s'", path);
  free_return:
-	if (p != path)
+	if (p < path || p > path + strlen(path))
 		free((char*)p);
 }
 
@@ -609,7 +609,7 @@ static int do_unresolve(int ac, const ch
 		const char *arg = av[i];
 		const char *p = prefix_path(prefix, prefix_length, arg);
 		err |= unresolve_one(p);
-		if (p != arg)
+		if (p < arg || p > arg + strlen(arg))
 			free((char*)p);
 	}
 	return err;
@@ -623,7 +623,7 @@ static int do_reupdate(int ac, const cha
 	 */
 	int pos;
 	int has_head = 1;
-	char **pathspec = get_pathspec(prefix, av + 1);
+	const char **pathspec = get_pathspec(prefix, av + 1);
 
 	if (read_ref(git_path("HEAD"), head_sha1))
 		/* If there is no HEAD, that means it is an initial
@@ -815,7 +815,7 @@ int main(int argc, const char **argv)
 			update_one(p, NULL, 0);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			if (p != path_name)
+			if (p < path_name || p > path_name + strlen(path_name))
 				free((char*) p);
 			if (path_name != buf.buf)
 				free(path_name);
-- 
1.3.2.g9ba6-dirty
