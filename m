From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach "git remote add" a mirror mode
Date: Sun, 2 Sep 2007 12:45:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021245040.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 13:46:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRnu8-00018m-7A
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 13:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbXIBLqH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 07:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbXIBLqG
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 07:46:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:41628 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965089AbXIBLqF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 07:46:05 -0400
Received: (qmail invoked by alias); 02 Sep 2007 11:46:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 02 Sep 2007 13:46:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/6cKRr1lz6JCPba4tuHgDjljtMQAel+NjSQGv3GT
	vMpUDcDDZ5MsdE
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57318>


When using the "--mirror" option to "git remote add", the refs will not
be stored in the refs/remotes/ namespace, but in refs/heads/.

This option probably only makes sense in a bare repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-remote.txt |    6 +++++-
 git-remote.perl              |   10 +++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 61a6022..94b9f17 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-remote'
-'git-remote' add [-t <branch>] [-m <branch>] [-f] <name> <url>
+'git-remote' add [-t <branch>] [-m <branch>] [-f] [--mirror] <name> <url>
 'git-remote' show <name>
 'git-remote' prune <name>
 'git-remote' update [group]
@@ -45,6 +45,10 @@ multiple branches without grabbing all branches.
 With `-m <master>` option, `$GIT_DIR/remotes/<name>/HEAD` is set
 up to point at remote's `<master>` branch instead of whatever
 branch the `HEAD` at the remote repository actually points at.
++
+In mirror mode, enabled with `--mirror`, the refs will not be stored
+in the 'refs/remotes/' namespace, but in 'refs/heads/'.  This option
+only makes sense in bare repositories.
 
 'show'::
 
diff --git a/git-remote.perl b/git-remote.perl
index 01cf480..e00b340 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -276,9 +276,13 @@ sub add_remote {
 	$git->command('config', "remote.$name.url", $url);
 	my $track = $opts->{'track'} || ["*"];
 
+	my $prefix = "refs/remotes/$name/";
+	if ($opts->{'mirror'}) {
+		$prefix = "refs/heads/";
+	}
 	for (@$track) {
 		$git->command('config', '--add', "remote.$name.fetch",
-			      "+refs/heads/$_:refs/remotes/$name/$_");
+			      "+refs/heads/$_:$prefix/$_");
 	}
 	if ($opts->{'fetch'}) {
 		$git->command('fetch', $name);
@@ -409,6 +413,10 @@ elsif ($ARGV[0] eq 'add') {
 			shift @ARGV;
 			next;
 		}
+		if ($opt eq '--mirror') {
+			$opts{'mirror'} = 1;
+			next;
+		}
 		add_usage();
 	}
 	if (@ARGV != 3) {
-- 
1.5.3.2.g46909
