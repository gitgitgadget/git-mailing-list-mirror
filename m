From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Teach git-remote to list pushed branches.
Date: Wed, 14 Mar 2007 21:56:00 +0100
Message-ID: <200703142156.00678.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 21:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRaWM-0001we-7Y
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 21:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbXCNU4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 16:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbXCNU4M
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 16:56:12 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:41159 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422652AbXCNU4G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 16:56:06 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 308DA13A2CD
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 21:56:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 811323AD24
	for <git@vger.kernel.org>; Wed, 14 Mar 2007 21:56:01 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42227>

The configured refspecs are printed almost verbatim, i.e. both the local
and the remote branch name separated by a colon are printed; only the
prefix 'refs/heads/' is removed, like this:

  Local branch(es) pushed with 'git push'
    master refs/tags/*:refs/tags/* next:next

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

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
