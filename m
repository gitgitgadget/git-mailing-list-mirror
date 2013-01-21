From: Barry Wardell <barry.wardell@gmail.com>
Subject: [PATCH 2/2] git-svn: Simplify calculation of GIT_DIR
Date: Mon, 21 Jan 2013 01:22:02 +0000
Message-ID: <1358731322-44600-3-git-send-email-barry.wardell@gmail.com>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
Cc: Barry Wardell <barry.wardell@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 02:23:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx66R-0004QB-MM
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 02:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab3AUBWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 20:22:53 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:44904 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752581Ab3AUBWv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 20:22:51 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so92666wgi.15
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 17:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=4JRk1YmJjo7srVNuASD+TNT/SnAxHUfDkKh6/q+aHDM=;
        b=flRMw3uP1qJRd+ogruc445wBvCMra9K/Q2U/DPqqhq4S6KVlFTeyJiEe/e9D0fkdWT
         tUHdAF8enM8+izFD928Gh3/hTQ0+lLTaLvAHulgimzOQevZRkHHBpfOslK8AXFK6riwm
         ozN5ddwX56wJjvnV7uK3wLk96qN+SBIiBgIWuoLsWwk8mbOsExScP4t4msiTOdbXWE9t
         yKTXzA7od8WbWiys1te5rDGSup0NV4i0F3PAekGkylcK/BKngghrweljoJ43RdJwaaEu
         /tyCXiFChj2k3gq/GZOIm866zhUdFx4qH8sXbwpIkQ3bVFsnIEYwfTot3jaAmqeFeMxa
         J3Vg==
X-Received: by 10.180.88.40 with SMTP id bd8mr12543969wib.33.1358731370409;
        Sun, 20 Jan 2013 17:22:50 -0800 (PST)
Received: from localhost.localdomain (87-198-121-119.ptr.magnet.ie. [87.198.121.119])
        by mx.google.com with ESMTPS id hu8sm14717231wib.6.2013.01.20.17.22.47
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Jan 2013 17:22:48 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214065>

Since git-rev-parse already checks for the $GIT_DIR environment
variable and that it returns an actual git repository, there is no
need to repeat the checks again here.

This also fixes a problem where git-svn did not work in cases where
.git was a file with a gitdir: link.

Signed-off-by: Barry Wardell <barry.wardell@gmail.com>
---
 git-svn.perl | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index bd5266c..3bcd769 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -61,8 +61,6 @@ my $cmd_dir_prefix = eval {
 	command_oneline([qw/rev-parse --show-prefix/], STDERR => 0)
 } || '';
 
-my $git_dir_user_set = 1 if defined $ENV{GIT_DIR};
-$ENV{GIT_DIR} ||= '.git';
 $Git::SVN::Ra::_log_window_size = 100;
 
 if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
@@ -325,27 +323,19 @@ for (my $i = 0; $i < @ARGV; $i++) {
 };
 
 # make sure we're always running at the top-level working directory
-unless ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
-	unless (-d $ENV{GIT_DIR}) {
-		if ($git_dir_user_set) {
-			die "GIT_DIR=$ENV{GIT_DIR} explicitly set, ",
-			    "but it is not a directory\n";
-		}
-		my $git_dir = delete $ENV{GIT_DIR};
-		my $cdup = undef;
-		git_cmd_try {
-			$cdup = command_oneline(qw/rev-parse --show-cdup/);
-			$git_dir = '.' unless ($cdup);
-			chomp $cdup if ($cdup);
-			$cdup = "." unless ($cdup && length $cdup);
-		} "Already at toplevel, but $git_dir not found\n";
-		chdir $cdup or die "Unable to chdir up to '$cdup'\n";
-		unless (-d $git_dir) {
-			die "$git_dir still not found after going to ",
-			    "'$cdup'\n";
-		}
-		$ENV{GIT_DIR} = $git_dir;
-	}
+if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
+	$ENV{GIT_DIR} ||= ".git";
+} else {
+	git_cmd_try {
+		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
+	} "Unable to find .git directory\n";
+	my $cdup = undef;
+	git_cmd_try {
+		$cdup = command_oneline(qw/rev-parse --show-cdup/);
+		chomp $cdup if ($cdup);
+		$cdup = "." unless ($cdup && length $cdup);
+	} "Already at toplevel, but $ENV{GIT_DIR} not found\n";
+	chdir $cdup or die "Unable to chdir up to '$cdup'\n";
 	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
 }
 
-- 
1.8.0
