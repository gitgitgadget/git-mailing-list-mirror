From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/3] Allow git-apply to ignore the hunk headers (AKA recountdiff)
Date: Tue, 24 Jun 2008 20:08:15 +0100
Message-ID: <200806242108.16379.trast@student.ethz.ch>
References: <20080624050901.GA19224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 21:12:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBDwA-0004ER-8A
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbYFXTLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYFXTLY
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:11:24 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:52328 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbYFXTLV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:11:21 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 21:11:18 +0200
Received: from [192.168.0.2] ([84.75.156.10]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 24 Jun 2008 21:11:18 +0200
In-Reply-To: <20080624050901.GA19224@sigill.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 24 Jun 2008 19:11:18.0697 (UTC) FILETIME=[14DDA990:01C8D62E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86111>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Sometimes, the easiest way to fix up a patch is to edit it directly, even
adding or deleting lines.  Now, many people are not as divine as certain
benevolent dictators as to update the hunk headers correctly at the first
try.

So teach the tool to do it for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-apply.txt |    7 ++++-
 builtin-apply.c             |   64 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index c834763..b8ab6ed 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
 	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
+	  [-pNUM] [-CNUM] [--inaccurate-eof] [--recount] [--cached]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
 	  [--exclude=PATH] [--verbose] [<patch>...]
 
@@ -171,6 +171,11 @@ behavior:
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
+--recount::
+	Do not trust the line counts in the hunk headers, but infer them
+	by inspecting the patch (e.g. after editing the patch without
+	adjusting the hunk headers appropriately).
+
 -v::
 --verbose::
 	Report progress to stderr. By default, only a message about the
diff --git a/builtin-apply.c b/builtin-apply.c
index c497889..34c220f 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -153,6 +153,7 @@ struct patch {
 	unsigned int is_binary:1;
 	unsigned int is_copy:1;
 	unsigned int is_rename:1;
+	unsigned int recount:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
@@ -882,6 +883,50 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
+static int recount_diff(char *line, int size, struct fragment *fragment)
+{
+	int line_nr = 0;
+
+	if (size < 1)
+		return -1;
+
+	fragment->oldpos = 2;
+	fragment->oldlines = fragment->newlines = 0;
+
+	for (;;) {
+		int len = linelen(line, size);
+		size -= len;
+		line += len;
+
+		if (size < 1)
+			return 0;
+
+		switch (*line) {
+		case ' ': case '\n':
+			fragment->newlines++;
+			/* fall through */
+		case '-':
+			fragment->oldlines++;
+			break;
+		case '+':
+			fragment->newlines++;
+			if (line_nr == 0) {
+				fragment->leading = 1;
+				fragment->oldpos = 1;
+			}
+			fragment->trailing = 1;
+			break;
+		case '@':
+			return size < 3 || prefixcmp(line, "@@ ");
+		case 'd':
+			return size < 5 || prefixcmp(line, "diff ");
+		default:
+			return -1;
+		}
+		line_nr++;
+	}
+}
+
 /*
  * Parse a unified diff fragment header of the
  * form "@@ -a,b +c,d @@"
@@ -1013,6 +1058,9 @@ static int parse_fragment(char *line, unsigned long size,
 	offset = parse_fragment_header(line, len, fragment);
 	if (offset < 0)
 		return -1;
+	if (offset > 0 && patch->recount &&
+			recount_diff(line + offset, size - offset, fragment))
+		return -1;
 	oldlines = fragment->oldlines;
 	newlines = fragment->newlines;
 	leading = 0;
@@ -2912,7 +2960,8 @@ static void prefix_patches(struct patch *p)
 	}
 }
 
-static int apply_patch(int fd, const char *filename, int inaccurate_eof)
+static int apply_patch(int fd, const char *filename, int inaccurate_eof,
+		int recount)
 {
 	size_t offset;
 	struct strbuf buf;
@@ -2929,6 +2978,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = inaccurate_eof;
+		patch->recount = recount;
 		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
@@ -2998,6 +3048,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	int i;
 	int read_stdin = 1;
 	int inaccurate_eof = 0;
+	int recount = 0;
 	int errs = 0;
 	int is_not_gitdir;
 
@@ -3015,7 +3066,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+			errs |= apply_patch(0, "<stdin>", inaccurate_eof,
+					recount);
 			read_stdin = 0;
 			continue;
 		}
@@ -3118,6 +3170,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			inaccurate_eof = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--recount")) {
+			recount = 1;
+			continue;
+		}
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
@@ -3126,12 +3182,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			die("can't open patch '%s': %s", arg, strerror(errno));
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		errs |= apply_patch(fd, arg, inaccurate_eof);
+		errs |= apply_patch(fd, arg, inaccurate_eof, recount);
 		close(fd);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+		errs |= apply_patch(0, "<stdin>", inaccurate_eof, recount);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
-- 
1.5.6.84.ge5c1
