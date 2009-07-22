From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: Re: [PATCH] Added git svn gc command
Date: Wed, 22 Jul 2009 17:26:36 -0500
Message-ID: <57d579150907221526m6d2ec48dj1fa731e071fe7a68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: normalperson@yhbt.net
X-From: git-owner@vger.kernel.org Thu Jul 23 00:27:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTkH9-0004tF-Bw
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 00:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbZGVW0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 18:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbZGVW0i
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 18:26:38 -0400
Received: from mail-yx0-f197.google.com ([209.85.210.197]:42095 "EHLO
	mail-yx0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbZGVW0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 18:26:37 -0400
Received: by yxe35 with SMTP id 35so872821yxe.33
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 15:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=79pBANn5UwHT+AVpnGHGLHSJe/dKV4y/O8rcgdZLvvw=;
        b=tAlOxp5GgkALtgUIhq6fdIeHof/QwE6cc30YlhwE075lsCdgdYRba2YI6mcHcOwymw
         gidJoqZAv6wL5X/o0YKlBwLAkg1RtMoo60F4vB+bTnfNbs2RZtZiPOQsu93zhsvq6k7o
         8Ama2zmUew7BV+SLS8Qb701t9zfbMF0do/uCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=asv4hHM7uZ3hxOXNH7lLoVyIg2oCw8cRW4pwLQ9lzGIrVY5gZGgL8AHAPvyKu0pLEp
         Jeaaxk1dCW8OOuQm3PN4v+3jcrs8VndgblABa3szbSQUUA83r3RtFPfuvLwcB1Ey3dOq
         EP7H6bmhIsoLKkyctflbYbYpkKnPyC+Rdt7lk=
Received: by 10.151.105.17 with SMTP id h17mr1830767ybm.22.1248301596482; Wed, 
	22 Jul 2009 15:26:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123804>

Eric,

Ok, here is a try sent with
 git format-patch -M --stdout HEAD~1  | git imap-send

I renamed the test tot9142-git-svn-gc.sh  keep up with the two tests
that have been added.


---
 Documentation/git-svn.txt |    4 +++
 git-svn.perl              |   35 ++++++++++++++++++++++++++++++++
 t/t9142-git-svn-gc.sh     |   48 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100755 t/t9142-git-svn-gc.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 10af599..2e35997 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -348,6 +348,10 @@ Any other arguments are passed directly to 'git log'
 	"checksum mismatch" (missed a modification).  If the problem
 	file cannot be ignored forever (with --ignore-paths) the only
 	way to repair the repo is to use 'reset'.
+
+'gc':: Compress $GIT_DIR/svn/<refname>/unhandled.log files in .git/svn
+	and remove $GIT_DIR/svn/<refname>index files in .git/svn.
+
 +
 Only the rev_map and refs/remotes/git-svn are changed.  Follow 'reset'
 with a 'fetch' and then 'git reset' or 'git rebase' to move local
diff --git a/git-svn.perl b/git-svn.perl
index cfade63..8fa8c09 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -31,6 +31,7 @@ require SVN::Delta;
 if ($SVN::Core::VERSION lt '1.1.0') {
 	fatal "Need SVN::Core 1.1.0 or better (got $SVN::Core::VERSION)";
 }
+my $can_compress = eval { require Compress::Zlib; 1};
 push @Git::SVN::Ra::ISA, 'SVN::Ra';
 push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
 push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
@@ -40,6 +41,8 @@ use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
 use File::Spec;
+use File::Find;
+use File::Basename;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
@@ -217,6 +220,9 @@ my %cmd = (
 		     "Undo fetches back to the specified SVN revision",
 		     { 'revision|r=s' => \$_revision,
 		       'parent|p' => \$_fetch_parent } ],
+    'gc' => [ \&cmd_gc,
+              "Compress unhandled.log files in .git/svn and remove
index files in .git/svn",
+              {} ],
 );

 my $cmd;
@@ -1107,6 +1113,16 @@ sub cmd_reset {
 	print "r$r = $c ($gs->{ref_id})\n";
 }

+sub cmd_gc
+{
+	if (!$can_compress) {
+		warn "Compress::Zlib could not be found; unhandled.log files will
not be compressed.\n";
+	}
+	find({ wanted => \&gc_directory,
+		   no_chdir => 1},
+		 "$ENV{GIT_DIR}/svn");
+}
+
 ########################### utility functions #########################

 sub rebase_cmd {
@@ -1527,6 +1543,25 @@ sub md5sum {
 	return $md5->hexdigest();
 }

+sub gc_directory {
+	if ($can_compress && -f $_ && basename($_) eq "unhandled.log") {
+		my $out_filename = $_ . ".gz";
+		open my $in_fh, "<", $_ or die "Unable to open $_: $!\n";
+		binmode $in_fh;
+		my $gz = Compress::Zlib::gzopen($out_filename, "ab")
+			or die "Unable to open $out_filename: $!\n";
+
+		my $res;
+		while ($res = sysread($in_fh, my $str, 1024)) {
+			$gz->gzwrite($str) or die "Unable to write: " . $gz->gzerror() . "!\n";
+		}
+		unlink $_ or die "unlink $File::Find::name: $!\n";
+	} elsif (-f $_ && basename($_) eq "index") {
+		unlink $_ or die "unlink %_: $!\n";
+	}
+}
+
+
 package Git::SVN;
 use strict;
 use warnings;
diff --git a/t/t9142-git-svn-gc.sh b/t/t9142-git-svn-gc.sh
new file mode 100755
index 0000000..a7042a4
--- /dev/null
+++ b/t/t9142-git-svn-gc.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Robert Allan Zeh
+
+test_description='git svn gc basic tests'
+
+. ./lib-git-svn.sh
+
+mkdir import
+mkdir tmp
+cd import
+	cat >> test.txt <<\EOF
+Sample text for Subversion repository.
+EOF
+	svn_cmd import -m 'import for git svn' . "$svnrepo" > /dev/null
+cd ..
+test_expect_success 'checkout working copy from svn' 'svn co
"$svnrepo" test_wc'
+test_expect_success 'set some properties to create an unhandled.log file' \
+	'cd test_wc &&
+		 svn_cmd propset foo bar test.txt &&
+		 svn_cmd commit -m "property set"
+	 cd ..'
+
+test_expect_success \
+	'Setup repo' '
+	 git svn init "$svnrepo"'
+
+test_expect_success \
+    'Fetch repo' '
+	 git svn fetch'
+
+test_expect_success \
+	'make backup copy of unhandled.log' '
+	 cp .git/svn/git-svn/unhandled.log tmp'
+
+test_expect_success \
+	'git svn gc runs' '
+	 git svn gc'
+
+test_expect_success \
+	'git svn gc produces a valid gzip file' '
+	 gunzip .git/svn/git-svn/unhandled.log.gz'
+
+test_expect_success \
+	'git svn gc does not change unhandled.log files' '
+	 test_cmp .git/svn/git-svn/unhandled.log tmp/unhandled.log'
+
+test_done
-- 
1.6.4.rc1.10.g2a67.dirty
