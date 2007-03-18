From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Teach git-remote to list pushed branches.
Date: Sun, 18 Mar 2007 21:34:46 +0100
Message-ID: <200703182134.46450.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 21:35:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT25v-0007Kh-Sr
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 21:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933219AbXCRUew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 16:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933231AbXCRUew
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 16:34:52 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:41588 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933232AbXCRUeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 16:34:50 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 7593713A498;
	Sun, 18 Mar 2007 21:34:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 154A256D7E;
	Sun, 18 Mar 2007 21:34:47 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42518>

The configured refspecs are printed almost verbatim, i.e. both the local
and the remote branch name separated by a colon are printed; only the
prefix 'refs/heads/' is removed, like this:

  Local branch(es) pushed with 'git push'
    master refs/tags/*:refs/tags/* next:next

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 [Resent; I don't see the patch applied nor were there any comments.]

 The hunk that reads the 'Push'es from the .git/remotes file is taken
 almost verbatim from the corresponding 'Pull' clause and is untested.

 -- Hannes

 git-remote.perl |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index bd70bf1..52013fe 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -15,6 +15,10 @@ sub add_remote_config {
 		$hash->{$name}{'FETCH'} ||= [];
 		push @{$hash->{$name}{'FETCH'}}, $value;
 	}
+	elsif ($what eq 'push') {
+		$hash->{$name}{'PUSH'} ||= [];
+		push @{$hash->{$name}{'PUSH'}}, $value;
+	}
 	if (!exists $hash->{$name}{'SOURCE'}) {
 		$hash->{$name}{'SOURCE'} = 'config';
 	}
@@ -44,7 +48,8 @@ sub add_remote_remotes {
 			}
 		}
 		elsif (/^Push:\s*(.*)$/) {
-			; # later
+			$it->{'PUSH'} ||= [];
+			push @{$it->{'PUSH'}}, $1;
 		}
 		elsif (/^Pull:\s*(.*)$/) {
 			$it->{'FETCH'} ||= [];
@@ -250,6 +255,15 @@ sub show_remote {
 	if ($info->{'LS_REMOTE'}) {
 		show_mapping($name, $info);
 	}
+	if ($info->{'PUSH'}) {
+		my @pushed = map {
+			s|^refs/heads/||;
+			s|:refs/heads/|:|;
+			$_;
+		} @{$info->{'PUSH'}};
+		print "  Local branch(es) pushed with 'git push'\n";
+		print "    @pushed\n";
+	}
 }
 
 sub add_remote {
-- 
1.5.0.3.438.gc49b2
