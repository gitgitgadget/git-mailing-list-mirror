From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH] git-svn: add --authors-prog option
Date: Sun,  3 May 2009 21:06:29 -0400
Message-ID: <1241399189-8731-1-git-send-email-lodatom@gmail.com>
Cc: Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 03:06:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0mdn-00034c-Py
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 03:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbZEDBGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 21:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbZEDBGg
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 21:06:36 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:43442 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZEDBGf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 21:06:35 -0400
Received: by qyk34 with SMTP id 34so5196388qyk.33
        for <git@vger.kernel.org>; Sun, 03 May 2009 18:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=DnEcOXxypeSjJ/FovCTxx7JKSiLQ4fJnLpvT42tkMlU=;
        b=EmhZYUf7Z6EWNDETC86BR3E/3eIee0agOR55d9kGp9nlQtGu9gTgatBNUNMoOJv/Gn
         9VMJclzPRjS4SIMcFLE+2M9DdY2HbuxBXueHQqQ7UA2w5MrT9nZ1RcVihy+f98rB2RbN
         cst1AGMC7Wno6DnhR03iX3R7sLFmcP5KmFBEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QRYNGlJ+44UAJgmHLTqSOyYeore1XEKXy9uAKL+E20yDuO5sc128k2aPtAym9eIEDS
         tkZYBvBHqeycFWtiJohxcJDCEAGe/3V3NmDcmIDLB6j5CXWfOhHt2p1GI2eNeAWmJ8V4
         nyr+ROBIuqTxLwF8GleuLGKLnO+8TatavZboY=
Received: by 10.224.20.77 with SMTP id e13mr5196259qab.186.1241399194502;
        Sun, 03 May 2009 18:06:34 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 6sm8972131qwd.32.2009.05.03.18.06.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 18:06:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118199>

Added a new option, --authors-prog, to git-svn that allows a more
flexible alternative (or supplement) to --authors-file.  If this option
is specified, for each SVN committer name that does not exist in the
authors file, the given file is executed with the commiter name as the
first argument.  The program is expected to return a single line of the
form "Name <email>", which will be logically inserted into the authors
file.

The purpose of this option is to allow more advanced username operations
than the authors file will allow, such as looking up users via LDAP as
they are encountered, or automatically computing the name and email from
the username.
---
 Documentation/git-svn.txt       |    8 ++++
 git-svn.perl                    |   30 +++++++++++++++--
 t/t9138-git-svn-authors-prog.sh |   69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100755 t/t9138-git-svn-authors-prog.sh

Notes:

* I did not implement this option for the 'log' command, which should probably
  be done.

* The test could probably be a bit more extensive.

* The argument is assumed to be a path to a program; it does not allow
  any generic command line.


So, does this seem like something that could be included in the future?
Such an option would be really handy for me, since I have many SVN users who
are all in a database.


diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1c40894..78582ad 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -398,6 +398,14 @@ after the authors-file is modified should continue operation.
 
 config key: svn.authorsfile
 
+--authors-prog=<filename>::
+
+If this option is specified, for each SVN committer name that does not
+exist in the authors file, the given file is executed with the commiter
+name as the first argument.  The program is expected to return a single
+line of the form "Name <email>", which will be logically inserted into the
+authors file.
+
 -q::
 --quiet::
 	Make 'git-svn' less verbose. Specify a second time to make it
diff --git a/git-svn.perl b/git-svn.perl
index c5965c9..472f575 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -5,7 +5,7 @@ use warnings;
 use strict;
 use vars qw/	$AUTHOR $VERSION
 		$sha1 $sha1_short $_revision $_repository
-		$_q $_authors %users/;
+		$_q $_authors $_authors_prog %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
 
@@ -39,6 +39,7 @@ use Digest::MD5;
 use IO::File qw//;
 use File::Basename qw/dirname basename/;
 use File::Path qw/mkpath/;
+use File::Spec;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
@@ -76,6 +77,7 @@ my %remote_opts = ( 'username=s' => \$Git::SVN::Prompt::_username,
                     'ignore-paths=s' => \$SVN::Git::Fetcher::_ignore_regex );
 my %fc_opts = ( 'follow-parent|follow!' => \$Git::SVN::_follow_parent,
 		'authors-file|A=s' => \$_authors,
+		'authors-prog=s' => \$_authors_prog,
 		'repack:i' => \$Git::SVN::_repack,
 		'noMetadata' => \$Git::SVN::_no_metadata,
 		'useSvmProps' => \$Git::SVN::_use_svm_props,
@@ -263,6 +265,7 @@ usage(0) if $_help;
 version() if $_version;
 usage(1) unless defined $cmd;
 load_authors() if $_authors;
+$_authors_prog = "'" . File::Spec->rel2abs($_authors_prog) . "'";
 
 unless ($cmd =~ /^(?:clone|init|multi-init|commit-diff)$/) {
 	Git::SVN::Migration::migration_check();
@@ -2663,12 +2666,33 @@ sub other_gs {
 	$gs
 }
 
+sub call_authors_prog {
+	my ($orig_author) = @_;
+	my $author = `$::_authors_prog $orig_author`;
+	if ($? != 0) {
+		die "$::_authors_prog failed with exit code $?\n"
+	}
+	if ($author =~ /^\s*(.+?)\s*<(.*)>\s*$/) {
+		my ($name, $email) = ($1, $2);
+		$email = undef if length $2 == 0;
+		return [$name, $email];
+	} else {
+		die "Author: $orig_author: $::_authors_prog returned "
+			. "invalid author format: $author\n";
+	}
+}
+
 sub check_author {
 	my ($author) = @_;
 	if (!defined $author || length $author == 0) {
 		$author = '(no author)';
-	} elsif (defined $::_authors && ! defined $::users{$author}) {
-		die "Author: $author not defined in $::_authors file\n";
+	}
+	if (!defined $::users{$author}) {
+		if (defined $::_authors_prog) {
+			$::users{$author} = call_authors_prog($author);
+		} elsif (defined $::_authors) {
+			die "Author: $author not defined in $::_authors file\n";
+		}
 	}
 	$author;
 }
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
new file mode 100755
index 0000000..a4b00f2
--- /dev/null
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong, Mark Lodato
+#
+
+test_description='git svn authors prog tests'
+
+. ./lib-git-svn.sh
+
+cat > svn-authors-prog <<'EOF'
+#!/usr/bin/perl
+$_ = shift;
+if (s/-sub$//)  {
+	print "$_ <$_\@sub.example.com>\n";
+}
+else {
+	print "$_ <$_\@example.com>\n";
+}
+EOF
+chmod +x svn-authors-prog
+
+cat > svn-authors <<'EOF'
+ff = FFFFFFF FFFFFFF <fFf@other.example.com>
+EOF
+
+test_expect_success 'setup svnrepo' '
+	for i in aa bb cc-sub dd-sub ee-foo ff
+	do
+		svn mkdir -m $i --username $i "$svnrepo"/$i
+	done
+	'
+
+test_expect_success 'import authors with prog and file' '
+	git svn clone --authors-prog=./svn-authors-prog \
+	    --authors-file=svn-authors "$svnrepo" x
+	'
+
+test_expect_success 'imported 6 revisions successfully' '
+	(
+		cd x
+		test "`git rev-list refs/remotes/git-svn | wc -l`" -eq 6
+	)
+	'
+
+test_expect_success 'authors-prog ran correctly' '
+	(
+		cd x
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
+		  grep "^author ee-foo <ee-foo@example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 | \
+		  grep "^author dd <dd@sub\.example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~3 | \
+		  grep "^author cc <cc@sub\.example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~4 | \
+		  grep "^author bb <bb@example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 | \
+		  grep "^author aa <aa@example\.com> "
+	)
+	'
+
+test_expect_success 'authors-file overrode authors-prog' '
+	(
+		cd x
+		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
+		  grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> "
+	)
+	'
+
+test_done
-- 
1.6.2.4
