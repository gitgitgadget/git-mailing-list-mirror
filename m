From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Added git svn gc command
Date: Thu, 23 Jul 2009 00:56:05 -0700
Message-ID: <20090723075605.GA8062@dcvr.yhbt.net>
References: <57d579150907221526m6d2ec48dj1fa731e071fe7a68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Zeh <robert.a.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 09:56:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTtA1-0003gF-Dh
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 09:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZGWH4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 03:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbZGWH4H
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 03:56:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36216 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbZGWH4G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 03:56:06 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 737751F793;
	Thu, 23 Jul 2009 07:56:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <57d579150907221526m6d2ec48dj1fa731e071fe7a68@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123855>

Robert Zeh <robert.a.zeh@gmail.com> wrote:
> Eric,
> 
> Ok, here is a try sent with
>  git format-patch -M --stdout HEAD~1  | git imap-send

Hi Robert,

Did you edit it afterwards?  At least the original commit message was
lost and some long lines were wrapped.  But there were only a few bad
lines so I went ahead and massaged the patch in and applied it.

Minor changes I made:

  * wrapped the test setup in test_expect_success to check for errors

  * use "(cd )" in subshells to make ourselves less error-prone

  * formatting changes, long lines really bother me, and some lines
    in the tests were wrapped unnecessarily.

  * Removed redundant "use File::Basename", it was use'd a few lines
    above and we don't depend on any new functions with this patch.

  * The "%_" in "unlink %_: $!\n" confused me, I assume you meant "$_"?
    I don't think %_ does anything special, it's not in the perlvar
    manpage at least...

  * moved the command documentation above the section for "reset",
    the reset docs continue for several paragraphs.

  * "svn" should always be "svn_cmd" in tests

> I renamed the test tot9142-git-svn-gc.sh  keep up with the two tests
> that have been added.

It's up to t9143, now :)

I'll push the following patch out if it's alright with you.
Thanks again!

>From 845c3deea6905dec2e0b82da45e1f938d66efbbc Mon Sep 17 00:00:00 2001
From: Robert Allan Zeh <robert.a.zeh@gmail.com>
Date: Sun, 19 Jul 2009 18:00:52 -0500
Subject: [PATCH] git svn: add gc command

Add a git svn gc command that gzips all unhandled.log files, and
removes all index files under .git/svn.

Signed-off-by: Robert Allan Zeh <robert.a.zeh@gmail.com>
Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-svn.txt |    4 ++++
 git-svn.perl              |   33 +++++++++++++++++++++++++++++++++
 t/t9143-git-svn-gc.sh     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100755 t/t9143-git-svn-gc.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 10af599..068aa58 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -338,6 +338,10 @@ Any other arguments are passed directly to 'git log'
 	Shows the Subversion externals.  Use -r/--revision to specify a
 	specific revision.
 
+'gc'::
+	Compress $GIT_DIR/svn/<refname>/unhandled.log files in .git/svn
+	and remove $GIT_DIR/svn/<refname>index files in .git/svn.
+
 'reset'::
 	Undoes the effects of 'fetch' back to the specified revision.
 	This allows you to re-'fetch' an SVN revision.  Normally the
diff --git a/git-svn.perl b/git-svn.perl
index 9369acc..7015920 100755
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
@@ -40,6 +41,7 @@ use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
 use File::Spec;
+use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
@@ -217,6 +219,10 @@ my %cmd = (
 		     "Undo fetches back to the specified SVN revision",
 		     { 'revision|r=s' => \$_revision,
 		       'parent|p' => \$_fetch_parent } ],
+	'gc' => [ \&cmd_gc,
+		  "Compress unhandled.log files in .git/svn and remove " .
+		  "index files in .git/svn",
+		{} ],
 );
 
 my $cmd;
@@ -1107,6 +1113,14 @@ sub cmd_reset {
 	print "r$r = $c ($gs->{ref_id})\n";
 }
 
+sub cmd_gc {
+	if (!$can_compress) {
+		warn "Compress::Zlib could not be found; unhandled.log " .
+		     "files will not be compressed.\n";
+	}
+	find({ wanted => \&gc_directory, no_chdir => 1}, "$ENV{GIT_DIR}/svn");
+}
+
 ########################### utility functions #########################
 
 sub rebase_cmd {
@@ -1527,6 +1541,25 @@ sub md5sum {
 	return $md5->hexdigest();
 }
 
+sub gc_directory {
+	if ($can_compress && -f $_ && basename($_) eq "unhandled.log") {
+		my $out_filename = $_ . ".gz";
+		open my $in_fh, "<", $_ or die "Unable to open $_: $!\n";
+		binmode $in_fh;
+		my $gz = Compress::Zlib::gzopen($out_filename, "ab") or
+				die "Unable to open $out_filename: $!\n";
+
+		my $res;
+		while ($res = sysread($in_fh, my $str, 1024)) {
+			$gz->gzwrite($str) or
+				die "Unable to write: ".$gz->gzerror()."!\n";
+		}
+		unlink $_ or die "unlink $File::Find::name: $!\n";
+	} elsif (-f $_ && basename($_) eq "index") {
+		unlink $_ or die "unlink $_: $!\n";
+	}
+}
+
 package Git::SVN;
 use strict;
 use warnings;
diff --git a/t/t9143-git-svn-gc.sh b/t/t9143-git-svn-gc.sh
new file mode 100755
index 0000000..aaa3af0
--- /dev/null
+++ b/t/t9143-git-svn-gc.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Robert Allan Zeh
+
+test_description='git svn gc basic tests'
+
+. ./lib-git-svn.sh
+
+test_expect_success 'setup directories and test repo' '
+	mkdir import &&
+	mkdir tmp &&
+	echo "Sample text for Subversion repository." > import/test.txt &&
+	svn_cmd import -m "import for git svn" import "$svnrepo" > /dev/null
+	'
+
+test_expect_success 'checkout working copy from svn' \
+	'svn_cmd co "$svnrepo" test_wc'
+
+test_expect_success 'set some properties to create an unhandled.log file' '
+	(
+		cd test_wc &&
+		svn_cmd propset foo bar test.txt &&
+		svn_cmd commit -m "property set"
+	)'
+
+test_expect_success 'Setup repo' 'git svn init "$svnrepo"'
+
+test_expect_success 'Fetch repo' 'git svn fetch'
+
+test_expect_success 'make backup copy of unhandled.log' '
+	 cp .git/svn/git-svn/unhandled.log tmp
+	'
+
+test_expect_success 'git svn gc runs' 'git svn gc'
+
+test_expect_success 'git svn gc produces a valid gzip file' '
+	 gunzip .git/svn/git-svn/unhandled.log.gz
+	'
+
+test_expect_success 'git svn gc does not change unhandled.log files' '
+	 test_cmp .git/svn/git-svn/unhandled.log tmp/unhandled.log
+	'
+
+test_done
-- 
Eric Wong
