From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Unify the use of standard set of exclude files
Date: Thu, 15 Nov 2007 02:04:30 -0500
Message-ID: <20071115070429.GD10185@sigill.intra.peff.net>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com> <20071113225057.GB22836@artemis.corp> <7vsl39l0b7.fsf@gitster.siamese.dyndns.org> <7v4pfo813i.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, shunichi fuji <palglowr@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsYmR-0007Qm-F3
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 08:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614AbXKOHEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 02:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933586AbXKOHEg
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 02:04:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1970 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933615AbXKOHEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 02:04:35 -0500
Received: (qmail 6725 invoked by uid 111); 15 Nov 2007 07:04:32 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 15 Nov 2007 02:04:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2007 02:04:30 -0500
Content-Disposition: inline
In-Reply-To: <7v4pfo813i.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65072>

On Wed, Nov 14, 2007 at 10:38:41PM -0800, Junio C Hamano wrote:

> This teaches "git ls-files" to read the standard set of exclude
> files when no exclude patterns nor files is given from the
> command line.  We used to error out in such a case.

Is that really the case, or is this _just_ when we have asked to include
ignored files in the output? Or maybe I am missing something fundamental
here.

git-add--interactive:list_untracked needs something like this, but I
don't think your patch will work. We need something more like this (also
on maint because your standard exclude patch is):

-- >8 --
git-ls-files: add --exclude-standard

This provides a way for scripts to get at the new standard exclude
function.

---
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 9e454f0..2ec0c0d 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 		[-x <pattern>|--exclude=<pattern>]
 		[-X <file>|--exclude-from=<file>]
 		[--exclude-per-directory=<file>]
+		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--abbrev] [--] [<file>]\*
 
@@ -77,6 +78,10 @@ OPTIONS
 	read additional exclude patterns that apply only to the
 	directory and its subdirectories in <file>.
 
+--exclude-standard::
+	Add the standard git exclusions: .git/info/exclude, .gitignore
+	in each directory, and the user's global exclusion file.
+
 --error-unmatch::
 	If any <file> does not appear in the index, treat this as an
 	error (return 1).
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 171d449..da97278 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -401,8 +401,8 @@ static void overlay_tree(const char *tree_name, const char *prefix)
 static const char ls_files_usage[] =
 	"git-ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
-	"[ --exclude-per-directory=<filename> ] [--full-name] [--abbrev] "
-	"[--] [<file>]*";
+	"[ --exclude-per-directory=<filename> ] [--exclude-standard] "
+	"[--full-name] [--abbrev] [--] [<file>]*";
 
 int cmd_ls_files(int argc, const char **argv, const char *prefix)
 {
@@ -510,6 +510,11 @@ int cmd_ls_files(int argc, const char **argv, const char *prefix)
 			dir.exclude_per_dir = arg + 24;
 			continue;
 		}
+		if (!strcmp(arg, "--exclude-standard")) {
+			exc_given = 1;
+			setup_standard_excludes(&dir);
+			continue;
+		}
 		if (!strcmp(arg, "--full-name")) {
 			prefix_offset = 0;
 			continue;
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index ac598f8..0317ad9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -37,10 +37,7 @@ sub list_untracked {
 		chomp $_;
 		$_;
 	}
-	run_cmd_pipe(qw(git ls-files --others
-			--exclude-per-directory=.gitignore),
-		     "--exclude-from=$GIT_DIR/info/exclude",
-		     '--', @_);
+	run_cmd_pipe(qw(git ls-files --others --exclude-standard --), @_);
 }
 
 my $status_fmt = '%12s %12s %s';
