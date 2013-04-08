From: Adam Spiers <git@adamspiers.org>
Subject: RFC: two minor tweaks to check-ignore to help git-annex assistant
Date: Mon, 8 Apr 2013 19:13:11 +0100
Message-ID: <20130408181311.GA14903@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 08 20:21:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGgt-0008Sv-Tl
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935532Ab3DHSU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:20:58 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:52776 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762937Ab3DHSU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:20:56 -0400
X-Greylist: delayed 464 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2013 14:20:56 EDT
Received: from localhost (8.3.f.1.8.3.4.7.1.3.5.9.d.a.4.c.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:c4ad:9531:7438:1f38])
	by coral.adamspiers.org (Postfix) with ESMTPSA id BA5432EAD2;
	Mon,  8 Apr 2013 19:13:11 +0100 (BST)
Content-Disposition: inline
Received: by 10.52.72.48 with HTTP; Mon, 8 Apr 2013 11:09:52 -0700 (PDT)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220482>

Hi all,

I was recently informed by the author of git-annex that my
implementation of git check-ignore has two minor deficiencies which
currently prevent him from adding .gitignore support to the git-annex
assistant (web UI):

    1. When accepting a list of files to check via --stdin, no results
       are calculated until EOF is hit.  This prevents it being used
       as a persistent background query process which streams results
       to its caller.  (This is inconsistent with check-attr, which
       *does* support stream-like behaviour.)

    2. Even if it did support streaming, the lack of output for files
       which don't match any ignore pattern make it impossible for the
       consumer to distinguish between the two cases a) the file
       doesn't match any pattern and b) it does match but the output
       hasn't arrived yet.

Both of these are pretty trivial to fix.  The first is fixed by
changing check_ignore_stdin_paths() to invoke check_ignore() per input
line, rather than collecting all input from STDIN and then invoking
check_ignore() on the whole lot.  (I have not implemented this yet,
but may well be able to do it this week, thanks to it being one of
SUSE's hack weeks :-)

I already have a rough fix for the second issue, but I wanted to
solicit feedback on the appropriate UI changes before proceeding much
further.  Does something like the below patch seem reasonable, modulo
the lack of tests?  In case the UI changes I am proposing are not
clear from the patch, here's some example output from running it
inside a clone of the git source tree:

    $ git check-ignore -v -n foo.tar.{gz,bz2}
    .gitignore:203:*.tar.gz foo.tar.gz
    ::      foo.tar.bz2

So the number of output fields does not change depending on whether
the pattern matches or not, and any caller can determine whether it
does simply by checking whether the first field is non-empty.

Also, does it make sense to write a new test to accompany the fix to
the first (streaming) issue?

Thanks,
Adam

-- >8 --
Subject: [PATCH] check-ignore: add -n / --non-matching option

If `-n` or `--non-matching` are specified, non-matching pathnames will
also be output, in which case all fields in each output record except
for <pathname> will be empty.  This can be useful when running
non-interactively, so that files can be incrementally streamed to
STDIN of a long-running check-ignore process, and for each of these
files, STDOUT will indicate whether that file matched a pattern or
not.  (Without this option, it would be impossible to tell whether the
absence of output for a given file meant that it didn't match any
pattern, or that the output hadn't been generated yet.)

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/git-check-ignore.txt | 15 +++++++++++++
 builtin/check-ignore.c             | 43 ++++++++++++++++++++++++--------------
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 854e4d0..7e3cabc 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -39,6 +39,12 @@ OPTIONS
 	below).  If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
+-n, --non-matching::
+	Show given paths which don't match any pattern.	 This only
+	makes sense when `--verbose` is enabled, otherwise it would
+	not be possible to distinguish between paths which match a
+	pattern and those which don't.
+
 OUTPUT
 ------
 
@@ -65,6 +71,15 @@ are also used instead of colons and hard tabs:
 
 <source> <NULL> <linenum> <NULL> <pattern> <NULL> <pathname> <NULL>
 
+If `-n` or `--non-matching` are specified, non-matching pathnames will
+also be output, in which case all fields in each output record except
+for <pathname> will be empty.  This can be useful when running
+non-interactively, so that files can be incrementally streamed to
+STDIN of a long-running check-ignore process, and for each of these
+files, STDOUT will indicate whether that file matched a pattern or
+not.  (Without this option, it would be impossible to tell whether the
+absence of output for a given file meant that it didn't match any
+pattern, or that the output hadn't been generated yet.)
 
 EXIT STATUS
 -----------
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 0240f99..498fd65 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -5,7 +5,7 @@
 #include "pathspec.h"
 #include "parse-options.h"
 
-static int quiet, verbose, stdin_paths;
+static int quiet, verbose, stdin_paths, show_non_matching;
 static const char * const check_ignore_usage[] = {
 "git check-ignore [options] pathname...",
 "git check-ignore [options] --stdin < <list-of-paths>",
@@ -22,21 +22,28 @@ static const struct option check_ignore_options[] = {
 		    N_("read file names from stdin")),
 	OPT_BOOLEAN('z', NULL, &null_term_line,
 		    N_("input paths are terminated by a null character")),
+	OPT_BOOLEAN('n', "non-matching", &show_non_matching,
+		    N_("show non-matching input paths")),
 	OPT_END()
 };
 
 static void output_exclude(const char *path, struct exclude *exclude)
 {
-	char *bang  = exclude->flags & EXC_FLAG_NEGATIVE  ? "!" : "";
-	char *slash = exclude->flags & EXC_FLAG_MUSTBEDIR ? "/" : "";
+	char *bang  = (exclude && exclude->flags & EXC_FLAG_NEGATIVE)  ? "!" : "";
+	char *slash = (exclude && exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
 	if (!null_term_line) {
 		if (!verbose) {
 			write_name_quoted(path, stdout, '\n');
 		} else {
-			quote_c_style(exclude->el->src, NULL, stdout, 0);
-			printf(":%d:%s%s%s\t",
-			       exclude->srcpos,
-			       bang, exclude->pattern, slash);
+			if (exclude) {
+				quote_c_style(exclude->el->src, NULL, stdout, 0);
+				printf(":%d:%s%s%s\t",
+				       exclude->srcpos,
+				       bang, exclude->pattern, slash);
+			}
+			else {
+				printf("::\t");
+			}
 			quote_c_style(path, NULL, stdout, 0);
 			fputc('\n', stdout);
 		}
@@ -44,11 +51,14 @@ static void output_exclude(const char *path, struct exclude *exclude)
 		if (!verbose) {
 			printf("%s%c", path, '\0');
 		} else {
-			printf("%s%c%d%c%s%s%s%c%s%c",
-			       exclude->el->src, '\0',
-			       exclude->srcpos, '\0',
-			       bang, exclude->pattern, slash, '\0',
-			       path, '\0');
+			if (exclude)
+				printf("%s%c%d%c%s%s%s%c%s%c",
+				       exclude->el->src, '\0',
+				       exclude->srcpos, '\0',
+				       bang, exclude->pattern, slash, '\0',
+				       path, '\0');
+			else
+				printf("%c%c%c%s%c", '\0', '\0', '\0', path, '\0');
 		}
 	}
 }
@@ -92,11 +102,10 @@ static int check_ignore(const char *prefix, const char **pathspec)
 		if (!seen[i]) {
 			exclude = last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
-			if (exclude) {
-				if (!quiet)
-					output_exclude(path, exclude);
+			if (!quiet && (exclude || show_non_matching))
+				output_exclude(path, exclude);
+			if (exclude)
 				num_ignored++;
-			}
 		}
 	}
 	free(seen);
@@ -161,6 +170,8 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 		if (verbose)
 			die(_("cannot have both --quiet and --verbose"));
 	}
+	if (show_non_matching && !verbose)
+		die(_("--non-matching is only valid with --verbose"));
 
 	if (stdin_paths) {
 		num_ignored = check_ignore_stdin_paths(prefix);
-- 
1.8.2.242.g8617715.dirty
