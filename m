From: Michael Olson <mwolson@gnu.org>
Subject: [PATCH/RFC] git-svn: Allow multiple branch and tag patterns
Date: Mon, 22 Feb 2010 14:29:34 -0800
Message-ID: <c8b3bef91002221429l3b277429l56f4e4cac4fdeb43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjgtL-0001j4-Jj
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab0BVWgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:36:35 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52284 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab0BVWge (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:36:34 -0500
Received: by pwj8 with SMTP id 8so3134251pwj.19
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 14:36:33 -0800 (PST)
Received: by 10.142.119.10 with SMTP id r10mr4436102wfc.43.1266877794099; Mon, 
	22 Feb 2010 14:29:54 -0800 (PST)
X-Originating-IP: [209.104.55.5]
X-Google-Sender-Auth: a5dfff8cbc34f3ac
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140728>

This change allows multiple branch and tag patterns to be specified in
.git/config for git-svn projects.  This is useful for fetching several
different parts out of the namespace of an svn repository.
Additionally, a new repeatable directive called "skip" has been added
to specify a specific tag or branch to ignore.

Signed-off-by: Michael W. Olson <mwolson@gnu.org>
---
I've been using this patch regularly for over a year on a very large
svn repository.

This patch is known to work on git 1.6.3.3 specifically.  Once I get a
few responses about whether or not it is useful, I'll rebase it
against the git.git master branch.  Some further documentation
(perhaps just a relevant example or two) would also need to be added
to the git-svn manpage.

Here is an example ~/.git/config file which works with these changes.
The example upstream svn repository has branches in tags in 2
different namespaces.  Originally all tags/branches were directly
under /root/mod/branches and /root/mod/tags.  Later on, they created
new branches and tags in subdirectories such as
/root/mod/branches/myorg/bugs/BUGID.  This config file forces
old-style branches and tags into the "old/" namespace in git, and puts
new-style branches and tags into (for example) "myorg/bugs/BUGID".
The "skip" directives prevent the first level of the new namespace
("myorg", in particular) from being replicated underneath "old/" in
git, which is for cosmetic purposes.

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[svn-remote "svn"]
	url = https://svn.my.org/svn/root
	fetch = mod/trunk:refs/remotes/trunk
	branches = mod/branches/*:refs/remotes/old/*
        skip = branches:old/myorg
	tags = mod/tags/*:refs/remotes/tags/old/*
        skip = tags:old/myorg
	branches = mod/branches/myorg/bugs/*:refs/remotes/myorg/bugs/*
	tags = mod/tags/myorg/bugs/*:refs/remotes/tags/myorg/bugs/*
	branches = mod/branches/myorg/projects/*:refs/remotes/myorg/projects/*
	tags = mod/tags/myorg/projects/*:refs/remotes/tags/myorg/projects/*
	branches = mod/branches/myorg/releases/*:refs/remotes/myorg/releases/*
	tags = mod/tags/myorg/releases/*:refs/remotes/tags/myorg/releases/*

 git-svn.perl |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index ef1d30d..f7ec70c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1548,7 +1548,7 @@ sub fetch_all {
 	# read the max revs for wildcard expansion (branches/*, tags/*)
 	foreach my $t (qw/branches tags/) {
 		defined $remote->{$t} or next;
-		push @globs, $remote->{$t};
+		push @globs, @{$remote->{$t}};
 		my $max_rev = eval { tmp_config(qw/--int --get/,
 		                         "svn-remote.$repo_id.${t}-maxRev") };
 		if (defined $max_rev && ($max_rev < $base)) {
@@ -1592,14 +1592,17 @@ sub read_all_remotes {
 			$r->{$1}->{svm} = {};
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
 			$r->{$1}->{url} = $2;
+		} elsif (m!^(.+)\.skip=(branches|tags):\s*(.*)\s*$!) {
+			push @{$r->{$1}->{skip}->{$2}}, $3;
 		} elsif (m!^(.+)\.(branches|tags)=
 		           (.*):refs/remotes/(.+)\s*$/!x) {
 			my ($p, $g) = ($3, $4);
-			my $rs = $r->{$1}->{$2} = {
+			my $rs = {
 			                  t => $2,
 					  remote => $1,
 			                  path => Git::SVN::GlobSpec->new($p),
 			                  ref => Git::SVN::GlobSpec->new($g) };
+			push @{$r->{$1}->{$2}}, $rs;
 			if (length($rs->{ref}->{right}) != 0) {
 				die "The '*' glob character must be the last ",
 				    "character of '$g'\n";
@@ -1623,6 +1626,14 @@ sub read_all_remotes {
 		}
 	} keys %$r;

+	for my $rname (keys %$r) {
+		map { $_->{skip} = $r->{$rname}->{skip}->{branches} }
+		    @{$r->{$rname}->{branches}};
+		map { $_->{skip} =
+			[ map { "tags/$_" } @{$r->{$rname}->{skip}->{tags}} ] }
+		    @{$r->{$rname}->{tags}};
+	}
+
 	$r;
 }

@@ -1744,8 +1755,9 @@ sub find_by_url { # repos_root and, path are optional

 		my $fetch = $remotes->{$repo_id}->{fetch} || {};
 		foreach (qw/branches tags/) {
-			resolve_local_globs($u, $fetch,
-			                    $remotes->{$repo_id}->{$_});
+			for my $p (@{$remotes->{$repo_id}->{$_}}) {
+				resolve_local_globs($u, $fetch, $p);
+			}
 		}
 		my $p = $path;
 		my $rwr = rewrite_root({repo_id => $repo_id});
@@ -4586,12 +4598,15 @@ sub match_globs {
 			next unless /$g->{path}->{regex}/;
 			my $p = $1;
 			my $pathname = $g->{path}->full_path($p);
+			my $refname = $g->{ref}->full_path($p);
+			next if $g->{skip} && grep { $refname eq $_ }
+						   @{$g->{skip}};
 			next if $exists->{$pathname};
 			next if ($self->check_path($pathname, $r) !=
 			         $SVN::Node::dir);
 			$exists->{$pathname} = Git::SVN->init(
 			                      $self->{url}, $pathname, undef,
-			                      $g->{ref}->full_path($p), 1);
+			                      $refname, 1);
 		}
 		my $c = '';
 		foreach (split m#/#, $g->{path}->{left}) {
-- 
1.6.3.3
