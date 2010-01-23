From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] git-svn: allow subset of branches/tags to be specified in glob spec
Date: Sat, 23 Jan 2010 03:30:01 -0500
Message-ID: <1264235401-44051-3-git-send-email-jaysoffian@gmail.com>
References: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 09:38:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYbWA-0007js-V5
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 09:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab0AWIiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 03:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330Ab0AWIiu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 03:38:50 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:38355 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0AWIiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 03:38:50 -0500
Received: by ywh6 with SMTP id 6so1743183ywh.4
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 00:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=vvmpF6MABoIXa1PbLm6IKwXfGh5KsB+8X5dU6lkYj5g=;
        b=fVP1NgFoLnhmf5oCPW8BsfcklGNk/+F8mRF3UQfXWseDMt4KoLlwkuBVOelXFkF1mK
         TEoO4wJUZ8ILKuUMurFVx8N2893AOGhYlDkN9wq2Vz0lMzNWr1dDiXbOSyovJNEGTJI7
         UKIDa+nQvIqFht0wCJOZb7Nwo+drfL1daRx5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uPAqT19SrqgM787YgxXqizGrqR7diYnqGW853cofMt7J4GS/K4orZvKpKAfJ5UvWOs
         cpgQ2XluPUtFr4qO+QERqAxWsmLcU/B4Ih3eupxk6ynLijcrktmkvzNdtP6bJfsjq49w
         KfcJDyBL6j0Pbru5Xy5u9PENzNYtKOXkAho/Y=
Received: by 10.90.19.24 with SMTP id 24mr3677077ags.10.1264235435530;
        Sat, 23 Jan 2010 00:30:35 -0800 (PST)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 13sm1762733gxk.5.2010.01.23.00.30.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 00:30:35 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.515.g288caf
In-Reply-To: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137817>

For very large projects it is useful to be able to clone a subset of the
upstream SVN repo's branches. Allow for this by letting the left-side of
the branches and tags glob specs contain a brace-delineated comma-separated
list of names. e.g.:

	branches = branches/{red,green}/src:refs/remotes/branches/*

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
The only part of this I don't like is asking the user to manually edit
.git/svn/.metadata, but I couldn't think of a clean way to invalidate
the cached maxRev property. Further, if you know the starting point
of your branches, it can speed things up quite a bit to just set maxRev
to the appropriate value, esp for repos with a long history.

 Documentation/git-svn.txt     |   16 +++
 git-svn.perl                  |   60 ++++++++----
 t/t9154-git-svn-fancy-glob.sh |   42 ++++++++
 t/t9154/svn.dump              |  222 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 320 insertions(+), 20 deletions(-)
 create mode 100755 t/t9154-git-svn-fancy-glob.sh
 create mode 100644 t/t9154/svn.dump

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 98fe439..190a62a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -825,6 +825,22 @@ independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using 'git config'.
 
+It is also possible to fetch a subset of branches or tags by using a
+comma-separated list of names within braces. For example:
+
+------------------------------------------------------------------------
+[svn-remote "huge-project"]
+	url = http://server.org/svn
+	fetch = trunk/src:refs/remotes/trunk
+	branches = branches/{red,green}/src:refs/remotes/branches/*
+	tags = tags/{1.0,2.0}/src:refs/remotes/tags/*
+------------------------------------------------------------------------
+
+Note that git-svn keeps track of the highest revision in which a branch
+or tag has appeared. If the subset of branches or tags is changed after
+fetching, then .git/svn/.metadata must be manually edited to remove (or
+reset) branches-maxRev and/or tags-maxRev as appropriate.
+
 SEE ALSO
 --------
 linkgit:git-rebase[1]
diff --git a/git-svn.perl b/git-svn.perl
index 1fab210..80bdef7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1807,8 +1807,8 @@ sub read_all_remotes {
 			my $rs = {
 			    t => $t,
 			    remote => $remote,
-			    path => Git::SVN::GlobSpec->new($local_ref),
-			    ref => Git::SVN::GlobSpec->new($remote_ref) };
+			    path => Git::SVN::GlobSpec->new($local_ref, 1),
+			    ref => Git::SVN::GlobSpec->new($remote_ref, 0) };
 			if (length($rs->{ref}->{right}) != 0) {
 				die "The '*' glob character must be the last ",
 				    "character of '$remote_ref'\n";
@@ -5180,6 +5180,7 @@ sub match_globs {
 			next if (length $g->{path}->{right} &&
 				 ($self->check_path($p, $r) !=
 				  $SVN::Node::dir));
+			next unless $p =~ /$g->{path}->{regex}/;
 			$exists->{$p} = Git::SVN->init($self->{url}, $p, undef,
 					 $g->{ref}->full_path($de), 1);
 		}
@@ -5953,29 +5954,48 @@ use strict;
 use warnings;
 
 sub new {
-	my ($class, $glob) = @_;
+	my ($class, $glob, $pattern_ok) = @_;
 	my $re = $glob;
 	$re =~ s!/+$!!g; # no need for trailing slashes
-	$re =~ m!^([^*]*)(\*(?:/\*)*)(.*)$!;
-	my $temp = $re;
-	my ($left, $right) = ($1, $3);
-	$re = $2;
-	my $depth = $re =~ tr/*/*/;
-	if ($depth != $temp =~ tr/*/*/) {
-		die "Only one set of wildcard directories " .
-			"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
+	my (@left, @right, @patterns);
+	my $state = "left";
+	my $die_msg = "Only one set of wildcard directories " .
+				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
+	for my $part (split(m|/|, $glob)) {
+		if ($part =~ /\*/ && $part ne "*") {
+			die "Invalid pattern in '$glob': $part\n";
+		} elsif ($pattern_ok && $part =~ /[{}]/ &&
+			 $part !~ /^\{[^{}]+\}/) {
+			die "Invalid pattern in '$glob': $part\n";
+		}
+		if ($part eq "*") {
+			die $die_msg if $state eq "right";
+			$state = "pattern";
+			push(@patterns, "[^/]*");
+		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
+			die $die_msg if $state eq "right";
+			$state = "pattern";
+			my $p = quotemeta($1);
+			$p =~ s/\\,/|/g;
+			push(@patterns, "(?:$p)");
+		} else {
+			if ($state eq "left") {
+				push(@left, $part);
+			} else {
+				push(@right, $part);
+				$state = "right";
+			}
+		}
 	}
+	my $depth = @patterns;
 	if ($depth == 0) {
-		die "One '*' is needed for glob: '$glob'\n";
-	}
-	$re =~ s!\*!\[^/\]*!g;
-	$re = quotemeta($left) . "($re)" . quotemeta($right);
-	if (length $left && !($left =~ s!/+$!!g)) {
-		die "Missing trailing '/' on left side of: '$glob' ($left)\n";
-	}
-	if (length $right && !($right =~ s!^/+!!g)) {
-		die "Missing leading '/' on right side of: '$glob' ($right)\n";
+		die "One '*' is needed in glob: '$glob'\n";
 	}
+	my $left = join('/', @left);
+	my $right = join('/', @right);
+	$re = join('/', @patterns);
+	$re = join('\/',
+		   grep(length, quotemeta($left), "($re)", quotemeta($right)));
 	my $left_re = qr/^\/\Q$left\E(\/|$)/;
 	bless { left => $left, right => $right, left_regex => $left_re,
 	        regex => qr/$re/, glob => $glob, depth => $depth }, $class;
diff --git a/t/t9154-git-svn-fancy-glob.sh b/t/t9154-git-svn-fancy-glob.sh
new file mode 100755
index 0000000..a6a56a6
--- /dev/null
+++ b/t/t9154-git-svn-fancy-glob.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Jay Soffian
+#
+
+test_description='git svn fancy glob test'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'load svn repo' "
+	svnadmin load -q '$rawsvnrepo' < '$TEST_DIRECTORY/t9154/svn.dump' &&
+	git svn init --minimize-url -T trunk '$svnrepo' &&
+	git svn fetch
+	"
+
+test_expect_success 'add red branch' "
+	git config svn-remote.svn.branches 'branches/{red}:refs/remotes/*' &&
+	git svn fetch &&
+	git rev-parse refs/remotes/red &&
+	test_must_fail git rev-parse refs/remotes/green &&
+	test_must_fail git rev-parse refs/remotes/blue
+	"
+
+test_expect_success 'add green branch' "
+	GIT_CONFIG=.git/svn/.metadata git config --unset svn-remote.svn.branches-maxRev &&
+	git config svn-remote.svn.branches 'branches/{red,green}:refs/remotes/*' &&
+	git svn fetch &&
+	git rev-parse refs/remotes/red &&
+	git rev-parse refs/remotes/green &&
+	test_must_fail git rev-parse refs/remotes/blue
+	"
+
+test_expect_success 'add all branches' "
+	GIT_CONFIG=.git/svn/.metadata git config --unset svn-remote.svn.branches-maxRev &&
+	git config svn-remote.svn.branches 'branches/*:refs/remotes/*' &&
+	git svn fetch &&
+	git rev-parse refs/remotes/red &&
+	git rev-parse refs/remotes/green &&
+	git rev-parse refs/remotes/blue
+	"
+
+test_done
diff --git a/t/t9154/svn.dump b/t/t9154/svn.dump
new file mode 100644
index 0000000..3dfabb6
--- /dev/null
+++ b/t/t9154/svn.dump
@@ -0,0 +1,222 @@
+SVN-fs-dump-format-version: 2
+
+UUID: a18093a0-5f0b-44e0-8d88-8911ac7078db
+
+Revision-number: 0
+Prop-content-length: 56
+Content-length: 56
+
+K 8
+svn:date
+V 27
+2010-01-23T07:40:25.660053Z
+PROPS-END
+
+Revision-number: 1
+Prop-content-length: 104
+Content-length: 104
+
+K 7
+svn:log
+V 7
+initial
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T07:41:33.636365Z
+PROPS-END
+
+Node-path: trunk
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: trunk/foo
+Node-kind: file
+Node-action: add
+Prop-content-length: 10
+Text-content-length: 4
+Text-content-md5: d3b07384d113edec49eaa6238ad5ff00
+Text-content-sha1: f1d2d2f924e986ac86fdf7b36c94bcdf32beec15
+Content-length: 14
+
+PROPS-END
+foo
+
+
+Revision-number: 2
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 12
+add branches
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T07:42:37.290694Z
+PROPS-END
+
+Node-path: branches
+Node-kind: dir
+Node-action: add
+Prop-content-length: 10
+Content-length: 10
+
+PROPS-END
+
+
+Node-path: branches/blue
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Node-path: branches/green
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Node-path: branches/red
+Node-kind: dir
+Node-action: add
+Node-copyfrom-rev: 1
+Node-copyfrom-path: trunk
+
+
+Revision-number: 3
+Prop-content-length: 108
+Content-length: 108
+
+K 7
+svn:log
+V 10
+red change
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T07:43:02.208918Z
+PROPS-END
+
+Node-path: branches/red/foo
+Node-kind: file
+Node-action: change
+Text-content-length: 8
+Text-content-md5: 64c3c8cf7d0233ab7627623a68888bd1
+Text-content-sha1: 95a0492027876adfd3891ec71ee37b79ee44d640
+Content-length: 8
+
+foo
+red
+
+
+Revision-number: 4
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 12
+green change
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T07:43:15.746586Z
+PROPS-END
+
+Node-path: branches/green/foo
+Node-kind: file
+Node-action: change
+Text-content-length: 10
+Text-content-md5: 0209b6450891abc033d5eaaa9d3a8023
+Text-content-sha1: 87fc3bef9faeec48c0cd61dfc9851db377fdccf7
+Content-length: 10
+
+foo
+green
+
+
+Revision-number: 5
+Prop-content-length: 109
+Content-length: 109
+
+K 7
+svn:log
+V 11
+blue change
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T07:43:29.364811Z
+PROPS-END
+
+Node-path: branches/blue/foo
+Node-kind: file
+Node-action: change
+Text-content-length: 9
+Text-content-md5: 9fbe4c13d0bae86386ae5209b2e6b275
+Text-content-sha1: cc4575083459a16f9aaef796c4a2456d64691ba0
+Content-length: 9
+
+foo
+blue
+
+
+Revision-number: 6
+Prop-content-length: 110
+Content-length: 110
+
+K 7
+svn:log
+V 12
+trunk change
+K 10
+svn:author
+V 3
+jay
+K 8
+svn:date
+V 27
+2010-01-23T07:44:01.313130Z
+PROPS-END
+
+Node-path: trunk/foo
+Node-kind: file
+Node-action: change
+Text-content-length: 10
+Text-content-md5: 1c4db977d7a57c3bae582aab87948516
+Text-content-sha1: 469c08df449e702cf2a1fe746244a9ef3f837fad
+Content-length: 10
+
+foo
+trunk
+
+
-- 
1.6.6.1.515.g288caf
