From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach "git remote" a mirror mode
Date: Sun, 2 Sep 2007 21:10:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709022101290.28586@racer.site>
References: <Pine.LNX.4.64.0709021245040.28586@racer.site>
 <7vk5r8q1yz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 22:10:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRvmM-0005RG-O5
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 22:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbXIBUKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 16:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759104AbXIBUK2
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 16:10:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:56104 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759853AbXIBUKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 16:10:25 -0400
Received: (qmail invoked by alias); 02 Sep 2007 20:10:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 02 Sep 2007 22:10:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9z/9OT9z9s85zfk/vtRoUtu7APb4izjUB6ESsL9
	wSS1jz1swxsFmI
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5r8q1yz.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57384>


When using the "--mirror" option to "git remote add", the refs will not
be stored in the refs/remotes/ namespace, but in the same location as
on the remote side.

This option probably only makes sense in a bare repository.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 2 Sep 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > When using the "--mirror" option to "git remote add", the refs 
	> > will not be stored in the refs/remotes/ namespace, but in 
	> > refs/heads/.
	> 
	> I suspect people'd prefer "+refs/*:refs/*" for a repo truly
	> mirroring another.

	Yes, you're right.

 Documentation/git-remote.txt |    6 +++++-
 git-remote.perl              |    8 +++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

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
index 01cf480..f6f283e 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -278,7 +278,9 @@ sub add_remote {
 
 	for (@$track) {
 		$git->command('config', '--add', "remote.$name.fetch",
-			      "+refs/heads/$_:refs/remotes/$name/$_");
+				$opts->{'mirror'} ?
+				"+refs/$_:refs/$_" :
+				"+refs/heads/$_:refs/remotes/$name/$_");
 	}
 	if ($opts->{'fetch'}) {
 		$git->command('fetch', $name);
@@ -409,6 +411,10 @@ elsif ($ARGV[0] eq 'add') {
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
