From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 5 Jun 2008 11:16:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051115570.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 05 12:18:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4CYE-00039J-27
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587AbYFEKRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbYFEKRk
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:17:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:45314 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754062AbYFEKRj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:17:39 -0400
Received: (qmail invoked by alias); 05 Jun 2008 10:17:37 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp032) with SMTP; 05 Jun 2008 12:17:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX191Dbk31LJ1WebtMtF6dTA2E4At6d3QFBUbGUFMHm
	eHh2wgXjyIuzWm
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83894>


Sometimes, the easiest way to fix up a patch is to edit it directly, even
adding or deleting lines.  Now, many people are not as divine as certain
benevolent dictators as to update the hunk headers correctly at the first
try.

So teach the tool to do it for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-apply.txt |    6 ++++-
 builtin-apply.c             |   55 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 2dec2ec..ba3dba7 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
 	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
+	  [-pNUM] [-CNUM] [--inaccurate-eof] [--fixup-line-counts] [--cached]
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
index c497889..3fd80e8 100644
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
@@ -882,6 +883,41 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
+static int fixup_counts(char *line, int size, struct fragment *fragment)
+{
+	if (size < 1)
+		return -1;
+
+	fragment->oldlines = fragment->newlines = -1;
+
+	for (;;) {
+		int len = linelen(line, size);
+		if (!len)
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
+			/* Probably "diff ..." */
+			return 0;
+		}
+
+		size -= len;
+		line += len;
+		if (size < 2 || !prefixcmp(line, "@@"))
+			break;
+	}
+	return 0;
+}
+
 /*
  * Parse a unified diff fragment header of the
  * form "@@ -a,b +c,d @@"
@@ -1013,6 +1049,9 @@ static int parse_fragment(char *line, unsigned long size,
 	offset = parse_fragment_header(line, len, fragment);
 	if (offset < 0)
 		return -1;
+	if (offset > 0 && patch->fixup &&
+			fixup_counts(line + offset, size - offset, fragment))
+		return -1;
 	oldlines = fragment->oldlines;
 	newlines = fragment->newlines;
 	leading = 0;
@@ -2912,7 +2951,8 @@ static void prefix_patches(struct patch *p)
 	}
 }
 
-static int apply_patch(int fd, const char *filename, int inaccurate_eof)
+static int apply_patch(int fd, const char *filename, int inaccurate_eof,
+		int fixup)
 {
 	size_t offset;
 	struct strbuf buf;
@@ -2929,6 +2969,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = inaccurate_eof;
+		patch->fixup = fixup;
 		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
@@ -2998,6 +3039,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	int i;
 	int read_stdin = 1;
 	int inaccurate_eof = 0;
+	int fixup = 0;
 	int errs = 0;
 	int is_not_gitdir;
 
@@ -3015,7 +3057,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+			errs |= apply_patch(0, "<stdin>", inaccurate_eof,
+					fixup);
 			read_stdin = 0;
 			continue;
 		}
@@ -3118,6 +3161,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			inaccurate_eof = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--fixup-line-counts")) {
+			fixup = 1;
+			continue;
+		}
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
@@ -3126,12 +3173,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
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
1.5.6.rc1.181.gb439d
