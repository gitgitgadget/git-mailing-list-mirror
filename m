From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Wed, 18 Oct 2006 10:59:49 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061018085949.GA26501@cepheus.pub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 18 10:54:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga7Bk-0001PW-O6
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 10:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWJRIyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 04:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWJRIyJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 04:54:09 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:4046 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932136AbWJRIyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 04:54:05 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Ga7Bb-0004qs-HZ; Wed, 18 Oct 2006 10:54:04 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k9I8rxhg008558;
	Wed, 18 Oct 2006 10:53:59 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k9I8rnP5008555;
	Wed, 18 Oct 2006 10:53:49 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29205>

If no error occurs, merge (from rcs 5.7) is nothing but:

	diff3 -E -am -L label1 -L label2 -L label3 file1 file2 file3 > tmpfile
	cat tmpfile > file1

Using diff3 directly saves one fork per conflicting file.

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
---
 merge-recursive.c |   34 +++++++++++++++++++++++-----------
 1 files changed, 23 insertions(+), 11 deletions(-)

It passes `make test` when NO_SVN_TESTS is defined.  (I'll write a
separate mail about that.)

I didn't made any timing tests or further tests for correctness, but I
hope Johannes still has the framework from the time when he converted
the Python script to C?  

@Johannes: If so, could you test this patch?

Best regards
Uwe

diff --git a/merge-recursive.c b/merge-recursive.c
index 2ba43ae..9e3f9d7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -657,8 +657,11 @@ static struct merge_file_info merge_file
 			char orig[PATH_MAX];
 			char src1[PATH_MAX];
 			char src2[PATH_MAX];
+			char tmppath[PATH_MAX];
+
 			const char *argv[] = {
-				"merge", "-L", NULL, "-L", NULL, "-L", NULL,
+				"diff3", "-E", "-am",
+				"-L", NULL, "-L", NULL, "-L", NULL,
 				NULL, NULL, NULL,
 				NULL
 			};
@@ -668,23 +671,31 @@ static struct merge_file_info merge_file
 			git_unpack_file(a->sha1, src1);
 			git_unpack_file(b->sha1, src2);
 
-			argv[2] = la = xstrdup(mkpath("%s/%s", branch1, a->path));
-			argv[6] = lb = xstrdup(mkpath("%s/%s", branch2, b->path));
-			argv[4] = lo = xstrdup(mkpath("orig/%s", o->path));
-			argv[7] = src1;
-			argv[8] = orig;
-			argv[9] = src2,
+			argv[4] = la = xstrdup(mkpath("%s/%s", branch1, a->path));
+			argv[8] = lb = xstrdup(mkpath("%s/%s", branch2, b->path));
+			argv[6] = lo = xstrdup(mkpath("orig/%s", o->path));
+			argv[9] = src1;
+			argv[10] = orig;
+			argv[11] = src2;
+
+			fd = git_mkstemp(tmppath, sizeof(tmppath),
+					".merge_file_XXXXXX");
+			if (fd < 0)
+				die("unable to create temp-file");
+
+			dup2(fd, 1);
+			close(fd);
 
-			code = run_command_v(10, argv);
+			code = run_command_v(12, argv);
 
 			free(la);
 			free(lb);
 			free(lo);
 			if (code && code < -256) {
-				die("Failed to execute 'merge'. merge(1) is used as the "
-				    "file-level merge tool. Is 'merge' in your path?");
+				die("Failed to execute 'diff3'. diff3(1) is used as the "
+				    "file-level merge tool. Is 'diff3' in your path?");
 			}
-			fd = open(src1, O_RDONLY);
+			fd = open(tmppath, O_RDONLY);
 			if (fd < 0 || fstat(fd, &st) < 0 ||
 					index_fd(result.sha, fd, &st, 1,
 						"blob"))
@@ -693,6 +704,7 @@ static struct merge_file_info merge_file
 			unlink(orig);
 			unlink(src1);
 			unlink(src2);
+			unlink(tmppath);
 
 			result.clean = WEXITSTATUS(code) == 0;
 		} else {
-- 
1.4.3.rc2

-- 
Uwe Zeisberger

http://www.google.com/search?q=1+newton+in+kg*m+%2F+s%5E2
