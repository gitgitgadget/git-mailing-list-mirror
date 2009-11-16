From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Preserving empty directories when doing a git-svn clone/rebase
Date: Sun, 15 Nov 2009 19:32:16 -0800
Message-ID: <20091116033216.GA16092@dcvr.yhbt.net>
References: <20091115020605.GE15966@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Steven J. Murdoch" <git+Steven.Murdoch@cl.cam.ac.uk>
X-From: git-owner@vger.kernel.org Mon Nov 16 04:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9sL5-0006ug-Op
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 04:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbZKPDcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 22:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZKPDcN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 22:32:13 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:34136 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751161AbZKPDcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 22:32:11 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022981F679;
	Mon, 16 Nov 2009 03:32:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091115020605.GE15966@cl.cam.ac.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132984>

"Steven J. Murdoch" <git+Steven.Murdoch@cl.cam.ac.uk> wrote:
> When git-svn clones a Subversion repository, any empty directories
> appear to be silently dropped (tested using git version 1.6.5.2 on Mac
> OS X Snow Leopard). This causes problems for using git with software
> projects which depend on Subversion's ability to track empty
> directories. I was recently caught out by this, and it was difficult
> to debug what had gone wrong.
> 
> Would it be possible to change git-svn to handle this case? Since git
> doesn't have the ability to track empty directories, probably the
> simplest thing to do would be to automatically add a file (e.g.
> .gitignore) to any empty directories. In theory this could cause
> problems, but I would think the chances of this are far lower than
> with the current behaviour.

Hi Steven,

The problem is that some git-svn using folks have started using
.gitignore to create empty directories on their own.  Dealing with
conflicts like this is very problematic because we have to know
if the .gitignore file is supposed to be committed up to SVN or
not (it can be quite expensive to check).

Attempting to deal with mismatching the information stored in the git
index and SVN nearly made my head explode when I tried to implement
svn:externals support via git submodules.  Fortunately I stopped in
time, but the mental scars still remain.

> I think this feature would help projects in which some contributors
> are transitioning to git. It would especially be useful to novice
> users of git, who are not aware of the potential problems with having
> empty directories.
> 
> I see there was a discussion in 2006:
>  http://kerneltrap.org/mailarchive/git/2006/11/29/231586
> 
> However, since then I haven't seen any updates. The rationale behind
> the original request still seems applicable today:
> 
>  "I think there are many potential git users out there who are
>  currently svn users.  And git-svn is a really nice way to get started,
>  but this sort of stumbling block could really turn people off.  For
>  example, it made me look pretty dumb when I carelessly complained to
>  my colleague about his code not working and then it turns out to be
>  because my super-advanced scm tool "messed things up"."
>   (git-svn and empty directories in svn (was: [PATCH 1.2/2 (fixed)]
>    git-svn: fix output reporting from the delta fetcher))

Shortly afterwards, git svn started logging unhandled information into
unhandled.log files.  I hoped that somebody would write a parser for
those log files to be able to recreate useful information from them.
Since I'm lazy, forgetful and absent-minded, I never got around to it
until now.

Let me know how it works and if the "git svn mkdirs" command name makes
sense.  Thanks for reminding me :)

>From 023675791988373beab921ad3ada115b2c224edf Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sun, 15 Nov 2009 18:57:16 -0800
Subject: [PATCH] git svn: attempt to create empty dirs on clone+rebase

Attempt to parse unhandled.log files for empty_dir statements
and make a best effort attempt to recreate empty directories
on fresh clones and rebase.

This cannot affect "normal" git commands like "checkout" or
"reset", so users switching between branches in a single working
directory should use the new "git svn mkdirs" command after
switching branches.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt                |    7 +++
 git-svn.perl                             |   45 ++++++++++++++++
 t/t9115-git-svn-dcommit-funky-renames.sh |    4 +-
 t/t9146-git-svn-empty-dirs.sh            |   85 ++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100755 t/t9146-git-svn-empty-dirs.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1812890..db00ed4 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -320,6 +320,13 @@ Any other arguments are passed directly to 'git log'
 	directories.  The output is suitable for appending to
 	the $GIT_DIR/info/exclude file.
 
+'mkdirs'::
+	Attempts to recreate empty directories that core git cannot track
+	based on information in $GIT_DIR/svn/<refname>/unhandled.log files.
+	Empty directories are automatically recreated when using
+	"git svn clone" and "git svn rebase", so "mkdirs" is intended
+	for use after commands like "git checkout" or "git reset".
+
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
 	command-line.  This command does not rely on being inside an `git svn
diff --git a/git-svn.perl b/git-svn.perl
index ea922ac..ab0a8dd 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -168,6 +168,9 @@ my %cmd = (
 			     'Create a .gitignore per svn:ignore',
 			     { 'revision|r=i' => \$_revision
 			     } ],
+	'mkdirs' => [ \&cmd_mkdirs ,
+	              "recreate empty directories after a checkout",
+	              { 'revision|r=i' => \$_revision } ],
         'propget' => [ \&cmd_propget,
 		       'Print the value of a property on a file or directory',
 		       { 'revision|r=i' => \$_revision } ],
@@ -769,6 +772,7 @@ sub cmd_rebase {
 		$_fetch_all ? $gs->fetch_all : $gs->fetch;
 	}
 	command_noisy(rebase_cmd(), $gs->refname);
+	$gs->mkemptydirs;
 }
 
 sub cmd_show_ignore {
@@ -830,6 +834,12 @@ sub cmd_create_ignore {
 	});
 }
 
+sub cmd_mkdirs {
+	my ($url, $rev, $uuid, $gs) = working_head_info('HEAD');
+	$gs ||= Git::SVN->new;
+	$gs->mkemptydirs($_revision);
+}
+
 sub canonicalize_path {
 	my ($path) = @_;
 	my $dot_slash_added = 0;
@@ -1196,6 +1206,7 @@ sub post_fetch_checkout {
 	command_noisy(qw/read-tree -m -u -v HEAD HEAD/);
 	print STDERR "Checked out HEAD:\n  ",
 	             $gs->full_url, " r", $gs->last_rev, "\n";
+	$gs->mkemptydirs($gs->last_rev);
 }
 
 sub complete_svn_url {
@@ -2724,6 +2735,34 @@ sub do_fetch {
 	$self->make_log_entry($rev, \@parents, $ed);
 }
 
+sub mkemptydirs {
+	my ($self, $r) = @_;
+	my %empty_dirs = ();
+
+	open my $fh, '<', "$self->{dir}/unhandled.log" or return;
+	binmode $fh or croak "binmode: $!";
+	while (<$fh>) {
+		if (defined $r && /^r(\d+)$/) {
+			last if $1 > $r;
+		} elsif (/^  \+empty_dir: (.+)$/) {
+			$empty_dirs{$1} = 1;
+		} elsif (/^  \-empty_dir: (.+)$/) {
+			delete $empty_dirs{$1};
+		}
+	}
+	close $fh;
+	foreach my $d (sort keys %empty_dirs) {
+		$d = uri_decode($d);
+		next if -d $d;
+		if (-e _) {
+			warn "$d exists but is not a directory\n";
+		} else {
+			print "creating empty directory: $d\n";
+			mkpath([$d]);
+		}
+	}
+}
+
 sub get_untracked {
 	my ($self, $ed) = @_;
 	my @out;
@@ -3556,6 +3595,12 @@ sub uri_encode {
 	$f
 }
 
+sub uri_decode {
+	my ($f) = @_;
+	$f =~ s#%([0-9a-fA-F]{2})#chr(hex($1))#eg;
+	$f
+}
+
 sub remove_username {
 	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
 }
diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 9be7aef..767799e 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -19,7 +19,7 @@ test_expect_success 'init and fetch repository' '
 	'
 
 test_expect_success 'create file in existing ugly and empty dir' '
-	mkdir "#{bad_directory_name}" &&
+	mkdir -p "#{bad_directory_name}" &&
 	echo hi > "#{bad_directory_name}/ foo" &&
 	git update-index --add "#{bad_directory_name}/ foo" &&
 	git commit -m "new file in ugly parent" &&
@@ -37,7 +37,7 @@ test_expect_success 'rename pretty file' '
 	git update-index --add pretty &&
 	git commit -m "pretty :x" &&
 	git svn dcommit &&
-	mkdir regular_dir_name &&
+	mkdir -p regular_dir_name &&
 	git mv pretty regular_dir_name/pretty &&
 	git commit -m "moved pretty file" &&
 	git svn dcommit
diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
new file mode 100755
index 0000000..5948544
--- /dev/null
+++ b/t/t9146-git-svn-empty-dirs.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+
+test_description='git svn creates empty directories'
+. ./lib-git-svn.sh
+
+test_expect_success 'initialize repo' '
+	for i in a b c d d/e d/e/f "weird file name"
+	do
+		svn_cmd mkdir -m "mkdir $i" "$svnrepo"/"$i"
+	done
+'
+
+test_expect_success 'clone' 'git svn clone "$svnrepo" cloned'
+
+test_expect_success 'empty directories exist' '
+	(
+		cd cloned &&
+		for i in a b c d d/e d/e/f "weird file name"
+		do
+			if ! test -d "$i"
+			then
+				echo >&2 "$i does not exist"
+				exit 1
+			fi
+		done
+	)
+'
+
+test_expect_success 'more emptiness' '
+	svn_cmd mkdir -m "bang bang"  "$svnrepo"/"! !"
+'
+
+test_expect_success 'git svn rebase creates empty directory' '
+	( cd cloned && git svn rebase )
+	test -d cloned/"! !"
+'
+
+test_expect_success 'git svn mkdirs recreates empty directories' '
+	(
+		cd cloned &&
+		rm -r * &&
+		git svn mkdirs &&
+		for i in a b c d d/e d/e/f "weird file name" "! !"
+		do
+			if ! test -d "$i"
+			then
+				echo >&2 "$i does not exist"
+				exit 1
+			fi
+		done
+	)
+'
+
+test_expect_success 'git svn mkdirs -r works' '
+	(
+		cd cloned &&
+		rm -r * &&
+		git svn mkdirs -r7 &&
+		for i in a b c d d/e d/e/f "weird file name"
+		do
+			if ! test -d "$i"
+			then
+				echo >&2 "$i does not exist"
+				exit 1
+			fi
+		done
+
+		if test -d "! !"
+		then
+			echo >&2 "$i should not exist"
+			exit 1
+		fi
+
+		git svn mkdirs -r8 &&
+		if ! test -d "! !"
+		then
+			echo >&2 "$i not exist"
+			exit 1
+		fi
+	)
+'
+
+test_done
-- 
Eric Wong
