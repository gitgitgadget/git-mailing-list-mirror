From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 1/5] fast-import: Let importers retrieve blobs
Date: Fri, 15 Oct 2010 23:54:12 +1100
Message-ID: <1287147256-9457-2-git-send-email-david.barr@cordelta.com>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 14:55:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6jog-0007tx-8B
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 14:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab0JOMyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 08:54:40 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:37328 "EHLO
	mail08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755492Ab0JOMyj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 08:54:39 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o9FCsPsl006314;
	Fri, 15 Oct 2010 23:54:28 +1100
X-Mailer: git-send-email 1.7.3.32.g634ef
In-Reply-To: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159116>

As the description of the "progress" option in git-fast-import.1
hints, there is no convenient way to immediately access the blobs
written to a new repository through fast-import.  Until a checkpoint
has been started and finishes writing the pack index, any new blobs
will not be accessible using standard git tools.

So introduce another way: a "cat-blob" command introduced in the
command stream requests for fast-import to print a blob to stdout
or a file descriptor specified by the argument --cat-blob-fd.

The output uses the same format as "git cat-file --batch".

Cc: Shawn O. Pearce <spearce@spearce.org>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: Sverre Rabbelier <srabbelier@gmail.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 Documentation/git-fast-import.txt |   34 ++++++++++++++
 fast-import.c                     |   92 +++++++++++++++++++++++++++++++++++++
 2 files changed, 126 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 966ba4f..42a100b 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -92,6 +92,17 @@ OPTIONS
 	--(no-)-relative-marks= with the --(import|export)-marks=
 	options.
 
+--cat-blob-fd=<fd>::
+	Specify the file descriptor that will be written to
+	when the `cat-blob` command is encountered in the stream.
+	The default behaviour is to write to `stdout`.
++
+The described objects are not necessarily accessible
+using standard git plumbing tools until a little while
+after the next checkpoint.  To request access to the
+blobs before then, use `cat-blob` lines in the command
+stream.
+
 --export-pack-edges=<file>::
 	After creating a packfile, print a line of data to
 	<file> listing the filename of the packfile and the last
@@ -320,6 +331,11 @@ and control the current import process.  More detailed discussion
 	standard output.  This command is optional and is not needed
 	to perform an import.
 
+`cat-blob`::
+	Causes fast-import to print a blob in 'cat-file --batch'
+	format to the file descriptor set with `--cat-blob-fd` or
+	`stdout` if unspecified.
+
 `feature`::
 	Require that fast-import supports the specified feature, or
 	abort if it does not.
@@ -876,6 +892,23 @@ Placing a `progress` command immediately after a `checkpoint` will
 inform the reader when the `checkpoint` has been completed and it
 can safely access the refs that fast-import updated.
 
+`cat-blob`
+~~~~~
+Causes fast-import to print a blob to a file descriptor previously
+arranged with the `--cat-blob-fd` argument.  The command otherwise
+has no impact on the current import; its main purpose is to
+retrieve blobs that may be in fast-import's memory but not
+accessible from the target repository a little quicker than by the
+method suggested by the description of the `progress` option.
+
+....
+	'cat-blob' SP <dataref> LF
+....
+
+The `<dataref>` can be either a mark reference (`:<idnum>`)
+set previously, or a full 40-byte SHA-1 of any Git blob,
+preexisting or ready to be written.
+
 `feature`
 ~~~~~~~~~
 Require that fast-import supports the specified feature, or abort if
@@ -896,6 +929,7 @@ The following features are currently supported:
 * date-format
 * import-marks
 * export-marks
+* cat-blob
 * relative-marks
 * no-relative-marks
 * force
diff --git a/fast-import.c b/fast-import.c
index 2317b0f..ea3e529 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -55,6 +55,8 @@ Format of STDIN stream:
     ('from' sp committish lf)?
     lf?;
 
+  cat_blob ::= 'cat-blob' sp (hexsha1 | idnum) lf;
+
   checkpoint ::= 'checkpoint' lf
     lf?;
 
@@ -361,6 +363,9 @@ static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
 
+/* Where to write output of cat-blob commands */
+static int cat_blob_fd = 1;
+
 static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
@@ -2680,6 +2685,77 @@ static void parse_reset_branch(void)
 		unread_command_buf = 1;
 }
 
+static void cat_blob_write(const char *buf, unsigned long size)
+{
+	if (write_in_full(cat_blob_fd, buf, size) != size)
+		die_errno("Write to frontend failed");
+}
+
+static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
+{
+	struct strbuf line = STRBUF_INIT;
+	unsigned long size;
+	enum object_type type = 0;
+	char *buf;
+
+	if (oe && oe->pack_id != MAX_PACK_ID) {
+		type = oe->type;
+		buf = gfi_unpack_entry(oe, &size);
+	} else {
+		buf = read_sha1_file(sha1, &type, &size);
+	}
+	if (!buf)
+		die("Can't read object %s", sha1_to_hex(sha1));
+
+	/*
+	 * Output based on batch_one_object() from cat-file.c.
+	 */
+	if (type <= 0) {
+		strbuf_reset(&line);
+		strbuf_addf(&line, "%s missing\n", sha1_to_hex(sha1));
+		cat_blob_write(line.buf, line.len);
+		return;
+	} else if (type != OBJ_BLOB) {
+		die("Object %s is a %s but a blob was expected.",
+		    sha1_to_hex(sha1), typename(type));
+	}
+	strbuf_reset(&line);
+	strbuf_addf(&line, "%s %s %lu\n", sha1_to_hex(sha1),
+						typename(type), size);
+	cat_blob_write(line.buf, line.len);
+	cat_blob_write(buf, size);
+	cat_blob_write("\n", 1);
+	free(buf);
+}
+
+
+static void parse_cat_blob(void)
+{
+	const char *p;
+	struct object_entry *oe = oe;
+	unsigned char sha1[20];
+
+	/* cat SP <object> */
+	p = command_buf.buf + strlen("cat-blob ");
+	if (*p == ':') {
+		char *x;
+		oe = find_mark(strtoumax(p + 1, &x, 10));
+		if (x == p + 1)
+			die("Invalid mark: %s", command_buf.buf);
+		if (!oe)
+			die("Unknown mark: %s", command_buf.buf);
+		p = x;
+		hashcpy(sha1, oe->idx.sha1);
+	} else {
+		if (get_sha1_hex(p, sha1))
+			die("Invalid SHA1: %s", command_buf.buf);
+		p += 40;
+		oe = find_object(sha1);
+	}
+
+	cat_blob(oe, sha1);
+}
+
 static void parse_checkpoint(void)
 {
 	if (object_count) {
@@ -2755,6 +2831,14 @@ static void option_export_marks(const char *marks)
 	safe_create_leading_directories_const(export_marks_file);
 }
 
+static void option_cat_blob_fd(const char *fd)
+{
+	unsigned long n = strtoul(fd, NULL, 0);
+	if (n > (unsigned long) INT_MAX)
+		die("--cat-blob-fd cannot exceed %d", INT_MAX);
+	cat_blob_fd = (int) n;
+}
+
 static void option_export_pack_edges(const char *edges)
 {
 	if (pack_edges)
@@ -2808,6 +2892,8 @@ static int parse_one_feature(const char *feature, int from_stream)
 		option_import_marks(feature + 13, from_stream);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
+	} else if (!prefixcmp(feature, "cat-blob")) {
+		/* Don't die - this feature is supported */
 	} else if (!prefixcmp(feature, "relative-marks")) {
 		relative_marks_paths = 1;
 	} else if (!prefixcmp(feature, "no-relative-marks")) {
@@ -2896,6 +2982,10 @@ static void parse_argv(void)
 		if (*a != '-' || !strcmp(a, "--"))
 			break;
 
+		if (!prefixcmp(a + 2, "cat-blob-fd=")) {
+			option_cat_blob_fd(a + 2 + 12);
+		}
+
 		if (parse_one_option(a + 2))
 			continue;
 
@@ -2953,6 +3043,8 @@ int main(int argc, const char **argv)
 			parse_new_tag();
 		else if (!prefixcmp(command_buf.buf, "reset "))
 			parse_reset_branch();
+		else if (!prefixcmp(command_buf.buf, "cat-blob "))
+			parse_cat_blob();
 		else if (!strcmp("checkpoint", command_buf.buf))
 			parse_checkpoint();
 		else if (!prefixcmp(command_buf.buf, "progress "))
-- 
1.7.3.32.g634ef
