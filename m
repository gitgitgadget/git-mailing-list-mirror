From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: [PATCH] Add git svn gc command
Date: Sun, 19 Jul 2009 18:00:52 -0500
Message-ID: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 01:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSfNT-0001Pd-4K
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 01:01:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbZGSXA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 19:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbZGSXA4
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 19:00:56 -0400
Received: from mail-px0-f193.google.com ([209.85.216.193]:59402 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbZGSXAz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 19:00:55 -0400
Received: by pxi31 with SMTP id 31so110139pxi.33
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=+RBwvNie9jhgBjSHmrYe+r5ptzIS5KUZLnjnS3lpWW4=;
        b=YZhM0YrKJrPtFOyyazwUXEWynOrKHZIbgMieJG+mJTW2rnz02uxPCiVmoSblOHfaO0
         drWaiaTBBwyNrmrn9YrDKzUhfQhcG+nvBgUfCffw2rEy9k5a8gQbScKIrl6msd+DJRfd
         mmpSD9wEdv3k+e2o6nbQMbzFcKg7rYbP9E0tM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=ZMLi3d7tmezmydFQ+selxxA6N3Y4lt8knfeyLAJj/mrWBmcSjQvN6Lum2Qzv0/E8SY
         OIwlOSh6yrdj+dcibIr4CTkDX7LVb4dftx5zRVb/PU9xA+UhiVv6/BxJbviFUaXAZmDd
         0KhX+cvOwnxEFhzOzsvvoEu7Ti7OkMgEArSp8=
Received: by 10.114.93.11 with SMTP id q11mr4956839wab.170.1248044455289;
        Sun, 19 Jul 2009 16:00:55 -0700 (PDT)
Received: from ?10.0.1.199? (h-69-3-100-138.chcgilgm.dynamic.covad.net [69.3.100.138])
        by mx.google.com with ESMTPS id j15sm7657742waf.51.2009.07.19.16.00.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Jul 2009 16:00:54 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123564>

Add a git svn gc command that gzips all unhandled.log files, and  
removes all index files under .git/svn.

Signed-off-by: Robert Allan Zeh <robert.a.zeh@gmail.com>
---
  Documentation/git-svn.txt |    4 ++++
  git-svn.perl              |   37 +++++++++++++++++++++++++++++++++++++
  t/t9140-git-svn-gc.sh     |   45 ++++++++++++++++++++++++++++++++++++ 
+++++++++
  3 files changed, 86 insertions(+), 0 deletions(-)
  create mode 100755 t/t9140-git-svn-gc.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 10af599..6d0753e 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -348,6 +348,10 @@ Any other arguments are passed directly to 'git  
log'
         "checksum mismatch" (missed a modification).  If the problem
         file cannot be ignored forever (with --ignore-paths) the only
         way to repair the repo is to use 'reset'.
+
+'gc':: Compress $GIT_DIR/svn/<refname>/unhandled.log files in .git/svn
+    and remove $GIT_DIR/svn/<refname>index files in .git/svn.
+
  +
  Only the rev_map and refs/remotes/git-svn are changed.  Follow 'reset'
  with a 'fetch' and then 'git reset' or 'git rebase' to move local
diff --git a/git-svn.perl b/git-svn.perl
index cfade63..022efc0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -35,11 +35,14 @@ push @Git::SVN::Ra::ISA, 'SVN::Ra';
  push @SVN::Git::Editor::ISA, 'SVN::Delta::Editor';
  push @SVN::Git::Fetcher::ISA, 'SVN::Delta::Editor';
  use Carp qw/croak/;
+use Compress::Zlib;
  use Digest::MD5;
  use IO::File qw//;
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
@@ -1107,6 +1113,18 @@ sub cmd_reset {
         print "r$r = $c ($gs->{ref_id})\n";
  }

+sub cmd_gc
+{
+    use Cwd;
+       my $git_dir = $ENV{GIT_DIR};
+    my $svn_dir = "$git_dir/svn";
+    print getcwd;
+    print "\n";
+    find({ wanted => \&gc_directory,
+           no_chdir => 1},
+         "$git_dir/svn");
+}
+
  ########################### utility functions  
#########################

  sub rebase_cmd {
@@ -1527,6 +1545,25 @@ sub md5sum {
         return $md5->hexdigest();
  }

+sub gc_directory {
+    if (-f $_ && basename($_) eq "unhandled.log") {
+        my $out_filename = $_ . ".gz";
+        print $out_filename, "\n";
+        open my $in_fh, "<", $_ or die "Unable to open $_: $!\n";
+        binmode $in_fh;
+        my $gz = gzopen($out_filename, "wb") or die "Unable to open  
$out_filename: $!\n";
+
+        my $res;
+        while ($res = sysread($in_fh, my $str, 1024)) {
+            $gz->gzwrite($str) or die "Unable to write: $gzerrno\n";
+        }
+        unlink $_ or die "unlink $File::Find::name: $!\n";
+    } elsif (-f $_ && basename($_) eq "index") {
+        unlink $_ or die "unlink %_: $!\n";
+    }
+}
+
+
  package Git::SVN;
  use strict;
  use warnings;
diff --git a/t/t9140-git-svn-gc.sh b/t/t9140-git-svn-gc.sh
new file mode 100755
index 0000000..545b6c7
--- /dev/null
+++ b/t/t9140-git-svn-gc.sh
@@ -0,0 +1,45 @@
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
+    cat >> test.txt <<\EOF
+Sample text for Subversion repository.
+EOF
+    svn_cmd import -m 'import for git svn' . "$svnrepo" > /dev/null
+cd ..
+test_expect_success 'checkout working copy from svn' 'svn co  
"$svnrepo" test_wc'
+test_expect_success 'set some properties to create an unhandled.log  
file' \
+    'cd test_wc &&
+         svn_cmd propset foo bar test.txt &&
+         svn_cmd commit -m "property set"
+     cd ..'
+
+test_expect_success \
+    'Setup repo and fetch' '
+     git svn init "$svnrepo" &&
+     git svn fetch'
+
+test_expect_success \
+    'make backup copy of unhandled.log' '
+     cp .git/svn/git-svn/unhandled.log tmp'
+
+test_expect_success \
+    'git svn gc runs' '
+     git svn gc'
+
+test_expect_success \
+    'git svn gc produces a valid gzip file' '
+     gunzip .git/svn/git-svn/unhandled.log.gz'
+
+test_expect_success \
+    'git svn gc does not change unhandled.log files' '
+     test_cmp .git/svn/git-svn/unhandled.log tmp/unhandled.log'
+
+test_done
--
1.6.4.rc1.dirty
