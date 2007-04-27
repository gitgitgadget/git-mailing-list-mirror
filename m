From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] [PATCH] git-mirror - exactly mirror another repository
Date: Fri, 27 Apr 2007 04:15:05 +0200
Message-ID: <20070427021505.1740.58136.stgit@rover>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 04:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhFzP-0000z6-D8
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 04:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412AbXD0CPL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 22:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755414AbXD0CPK
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 22:15:10 -0400
Received: from rover.dkm.cz ([62.24.64.27]:46798 "EHLO rover.dkm.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412AbXD0CPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 22:15:07 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Apr 2007 22:15:07 EDT
Received: from [127.0.0.1] (rover [127.0.0.1])
	by rover.dkm.cz (Postfix) with ESMTP id 8F8DF8BEAA;
	Fri, 27 Apr 2007 04:15:05 +0200 (CEST)
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sometimes its handy to be able to efficiently backup or mirror one
Git repository to another Git repository by employing the native
Git object transfer protocol.  But when mirroring or backing up a
repository you really want:

  1) Every object in the source to go to the mirror.
  2) Every ref in the source to go to the mirror.
  3) Any ref removed from the source to be removed from the mirror.

and since git-fetch doesn't do 2 and 3, here's a tool that does.

This is based on Shawn Pearce's patch from 25 Sep 2006, updated to take
Junio's and Sergey's review into account, to use few newer pieces of Git
infrastructure and with few trivial tweaks. The repacking part was dropped
since git-fetch does that on its own now.

I actually still would kind of prefer this to be a git-fetch's feature but
the general mood seems to be to have this as a separate command and I can't
say I care at all.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 .gitignore                   |    1 
 Documentation/config.txt     |    6 ++
 Documentation/git-mirror.txt |   54 +++++++++++++++++++++
 Makefile                     |    2 -
 git-mirror.perl              |  110 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 172 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 4dc0c39..d0b67da 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,6 +80,7 @@ git-merge-resolve
 git-merge-stupid
 git-merge-subtree
 git-mergetool
+git-mirror
 git-mktag
 git-mktree
 git-name-rev
diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0aff53..e05e4c5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -513,6 +513,12 @@ log.showroot::
 	Tools like gitlink:git-log[1] or gitlink:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+mirror.allowed::
+	If true, gitlink:git-mirror[1] will be allowed to run on the
+	repository.  Please see its documentation for all the implications.
+
+mirror.
+
 merge.summary::
 	Whether to include summaries of merged commits in newly created
 	merge commit messages. False by default.
diff --git a/Documentation/git-mirror.txt b/Documentation/git-mirror.txt
new file mode 100644
index 0000000..0909124
--- /dev/null
+++ b/Documentation/git-mirror.txt
@@ -0,0 +1,54 @@
+git-mirror(1)
+============
+
+NAME
+----
+git-mirror - Exactly mirror another repository
+
+
+SYNOPSIS
+--------
+'git-mirror' <repository>
+
+
+DESCRIPTION
+-----------
+Completely mirrors another repository into the local repository.
+
+All heads and tags from the other repository are copied to the
+local repository without any regard for merging.  This means
+that all heads and tags will be FORCIBLY CHANGED in the local
+repository to make them match the other repository.  Any local
+ref or tags which has been deleted from the other repository
+will also be deleted from the local repository.
+
+After mirroring is complete, in case the 'HEAD' symref does not
+seem to match locally the remote one, `git-mirror` will attempt
+to guess which head is now the 'HEAD'; if there are more candidates,
+one will be chosen roughly randomly.
+
+
+CONFIGURATION
+-------------
+
+Prior to updating the local repository 'git-mirror' requires
+that the user set 'mirror.allowed' to a true value in the local
+repository's config file.  This is considered to be a safety
+latch which is intended to prevent accidental overwriting of
+the local repository.
+
+
+SEE ALSO
+--------
+gitlink:git-fetch[1]
+gitlink:git-prune[1]
+gitlink:git-repack[1]
+
+
+Author
+------
+Written by Shawn Pearce <spearce@spearce.org> and Petr Baudis <pasky@suse.cz>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 60c41fd..5fa370f 100644
--- a/Makefile
+++ b/Makefile
@@ -208,7 +208,7 @@ SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-cvsserver.perl git-remote.perl \
 	git-svnimport.perl git-cvsexportcommit.perl \
-	git-send-email.perl git-svn.perl
+	git-send-email.perl git-svn.perl git-mirror.perl
 
 SCRIPT_PYTHON = \
 	git-p4import.py
diff --git a/git-mirror.perl b/git-mirror.perl
new file mode 100644
index 0000000..22ea879
--- /dev/null
+++ b/git-mirror.perl
@@ -0,0 +1,110 @@
+#!/usr/bin/env perl
+# Copyright (C) 2006, Shawn Pearce <spearce@spearce.org>
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Linus.
+
+use warnings;
+use strict;
+use Git;
+
+my $remote = shift || 'origin';
+my $repo = Git->repository();
+
+# Verify its OK to execute in this repository.
+#
+unless ($repo->config_bool('mirror.allowed')) {
+	print STDERR <<EOF;
+Error: mirror.allowed is false.
+Error:
+Error: For safety reasons please set mirror.allowed in this repository's
+Error: config before using this command.
+Error:
+Error: Unless you are using this repository ONLY for mirroring another
+Error: repository you probably don't want to do this. Please see the
+Error: manpage for more details.
+EOF
+	exit 1;
+}
+
+# Build our list of refs.
+#
+my $remote_refs = ls_refs($repo, $remote);
+my $local_refs = ls_refs($repo, $repo->repo_path());
+my $remote_HEAD = $remote_refs->{'HEAD'};
+my $local_HEAD = $local_refs->{'HEAD'};
+delete $remote_refs->{'HEAD'};
+delete $local_refs->{'HEAD'};
+
+# Execute the fetch for any refs which differ from our own.
+# We don't worry about trying to optimize for rewinds or
+# exact branch copies as they are rather uncommon.
+#
+my @to_fetch;
+while (my ($ref, $hash) = each %$remote_refs) {
+	push(@to_fetch, "$ref:$ref")
+		if (!$local_refs->{$ref} || $local_refs->{$ref} ne $hash);
+}
+if (@to_fetch) {
+	git_cmd_try {
+		$repo->command_noisy('fetch',
+			'--force',
+			'--update-head-ok',
+			$remote, sort @to_fetch);
+	} '%s failed w/ code %d';
+} else {
+	print "No changed refs.  Skipping fetch.\n";
+}
+
+# See what the remote has HEAD pointing at and update our local
+# HEAD to point at some ref which points at the same hash.
+# Prefer to keep HEAD the same if possible to avoid HEAD drifting
+# between different branches.
+# Note that with dumb protocols, we don't get to *know* HEAD implicitly
+# with git-ls-remote...
+#
+git_cmd_try {
+	my $headref = $repo->command_oneline('symbolic-ref', 'HEAD');
+	my $HEAD;
+	if (not $remote_refs->{$headref}) {
+		$HEAD = 'refs/heads/master';
+		print "Local HEAD branch disappeared, falling back to refs/heads/master\n";
+	} elsif ($remote_HEAD and $remote_refs->{$headref} ne $remote_HEAD) {
+		my %by_hash = map {$remote_refs->{$_} => $_}
+			grep {m,^refs/heads/,}
+			sort keys %$remote_refs;
+		$HEAD = $by_hash{$remote_HEAD};
+		if ($HEAD) {
+			print "Setting HEAD to $HEAD ($remote_HEAD)\n";
+		} else {
+			print "Remote HEAD ($remote_HEAD) does not match any remote branch\n";
+		}
+	}
+	if ($HEAD) {
+		$repo->command_noisy('symbolic-ref', 'HEAD', $HEAD);
+	}
+} '%s failed w/ code %d';
+
+# Delete any local refs which the server no longer contains.
+#
+foreach my $ref (keys %$local_refs) {
+	next if $remote_refs->{$ref};
+	print "Removing $ref\n";
+	git_cmd_try {
+		$repo->command_noisy('update-ref', '-d', $ref, $local_refs->{$ref});
+	} '%s failed w/ code %d';
+}
+
+sub ls_refs {
+	my $repo = shift;
+	my $name = shift;
+	my $refs = $repo->remote_refs($name);
+	my @interesting = grep {
+		$_ eq 'HEAD' or (/^refs\// and not /\.\./ and not /\^{}$/);
+	} keys %$refs;
+
+	my %refs2;
+	# This funky-looking expression puts @interesting-subset of %$refs
+	# to %refs2.
+	@refs2{@interesting} = @{$refs}{@interesting};
+	\%refs2;
+}
