From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] logmsg_reencode: lazily load missing commit buffers
Date: Sat, 26 Jan 2013 04:44:28 -0500
Message-ID: <20130126094428.GC6999@sigill.intra.peff.net>
References: <20130126094026.GA9646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <jmah@me.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 10:44:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz2Jh-00049K-Qs
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 10:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753024Ab3AZJoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 04:44:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51386 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752840Ab3AZJoa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 04:44:30 -0500
Received: (qmail 21188 invoked by uid 107); 26 Jan 2013 09:45:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 04:45:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 04:44:28 -0500
Content-Disposition: inline
In-Reply-To: <20130126094026.GA9646@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214618>

Usually a commit that makes it to logmsg_reencode will have
been parsed, and the commit->buffer struct member will be
valid. However, some code paths will free commit buffers
after having used them (for example, the log traversal
machinery will do so to keep memory usage down).

Most of the time this is fine; log should only show a commit
once, and then exits. However, there are some code paths
where this does not work. At least two are known:

  1. A commit may be shown as part of a regular ref, and
     then it may be shown again as part of a submodule diff
     (e.g., if a repo contains refs to both the superproject
     and subproject).

  2. A notes-cache commit may be shown during "log --all",
     and then later used to access a textconv cache during a
     diff.

Lazily loading in logmsg_reencode does not necessarily catch
all such cases, but it should catch most of them. Users of
the commit buffer tend to be either parsing for structure
(in which they will call parse_commit, and either we will
already have parsed, or we will load commit->buffer lazily
there), or outputting (either to the user, or fetching a
part of the commit message via format_commit_message). In
the latter case, we should always be using logmsg_reencode
anyway (and typically we do so via the pretty-print
machinery).

If there are any cases that this misses, we can fix them up
to use logmsg_reencode (or handle them on a case-by-case
basis if that is inappropriate).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c                  | 13 ---------
 pretty.c                         | 57 ++++++++++++++++++++++++++++++++++------
 t/t4042-diff-textconv-caching.sh |  8 ++++++
 3 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 962e4e3..86100e9 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1424,19 +1424,6 @@ static void get_commit_info(struct commit *commit,
 
 	commit_info_init(ret);
 
-	/*
-	 * We've operated without save_commit_buffer, so
-	 * we now need to populate them for output.
-	 */
-	if (!commit->buffer) {
-		enum object_type type;
-		unsigned long size;
-		commit->buffer =
-			read_sha1_file(commit->object.sha1, &type, &size);
-		if (!commit->buffer)
-			die("Cannot read commit %s",
-			    sha1_to_hex(commit->object.sha1));
-	}
 	encoding = get_log_output_encoding();
 	message = logmsg_reencode(commit, encoding);
 	get_ac_line(message, "\nauthor ",
diff --git a/pretty.c b/pretty.c
index c675349..eae57ad 100644
--- a/pretty.c
+++ b/pretty.c
@@ -592,18 +592,59 @@ char *logmsg_reencode(const struct commit *commit,
 	char *msg = commit->buffer;
 	char *out;
 
+	if (!msg) {
+		enum object_type type;
+		unsigned long size;
+
+		msg = read_sha1_file(commit->object.sha1, &type, &size);
+		if (!msg)
+			die("Cannot read commit object %s",
+			    sha1_to_hex(commit->object.sha1));
+		if (type != OBJ_COMMIT)
+			die("Expected commit for '%s', got %s",
+			    sha1_to_hex(commit->object.sha1), typename(type));
+	}
+
 	if (!output_encoding || !*output_encoding)
 		return msg;
 	encoding = get_header(commit, msg, "encoding");
 	use_encoding = encoding ? encoding : utf8;
-	if (same_encoding(use_encoding, output_encoding))
-		if (encoding) /* we'll strip encoding header later */
-			out = xstrdup(commit->buffer);
-		else
-			return msg; /* nothing to do */
-	else
-		out = reencode_string(commit->buffer,
-				      output_encoding, use_encoding);
+	if (same_encoding(use_encoding, output_encoding)) {
+		/*
+		 * No encoding work to be done. If we have no encoding header
+		 * at all, then there's nothing to do, and we can return the
+		 * message verbatim (whether newly allocated or not).
+		 */
+		if (!encoding)
+			return msg;
+
+		/*
+		 * Otherwise, we still want to munge the encoding header in the
+		 * result, which will be done by modifying the buffer. If we
+		 * are using a fresh copy, we can reuse it. But if we are using
+		 * the cached copy from commit->buffer, we need to duplicate it
+		 * to avoid munging commit->buffer.
+		 */
+		out = msg;
+		if (out == commit->buffer)
+			out = xstrdup(out);
+	}
+	else {
+		/*
+		 * There's actual encoding work to do. Do the reencoding, which
+		 * still leaves the header to be replaced in the next step. At
+		 * this point, we are done with msg. If we allocated a fresh
+		 * copy, we can free it.
+		 */
+		out = reencode_string(msg, output_encoding, use_encoding);
+		if (out && msg != commit->buffer)
+			free(msg);
+	}
+
+	/*
+	 * This replacement actually consumes the buffer we hand it, so we do
+	 * not have to worry about freeing the old "out" here.
+	 */
 	if (out)
 		out = replace_encoding_header(out, output_encoding);
 
diff --git a/t/t4042-diff-textconv-caching.sh b/t/t4042-diff-textconv-caching.sh
index 91f8198..04a44d5 100755
--- a/t/t4042-diff-textconv-caching.sh
+++ b/t/t4042-diff-textconv-caching.sh
@@ -106,4 +106,12 @@ test_expect_success 'switching diff driver produces correct results' '
 	test_cmp expect actual
 '
 
+# The point here is to test that we can log the notes cache and still use it to
+# produce a diff later (older versions of git would segfault on this). It's
+# much more likely to come up in the real world with "log --all -p", but using
+# --no-walk lets us reliably reproduce the order of traversal.
+test_expect_success 'log notes cache and still use cache for -p' '
+	git log --no-walk -p refs/notes/textconv/magic HEAD
+'
+
 test_done
-- 
1.8.0.2.16.g72e2fc9
