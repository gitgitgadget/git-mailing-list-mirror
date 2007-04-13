From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] Define 'crlf' attribute.
Date: Fri, 13 Apr 2007 02:01:36 -0700
Message-ID: <7vps68d4wf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 11:02:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcHfi-0006Ne-Lk
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 11:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbXDMJBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 05:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbXDMJBm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 05:01:42 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61798 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbXDMJBi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 05:01:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070413090136.SUNS1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Apr 2007 05:01:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id mZ1c1W00M1kojtg0000000; Fri, 13 Apr 2007 05:01:37 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44399>

This defines the semantics of 'crlf' attribute as an example.
When a path has this attribute unset (i.e. '!crlf'), autocrlf
line-end conversion is not applied.

Eventually we would want to let users to build a pipeline of
processing to munge blob data to filesystem format (and in the
other direction) based on combination of attributes, and at that
point the mechanism in convert_to_{git,working_tree}() that
looks at 'crlf' attribute needs to be enhanced.  Perhaps the
existing 'crlf' would become the first step in the input chain,
and the last step in the output chain.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 attr.c          |   18 ++++++++++++++++++
 convert.c       |   49 ++++++++++++++++++++++++++++++++++++++++++-------
 t/t0020-crlf.sh |   24 ++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 7 deletions(-)

diff --git a/attr.c b/attr.c
index bdbc4a3..d35ae9e 100644
--- a/attr.c
+++ b/attr.c
@@ -299,3 +299,21 @@ int git_checkattr(const char *path, int num, struct git_attr_check *check)
 		rem = fill(path, pathlen, stk, check, num, rem);
 	return 0;
 }
+
+static void setup_binary_check(struct git_attr_check *check)
+{
+	static struct git_attr *attr_binary;
+
+	if (!attr_binary)
+		attr_binary = git_attr("binary", 6);
+	check->attr = attr_binary;
+}
+
+int git_path_is_binary(const char *path)
+{
+	struct git_attr_check attr_binary_check;
+
+	setup_binary_check(&attr_binary_check);
+	return (!git_checkattr(path, 1, &attr_binary_check) &&
+		(0 < attr_binary_check.isset));
+}
diff --git a/convert.c b/convert.c
index 898bfe3..20c744a 100644
--- a/convert.c
+++ b/convert.c
@@ -1,4 +1,6 @@
 #include "cache.h"
+#include "attr.h"
+
 /*
  * convert.c - convert a file when checking it out and checking it in.
  *
@@ -72,17 +74,12 @@ static int is_binary(unsigned long size, struct text_stat *stats)
 	return 0;
 }
 
-int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
+static int autocrlf_to_git(const char *path, char **bufp, unsigned long *sizep)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
 	struct text_stat stats;
 
-	/*
-	 * FIXME! Other pluggable conversions should go here,
-	 * based on filename patterns. Right now we just do the
-	 * stupid auto-CRLF one.
-	 */
 	if (!auto_crlf)
 		return 0;
 
@@ -128,7 +125,7 @@ int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
 	return 1;
 }
 
-int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+static int autocrlf_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
 {
 	char *buffer, *nbuf;
 	unsigned long size, nsize;
@@ -184,3 +181,41 @@ int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
 
 	return 1;
 }
+
+static void setup_crlf_check(struct git_attr_check *check)
+{
+	static struct git_attr *attr_crlf;
+
+	if (!attr_crlf)
+		attr_crlf = git_attr("crlf", 4);
+	check->attr = attr_crlf;
+}
+
+static int git_path_is_binary(const char *path)
+{
+	struct git_attr_check attr_crlf_check;
+
+	setup_crlf_check(&attr_crlf_check);
+
+	/*
+	 * If crlf is not mentioned, default to autocrlf;
+	 * disable autocrlf only when crlf attribute is explicitly
+	 * unset.
+	 */
+	return (!git_checkattr(path, 1, &attr_crlf_check) &&
+		(0 == attr_crlf_check.isset));
+}
+
+int convert_to_git(const char *path, char **bufp, unsigned long *sizep)
+{
+	if (git_path_is_binary(path))
+		return 0;
+	return autocrlf_to_git(path, bufp, sizep);
+}
+
+int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
+{
+	if (git_path_is_binary(path))
+		return 0;
+	return autocrlf_to_working_tree(path, bufp, sizep);
+}
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 723b29a..600dcd3 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -214,4 +214,28 @@ test_expect_success 'apply patch --index (autocrlf=true)' '
 	}
 '
 
+test_expect_success '.gitattributes says two is binary' '
+
+	echo "two !crlf" >.gitattributes &&
+	rm -f tmp one dir/two &&
+	git repo-config core.autocrlf true &&
+	git read-tree --reset -u HEAD &&
+
+	if remove_cr dir/two >/dev/null
+	then
+		echo "Huh?"
+		false
+	else
+		: happy
+	fi &&
+
+	if remove_cr one >/dev/null
+	then
+		: happy
+	else
+		echo "Huh?"
+		false
+	fi
+'
+
 test_done
-- 
1.5.1.1.784.g95e2
