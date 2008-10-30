From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Encoding problems using git-svn
Date: Thu, 30 Oct 2008 00:41:49 -0700
Message-ID: <20081030074114.GA26926@yp-box.dyndns.org>
References: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: James North <tocapicha@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 08:43:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvSBO-00068n-Vn
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 08:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbYJ3Hlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 03:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754104AbYJ3Hlv
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 03:41:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:54849 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970AbYJ3Hlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 03:41:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 71FDD2DC01A;
	Thu, 30 Oct 2008 07:41:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99448>

Hi James,

I saw your other patch too late, I had already started working on my
patch earlier today but got distracted by other things (being at
GitTogether :) and lacked a stable Internet connection afterwards.

Anyways, here's my version, it handles the case where the user specifies
the --edit option to interactively edit the commit message before
committing; and also reencodes the messages when fetching from SVN.

Can you let me know if it works for you?

Note: I'll be in transit tomorrow and may not have time to follow
up on this until Saturday.

>From 84f003e0c39414ebf27a98de167643e95bed6abb Mon Sep 17 00:00:00 2001
From: Eric Wong <normalperson@yhbt.net>
Date: Wed, 29 Oct 2008 23:49:26 -0700
Subject: [PATCH] git-svn: respect i18n.commitencoding config

SVN itself always stores log messages in the repository as
UTF-8.  git always stores/retrieves everything as raw binary
data with no transformations whatsoever.

To interact with SVN, we need to encode log messages as UTF-8
before sending them to SVN, as SVN cannot do it for us.  When
retrieving log messages from SVN, we also need to (attempt to)
reencode the UTF-8 log message back to the user-specified commit
encoding.

Note, handling i18n.logoutputencoding for "git svn log" also
needs to be done in a future change.

Also, this change only deals with the encoding of commit
messages and nothing else (path names, blob content, ...).

In-Reply-To: <8b168cfb0810282014r789ac01dnec51824de1078f0@mail.gmail.com>
James North <tocapicha@gmail.com> wrote:
> Hi,
>
> I'm using git-svn on a system with ISO-8859-1 encoding. The problem is
> when I try to use "git svn dcommit" to send changes to a remote svn
> (also ISO-8859-1).
>
> Seems like git-svn is sending commit messages with utf-8 (just a
> guessing...) and they look bad on the remote svn log. E.g. "Ca?\241a
> de cami?\243n"
>
> I have tried using i18n.commitencoding=ISO-8859-1 as suggested by the
> warning when doing "git svn dcommit" but messages still are sent with
> wrong encoding.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl                           |   24 ++++++++-
 t/t9129-git-svn-i18n-commitencoding.sh |   80 ++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 3 deletions(-)
 create mode 100755 t/t9129-git-svn-i18n-commitencoding.sh

diff --git a/git-svn.perl b/git-svn.perl
index f90ddac..f24559c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1136,9 +1136,19 @@ sub get_commit_entry {
 		system($editor, $commit_editmsg);
 	}
 	rename $commit_editmsg, $commit_msg or croak $!;
-	open $log_fh, '<', $commit_msg or croak $!;
-	{ local $/; chomp($log_entry{log} = <$log_fh>); }
-	close $log_fh or croak $!;
+	{
+		# SVN requires messages to be UTF-8 when entering the repo
+		local $/;
+		open $log_fh, '<', $commit_msg or croak $!;
+		binmode $log_fh;
+		chomp($log_entry{log} = <$log_fh>);
+
+		if (my $enc = Git::config('i18n.commitencoding')) {
+			require Encode;
+			Encode::from_to($log_entry{log}, $enc, 'UTF-8');
+		}
+		close $log_fh or croak $!;
+	}
 	unlink $commit_msg;
 	\%log_entry;
 }
@@ -2273,6 +2283,14 @@ sub do_git_commit {
 	}
 	defined(my $pid = open3(my $msg_fh, my $out_fh, '>&STDERR', @exec))
 	                                                           or croak $!;
+	binmode $msg_fh;
+
+	# we always get UTF-8 from SVN, but we may want our commits in
+	# a different encoding.
+	if (my $enc = Git::config('i18n.commitencoding')) {
+		require Encode;
+		Encode::from_to($log_entry->{log}, 'UTF-8', $enc);
+	}
 	print $msg_fh $log_entry->{log} or croak $!;
 	restore_commit_header_env($old_env);
 	unless ($self->no_metadata) {
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
new file mode 100755
index 0000000..2848e46
--- /dev/null
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -0,0 +1,80 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Eric Wong
+
+test_description='git svn honors i18n.commitEncoding in config'
+
+. ./lib-git-svn.sh
+
+compare_git_head_with () {
+	nr=`wc -l < "$1"`
+	a=7
+	b=$(($a + $nr - 1))
+	git cat-file commit HEAD | sed -ne "$a,${b}p" >current &&
+	test_cmp current "$1"
+}
+
+compare_svn_head_with () {
+	LC_ALL=en_US.UTF-8 svn log --limit 1 `git svn info --url` | \
+		sed -e 1,3d -e "/^-\+\$/d" >current &&
+	test_cmp current "$1"
+}
+
+for H in ISO-8859-1 EUCJP ISO-2022-JP
+do
+	test_expect_success "$H setup" '
+		mkdir $H &&
+		svn import -m "$H test" $H "$svnrepo"/$H &&
+		git svn clone "$svnrepo"/$H $H
+	'
+done
+
+for H in ISO-8859-1 EUCJP ISO-2022-JP
+do
+	test_expect_success "$H commit on git side" '
+	(
+		cd $H &&
+		git config i18n.commitencoding $H &&
+		git checkout -b t refs/remotes/git-svn &&
+		echo $H >F &&
+		git add F &&
+		git commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt &&
+		E=$(git cat-file commit HEAD | sed -ne "s/^encoding //p") &&
+		test "z$E" = "z$H"
+		compare_git_head_with "$TEST_DIRECTORY"/t3900/$H.txt
+	)
+	'
+done
+
+for H in ISO-8859-1 EUCJP ISO-2022-JP
+do
+	test_expect_success "$H dcommit to svn" '
+	(
+		cd $H &&
+		git svn dcommit &&
+		git cat-file commit HEAD | grep git-svn-id: &&
+		E=$(git cat-file commit HEAD | sed -ne "s/^encoding //p") &&
+		test "z$E" = "z$H" &&
+		compare_git_head_with "$TEST_DIRECTORY"/t3900/$H.txt
+	)
+	'
+done
+
+test_expect_success 'ISO-8859-1 should match UTF-8 in svn' '
+(
+	cd ISO-8859-1 &&
+	compare_svn_head_with "$TEST_DIRECTORY"/t3900/1-UTF-8.txt
+)
+'
+
+for H in EUCJP ISO-2022-JP
+do
+	test_expect_success '$H should match UTF-8 in svn' '
+	(
+		cd $H &&
+		compare_svn_head_with "$TEST_DIRECTORY"/t3900/2-UTF-8.txt
+	)
+	'
+done
+
+test_done
-- 
Eric Wong
