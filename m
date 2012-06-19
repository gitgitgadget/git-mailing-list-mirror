From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] diff-no-index: exit(1) if 'diff --quiet <repo file>
 <external file>' finds changes
Date: Tue, 19 Jun 2012 09:58:15 -0400
Message-ID: <20120619135814.GA3210@sigill.intra.peff.net>
References: <1340047704-8752-1-git-send-email-tim.henigan@gmail.com>
 <7vr4tc2xhy.fsf@alter.siamese.dyndns.org>
 <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 15:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sgywr-0003Do-Nb
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 15:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664Ab2FSN6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 09:58:21 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:60981
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab2FSN6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 09:58:21 -0400
Received: (qmail 9139 invoked by uid 107); 19 Jun 2012 13:58:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 19 Jun 2012 09:58:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2012 09:58:15 -0400
Content-Disposition: inline
In-Reply-To: <CAFouethcrw3vOF7SPwHxjH4ABmF8U1df0MfyzcUGq2yTYxs4ow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200200>

On Tue, Jun 19, 2012 at 09:05:40AM -0400, Tim Henigan wrote:

> As a side note, I found that these tests fail if a relative path is
> used for the file in 'non/git'.  In other words, this passes:
> 
>     test_expect_code 0 git diff --quiet a
> "$TRASH_DIRECTORY/test-outside/non/git/matching-file"
> 
> but this fails:
> 
>     test_expect_code 0 git diff --quiet a ../non/git/matching-file
> 
> This surprised me, but I have not investigated any further.

The problem is that path_outside_repo in diff-no-index.c does not bother
handling relative paths at all, and just assumes they are inside the
repository. This is obviously not true if the path starts with "..", in
which case you would need to compare the number of ".." with the current
depth in the repository.

prefix_path already does this (and is what generates the later
"../non/git/matching-file is not in the repository" message). We could
perhaps get rid of path_outside_repo and just re-use prefix_path's
logic, something like (not tested):

diff --git a/cache.h b/cache.h
index 0b7ddee..0736bfb 100644
--- a/cache.h
+++ b/cache.h
@@ -411,6 +411,7 @@ extern const char *prefix_filename(const char *prefix, int len, const char *path
 extern int check_filename(const char *prefix, const char *name);
 extern void verify_filename(const char *prefix, const char *name);
 extern void verify_non_filename(const char *prefix, const char *name);
+extern int path_inside_repo(const char *prefix, const char *path);
 
 #define INIT_DB_QUIET 0x0001
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 6911196..9a1b459 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -151,23 +151,6 @@ static int queue_diff(struct diff_options *o,
 	}
 }
 
-static int path_outside_repo(const char *path)
-{
-	const char *work_tree;
-	size_t len;
-
-	if (!is_absolute_path(path))
-		return 0;
-	work_tree = get_git_work_tree();
-	if (!work_tree)
-		return 1;
-	len = strlen(work_tree);
-	if (strncmp(path, work_tree, len) ||
-	    (path[len] != '\0' && path[len] != '/'))
-		return 1;
-	return 0;
-}
-
 void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   int nongit, const char *prefix)
@@ -197,8 +180,8 @@ void diff_no_index(struct rev_info *revs,
 		 * a colourful "diff" replacement.
 		 */
 		if ((argc != i + 2) ||
-		    (!path_outside_repo(argv[i]) &&
-		     !path_outside_repo(argv[i+1])))
+		    (path_inside_repo(prefix, argv[i]) &&
+		     path_inside_repo(prefix, argv[i+1])))
 			return;
 	}
 	if (argc != i + 2)
diff --git a/setup.c b/setup.c
index 731851a..2cfa037 100644
--- a/setup.c
+++ b/setup.c
@@ -4,7 +4,7 @@
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
 
-char *prefix_path(const char *prefix, int len, const char *path)
+static char *prefix_path_gently(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
 	char *sanitized;
@@ -31,7 +31,8 @@ char *prefix_path(const char *prefix, int len, const char *path)
 		if (strncmp(sanitized, work_tree, len) ||
 		    (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
 		error_out:
-			die("'%s' is outside repository", orig);
+			free(sanitized);
+			return NULL;
 		}
 		if (sanitized[len] == '/')
 			len++;
@@ -40,6 +41,25 @@ char *prefix_path(const char *prefix, int len, const char *path)
 	return sanitized;
 }
 
+char *prefix_path(const char *prefix, int len, const char *path)
+{
+	char *r = prefix_path_gently(prefix, len, path);
+	if (!r)
+		die("'%s' is outside repository", path);
+	return r;
+}
+
+int path_inside_repo(const char *prefix, const char *path)
+{
+	int len = prefix ? strlen(prefix) : 0;
+	char *r = prefix_path_gently(prefix, len, path);
+	if (r) {
+		free(r);
+		return 1;
+	}
+	return 0;
+}
+
 int check_filename(const char *prefix, const char *arg)
 {
 	const char *name;
