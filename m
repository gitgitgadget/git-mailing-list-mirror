From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] diff: add filter for converting binary to text
Date: Sun, 5 Oct 2008 17:43:45 -0400
Message-ID: <20081005214345.GD21925@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Oct 05 23:45:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmbPT-0001sw-8G
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 23:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbYJEVnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 17:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754943AbYJEVnt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 17:43:49 -0400
Received: from peff.net ([208.65.91.99]:2852 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754920AbYJEVns (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 17:43:48 -0400
Received: (qmail 17920 invoked by uid 111); 5 Oct 2008 21:43:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 05 Oct 2008 17:43:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Oct 2008 17:43:45 -0400
Content-Disposition: inline
In-Reply-To: <20081005214114.GA21875@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97541>

When diffing binary files, it is sometimes nice to see the
differences of a canonical text form rather than either a
binary patch or simply "binary files differ."

Until now, the only option for doing this was to define an
external diff command to perform the diff. This was a lot of
work, since the external command needed to take care of
doing the diff itself (including mode changes), and lost the
benefit of git's colorization and other options.

This patch adds a text conversion option, which converts a
file to its canonical format before performing the diff.
This is less flexible than an arbitrary external diff, but
is much less work to set up. For example:

  $ echo '*.jpg diff=exif' >>.gitattributes
  $ git config diff.exif.textconv exiftool
  $ git config diff.exif.binary false

allows one to see jpg diffs represented by the text output
of exiftool.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c     |   49 +++++++++++++++++++++++++++++++++++++++++++++++--
 userdiff.c |    2 ++
 userdiff.h |    1 +
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index ba4f6fa..421da29 100644
--- a/diff.c
+++ b/diff.c
@@ -38,6 +38,9 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	"\033[41m",	/* WHITESPACE (red background) */
 };
 
+static void diff_filespec_load_driver(struct diff_filespec *one);
+static char *run_textconv(const char *, struct diff_filespec *, size_t *);
+
 static int parse_diff_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -291,8 +294,19 @@ static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
 	}
 	else if (diff_populate_filespec(one, 0))
 		return -1;
-	mf->ptr = one->data;
-	mf->size = one->size;
+
+	diff_filespec_load_driver(one);
+	if (one->driver->textconv) {
+		size_t size;
+		mf->ptr = run_textconv(one->driver->textconv, one, &size);
+		if (!mf->ptr)
+			return -1;
+		mf->size = size;
+	}
+	else {
+		mf->ptr = one->data;
+		mf->size = one->size;
+	}
 	return 0;
 }
 
@@ -3374,3 +3388,34 @@ void diff_unmerge(struct diff_options *options,
 	fill_filespec(one, sha1, mode);
 	diff_queue(&diff_queued_diff, one, two)->is_unmerged = 1;
 }
+
+static char *run_textconv(const char *pgm, struct diff_filespec *spec,
+		size_t *outsize)
+{
+	struct diff_tempfile temp;
+	const char *argv[3];
+	const char **arg = argv;
+	struct child_process child;
+	struct strbuf buf = STRBUF_INIT;
+
+	prepare_temp_file(spec->path, &temp, spec);
+	*arg++ = pgm;
+	*arg++ = temp.name;
+	*arg = NULL;
+
+	memset(&child, 0, sizeof(child));
+	child.argv = argv;
+	child.out = -1;
+	if (start_command(&child) != 0 ||
+	    strbuf_read(&buf, child.out, 0) < 0 ||
+	    finish_command(&child) != 0) {
+		if (temp.name == temp.tmp_path)
+			unlink(temp.name);
+		error("error running textconv command '%s'", pgm);
+		return NULL;
+	}
+	if (temp.name == temp.tmp_path)
+		unlink(temp.name);
+
+	return strbuf_detach(&buf, outsize);
+}
diff --git a/userdiff.c b/userdiff.c
index ac6d4a1..02f225f 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -131,6 +131,8 @@ int userdiff_config_porcelain(const char *k, const char *v)
 
 	if ((drv = parse_driver(k, v, "command")))
 		return parse_string(&drv->external, k, v);
+	if ((drv = parse_driver(k, v, "textconv")))
+		return parse_string(&drv->textconv, k, v);
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 1c1eb04..f29c18f 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -11,6 +11,7 @@ struct userdiff_driver {
 	const char *external;
 	int binary;
 	struct userdiff_funcname funcname;
+	const char *textconv;
 };
 
 int userdiff_config_basic(const char *k, const char *v);
-- 
1.6.0.2.639.g4d7f.dirty
