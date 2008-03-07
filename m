From: Teemu Likonen <tlikonen@iki.fi>
Subject: [PATCH/RFC] Make "git remote rm <remote>" remove file refs/remotes/<remote>/HEAD
Date: Fri,  7 Mar 2008 23:02:12 +0200
Message-ID: <1204923732-29141-1-git-send-email-tlikonen@iki.fi>
References: <200803051338.44938.tlikonen@iki.fi>
Cc: Teemu Likonen <tlikonen@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 22:03:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXjiS-0003C1-76
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 22:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759685AbYCGVCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759515AbYCGVCP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 16:02:15 -0500
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:55950 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759505AbYCGVCO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2008 16:02:14 -0500
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB96002D9F4A; Fri, 7 Mar 2008 22:02:13 +0100
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JXjhk-0007aL-II; Fri, 07 Mar 2008 23:02:12 +0200
X-Mailer: git-send-email 1.5.4.3.451.ga9908.dirty
In-Reply-To: <200803051338.44938.tlikonen@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76521>

The command "git remote rm <remote>" used to leave the
refs/remotes/<remote>/HEAD file lying in the directory. This usually
happens when user has cloned a remote repository and later decided to
remove the default "origin" with "git remote rm origin". The result is
that several git commans display the error message

  error: refs/remotes/origin/HEAD points nowhere!

This patch makes "git remote rm" remove the HEAD file if it exists.

Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
---

I have never written or even read any perl code before this (I'm not really
a programmer) but I managed to come up with this. This seems to work well. If
more error checking or something is needed, I guess somebody else has to do it;
my skills aren't quite enough. :)

Any comments?

 git-remote.perl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index b30ed73..f1f2a1a 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -323,6 +323,7 @@ sub update_remote {
 
 sub rm_remote {
 	my ($name) = @_;
+	my $git_dir = $ENV{GIT_DIR} || ".git";
 	if (!exists $remote->{$name}) {
 		print STDERR "No such remote $name\n";
 		return 1;
@@ -340,6 +341,11 @@ sub rm_remote {
 		}
 	};
 
+	my $remotes_dir = "$git_dir/refs/remotes/$name";
+	if (-f "$remotes_dir/HEAD") {
+		unlink "$remotes_dir/HEAD";
+	}
+
 	my @refs = $git->command('for-each-ref',
 		'--format=%(refname) %(objectname)', "refs/remotes/$name");
 	for (@refs) {
-- 
1.5.4.3.451.ga9908.dirty

