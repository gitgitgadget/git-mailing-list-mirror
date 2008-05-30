From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Fri, 30 May 2008 10:49:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805301049000.13507@racer.site.net>
References: <200805232221.45406.trast@student.ethz.ch> <200805291737.53291.trast@student.ethz.ch> <20080529185808.GA2140@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 30 11:52:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K21HG-0002Cs-HV
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 11:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbYE3JvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 05:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbYE3JvJ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 05:51:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:37495 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752984AbYE3JvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 05:51:07 -0400
Received: (qmail invoked by alias); 30 May 2008 09:51:04 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO none.local) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 30 May 2008 11:51:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WIRRih7NWMb6/AuvK9uxJRXfMOiBTSdHazYBEIa
	/iYnF1YhJYpQWO
X-X-Sender: gene099@racer.site.net
In-Reply-To: <20080529185808.GA2140@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83282>

Hi,

On Thu, 29 May 2008, Jeff King wrote:

> I would much rather get dumped in my favorite editor, which happens to 
> be quite fast at removing a subset of lines. After editing, any lines 
> remaining would be staged.
> 
> We would have to figure out what happens if lines are added or edited,
> of course. It may be right to signal an error, or maybe there is some
> other useful functionality that can come of that. I think other systems
> have some diff-editing functionality (IIRC, cogito did). It is probably
> worth looking at that for ideas.

Maybe you want to start from this patch (only compile-tested):

-- snipsnap --
[PATCH] WIP: allow git-apply to fix up the line counts

Sometimes, the easiest way to fix up a patch is to edit it directly, even
adding or deleting lines.  Now, many people are not as divine as certain
benevolent dictators as to update the hunk headers correctly at the first
try.

So teach the tool to do it for us.
---
 Documentation/git-apply.txt |    6 +++-
 builtin-apply.c             |   66 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 2dec2ec..8007d10 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
 	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
+	  [-pNUM] [-CNUM] [--inaccurate-eof] [--fixup] [--cached]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
 	  [--exclude=PATH] [--verbose] [<patch>...]
 
@@ -169,6 +169,10 @@ behavior:
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
+--fixup-line-counts::
+	Fix up the line counts (e.g. after editing the patch without
+	adjusting the hunk headers appropriately).
+
 -v, --verbose::
 	Report progress to stderr. By default, only a message about the
 	current patch being applied will be printed. This option will cause
diff --git a/builtin-apply.c b/builtin-apply.c
index c497889..c8f1cd9 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -153,6 +153,7 @@ struct patch {
 	unsigned int is_binary:1;
 	unsigned int is_copy:1;
 	unsigned int is_rename:1;
+	unsigned int fixup:1;
 	struct fragment *fragments;
 	char *result;
 	size_t resultsize;
@@ -882,11 +883,49 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
+static int fixup_counts(char *line, int len, struct fragment *fragment)
+{
+
+	if (len < 1)
+		return -1;
+
+	fragment->oldlines = fragment->newlines = 0;
+
+	for (;;) {
+		char *newline = memchr(line, '\n', len);
+		if (!newline)
+			break;
+
+		switch (*line) {
+		case ' ':
+			fragment->oldlines++;
+			/* fall through */
+		case '+':
+			fragment->newlines++;
+			break;
+		case '-':
+			fragment->oldlines++;
+			break;
+		default:
+			return error("Unexpected first character: %c in line "
+				"'%.*s'",
+				*line, newline ? newline - line : len, line);
+		}
+
+		len -= newline + 1 - line;
+		line = newline + 1;
+		if (len < 2 || !prefixcmp(line, "@@"))
+			break;
+	}
+	return 0;
+}
+
 /*
  * Parse a unified diff fragment header of the
  * form "@@ -a,b +c,d @@"
  */
-static int parse_fragment_header(char *line, int len, struct fragment *fragment)
+static int parse_fragment_header(char *line, int len, struct fragment *fragment,
+	int fixup)
 {
 	int offset;
 
@@ -897,6 +936,10 @@ static int parse_fragment_header(char *line, int len, struct fragment *fragment)
 	offset = parse_range(line, len, 4, " +", &fragment->oldpos, &fragment->oldlines);
 	offset = parse_range(line, len, offset, " @@", &fragment->newpos, &fragment->newlines);
 
+	if (offset > 0 && fixup &&
+			fixup_counts(line + offset, len - offset, fragment))
+		return -1;
+
 	return offset;
 }
 
@@ -927,7 +970,8 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 		 */
 		if (!memcmp("@@ -", line, 4)) {
 			struct fragment dummy;
-			if (parse_fragment_header(line, len, &dummy) < 0)
+			if (parse_fragment_header(line, len, &dummy,
+					patch->fixup) < 0)
 				continue;
 			die("patch fragment without header at line %d: %.*s",
 			    linenr, (int)len-1, line);
@@ -1010,7 +1054,7 @@ static int parse_fragment(char *line, unsigned long size,
 	unsigned long oldlines, newlines;
 	unsigned long leading, trailing;
 
-	offset = parse_fragment_header(line, len, fragment);
+	offset = parse_fragment_header(line, len, fragment, patch->fixup);
 	if (offset < 0)
 		return -1;
 	oldlines = fragment->oldlines;
@@ -2912,7 +2956,8 @@ static void prefix_patches(struct patch *p)
 	}
 }
 
-static int apply_patch(int fd, const char *filename, int inaccurate_eof)
+static int apply_patch(int fd, const char *filename, int inaccurate_eof,
+		int fixup)
 {
 	size_t offset;
 	struct strbuf buf;
@@ -2929,6 +2974,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = inaccurate_eof;
+		patch->fixup = fixup;
 		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
@@ -2998,6 +3044,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	int i;
 	int read_stdin = 1;
 	int inaccurate_eof = 0;
+	int fixup = 0;
 	int errs = 0;
 	int is_not_gitdir;
 
@@ -3015,7 +3062,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+			errs |= apply_patch(0, "<stdin>", inaccurate_eof,
+					fixup);
 			read_stdin = 0;
 			continue;
 		}
@@ -3118,6 +3166,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			inaccurate_eof = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--fixup-line-counts")) {
+			fixup = 1;
+			continue;
+		}
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
@@ -3126,12 +3178,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			die("can't open patch '%s': %s", arg, strerror(errno));
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		errs |= apply_patch(fd, arg, inaccurate_eof);
+		errs |= apply_patch(fd, arg, inaccurate_eof, fixup);
 		close(fd);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+		errs |= apply_patch(0, "<stdin>", inaccurate_eof, fixup);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
-- 
1.5.6.rc0.206.g61199
