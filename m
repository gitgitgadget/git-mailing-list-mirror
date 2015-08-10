From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 12/16] diff: use tempfile module
Date: Mon, 10 Aug 2015 11:47:47 +0200
Message-ID: <404c8bc508639a5723420691d9daa122f10d7cd4.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjh7-00021w-Ef
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752AbbHJJsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:19 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:49330 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754724AbbHJJsK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:10 -0400
X-AuditID: 1207440d-f79136d00000402c-bf-55c8735990c3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 9B.F5.16428.95378C55; Mon, 10 Aug 2015 05:48:09 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsx2021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:09 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqBtZfCLU4NA/E4uuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGQ+3PGQt
	mCJa8ez5DZYGxtWCXYycHBICJhIvp15lgrDFJC7cW8/WxcjFISRwmVFiccc+JgjnBJPEwtvH
	mEGq2AR0JRb1NIN1iAioSUxsO8QCYjMLpEucWNAOZHNwCAsYS/QuCQQxWQRUJbZ3KoBU8ApE
	SVzb2csEEpYQkJNYcCEdJMwpYCGxvXEDK4gtJGAu8XjeefYJjLwLGBlWMcol5pTm6uYmZuYU
	pybrFicn5uWlFuka6eVmluilppRuYoSEDu8Oxv/rZA4xCnAwKvHwzth8PFSINbGsuDL3EKMk
	B5OSKK9F/olQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK88RlAOd6UxMqq1KJ8mJQ0B4uSOK/a
	EnU/IYH0xJLU7NTUgtQimKwMB4eSBK98EVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFi
	aUlGPCgq4ouBcQGS4gHae6QQZG9xQWIuUBSi9RSjopQ47x+QhABIIqM0D24sLCG8YhQH+lKY
	9ydIFQ8wmcB1vwIazAQ02C4QbHBJIkJKqoHR4+W+M5/Ut3OGZywS1V/12DAvZN2XxaxGmT63
	boq16gvrcew99bd1pq6s176p5XI3b9yaYrf1/1ndxrVz1UR8pLuXR27+/5Xz2P7kuZ42HHtr
	It++nR7TWOGhfUzW3GZt6nQe693a3ZKvZQoPt+W71jImtOfzvtm6sn192oEv1VuP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275593>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 7500c55..dc95247 100644
--- a/diff.c
+++ b/diff.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "tempfile.h"
 #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -312,7 +313,7 @@ static struct diff_tempfile {
 	const char *name; /* filename external diff should read from */
 	char hex[41];
 	char mode[10];
-	char tmp_path[PATH_MAX];
+	struct tempfile tempfile;
 } diff_temp[2];
 
 typedef unsigned long (*sane_truncate_fn)(char *line, unsigned long len);
@@ -564,25 +565,16 @@ static struct diff_tempfile *claim_diff_tempfile(void) {
 	die("BUG: diff is failing to clean up its tempfiles");
 }
 
-static int remove_tempfile_installed;
-
 static void remove_tempfile(void)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
-		if (diff_temp[i].name == diff_temp[i].tmp_path)
-			unlink_or_warn(diff_temp[i].name);
+		if (is_tempfile_active(&diff_temp[i].tempfile))
+			delete_tempfile(&diff_temp[i].tempfile);
 		diff_temp[i].name = NULL;
 	}
 }
 
-static void remove_tempfile_on_signal(int signo)
-{
-	remove_tempfile();
-	sigchain_pop(signo);
-	raise(signo);
-}
-
 static void print_line_count(FILE *file, int count)
 {
 	switch (count) {
@@ -2817,8 +2809,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	strbuf_addstr(&template, "XXXXXX_");
 	strbuf_addstr(&template, base);
 
-	fd = git_mkstemps(temp->tmp_path, PATH_MAX, template.buf,
-			strlen(base) + 1);
+	fd = mks_tempfile_ts(&temp->tempfile, template.buf, strlen(base) + 1);
 	if (fd < 0)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(path,
@@ -2828,8 +2819,8 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 	}
 	if (write_in_full(fd, blob, size) != size)
 		die_errno("unable to write temp-file");
-	close(fd);
-	temp->name = temp->tmp_path;
+	close_tempfile(&temp->tempfile);
+	temp->name = get_tempfile_path(&temp->tempfile);
 	strcpy(temp->hex, sha1_to_hex(sha1));
 	temp->hex[40] = 0;
 	sprintf(temp->mode, "%06o", mode);
@@ -2854,12 +2845,6 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		return temp;
 	}
 
-	if (!remove_tempfile_installed) {
-		atexit(remove_tempfile);
-		sigchain_push_common(remove_tempfile_on_signal);
-		remove_tempfile_installed = 1;
-	}
-
 	if (!S_ISGITLINK(one->mode) &&
 	    (!one->sha1_valid ||
 	     reuse_worktree_file(name, one->sha1, 1))) {
-- 
2.5.0
