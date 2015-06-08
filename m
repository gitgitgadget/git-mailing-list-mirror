From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 10/14] diff: use tempfile module
Date: Mon,  8 Jun 2015 11:07:41 +0200
Message-ID: <212de4f3fccb311f08fce109321a9b45e817ec3d.1433751986.git.mhagger@alum.mit.edu>
References: <cover.1433751986.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 08 11:08:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1t32-0002r8-Po
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 11:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbbFHJIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 05:08:41 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60500 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752716AbbFHJIM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2015 05:08:12 -0400
X-AuditID: 1207440e-f79fc6d000000caf-5c-55755b734b62
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 05.15.03247.37B55755; Mon,  8 Jun 2015 05:08:04 -0400 (EDT)
Received: from michael.fritz.box (p4FC977B6.dip0.t-ipconnect.de [79.201.119.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5897ojY010669
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 8 Jun 2015 05:08:03 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433751986.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqFsSXRpqcHYJq0XXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE7Y84fg4L/
	IhVXNn9mbmCcJtjFyMkhIWAisfLLDWYIW0ziwr31bF2MXBxCApcZJdoe9TNCOCeYJF4uOgBW
	xSagK7Gop5kJxBYRcJQ48eA6K4jNLOAgsflzIyOILSxgIPFuI4TNIqAq0T//A5jNKxAlcW3N
	AXaIbXIS54//BJvJKWAh8evrLqCZHEDLzCV+zGWdwMi7gJFhFaNcYk5prm5uYmZOcWqybnFy
	Yl5eapGusV5uZoleakrpJkZI8PDtYGxfL3OIUYCDUYmH98CiklAh1sSy4srcQ4ySHExKorwf
	I0pDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwMlkA5XhTEiurUovyYVLSHCxK4rxqS9T9hATS
	E0tSs1NTC1KLYLIyHBxKErw/IoEaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kFx
	EV8MjAyQFA/Q3lMg7bzFBYm5QFGI1lOMilLivEZRQAkBkERGaR7cWFhKeMUoDvSlMK8NSBUP
	MJ3Adb8CGswENPj712KQwSWJCCmpBkaNkrMv7gpP3MEaNodVMT0ofMe1rfISWULl+/a1i+9+
	+JXB8aJvzL+k+ZveH6rkY/G40Z3n5ucl2bxNf9/FJZeNX86Ib2OeING29NnfqbKbJ3Gt9fVb
	w8Tz+fsaLVf/OomFJnbf0oNOsEatZn2d1bBhvdlSc1eF1vId7R1+VRpVWdtemfhU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271008>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 diff.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/diff.c b/diff.c
index 7500c55..742a842 100644
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
+		if (diff_temp[i].tempfile.active)
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
+	temp->name = temp->tempfile.filename.buf;
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
2.1.4
