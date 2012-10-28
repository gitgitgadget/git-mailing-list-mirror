From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 7/8] setup_git_directory_gently_1(): resolve symlinks in ceiling paths
Date: Sun, 28 Oct 2012 17:16:26 +0100
Message-ID: <1351440987-26636-8-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVYG-0003Ww-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab2J1QRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:17:14 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:46707 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753086Ab2J1QRN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:17:13 -0400
X-AuditID: 12074411-b7fa36d0000008cc-09-508d5a870026
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id FE.44.02252.78A5D805; Sun, 28 Oct 2012 12:17:11 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJh002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:17:10 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqNse1Rtg8Hq1pUXXlW4mi4beK8wW
	T+beZbY4esrC4vaK+cwWP1p6mC3Wv7vK7MDu8ff9ByaPnbPusns8fNXF7vGsdw+jx8VLyh6f
	N8kFsEVx2yQllpQFZ6bn6dslcGdsmfyNseCveMW3A0/YGxjfCHcxcnJICJhI9H18wwxhi0lc
	uLeerYuRi0NI4DKjxKnTC5ghnDNMEk/XTGcEqWIT0JVY1NPMBGKLCMhKfD+8kRGkiFngLqPE
	pKNT2UASwgKREru/vgIbyyKgKjFhSzc7iM0r4CKxcdFPqHVyEh/2PAKKc3BwCrhKHO13BgkL
	AZX8WfWOcQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsYIQEnuINx
	xkm5Q4wCHIxKPLyXCnoChFgTy4orcw8xSnIwKYnyMgf1BgjxJeWnVGYkFmfEF5XmpBYfYpTg
	YFYS4V3KDZTjTUmsrEotyodJSXOwKInz8i1R9xMSSE8sSc1OTS1ILYLJynBwKEnwTo0EahQs
	Sk1PrUjLzClBSDNxcIIILpANPEAbzEEKeYsLEnOLM9Mhik4xKkqJ8x6LAEoIgCQySvPgBsBS
	wytGcaB/hHnTQNp5gGkFrvsV0GAmoME6fGCDSxIRUlINjGt+TZlz0z/tWYT8qees0xhzpbPz
	T+lf+RiTf3StHv+snWqvnbNOPXWcunSxYP+TIyEbE7Z7/w9Yy81tuK00/cDPEOUfz38HqUWJ
	Rn95ah2w4Ga9ROvry9/3Z7RZ6CUEKIvInr8ZYe3+7co+24D9pXXNH9bxix7/V9Zz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208557>

longest_ancestor_length() relies on a textual comparison of directory
parts to find the part of path that overlaps with one of the paths in
prefix_list.  But this doesn't work if any of the prefixes involves a
symbolic link, because the directories will look different even though
they might logically refer to the same directory.  So canonicalize the
paths listed in GIT_CEILING_DIRECTORIES using real_path_if_valid()
before passing them to longest_ancestor_length().  (Also rename
normalize_ceiling_entry() to canonicalize_ceiling_entry() to reflect
the change.)

path is already in canonical form, so doesn't need to be canonicalized
again.

This fixes some problems with using GIT_CEILING_DIRECTORIES that
contains paths involving symlinks, including t4035 if run with --root
set to a path involving symlinks.

Please note that test t0060 is *not* changed analogously, because that
would make the test suite results dependent on the contents of the
local root directory.  However, real_path() is already tested
independently, and the "ancestor" tests cover the non-normalization
aspects of longest_ancestor_length(), so coverage remains sufficient.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 setup.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/setup.c b/setup.c
index df97ad3..f108c4b 100644
--- a/setup.c
+++ b/setup.c
@@ -622,24 +622,23 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 }
 
 /*
- * A "string_list_each_func_t" function that normalizes an entry from
- * GIT_CEILING_DIRECTORIES or discards it if unusable.
+ * A "string_list_each_func_t" function that canonicalizes an entry
+ * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
+ * discards it if unusable.
  */
-static int normalize_ceiling_entry(struct string_list_item *item, void *unused)
+static int canonicalize_ceiling_entry(struct string_list_item *item,
+				      void *unused)
 {
-	const char *ceil = item->string;
-	int len = strlen(ceil);
-	char buf[PATH_MAX+1];
+	char *ceil = item->string;
+	const char *real_path;
 
-	if (len == 0 || len > PATH_MAX || !is_absolute_path(ceil))
+	if (!*ceil || !is_absolute_path(ceil))
 		return 0;
-	if (normalize_path_copy(buf, ceil) < 0)
+	real_path = real_path_if_valid(ceil);
+	if (!real_path)
 		return 0;
-	len = strlen(buf);
-	if (len > 1 && buf[len-1] == '/')
-		buf[--len] = '\0';
 	free(item->string);
-	item->string = xstrdup(buf);
+	item->string = xstrdup(real_path);
 	return 1;
 }
 
@@ -681,7 +680,8 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 
 	if (env_ceiling_dirs) {
 		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
-		filter_string_list(&ceiling_dirs, 0, normalize_ceiling_entry, NULL);
+		filter_string_list(&ceiling_dirs, 0,
+				   canonicalize_ceiling_entry, NULL);
 		ceil_offset = longest_ancestor_length(cwd, &ceiling_dirs);
 		string_list_clear(&ceiling_dirs, 0);
 	}
-- 
1.8.0
