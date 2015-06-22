From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] cat-file: add --buffer option
Date: Mon, 22 Jun 2015 06:45:17 -0400
Message-ID: <20150622104517.GD14475@peff.net>
References: <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:45:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zED-00063C-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbbFVKpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:45:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:49774 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754168AbbFVKpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:45:19 -0400
Received: (qmail 17387 invoked by uid 102); 22 Jun 2015 10:45:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:45:19 -0500
Received: (qmail 7543 invoked by uid 107); 22 Jun 2015 10:45:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:45:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:45:17 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272327>

We use a direct write() to output the results of --batch and
--batch-check. This is good for processes feeding the input
and reading the output interactively, but it introduces
measurable overhead if you do not want this feature. For
example, on linux.git:

  $ git rev-list --objects --all | cut -d' ' -f1 >objects
  $ time git cat-file --batch-check='%(objectsize)' \
          <objects >/dev/null
  real    0m5.440s
  user    0m5.060s
  sys     0m0.384s

This patch adds an option to use regular stdio buffering:

  $ time git cat-file --batch-check='%(objectsize)' \
          --buffer <objects >/dev/null
  real    0m4.975s
  user    0m4.888s
  sys     0m0.092s

Signed-off-by: Jeff King <peff@peff.net>
---
This selectively uses fwrite or write_or_die, depending on the buffer
setting. Another option would be to just always use fwrite(), and then
selectively fflush(). It feels kind of wasteful in the non-buffered
case, as it's just another layer to write through. OTOH, the cost of
writing a line into the buffer only to flush is probably dwarfed by the
system call of actually flushing.

If we went that direction, we could probably simplify the code a bit
(both getting rid of the batch_write function I call here, and dropping
a bunch of existing fflush() calls, where we must flush any time we use
printf for its formatting capabilities).

I also considered that the "--buffer" case is likely to be the common
one. We cannot flip the default, though, as it would break any existing
callers (who would need to specify "--no-buffer"). We can do the usual
deprecation dance, but I don't know if it is worth it for a plumbing
command like this.

 Documentation/git-cat-file.txt |  7 +++++++
 builtin/cat-file.c             | 26 +++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 319ab4c..0058bd4 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -69,6 +69,13 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--buffer::
+	Normally batch output is flushed after each object is output, so
+	that a process can interactively read and write from
+	`cat-file`. With this option, the output uses normal stdio
+	buffering; this is much more efficient when invoking
+	`--batch-check` on a large number of objects.
+
 --allow-unknown-type::
 	Allow -s or -t to query broken/corrupt objects of unknown type.
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d4101b7..741e100 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -14,6 +14,7 @@ struct batch_options {
 	int enabled;
 	int follow_symlinks;
 	int print_contents;
+	int buffer_output;
 	const char *format;
 };
 
@@ -211,14 +212,25 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 	return end - start + 1;
 }
 
-static void print_object_or_die(int fd, struct expand_data *data)
+static void batch_write(struct batch_options *opt, const void *data, int len)
+{
+	if (opt->buffer_output) {
+		if (fwrite(data, 1, len, stdout) != len)
+			die_errno("unable to write to stdout");
+	} else
+		write_or_die(1, data, len);
+}
+
+static void print_object_or_die(struct batch_options *opt, struct expand_data *data)
 {
 	const unsigned char *sha1 = data->sha1;
 
 	assert(data->info.typep);
 
 	if (data->type == OBJ_BLOB) {
-		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
+		if (opt->buffer_output)
+			fflush(stdout);
+		if (stream_blob_to_fd(1, sha1, NULL, 0) < 0)
 			die("unable to stream %s to stdout", sha1_to_hex(sha1));
 	}
 	else {
@@ -234,12 +246,11 @@ static void print_object_or_die(int fd, struct expand_data *data)
 		if (data->info.sizep && size != data->size)
 			die("object %s changed size!?", sha1_to_hex(sha1));
 
-		write_or_die(fd, contents, size);
+		batch_write(opt, contents, size);
 		free(contents);
 	}
 }
 
-
 static int batch_one_object(const char *obj_name, struct batch_options *opt,
 			    struct expand_data *data)
 {
@@ -294,12 +305,12 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 
 	strbuf_expand(&buf, opt->format, expand_format, data);
 	strbuf_addch(&buf, '\n');
-	write_or_die(1, buf.buf, buf.len);
+	batch_write(opt, buf.buf, buf.len);
 	strbuf_release(&buf);
 
 	if (opt->print_contents) {
-		print_object_or_die(1, data);
-		write_or_die(1, "\n", 1);
+		print_object_or_die(opt, data);
+		batch_write(opt, "\n", 1);
 	}
 	return 0;
 }
@@ -415,6 +426,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			    N_("for blob objects, run textconv on object's content"), 'c'),
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
+		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
 		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG, batch_option_callback },
-- 
2.4.4.719.g3984bc6
