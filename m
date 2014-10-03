From: Jeff King <peff@peff.net>
Subject: [PATCH 11/16] count-objects: use for_each_loose_file_in_objdir
Date: Fri, 3 Oct 2014 16:31:50 -0400
Message-ID: <20141003203150.GK16293@peff.net>
References: <20141003202045.GA15205@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 22:31:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9W8-0002ID-P0
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:31:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbaJCUbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:31:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:54853 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbaJCUbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:31:52 -0400
Received: (qmail 3202 invoked by uid 102); 3 Oct 2014 20:31:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 15:31:52 -0500
Received: (qmail 15132 invoked by uid 107); 3 Oct 2014 20:31:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 16:31:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 16:31:50 -0400
Content-Disposition: inline
In-Reply-To: <20141003202045.GA15205@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257862>

This drops our line count considerably, and should make
things more readable by keeping the counting logic separate
from the traversal.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/count-objects.c | 101 ++++++++++++++----------------------------------
 1 file changed, 30 insertions(+), 71 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 316a805..e47ef0b 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -11,6 +11,9 @@
 
 static unsigned long garbage;
 static off_t size_garbage;
+static int verbose;
+static unsigned long loose, packed, packed_loose;
+static off_t loose_size;
 
 static void real_report_garbage(const char *desc, const char *path)
 {
@@ -21,61 +24,31 @@ static void real_report_garbage(const char *desc, const char *path)
 	garbage++;
 }
 
-static void count_objects(DIR *d, char *path, int len, int verbose,
-			  unsigned long *loose,
-			  off_t *loose_size,
-			  unsigned long *packed_loose)
+static void loose_garbage(const char *path)
 {
-	struct dirent *ent;
-	while ((ent = readdir(d)) != NULL) {
-		char hex[41];
-		unsigned char sha1[20];
-		const char *cp;
-		int bad = 0;
+	if (verbose)
+		report_garbage("garbage found", path);
+}
 
-		if (is_dot_or_dotdot(ent->d_name))
-			continue;
-		for (cp = ent->d_name; *cp; cp++) {
-			int ch = *cp;
-			if (('0' <= ch && ch <= '9') ||
-			    ('a' <= ch && ch <= 'f'))
-				continue;
-			bad = 1;
-			break;
-		}
-		if (cp - ent->d_name != 38)
-			bad = 1;
-		else {
-			struct stat st;
-			memcpy(path + len + 3, ent->d_name, 38);
-			path[len + 2] = '/';
-			path[len + 41] = 0;
-			if (lstat(path, &st) || !S_ISREG(st.st_mode))
-				bad = 1;
-			else
-				(*loose_size) += on_disk_bytes(st);
-		}
-		if (bad) {
-			if (verbose) {
-				struct strbuf sb = STRBUF_INIT;
-				strbuf_addf(&sb, "%.*s/%s",
-					    len + 2, path, ent->d_name);
-				report_garbage("garbage found", sb.buf);
-				strbuf_release(&sb);
-			}
-			continue;
-		}
-		(*loose)++;
-		if (!verbose)
-			continue;
-		memcpy(hex, path+len, 2);
-		memcpy(hex+2, ent->d_name, 38);
-		hex[40] = 0;
-		if (get_sha1_hex(hex, sha1))
-			die("internal error");
-		if (has_sha1_pack(sha1))
-			(*packed_loose)++;
+static int count_loose(const unsigned char *sha1, const char *path, void *data)
+{
+	struct stat st;
+
+	if (lstat(path, &st) || !S_ISREG(st.st_mode))
+		loose_garbage(path);
+	else {
+		loose_size += on_disk_bytes(st);
+		loose++;
+		if (verbose && has_sha1_pack(sha1))
+			packed_loose++;
 	}
+	return 0;
+}
+
+static int count_cruft(const char *basename, const char *path, void *data)
+{
+	loose_garbage(path);
+	return 0;
 }
 
 static char const * const count_objects_usage[] = {
@@ -85,12 +58,7 @@ static char const * const count_objects_usage[] = {
 
 int cmd_count_objects(int argc, const char **argv, const char *prefix)
 {
-	int i, verbose = 0, human_readable = 0;
-	const char *objdir = get_object_directory();
-	int len = strlen(objdir);
-	char *path = xmalloc(len + 50);
-	unsigned long loose = 0, packed = 0, packed_loose = 0;
-	off_t loose_size = 0;
+	int human_readable = 0;
 	struct option opts[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_BOOL('H', "human-readable", &human_readable,
@@ -104,19 +72,10 @@ int cmd_count_objects(int argc, const char **argv, const char *prefix)
 		usage_with_options(count_objects_usage, opts);
 	if (verbose)
 		report_garbage = real_report_garbage;
-	memcpy(path, objdir, len);
-	if (len && objdir[len-1] != '/')
-		path[len++] = '/';
-	for (i = 0; i < 256; i++) {
-		DIR *d;
-		sprintf(path + len, "%02x", i);
-		d = opendir(path);
-		if (!d)
-			continue;
-		count_objects(d, path, len, verbose,
-			      &loose, &loose_size, &packed_loose);
-		closedir(d);
-	}
+
+	for_each_loose_file_in_objdir(get_object_directory(),
+				      count_loose, count_cruft, NULL, NULL);
+
 	if (verbose) {
 		struct packed_git *p;
 		unsigned long num_pack = 0;
-- 
2.1.1.566.gdb1f904
