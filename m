From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-add: fix command line building to call interactive
Date: Sun, 25 Nov 2007 11:48:28 -0800
Message-ID: <7vprxyksxf.fsf@gitster.siamese.dyndns.org>
References: <1195996542-86074-1-git-send-email-win@wincent.com>
	<7vd4tynqpw.fsf@gitster.siamese.dyndns.org>
	<F09249EB-475A-4352-A3A1-A8B15D2A94FF@wincent.com>
	<7vlk8mmatu.fsf@gitster.siamese.dyndns.org>
	<22CBC161-57C2-4A7E-9415-CE8117758A44@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 20:49:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwNTX-0002ny-0x
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 20:49:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbXKYTsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 14:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbXKYTsm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 14:48:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:46737 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbXKYTsl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 14:48:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id CC6E62F0;
	Sun, 25 Nov 2007 14:49:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id ACCB599A7B;
	Sun, 25 Nov 2007 14:48:56 -0500 (EST)
In-Reply-To: <22CBC161-57C2-4A7E-9415-CE8117758A44@wincent.com> (Wincent
	Colaiuta's message of "Sun, 25 Nov 2007 20:02:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65984>

Wincent Colaiuta <win@wincent.com> writes:

>>  I _think_ the only remaining thing is --patch, and none of the  
>> pathspec
>> thing is needed.
>
> You're probably right; the pathspec validation is probably not  
> necessary (and you may recall that my original patch didn't include  
> it; I only tried adding after you said it might be appropriate to have  
> the "--error-unmatch" behaviour)...

Oh, I did not mean the validation bits I left out in the second "fixup"
patch I sent earlier by that comment.  What I meant was the changes you
had in git-add--interactive::patch_update_cmd() to make it take non
files but pathspecs.

> This is probably more convenient for  
> the user, as it allows them to pass "sloppy" parameters like the  
> following:
>
> 	git-add -i *.h
>
> (Note that's "*.h" and not "\*.h"). In the Git repository, without  
> validation, this just works. With strict validation, it would complain...

I'd mostly agree, but we need to realize that this is a two edged sword.
Pathspecs can be leading-directories or fileglobs.  For fileglobs, you
are right.  The user can let the shell do the globbing.  Not validating,
however, also means that

	git add -p Documentatoin

would report "there is nothing to patch" without being helpful, pointing
out that the name of the directory is misspelled.

> As for adding the --patch option, I'll stand back and see if someone  
> more skilled than I wants to do it; should only be a few lines and  
> will save traffic to the list because they'll probably get it right  
> first time.

And that skilled person turns out to be you ;-).

At the end of this message is your 3/3 from yesterday, minimally
adjusted to the current tip of 'next'.

I tweaked it to allow:

	git add -p

without any pathspecs, which I think is a valid usage.

-- >8 --
[PATCH] Add "--patch" option to git-add--interactive

When the "--patch" option is supplied, the patch_update_cmd() function is
called bypassing the main_loop() and exits.

Seeing as builtin-add is the only caller of git-add--interactive we can
impose a strict requirement on the format of the arguments to avoid
possible ambiguity: an "--" argument must be used whenever any pathspecs
are passed, both with the "--patch" option and without it.

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---
 Documentation/git-add.txt |    9 +++++++-
 builtin-add.c             |   24 ++++++++++++++-------
 git-add--interactive.perl |   51 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 63829d9..ce22de8 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -61,7 +61,14 @@ OPTIONS
 
 -i, \--interactive::
 	Add modified contents in the working tree interactively to
-	the index.
+	the index. Optional path arguments may be supplied to limit
+	operation to a subset of the working tree. See ``Interactive
+	mode'' for details.
+
+-p, \--patch:
+	Similar to Interactive mode but the initial command loop is
+	bypassed and the 'patch' subcommand is invoked using each of
+	the specified filepatterns before exiting.
 
 -u::
 	Update only files that git already knows about. This is similar
diff --git a/builtin-add.c b/builtin-add.c
index 865c475..5c29cc2 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -19,7 +19,7 @@ static const char * const builtin_add_usage[] = {
 	"git-add [options] [--] <filepattern>...",
 	NULL
 };
-
+static int patch_interactive = 0, add_interactive = 0;
 static int take_worktree_changes;
 
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
@@ -144,7 +144,7 @@ static const char **validate_pathspec(int argc, const char **argv, const char *p
 
 int interactive_add(int argc, const char **argv, const char *prefix)
 {
-	int status;
+	int status, ac;
 	const char **args;
 	const char **pathspec = NULL;
 
@@ -154,11 +154,17 @@ int interactive_add(int argc, const char **argv, const char *prefix)
 			return -1;
 	}
 
-	args = xcalloc(sizeof(const char *), (argc + 2));
-	args[0] = "add--interactive";
-	if (argc)
-		memcpy(&(args[1]), pathspec, sizeof(const char *) * argc);
-	args[argc + 1] = NULL;
+	args = xcalloc(sizeof(const char *), (argc + 4));
+	ac = 0;
+	args[ac++] = "add--interactive";
+	if (patch_interactive)
+		args[ac++] = "--patch";
+	args[ac++] = "--";
+	if (argc) {
+		memcpy(&(args[ac]), pathspec, sizeof(const char *) * argc);
+		ac += argc;
+	}
+	args[ac] = NULL;
 
 	status = run_command_v_opt(args, RUN_GIT_CMD);
 	free(args);
@@ -171,13 +177,13 @@ static const char ignore_error[] =
 "The following paths are ignored by one of your .gitignore files:\n";
 
 static int verbose = 0, show_only = 0, ignored_too = 0, refresh_only = 0;
-static int add_interactive = 0;
 
 static struct option builtin_add_options[] = {
 	OPT__DRY_RUN(&show_only),
 	OPT__VERBOSE(&verbose),
 	OPT_GROUP(""),
 	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive picking"),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, "interactive patching"),
 	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored files"),
 	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update tracked files"),
 	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh the index"),
@@ -192,6 +198,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
+	if (patch_interactive)
+		add_interactive = 1;
 	if (add_interactive)
 		exit(interactive_add(argc, argv, prefix));
 
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index e347216..df5df3e 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -2,6 +2,9 @@
 
 use strict;
 
+# command line options
+my $patch_mode;
+
 sub run_cmd_pipe {
 	if ($^O eq 'MSWin32') {
 		my @invalid = grep {m/[":*]/} @_;
@@ -552,8 +555,8 @@ sub help_patch_cmd {
 	print <<\EOF ;
 y - stage this hunk
 n - do not stage this hunk
-a - stage this and all the remaining hunks
-d - do not stage this hunk nor any of the remaining hunks
+a - stage this and all the remaining hunks in the file
+d - do not stage this hunk nor any of the remaining hunks in the file
 j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
@@ -563,13 +566,21 @@ EOF
 }
 
 sub patch_update_cmd {
-	my @mods = list_modified('file-only');
-	@mods = grep { !($_->{BINARY}) } @mods;
-	return if (!@mods);
+	my @mods = grep { !($_->{BINARY}) } list_modified('file-only');
+	my @them;
 
-	my (@them) = list_and_choose({ PROMPT => 'Patch update',
-				       HEADER => $status_head, },
-				     @mods);
+	if (!@mods) {
+		print STDERR "No changes.\n";
+		return 0;
+	}
+	if ($patch_mode) {
+		@them = @mods;
+	}
+	else {
+		@them = list_and_choose({ PROMPT => 'Patch update',
+					  HEADER => $status_head, },
+					@mods);
+	}
 	for (@them) {
 		patch_update_file($_->{VALUE});
 	}
@@ -783,6 +794,20 @@ add untracked - add contents of untracked files to the staged set of changes
 EOF
 }
 
+sub process_args {
+	return unless @ARGV;
+	my $arg = shift @ARGV;
+	if ($arg eq "--patch") {
+		$patch_mode = 1;
+		$arg = shift @ARGV or die "missing --";
+		die "invalid argument $arg, expecting --"
+		    unless $arg eq "--";
+	}
+	elsif ($arg ne "--") {
+		die "invalid argument $arg, expecting --";
+	}
+}
+
 sub main_loop {
 	my @cmd = ([ 'status', \&status_cmd, ],
 		   [ 'update', \&update_cmd, ],
@@ -811,6 +836,12 @@ sub main_loop {
 	}
 }
 
+process_args();
 refresh();
-status_cmd();
-main_loop();
+if ($patch_mode) {
+	patch_update_cmd();
+}
+else {
+	status_cmd();
+	main_loop();
+}
-- 
1.5.3.6.2018.g84394
