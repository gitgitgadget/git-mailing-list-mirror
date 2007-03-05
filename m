From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/3] git-remote: add -b option to enable tracking remote branches
Date: Mon, 05 Mar 2007 09:57:30 +0100
Message-ID: <esgm1q$33f$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 10:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO93V-0008NE-E6
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 10:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729AbXCEJAV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 04:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752726AbXCEJAV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 04:00:21 -0500
Received: from main.gmane.org ([80.91.229.2]:51643 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbXCEJAU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 04:00:20 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HO934-00070t-J1
	for git@vger.kernel.org; Mon, 05 Mar 2007 10:00:02 +0100
Received: from usilu-ge.ti-edu.ch ([195.176.176.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 10:00:02 +0100
Received: from bonzini by usilu-ge.ti-edu.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Mar 2007 10:00:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: usilu-ge.ti-edu.ch
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41428>

This commit adds an option to git-remote, providing a way to
switch the default behavior of git-branch from --no-track to
--track.

With `-b` option, local branches created off the remote repository
will be set up to track the remote repository, so that `git pull`
with no parameters does the right thing while you are on your local
branch.

Signed-off-by: Paolo Bonzini  <bonzini@gnu.org>
---
 Documentation/git-remote.txt |    7 ++++++-
 git-remote.perl              |    9 ++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a9fb6a9..516d890 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-remote'
-'git-remote' add [-t <branch>] [-m <branch>] [-f] <name> <url>
+'git-remote' add [-t <branch>] [-m <branch>] [-f] [-b] <name> <url>
 'git-remote' show <name>
 'git-remote' prune <name>
 'git-remote' update [group]
@@ -45,6 +45,11 @@ multiple branche without grabbing all branches.
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch instead of whatever
 branch the `HEAD` at the remote repository actually points at.
++
+With `-b` option, local branches created off the remote repository
+will be set up to track the remote repository, so that `git pull`
+with no parameters does the right thing while you are on your local
+branch.
 
 'show'::
 
diff --git a/git-remote.perl b/git-remote.perl
index bd70bf1..0a736da 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -265,6 +265,9 @@ sub add_remote {
 		$git->command('config', '--add', "remote.$name.fetch",
 			      "+refs/heads/$_:refs/remotes/$name/$_");
 	}
+	if ($opts->{'track_branch'}) {
+		$git->command('config', "remote.$name.trackintolocalbranches", "true");
+	}
 	if ($opts->{'fetch'}) {
 		$git->command('fetch', $name);
 	}
@@ -300,7 +303,7 @@ sub update_remote {
 }
 
 sub add_usage {
-	print STDERR "Usage: git remote add [-f] [-t track]* [-m master] <name> <url>\n";
+	print STDERR "Usage: git remote add [-f] [-b] [-t track]* [-m master] <name> <url>\n";
 	exit(1);
 }
 
@@ -365,6 +368,10 @@ elsif ($ARGV[0] eq 'add') {
 			$opts{'fetch'} = 1;
 			next;
 		}
+		if ($opt eq '-b' || $opt eq '--track-into-branches') {
+			$opts{'track_branch'} = 1;
+			next;
+		}
 		if ($opt eq '-t' || $opt eq '--track') {
 			if (@ARGV < 1) {
 				add_usage();
-- 
1.4.4.2
