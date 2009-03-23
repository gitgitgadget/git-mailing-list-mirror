From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: add support for an extended revision syntax
Date: Mon, 23 Mar 2009 03:15:48 -0700
Message-ID: <1237803348-9329-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 11:17:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhDA-0008Kv-Et
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756141AbZCWKPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 06:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755959AbZCWKPS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:15:18 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:29638 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899AbZCWKPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 06:15:15 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1440711wah.21
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=A1mOWQxWRnMZ9j31cNupD3Uc7baP4dar22N9PQOngKE=;
        b=BCeGtO0NrcVZ5vn+xiwu81JPpJvosI/q9zr7Tlloap4VzvtwzRd+PWOKN9SWOZRNCA
         w9i72F55IjHa85oRT59XS91TeK6YZ9JiY3cPkk0lBKcfklJzmxUM6bih1TtksY8+RUHA
         IlyOQEiYVg//UEjp3nBhOaObKPMQAtdVGQX5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=PKuLNRZoJAcfIKAFhorcGWW27YVKPGpj2kPA+tmy58P8QVuHiRClgJH9eipKOug/mB
         gAx9H05Pi0OmFTR6iJWokA4wCVvozzE/ikXDOHFgQKlJm41Gt6nyH0h5rMXxvlRlghl0
         GKZMvqrFfOgfX5Zni/cII0lxhc9w174V6dXNA=
Received: by 10.115.111.3 with SMTP id o3mr4672043wam.210.1237803313726;
        Mon, 23 Mar 2009 03:15:13 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l28sm5198129waf.30.2009.03.23.03.15.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 03:15:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.303.g63699
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114269>

This adds an extended revision syntax to git-difftool.
Users often ask "how do I compare a file against its
previous version" and the answer is typically a combination
of 'git log <file>' and 'git difftool <sha1> <sha1> <file>'.

This makes answering that question considerably easier.
Users can now simply say:

	$ git difftool <file>~

to compare <file> in the worktree against its
previous version, and:

	$ git difftool <file>~2 <file>~

to compare <file> from 2 versions ago to <file>'s
previous version, etc.

The extended revision syntax also expands revisions
that are suffixed with '!' as a convenient way to
see commit diffs.  Specifying only '!' is equivalent
to specifying 'HEAD!'.

This makes the following statements equivalent:

	$ git difftool !
	$ git difftool HEAD!
	$ git difftool HEAD~ HEAD

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This patch is based on top of the "add tests to difftool"
patch which itself is based upon the "move difftool out of contrib"
patch currently in the "pu" and "da/difftool" branches.

This feature is incredibly useful but it also adds a brand new
way of specifying revisions that is only understood by git-difftool.

This was specifically asked for by a git-difftool user
who was disapointed to learn that they had to dig through
git-log just to use git-difftool effectively.

I do not think git-diff should know anything about the
"extended revision syntax" which is why this behavior
is best suited for a porcelain such as difftool.
I can imagine that 'file~' would be a useful construct
in core git, but changing the plumbing just for something
like that seems both daunting and misguided.

Some of the conditional expressions were modified to match
the style used in git-add--interactive.perl.  I can split
this patch into two if needed, but I figured they were
trivial and didn't warrant a separate patch.

I had to escape some tilde characters in the documentation
because asciidoc kept generating invalid html when the
{tilde} notation was used within single quotes multiple times.

In case anyone asks, git-diff understands this new syntax too
(though we did have to twist its arm ;))

	$ git config alias.ddiff 'difftool --no-ext-diff'
	$ git ddiff Makefile~

Any thoughts on whether adding this syntax to git-diff/rev-parse
would be feasible/sane/worth it?

 Documentation/git-difftool.txt |   55 ++++++++++++++++++-
 git-difftool.perl              |  119 ++++++++++++++++++++++++++++++++++++++--
 t/t7800-difftool.sh            |   43 ++++++++++++++
 3 files changed, 210 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 5ae02f8..2911b84 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -7,7 +7,9 @@ git-difftool - Show changes using common diff tools
 
 SYNOPSIS
 --------
-'git difftool' [--tool=<tool>] [--no-prompt] [<'git diff' options>]
+'git difftool' [--tool=<tool>] [--no-prompt]
+               [<'git diff' options>]
+               [<extended revision syntax>]
 
 DESCRIPTION
 -----------
@@ -54,6 +56,57 @@ with custom merge tool commands and has the same value as `$LOCAL`.
 
 See linkgit:git-diff[1] for the full list of supported options.
 
+EXTENDED REVISION SYNTAX
+------------------------
+'git-difftool' understands an extended syntax for specifying revisions.
+
+* A suffix '{tilde}' to a file means the previous commit that touched file.
+
+* A suffix '{tilde}<n>' to a file means the <n>th previous commit that
+touched file.  E.g. 'file\~3' is equivalent to 'file\~\~\~'.
+
+* A revision suffixed with an exclamation mark '!' expands to
+'revision\~..revision', i.e. the commit diff for that revision.
+
+'git-difftool' recognizes this syntax and passes the corresponding
+commits to 'git-diff'.
+
+Examples
+~~~~~~~~
+
+---------------------------------------------------
+# File Revision Specifiers
+$ git difftool Makefile~2 <1>
+$ git difftool Makefile~4 Makefile~2 <2>
+$ git difftool Makefile~~~~ Makefile~~ <3>
+
+# Commit Diff Specifiers
+$ git difftool origin/next~! <4>
+$ git difftool HEAD! <5>
+$ git difftool ! <6>
+---------------------------------------------------
+
+<1> compare 'Makefile' in the worktree against 'Makefile'
+as it existed two `versions` ago.  `Versions` here means
+"changes to Makefile" such that only commits that touch
+'Makefile' are considered when finding commits.
+
+<2> compare 'Makefile' as it existed four versions ago to
+'Makefile' as it existed two versions ago.
+
+<3> equivalent to example 2 and illustrates what happens when
+multiple '{tilde}' characters are used.
+
+<4> show the commit diff for 'origin/next\~'.
+Specifying '!' expands 'origin/next\~' to
+'origin/next\~\~..origin/next\~'.
+
+<5> show the commit diff for the most recent commit.
+'HEAD!' is equivalent to 'HEAD\~..HEAD'.
+
+<6> '!' is a shorthand for 'HEAD!' and is equivalent to example 5.
+
+
 CONFIG VARIABLES
 ----------------
 'git-difftool' falls back to 'git-mergetool' config variables when the
diff --git a/git-difftool.perl b/git-difftool.perl
index 0deda3a..4845f9b 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -12,13 +12,17 @@ use warnings;
 use Cwd qw(abs_path);
 use File::Basename qw(dirname);
 
+binmode(STDOUT, ":raw");
+
 my $DIR = abs_path(dirname($0));
 
 
 sub usage
 {
 	print << 'USAGE';
-usage: git difftool [--tool=<tool>] [--no-prompt] ["git diff" options]
+usage: git difftool [--tool=<tool>] [--no-prompt]
+                    [<'git diff' options>]
+                    [<extended revision specifier>]
 USAGE
 	exit 1;
 }
@@ -33,12 +37,18 @@ sub setup_environment
 sub exe
 {
 	my $exe = shift;
-	return defined $ENV{COMSPEC} ? "$exe.exe" : $exe;
+	if ($^O eq 'MSWin32' || $^O eq 'msys') {
+		return "$exe.exe";
+	}
+	return  $exe;
 }
 
 sub generate_command
 {
+	# Generate a git-diff command line and set environment
+	# variables recognized by git-difftool-helper
 	my @command = (exe('git'), 'diff');
+	my @args = ();
 	my $skip_next = 0;
 	my $idx = -1;
 	for my $arg (@ARGV) {
@@ -47,7 +57,7 @@ sub generate_command
 			$skip_next = 0;
 			next;
 		}
-		if ($arg eq '-t' or $arg eq '--tool') {
+		if ($arg eq '-t' || $arg eq '--tool') {
 			usage() if $#ARGV <= $idx;
 			$ENV{GIT_DIFF_TOOL} = $ARGV[$idx + 1];
 			$skip_next = 1;
@@ -61,12 +71,109 @@ sub generate_command
 			$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
 			next;
 		}
-		if ($arg eq '-h' or $arg eq '--help') {
+		if ($arg eq '-h' || $arg eq '--help') {
 			usage();
 		}
-		push @command, $arg;
+		push @args, $arg;
+	}
+	return (@command, interpolate_args(@args));
+}
+
+
+sub interpolate_args
+{
+	# Interpolates arguments that should be expanded out to
+	# corresponding commits, e.g. 'file~3' or 'master!'.
+	my @args = @_;
+	my $file = undef;
+	my @command = ();
+	for my $arg (@args) {
+		if (defined $file && $arg eq $file) {
+			# This allows 'git difftool file~ file'
+			next;
+		}
+		if ($arg =~ /^(.+?)(~+\d*)$/) {
+			# This arg might be a file-revision specifier
+			my $cur_file = $1;
+			my $rev_spec = $2;
+			if (defined $file && $file ne $cur_file) {
+				# We don't currently support comparing
+				# file~ to other_file~
+				usage();
+			}
+			if (!-e $cur_file) {
+				# This arg is a revision parameter and should
+				# be passed along to git-diff as-is
+				push @command, $arg;
+				next;
+			}
+			# This arg is a file-revision specifier so find the
+			# corresponding commits
+			$file = $cur_file;
+			push @command,
+				find_commit_for_file($cur_file, $rev_spec);
+		}
+		elsif ($arg =~ /^(.*?)!$/) {
+			# Expand 'sha1!' to 'sha1~ sha1'
+			my $head = $1;
+			if (length($head) == 0) {
+				# Expand '!' to 'HEAD~ HEAD'
+				$head = 'HEAD';
+			}
+			push @command, $head.'~';
+			push @command, $head;
+		}
+		else {
+			# This is a regular arg so just pass it along
+			push @command, $arg;
+		}
+	}
+	if (defined $file) {
+		# We're using a 'file~' revision specifier so
+		# automatically limit git-diff to just a single file
+		$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
+		push @command, '--', $file;
+	}
+	return @command;
+}
+
+sub find_commit_for_file
+{
+	# Searches back in $file's history according to $rev_spec
+	# and finds the corresponding commits.
+	# $rev_spec usually looks like '~' or '~2'.
+	my ($file, $rev_spec) = @_;
+	my $num = 0;
+	if ($rev_spec =~ /^(~+)(\d+)$/) {
+		$num = length($1);
+		$num += $2;
+	}
+	else {
+		$num = 1;
+		$num += length($rev_spec);
+	}
+	my @cmd = (exe('git'), 'log');
+	my @opts = ('--reverse', '--pretty=format:%H', '--max-count='.$num);
+	my @args = ('--', $file);
+	return read_first_line(@cmd, @opts, @args);
+}
+
+sub read_first_line
+{
+	# Runs a command in a child process and returns the first line
+	my @command = @_;
+	my $pid = open(CHILD, '-|');
+	if ($pid) {
+		# Grab the first line and loop over stdout until we're done
+		my $line = <CHILD>;
+		while(<CHILD>) {};
+		close(CHILD);
+		chomp $line;
+		return $line;
+	} else {
+		# Execute the command and pipe output to our parent
+		exec(@command) or exit 1;
 	}
-	return @command
 }
 
 setup_environment();
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index c7cd2b1..88af30a 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -136,4 +136,47 @@ test_expect_success 'difftool + mergetool config variables' '
 	restore_test_defaults
 '
 
+test_expect_success 'extended file revision syntax' '
+	git checkout branch &&
+
+	diff=$(git difftool file~) &&
+	test "$diff" = "master" &&
+
+	diff=$(git difftool file~ file) &&
+	test "$diff" = "master" &&
+
+	echo branch 2 >file &&
+	git commit -a -m "branch changes again" &&
+
+	diff=$(git difftool file~~ file) &&
+	test "$diff" = "master" &&
+
+	diff=$(git difftool file~2 file) &&
+	test "$diff" = "master" &&
+
+	git reset --hard HEAD~ &&
+	git checkout master
+'
+
+test_expect_success 'extended commit-ish revision syntax' '
+	git checkout branch &&
+
+	diff=$(git difftool --no-prompt HEAD!) &&
+	test "$diff" = "master" &&
+
+	diff=$(git difftool --no-prompt !) &&
+	test "$diff" = "master" &&
+
+	echo branch again >file &&
+	git commit -a -m "branch again" &&
+	git checkout master &&
+
+	diff=$(git difftool --no-prompt branch!) &&
+	test "$diff" = "branch" &&
+
+	git checkout branch &&
+	git reset --hard HEAD~ &&
+	git checkout master
+'
+
 test_done
-- 
1.6.2.1.303.g63699
