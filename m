From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 4/6] git-check-attr: Normalize paths
Date: Thu, 28 Jul 2011 12:37:03 +0200
Message-ID: <1311849425-9057-5-git-send-email-mhagger@alum.mit.edu>
References: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 12:37:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmNyK-0007Q2-RV
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 12:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab1G1Khc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 06:37:32 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:32851 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab1G1KhR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 06:37:17 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1QmNvm-0001Zr-Dd; Thu, 28 Jul 2011 12:35:06 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1311849425-9057-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178060>

Normalize the path arguments (relative to the working tree root, if
applicable) before looking up their attributes.  This requires passing
the prefix down the call chain.

This fixes two test cases for different reasons:

* "unnormalized paths" is fixed because the .gitattribute-file-seeking
  code is not confused into reading the top-level file twice.

* "relative paths" is fixed because the canonical pathnames are passed
  to get_checkattr() or get_allattrs(), allowing them to match the
  pathname patterns as expected.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I had a very hard time figuring out the correct approach to fixing
this problem.  There is so little documentation in the C code!  The
suggested patch fixes the tests, but it might be wrong for other
reasons:

1. I'm not sure whether it is correct to fix this problem at the level
   of git-check-attr, or whether the fix belongs in the API layer.
   What is the convention for API functions?  Do they typically take
   path names relative to the CWD or relative to the working tree
   root, or ...?  I also found examples of commands that change the
   current directory during their operation, making the CWD and the
   working tree root identical.  What is preferred?  (And where is it
   documented?)

2. It could be that I'm abusing the prefix_path() function, or that
   there is a better way to achieve the normalization.

 builtin/check-attr.c  |   20 ++++++++++++--------
 t/t0003-attributes.sh |    4 ++--
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 781b7df..23a6e07 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -41,22 +41,26 @@ static void output_attr(int cnt, struct git_attr_value *check,
 	}
 }
 
-static void check_attr(int cnt, struct git_attr_value *check,
-	const char *file)
+static void check_attr(const char *prefix, int cnt,
+	struct git_attr_value *check, const char *file)
 {
+	const char *full_path =
+		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_checkattr(file, cnt, check))
+		if (git_checkattr(full_path, cnt, check))
 			die("git_checkattr died");
 		output_attr(cnt, check, file);
 	} else {
-		if (git_allattrs(file, &cnt, &check))
+		if (git_allattrs(full_path, &cnt, &check))
 			die("git_allattrs died");
 		output_attr(cnt, check, file);
 		free(check);
 	}
+	free(full_path);
 }
 
-static void check_attr_stdin_paths(int cnt, struct git_attr_value *check)
+static void check_attr_stdin_paths(const char *prefix, int cnt,
+	struct git_attr_value *check)
 {
 	struct strbuf buf, nbuf;
 	int line_termination = null_term_line ? 0 : '\n';
@@ -70,7 +74,7 @@ static void check_attr_stdin_paths(int cnt, struct git_attr_value *check)
 				die("line is badly quoted");
 			strbuf_swap(&buf, &nbuf);
 		}
-		check_attr(cnt, check, buf.buf);
+		check_attr(prefix, cnt, check, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
@@ -154,10 +158,10 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	}
 
 	if (stdin_paths)
-		check_attr_stdin_paths(cnt, check);
+		check_attr_stdin_paths(prefix, cnt, check);
 	else {
 		for (i = filei; i < argc; i++)
-			check_attr(cnt, check, argv[i]);
+			check_attr(prefix, cnt, check, argv[i]);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	return 0;
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index f6cf77d..ae2f1da 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -93,7 +93,7 @@ test_expect_success 'attribute test' '
 
 '
 
-test_expect_failure 'unnormalized paths' '
+test_expect_success 'unnormalized paths' '
 
 	attr_check ./f f &&
 	attr_check ./a/g a/g &&
@@ -102,7 +102,7 @@ test_expect_failure 'unnormalized paths' '
 
 '
 
-test_expect_failure 'relative paths' '
+test_expect_success 'relative paths' '
 
 	(cd a && attr_check ../f f) &&
 	(cd a && attr_check f f) &&
-- 
1.7.6.8.gd2879
