From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Thu, 5 Jun 2008 17:20:17 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051720070.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 18:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4IEo-0004FX-3u
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 18:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYFEQVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 12:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbYFEQVq
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 12:21:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:59463 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754339AbYFEQVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 12:21:45 -0400
Received: (qmail invoked by alias); 05 Jun 2008 16:21:43 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 05 Jun 2008 18:21:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bo0hCojBbQwDAY4NAq6lUkiDTFQ9eD+2hjJ/wGu
	S682hXw3oob551
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0806051719170.21190@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83943>


Sometimes, the easiest way to fix up a patch is to edit it directly, even
adding or deleting lines.  Now, many people are not as divine as certain
benevolent dictators as to update the hunk headers correctly at the first
try.

So teach the tool to do it for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-apply.txt |    7 ++++-
 builtin-apply.c             |   57 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 2dec2ec..e4c5530 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-apply' [--stat] [--numstat] [--summary] [--check] [--index]
 	  [--apply] [--no-add] [--build-fake-ancestor <file>] [-R | --reverse]
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
-	  [-pNUM] [-CNUM] [--inaccurate-eof] [--cached]
+	  [-pNUM] [-CNUM] [--inaccurate-eof] [--ignore-hunk-headers] [--cached]
 	  [--whitespace=<nowarn|warn|fix|error|error-all>]
 	  [--exclude=PATH] [--verbose] [<patch>...]
 
@@ -169,6 +169,11 @@ behavior:
 	correctly. This option adds support for applying such patches by
 	working around this bug.
 
+--ignore-hunk-headers::
+	Do not trust the line counts in the hunk headers, but infer them
+	by inspecting the patch (e.g. after editing the patch without
+	adjusting the hunk headers appropriately).
+
 -v, --verbose::
 	Report progress to stderr. By default, only a message about the
 	current patch being applied will be printed. This option will cause
diff --git a/builtin-apply.c b/builtin-apply.c
index c497889..b357e35 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -153,6 +153,7 @@ struct patch {
 	unsigned int is_binary:1;
 	unsigned int is_copy:1;
 	unsigned int is_rename:1;
+	unsigned int ignore_hunk_headers:1;
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
+	if (offset > 0 && patch->ignore_hunk_headers &&
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
+		int ignore_hunk_headers)
 {
 	size_t offset;
 	struct strbuf buf;
@@ -2929,6 +2969,7 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = inaccurate_eof;
+		patch->ignore_hunk_headers = ignore_hunk_headers;
 		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
@@ -2998,6 +3039,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	int i;
 	int read_stdin = 1;
 	int inaccurate_eof = 0;
+	int ignore_hunk_headers = 0;
 	int errs = 0;
 	int is_not_gitdir;
 
@@ -3015,7 +3057,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+			errs |= apply_patch(0, "<stdin>", inaccurate_eof,
+					ignore_hunk_headers);
 			read_stdin = 0;
 			continue;
 		}
@@ -3118,6 +3161,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			inaccurate_eof = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--ignore-hunk-headers")) {
+			ignore_hunk_headers = 1;
+			continue;
+		}
 		if (0 < prefix_length)
 			arg = prefix_filename(prefix, prefix_length, arg);
 
@@ -3126,12 +3173,14 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			die("can't open patch '%s': %s", arg, strerror(errno));
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		errs |= apply_patch(fd, arg, inaccurate_eof);
+		errs |= apply_patch(fd, arg, inaccurate_eof,
+				ignore_hunk_headers);
 		close(fd);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+		errs |= apply_patch(0, "<stdin>", inaccurate_eof,
+				ignore_hunk_headers);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
-- 
1.5.6.rc1.181.gb439d
