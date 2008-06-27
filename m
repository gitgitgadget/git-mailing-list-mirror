From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Fri, 27 Jun 2008 18:43:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806271823220.9925@racer>
References: <20080624050901.GA19224@sigill.intra.peff.net> <200806242108.16379.trast@student.ethz.ch> <7vfxr29zju.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCI1T-0002aM-Of
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665AbYF0RpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756273AbYF0RpM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:45:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:58574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757156AbYF0RpK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:45:10 -0400
Received: (qmail invoked by alias); 27 Jun 2008 17:45:08 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp023) with SMTP; 27 Jun 2008 19:45:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/bs25tU0TbO+nF4TQaYOQhGSTBtkyNy+81Q+ey2Q
	wzy7mgMaBCkmf3
X-X-Sender: gene099@racer
In-Reply-To: <7vfxr29zju.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86609>

Hi,

On Tue, 24 Jun 2008, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > diff --git a/builtin-apply.c b/builtin-apply.c
> > index c497889..34c220f 100644
> > --- a/builtin-apply.c
> > +++ b/builtin-apply.c
> > @@ -153,6 +153,7 @@ struct patch {
> >  	unsigned int is_binary:1;
> >  	unsigned int is_copy:1;
> >  	unsigned int is_rename:1;
> > +	unsigned int recount:1;
> >  	struct fragment *fragments;
> >  	char *result;
> >  	size_t resultsize;
> 
> Why doesn't anybody find this quite wrong?
> 
> What is a "struct patch"?  It describes a change to a single file
> (i.e. information contained from one "diff --git" til next "diff --git"),
> groups the hunks (called "fragments") together and holds the postimage
> after applying these hunks.  Is this new "recount" field a per file
> attribute?

Actually, it is not.  But then, it is an attribute of the patch: it will 
be recounted.

In addition, the patch would get quite large and unwieldy with "recount" 
being passed between the functions, because we do not have "apply_options" 
yet.

I was even briefly working on apply_options, but this would be a _huge_ 
patch (I had an initial working version, but given my limited time, I 
could not clean it up for submission anyway, so I scrapped it).

> > +	fragment->oldpos = 2;
> > +	fragment->oldlines = fragment->newlines = 0;
> 
> Why is this discarding the position information?

Sorry, I forgot.

> > @@ -1013,6 +1058,9 @@ static int parse_fragment(char *line, unsigned long size,
> >  	offset = parse_fragment_header(line, len, fragment);
> >  	if (offset < 0)
> >  		return -1;
> > +	if (offset > 0 && patch->recount &&
> > +			recount_diff(line + offset, size - offset, fragment))
> > +		return -1;
> 
> And recount should not cause parse_fragment() to fail out either.  If 
> you miscounted, the codepath that follows this part knows how to handle 
> broken patch correctly anyway.

Okay.

> I think I've already mentioned the above two points when this was 
> originally posted.
> 
> Somewhat disgusted...

Sorry.

This is my updated patch (making changes to my "add -e" patch, which I 
may submit later), according to your comments so far:

-- snipsnap --
[PATCH] Allow git-apply to recount the lines in a hunk (AKA recountdiff)

Sometimes, the easiest way to fix up a patch is to edit it directly, even
adding or deleting lines.  Now, many people are not as divine as certain
benevolent dictators as to update the hunk headers correctly at the first
try.

So teach the tool to do it for us.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-apply.txt |    7 +++-
 builtin-apply.c             |   76 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index c834763..c5ee636 100644
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
 
@@ -177,6 +177,11 @@ behavior:
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
 
+--recount::
+	Do not trust the line counts in the hunk headers, but infer them
+	by inspecting the patch (e.g. after editing the patch without
+	adjusting the hunk headers appropriately).
+
 Configuration
 -------------
 
diff --git a/builtin-apply.c b/builtin-apply.c
index c497889..c819652 100644
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
@@ -882,6 +883,57 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
+static int recount_diff(char *line, int size, struct fragment *fragment)
+{
+	int oldlines = 0, newlines = 0, ret = 0;
+
+	if (size < 1) {
+		warning("recount: ignore empty hunk");
+		return -1;
+	}
+
+	for (;;) {
+		int len = linelen(line, size);
+		size -= len;
+		line += len;
+
+		if (size < 1)
+			break;
+
+		switch (*line) {
+		case ' ': case '\n':
+			newlines++;
+			/* fall through */
+		case '-':
+			oldlines++;
+			continue;
+		case '+':
+			newlines++;
+			continue;
+		case '\\':
+			break;
+		case '@':
+			ret = size < 3 || prefixcmp(line, "@@ ");
+			break;
+		case 'd':
+			ret = size < 5 || prefixcmp(line, "diff ");
+			break;
+		default:
+			ret = -1;
+			break;
+		}
+		if (ret) {
+			warning("recount: unexpected line: %.*s",
+				(int)linelen(line, size), line);
+			return -1;
+		}
+		break;
+	}
+	fragment->oldlines = oldlines;
+	fragment->newlines = newlines;
+	return 0;
+}
+
 /*
  * Parse a unified diff fragment header of the
  * form "@@ -a,b +c,d @@"
@@ -1013,6 +1065,8 @@ static int parse_fragment(char *line, unsigned long size,
 	offset = parse_fragment_header(line, len, fragment);
 	if (offset < 0)
 		return -1;
+	if (offset > 0 && patch->recount)
+		recount_diff(line + offset, size - offset, fragment);
 	oldlines = fragment->oldlines;
 	newlines = fragment->newlines;
 	leading = 0;
@@ -2912,7 +2966,10 @@ static void prefix_patches(struct patch *p)
 	}
 }
 
-static int apply_patch(int fd, const char *filename, int inaccurate_eof)
+#define INACCURATE_EOF	(1<<0)
+#define RECOUNT		(1<<1)
+
+static int apply_patch(int fd, const char *filename, int options)
 {
 	size_t offset;
 	struct strbuf buf;
@@ -2928,7 +2985,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = inaccurate_eof;
+		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
+		patch->recount =  !!(options & RECOUNT);
 		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
@@ -2997,7 +3055,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 {
 	int i;
 	int read_stdin = 1;
-	int inaccurate_eof = 0;
+	int options = 0;
 	int errs = 0;
 	int is_not_gitdir;
 
@@ -3015,7 +3073,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+			errs |= apply_patch(0, "<stdin>", options);
 			read_stdin = 0;
 			continue;
 		}
@@ -3115,7 +3173,11 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			continue;
 		}
 		if (!strcmp(arg, "--inaccurate-eof")) {
-			inaccurate_eof = 1;
+			options |= INACCURATE_EOF;
+			continue;
+		}
+		if (!strcmp(arg, "--recount")) {
+			options |= RECOUNT;
 			continue;
 		}
 		if (0 < prefix_length)
@@ -3126,12 +3188,12 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 			die("can't open patch '%s': %s", arg, strerror(errno));
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		errs |= apply_patch(fd, arg, inaccurate_eof);
+		errs |= apply_patch(fd, arg, options);
 		close(fd);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		errs |= apply_patch(0, "<stdin>", inaccurate_eof);
+		errs |= apply_patch(0, "<stdin>", options);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
-- 
1.5.6.173.gde14c
