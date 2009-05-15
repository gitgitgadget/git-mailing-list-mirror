From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH v3] git-svn: add --authors-prog option
Date: Thu, 14 May 2009 21:27:15 -0400
Message-ID: <1242350835-22684-1-git-send-email-lodatom@gmail.com>
References: <20090510003509.GA2000@dcvr.yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 15 03:26:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4mBZ-0008V0-Jx
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 03:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbZEOBZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 21:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbZEOBZz
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 21:25:55 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:30687 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbZEOBZy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 21:25:54 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1310414qwd.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=61XgDwCxHrgHM39L0QwigNdV6fYQ+qImXX5CzmQQde4=;
        b=nAuqcLRKy79HlQZuA4mPOnCfVj32+yMM7G5IAg22ab9Eb3yJvd4u6XvtiOWxPZZOj7
         KCanHwBYQpIl5PLKLqxB1WIw2g3rF9CwKxOYHfExq5E4L6Z8qvY4Vaz8lKXttznIkjmV
         Jp1osPDkF5oU3Ls8JLoFzDL6ceYcSpMXmvokg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bPkRNLPDyNP4XEtd5A7by4T2h5wK2VfwrtxM2jmwPG/tj/clZttMPJfWQhdgiJHRtn
         ZKafyTnCXX/7lmKO5y4FEi3Q+7/Ne7m7wn2uiqmEGGRql6rWDz0klyK7zayORRJzg9Gu
         /OVdgmYSFqeWAvXvIXOfh0v1JziKrlybYN79U=
Received: by 10.224.73.140 with SMTP id q12mr3397049qaj.188.1242350755299;
        Thu, 14 May 2009 18:25:55 -0700 (PDT)
Received: from localhost.localdomain (c-68-33-182-150.hsd1.dc.comcast.net [68.33.182.150])
        by mx.google.com with ESMTPS id 26sm1092916qwa.8.2009.05.14.18.25.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 18:25:54 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <20090510003509.GA2000@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119244>

Add a new option, --authors-prog, to git-svn that allows a more flexible
alternative (or supplement) to --authors-file.  This allows more
advanced username operations than the authors file will allow.  For
example, one may look up Subversion users via LDAP, or may generate the
name and email address from the Subversion username.

Notes:

* If both --authors-name and --authors-prog are given, the former is
  tried first, falling back to the later.

* The program is called once per unique SVN username, and the result is
  cached.

* The command-line argument must be the path to a program, not a generic
  shell command line.  The absolute path to this program is taken at
  startup since the git-svn script changes directory during operation.

* The option is not enabled for `git svn log'.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---

Third attempt at the patch.  I fixed a typo and reworded the documentation
(thanks to Michael Gruber), and I fixed a small mistake in the commit message.
Other than rebasing onto master, nothing else was changed.

 Documentation/git-svn.txt       |    8 ++++
 git-svn.perl                    |   30 +++++++++++++++--
 t/t9138-git-svn-authors-prog.sh |   69 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 3 deletions(-)
 create mode 100755 t/t9138-git-svn-authors-prog.sh

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 1c40894..ca3fc3d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -398,6 +398,14 @@ after the authors-file is modified should continue operation.
 
 config key: svn.authorsfile
 
+--authors-prog=<filename>::
+
+If this option is specified, for each SVN committer name that does not
+exist in the authors file, the given file is executed with the committer
+name as the first argument.  The program is expected to return a single
+line of the form "Name <email>", which will be treated as if included in
+the authors file.
+
 -q::
 --quiet::
 	Make 'git-svn' less verbose. Specify a second time to make it
diff --git a/git-svn.perl b/git-svn.perl
index ef1d30d..f9c9567 100755
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
1.6.3.1
