From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] fast-import.c: detect fclose- and fflush-induced write failure
Date: Mon, 25 Jun 2007 11:39:27 +0200
Message-ID: <87abuoxtio.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 11:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2l2q-0007bv-8J
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 11:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbXFYJja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 05:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754555AbXFYJj3
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 05:39:29 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:44055 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518AbXFYJj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 05:39:28 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7B48E5A22A
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 11:39:27 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 4D30E2BBF7; Mon, 25 Jun 2007 11:39:27 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50883>

There are potentially ignored write errors in fast-import.c.
Here's a proof-of-concept patch.
Something like close_stream might be worth making more generally
accessible, but rather than close_wstream_or_die, I'd prefer general
purpose die-like functions that take an errno value, e.g.,

  die_errno (errno, fmt_str, arg1, ...)

that would work just like die, with this change:
- when errno is nonzero,
    append the concatenation of ": " and strerror(errno)
    between the format-string-denoted output and the final newline
- when errno is zero
    work just like "die" currently does.

This functionality is like that provided by the error, warn*,
err, verr, etc. functions that have been in glibc forever.

With such a function (and an error_errno analog), the nearly-identical
uses of "error" added below and the nearly identical uses of "die" that
might end up in git.c could be factored out.

Here's a ChangeLog-style entry:

 (end_packfile): Die upon fflush failure.
 (close_stream, close_wstream_or_die): New functions.
 (dump_marks): Upon fclose failure, rollback the lock and give a diagnostic.
 (main): Die upon fclose failure.  Record pack_edges file name for use in diagnostics.

Signed-off-by: Jim Meyering <jim@meyering.net>
---
 fast-import.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index f9bfcc7..7941839 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -793,7 +793,9 @@ static void end_packfile(void)
 					fprintf(pack_edges, " %s", sha1_to_hex(t->sha1));
 			}
 			fputc('\n', pack_edges);
-			fflush(pack_edges);
+			if (fflush(pack_edges))
+				die("failed to write pack-edges file: %s",
+				    strerror(errno));
 		}

 		pack_id++;
@@ -1344,6 +1346,31 @@ static void dump_marks_helper(FILE *f,
 	}
 }

+static int
+close_stream(FILE *stream)
+{
+	int prev_fail = (ferror(stream) != 0);
+	int fclose_fail = (fclose(stream) != 0);
+
+	if (prev_fail || fclose_fail) {
+		if (! fclose_fail)
+			errno = 0;
+		return EOF;
+	}
+	return 0;
+}
+
+static void
+close_wstream_or_die(FILE *stream, const char *file_name)
+{
+	if (close_stream(stream)) {
+		if (errno == 0)
+			die ("%s: write failed: %s", file_name, strerror(errno));
+		else
+			die ("%s: write failed", file_name);
+	}
+}
+
 static void dump_marks(void)
 {
 	static struct lock_file mark_lock;
@@ -1369,7 +1396,18 @@ static void dump_marks(void)
 	}

 	dump_marks_helper(f, 0, marks);
-	fclose(f);
+	if (close_stream(f) != 0) {
+		int close_errno = errno;
+		rollback_lock_file(&mark_lock);
+		failure |=
+		  (close_errno == 0
+		   ? error("Failed to write temporary marks file %s.lock",
+			   mark_file)
+		   : error("Failed to write temporary marks file %s.lock: %s",
+			   mark_file, strerror(close_errno)));
+		return;
+	}
+
 	if (commit_lock_file(&mark_lock))
 		failure |= error("Unable to write marks file %s: %s",
 			mark_file, strerror(errno));
@@ -2015,6 +2053,7 @@ static const char fast_import_usage[] =
 int main(int argc, const char **argv)
 {
 	int i, show_stats = 1;
+	const char *pack_edges_file = NULL;

 	git_config(git_default_config);
 	alloc_objects(object_entry_alloc);
@@ -2052,10 +2091,13 @@ int main(int argc, const char **argv)
 			mark_file = a + 15;
 		else if (!prefixcmp(a, "--export-pack-edges=")) {
 			if (pack_edges)
-				fclose(pack_edges);
-			pack_edges = fopen(a + 20, "a");
+				close_wstream_or_die(pack_edges,
+						     pack_edges_file);
+			pack_edges_file = a + 20;
+			pack_edges = fopen(pack_edges_file, "a");
 			if (!pack_edges)
-				die("Cannot open %s: %s", a + 20, strerror(errno));
+				die("Cannot open %s: %s", pack_edges_file,
+				    strerror(errno));
 		} else if (!strcmp(a, "--force"))
 			force_update = 1;
 		else if (!strcmp(a, "--quiet"))
@@ -2095,7 +2137,7 @@ int main(int argc, const char **argv)
 	dump_marks();

 	if (pack_edges)
-		fclose(pack_edges);
+		close_wstream_or_die(pack_edges, pack_edges_file);

 	if (show_stats) {
 		uintmax_t total_count = 0, duplicate_count = 0;
