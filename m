From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: refuse to dcommit non-UTF-8 messages
Date: Thu, 28 May 2009 01:18:04 -0700
Message-ID: <20090528081804.GB9239@dcvr.yhbt.net>
References: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de> <20090528080706.GA9239@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, users@subversion.tigris.org,
	Matthias Andree <matthias.andree@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 10:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9aoZ-00057W-4M
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 10:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbZE1ISG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 04:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbZE1ISG
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 04:18:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37347 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497AbZE1ISE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 04:18:04 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id CFCFF1F586;
	Thu, 28 May 2009 08:18:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090528080706.GA9239@dcvr.yhbt.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120170>

...without i18n.commitencoding set in the config.

SVN tries to store all commit messages in UTF-8, however it is
up to the job of the clients to enforce this rule.  SVN servers
themselves do not always enforce this; allowing clients to
commit malformed UTF-8 messages and break repositories.

So git-svn will enforce this and tell the user to set
i18n.commitencoding when a git commit is is not in UTF-8.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

 Also pushed to git://git.bogomips.org/git-svn.git

 git-svn.perl                               |   17 ++++++++--
 t/t9139-git-svn-non-utf8-commitencoding.sh |   47 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100755 t/t9139-git-svn-non-utf8-commitencoding.sh

diff --git a/git-svn.perl b/git-svn.perl
index a70c7d7..3301797 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1178,16 +1178,27 @@ sub get_commit_entry {
 	}
 	rename $commit_editmsg, $commit_msg or croak $!;
 	{
+		require Encode;
 		# SVN requires messages to be UTF-8 when entering the repo
 		local $/;
 		open $log_fh, '<', $commit_msg or croak $!;
 		binmode $log_fh;
 		chomp($log_entry{log} = <$log_fh>);
 
-		if (my $enc = Git::config('i18n.commitencoding')) {
-			require Encode;
-			Encode::from_to($log_entry{log}, $enc, 'UTF-8');
+		my $enc = Git::config('i18n.commitencoding') || 'UTF-8';
+		my $msg = $log_entry{log};
+
+		eval { $msg = Encode::decode($enc, $msg, 1) };
+		if ($@) {
+			die "Could not decode as $enc:\n", $msg,
+			    "\nPerhaps you need to set i18n.commitencoding\n";
 		}
+
+		eval { $msg = Encode::encode('UTF-8', $msg, 1) };
+		die "Could not encode as UTF-8:\n$msg\n" if $@;
+
+		$log_entry{log} = $msg;
+
 		close $log_fh or croak $!;
 	}
 	unlink $commit_msg;
diff --git a/t/t9139-git-svn-non-utf8-commitencoding.sh b/t/t9139-git-svn-non-utf8-commitencoding.sh
new file mode 100755
index 0000000..2b1db97
--- /dev/null
+++ b/t/t9139-git-svn-non-utf8-commitencoding.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Eric Wong
+
+test_description='git svn refuses to dcommit non-UTF8 messages'
+
+. ./lib-git-svn.sh
+
+# ISO-2022-JP can pass for valid UTF-8, so skipping that in this test
+
+for H in ISO-8859-1 EUCJP
+do
+	test_expect_success "$H setup" '
+		mkdir $H &&
+		svn_cmd import -m "$H test" $H "$svnrepo"/$H &&
+		git svn clone "$svnrepo"/$H $H
+	'
+done
+
+for H in ISO-8859-1 EUCJP
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
+	)
+	'
+done
+
+for H in ISO-8859-1 EUCJP
+do
+	test_expect_success "$H dcommit to svn" '
+	(
+		cd $H &&
+		git config --unset i18n.commitencoding &&
+		! git svn dcommit
+	)
+	'
+done
+
+test_done
-- 
Eric Wong
