From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn rebase issues (the commiter gets changed)
Date: Sat, 15 Dec 2007 19:27:09 -0800
Message-ID: <20071216032523.GA17666@muzzle>
References: <94ccbe710711220815j663d22e0v3c744244d0a87b66@mail.gmail.com> <20071129075205.GB32277@soma> <94ccbe710711290816t7a6ba9b1o8f37ecf583305a51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kelvie Wong <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:27:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kAB-0008Ef-1d
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495AbXLPD1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758545AbXLPD1L
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:27:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34874 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757171AbXLPD1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:27:11 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id DF6607DC10A;
	Sat, 15 Dec 2007 19:27:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <94ccbe710711290816t7a6ba9b1o8f37ecf583305a51@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68427>

Sorry for the late reply, I've been all over the place lately.

Kelvie Wong <kelvie@ieee.org> wrote:
> Just did it again this morning, with a clean test branch:
> 
> kelvie@mudd (text-edit) qt $ git checkout -b test git-svn
> Switched to a new branch "test"
> kelvie@mudd (test) qt $ touch test
> kelvie@mudd (test) qt $ git add test
> kelvie@mudd (test) qt $ git commit -a -m 'Test!'
> Created commit 05c4016: Test!
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 apps/qt/test
> kelvie@mudd (test) qt $ git-cat-file commit HEAD
> tree 867c0aa4c814542f0752b5d4c85fc96ba2279aac
> parent 831ffbf25057ed30274d4216269c572cfce12184
> author Kelvie Wong <Kelvie.Wong@safe.com> 1196352603 -0800
> committer Kelvie Wong <Kelvie.Wong@safe.com> 1196352603 -0800
> 
> Test!
> kelvie@mudd (test) qt $ git svn rebase
> <snip>
> HEAD is now at 7319c2a... (svn commit message)
> kelvie@mudd (test) qt $ git-cat-file commit HEAD
> tree 4edacbd41af76ac243099467b33350887c0fb03d
> parent 7319c2a810554aab25a688bcc2b16fc60529b59d
> author Kelvie Wong <Kelvie.Wong@safe.com> 1196352603 -0800
> committer ogibbins <ogibbins@e2d93294-a71b-0410-9dca-e2ea525a67c9>
> 1196346907 +0000
> 
> Test!
> kelvie@mudd (test) qt $ git --version
> git version 1.5.3.6.736.gb7f30
> 
> And again, the committer of a local commit gets changed.
> 
> Now, this part is more interesting:
> 
> kelvie@mudd (test) qt $ git checkout working
> Switched to branch "working"
> kelvie@mudd (working) qt $ git svn rebase
> <no fetch, just a checkout and rebase>
> 
> And when I cat-file the commit, this time it's preserved.  Wild guess
> here (this behaviour seems kind of inconsistent), but it has to do
> with the transition between fetch and rebase?  Or is this a bug in
> git-rebase somewhere?

Ah, it looks like a bug in git-svn.  The following should fix it:

>From 84e99bffc72c10ec7db6d5ae7af6a795b75ef724 Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Sat, 15 Dec 2007 19:08:22 -0800
Subject: [PATCH] git-svn: avoid leaving leftover committer/author info in rebase

We set the 6 environment variables for controlling
committer/author email/name/time for every commit.

We do this in the parent process to be passed to
git-commit-tree, because open3() doesn't afford us the control
of doing it only in the child process.  This means we leave them
hanging around in the main process until the next revision comes
around and all 6 environment variables are overwridden again.

Unfortunately, for the last commit, leaving them hanging around
means the git-rebase invocation will pick it up, rewriting the
rebased commit with incorrect author information.  This should fix
it.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |   50 +++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index d411a34..7cd62fc 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2052,18 +2052,16 @@ sub full_url {
 	$self->{url} . (length $self->{path} ? '/' . $self->{path} : '');
 }
 
-sub do_git_commit {
-	my ($self, $log_entry) = @_;
-	my $lr = $self->last_rev;
-	if (defined $lr && $lr >= $log_entry->{revision}) {
-		die "Last fetched revision of ", $self->refname,
-		    " was r$lr, but we are about to fetch: ",
-		    "r$log_entry->{revision}!\n";
-	}
-	if (my $c = $self->rev_map_get($log_entry->{revision})) {
-		croak "$log_entry->{revision} = $c already exists! ",
-		      "Why are we refetching it?\n";
+
+sub set_commit_header_env {
+	my ($log_entry) = @_;
+	my %env;
+	foreach my $ned (qw/NAME EMAIL DATE/) {
+		foreach my $ac (qw/AUTHOR COMMITTER/) {
+			$env{"GIT_${ac}_${ned}"} = $ENV{"GIT_${ac}_${ned}"};
+		}
 	}
+
 	$ENV{GIT_AUTHOR_NAME} = $log_entry->{name};
 	$ENV{GIT_AUTHOR_EMAIL} = $log_entry->{email};
 	$ENV{GIT_AUTHOR_DATE} = $ENV{GIT_COMMITTER_DATE} = $log_entry->{date};
@@ -2074,7 +2072,36 @@ sub do_git_commit {
 	$ENV{GIT_COMMITTER_EMAIL} = (defined $log_entry->{commit_email})
 						? $log_entry->{commit_email}
 						: $log_entry->{email};
+	\%env;
+}
 
+sub restore_commit_header_env {
+	my ($env) = @_;
+	foreach my $ned (qw/NAME EMAIL DATE/) {
+		foreach my $ac (qw/AUTHOR COMMITTER/) {
+			my $k = "GIT_${ac}_${ned}";
+			if (defined $env->{$k}) {
+				$ENV{$k} = $env->{$k};
+			} else {
+				delete $ENV{$k};
+			}
+		}
+	}
+}
+
+sub do_git_commit {
+	my ($self, $log_entry) = @_;
+	my $lr = $self->last_rev;
+	if (defined $lr && $lr >= $log_entry->{revision}) {
+		die "Last fetched revision of ", $self->refname,
+		    " was r$lr, but we are about to fetch: ",
+		    "r$log_entry->{revision}!\n";
+	}
+	if (my $c = $self->rev_map_get($log_entry->{revision})) {
+		croak "$log_entry->{revision} = $c already exists! ",
+		      "Why are we refetching it?\n";
+	}
+	my $old_env = set_commit_header_env($log_entry);
 	my $tree = $log_entry->{tree};
 	if (!defined $tree) {
 		$tree = $self->tmp_index_do(sub {
@@ -2089,5 +2116,6 @@ sub do_git_commit {
 	defined(my $pid = open3(my $msg_fh, my $out_fh, '>&STDERR', @exec))
 	                                                           or croak $!;
 	print $msg_fh $log_entry->{log} or croak $!;
+	restore_commit_header_env($old_env);
 	unless ($self->no_metadata) {
 		print $msg_fh "\ngit-svn-id: $log_entry->{metadata}\n"
\ No newline at end of file
-- 
Eric Wong
