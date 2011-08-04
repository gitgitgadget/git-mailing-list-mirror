From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 4/6] git-check-attr: Normalize paths
Date: Thu,  4 Aug 2011 06:47:46 +0200
Message-ID: <1312433268-11385-5-git-send-email-mhagger@alum.mit.edu>
References: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
Cc: gitster@pobox.com, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 06:48:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoprE-0000n2-IB
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab1HDEsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:48:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:39757 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1HDEsC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:48:02 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB339.dip.t-dialin.net [84.190.179.57])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p744ltPZ029942;
	Thu, 4 Aug 2011 06:47:58 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1312433268-11385-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178697>

Normalize the path arguments (relative to the working tree root, if
applicable) before looking up their attributes.  This requires passing
the prefix down the call chain.

This fixes two test cases for different reasons:

* "unnormalized paths" is fixed because the .gitattribute-file-seeking
  code is not confused into reading the top-level file twice.

* "relative paths" is fixed because the canonical pathnames are passed
  to get_check_attr() or get_all_attrs(), allowing them to match the
  pathname patterns as expected.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-attr.c  |   20 ++++++++++++--------
 t/t0003-attributes.sh |    4 ++--
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 6b16368..708988a 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -41,22 +41,26 @@ static void output_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
-static void check_attr(int cnt, struct git_attr_check *check,
-	const char *file)
+static void check_attr(const char *prefix, int cnt,
+	struct git_attr_check *check, const char *file)
 {
+	char *full_path =
+		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attr(file, cnt, check))
+		if (git_check_attr(full_path, cnt, check))
 			die("git_check_attr died");
 		output_attr(cnt, check, file);
 	} else {
-		if (git_all_attrs(file, &cnt, &check))
+		if (git_all_attrs(full_path, &cnt, &check))
 			die("git_all_attrs died");
 		output_attr(cnt, check, file);
 		free(check);
 	}
+	free(full_path);
 }
 
-static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
+static void check_attr_stdin_paths(const char *prefix, int cnt,
+	struct git_attr_check *check)
 {
 	struct strbuf buf, nbuf;
 	int line_termination = null_term_line ? 0 : '\n';
@@ -70,7 +74,7 @@ static void check_attr_stdin_paths(int cnt, struct git_attr_check *check)
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
