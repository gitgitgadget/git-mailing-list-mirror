From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Introduce git-mirror, a tool for exactly mirroring another repository.
Date: Mon, 25 Sep 2006 00:46:41 -0400
Message-ID: <20060925044641.GB15757@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 25 06:46:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRiMp-0008Gi-KL
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 06:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbWIYEqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 00:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbWIYEqt
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 00:46:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51633 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751669AbWIYEqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 00:46:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GRiMd-0005cC-3a; Mon, 25 Sep 2006 00:46:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B78D120FB16; Mon, 25 Sep 2006 00:46:41 -0400 (EDT)
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27726>

Sometimes its handy to be able to efficiently backup or mirror one
Git repository to another Git repository by employing the native
Git object transfer protocol.  But when mirroring or backing up a
repository you really want:

  1) Every object in the source to go to the mirror.
  2) Every ref in the source to go to the mirror.
  3) Any ref removed from the source to be removed from the mirror.
  4) Automatically repack and prune the mirror when necessary.

and since git-fetch doesn't do 2, 3, and 4 here's a tool that does.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Since 'git fetch --mirror-all' wasn't quite ready here's something
 slightly more polished.

 I'm hoping this gets accepted as I'm thinking it would be very
 useful for backing up a user's repository to another host on a
 regular basis, not to mention also useful for Pasky's mirroring
 service.  I'm planning on using it for backups, especially of
 repositories where branches are frequently being added and deleted.

 .gitignore                   |    1 
 Documentation/git-mirror.txt |   64 ++++++++++++++++++++++++
 Makefile                     |    2 -
 git-mirror.perl              |  111 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 1 deletions(-)

diff --git a/.gitignore b/.gitignore
index 78a3a3d..5f99149 100644
--- a/.gitignore
+++ b/.gitignore
@@ -68,6 +68,7 @@ git-merge-recur
 git-merge-recursive
 git-merge-resolve
 git-merge-stupid
+git-mirror
 git-mktag
 git-mktree
 git-name-rev
diff --git a/Documentation/git-mirror.txt b/Documentation/git-mirror.txt
new file mode 100644
index 0000000..27e5167
--- /dev/null
+++ b/Documentation/git-mirror.txt
@@ -0,0 +1,64 @@
+git-mirror(1)
+============
+
+NAME
+----
+git-mirror - Exactly mirror another repository.
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
+that all heads and tags will be forcibly changed in the local
+repository to make them match the other repository.  Any local
+ref or tags which has been deleted from the other repository
+will also be deleted from the local repository.
+
+After mirroring is complete the 'HEAD' symref will point at
+any branch in 'refs/heads' which has the same SHA1 as the other
+repository's 'HEAD' contained when 'git-mirror' started.  This
+is simply a rough guess and may not always be accurate.
+
+This command will also invoke 'git-repack' and 'git-prune' if
+the number of loose objects exceeds the configured threshold.
+As a result this command may cause the local repository to lose
+commits that have been removed from the other repository.
+
+
+CONFIGURATION
+-------------
+
+Prior to updating the local repository 'git-mirror' requires
+that the user set 'mirror.allowed' to a true value in the local
+repository's config file.  This is considered to be a safety
+feature which is intended to prevent accidental overwriting of
+the local repository.
+
+After updating the local repository 'git-mirror' will run
+'git-repack -a -d' and 'git-prune' if the number of loose objects
+exceeds the limit specified in the configuration file by
+'mirror.maxlooseobjects' (default 100).
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
+Written by Shawn Pearce <spearce@spearce.org>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 9a1f23f..08fb714 100644
--- a/Makefile
+++ b/Makefile
@@ -181,7 +181,7 @@ SCRIPT_PERL = \
 	git-shortlog.perl git-rerere.perl \
 	git-annotate.perl git-cvsserver.perl \
 	git-svnimport.perl git-cvsexportcommit.perl \
-	git-send-email.perl git-svn.perl
+	git-send-email.perl git-svn.perl git-mirror.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
diff --git a/git-mirror.perl b/git-mirror.perl
new file mode 100755
index 0000000..bff2003
--- /dev/null
+++ b/git-mirror.perl
@@ -0,0 +1,111 @@
+#!/usr/bin/env perl
+# Copyright (C) 2006, Shawn Pearce <spearce@spearce.org>
+# This file is licensed under the GPL v2, or a later version
+# at the discretion of Linus.
+
+use warnings;
+use strict;
+use Git;
+
+sub ls_refs ($$);
+
+my $remote = shift || 'origin';
+my $repo = Git->repository();
+
+# Verify its OK to execute in this repository.
+#
+my $mirror_ok = $repo->config('mirror.allowed') || 0;
+unless ($mirror_ok =~ /^(?:true|t|yes|y|1)$/i) {
+	print STDERR <<EOF;
+error: mirror.allowed is false.
+error:
+error: For safety reasons please set mirror.allowed in this repository's
+error: config before using this command.
+error:
+error: Unless you are using this repository ONLY for mirroring another
+error: repository you probably don't want to do this.
+EOF
+	exit 1;
+}
+
+# Build our list of refs.
+#
+my $remote_refs = ls_refs($repo, $remote);
+my $local_refs = ls_refs($repo, $repo->repo_path());
+my $remote_HEAD = $remote_refs->{'HEAD'};
+delete $remote_refs->{'HEAD'};
+delete $local_refs->{'HEAD'};
+
+# Delete any local refs which the server no longer contains.
+#
+foreach my $ref (keys %$local_refs) {
+	next if $remote_refs->{$ref};
+	print "removing $ref\n";
+	my $log = "logs/$ref";
+	unlink($repo->repo_path() . '/' . $ref);
+	unlink($repo->repo_path() . '/' . $log);
+	rmdir($repo->repo_path() . '/' . $ref) while $ref =~ s,/[^/]*$,,;
+	rmdir($repo->repo_path() . '/' . $log) while $log =~ s,/[^/]*$,,;
+}
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
+# HEAD to point at the any ref which points at the same hash.
+#
+my %by_hash = map {$remote_refs->{$_} => $_}
+	grep {m,^refs/heads/,}
+	keys %$remote_refs;
+my $HEAD = $by_hash{$remote_HEAD} || 'refs/heads/master';
+print "Setting HEAD to $HEAD\n";
+print "                ($remote_HEAD)\n";
+git_cmd_try {
+	$repo->command_noisy('symbolic-ref', 'HEAD', $HEAD);
+} '%s failed w/ code %d';
+
+# Repack if we have a large number of loose objects.
+#
+if (@to_fetch) {
+	my $count_output = $repo->command('count-objects');
+	my ($cur_loose) = ($count_output =~ /^(\d+) objects/);
+	my $max_loose = $repo->config('mirror.maxlooseobjects') || 100;
+	if ($cur_loose >= $max_loose) {
+		git_cmd_try {
+			$repo->command_noisy('repack', '-a', '-d');
+			$repo->command_noisy('prune');
+		} '%s failed w/ code %d';
+	}
+}
+
+sub ls_refs ($$) {
+	my $repo = shift;
+	my $name = shift;
+	my ($fh, $c) = $repo->command_output_pipe('ls-remote', $name);
+	my %refs;
+	while (<$fh>) {
+		chomp;
+		next if /\^{}$/;
+		my ($hash, $ref) = split(/\t/, $_, 2);
+		$refs{$ref} = $hash if ($ref eq 'HEAD' || $ref =~ m,^refs/,);
+	}
+	$repo->command_close_pipe($fh, $c);
+	\%refs;
+}
-- 
1.4.2.1.gde2b2-dirty
