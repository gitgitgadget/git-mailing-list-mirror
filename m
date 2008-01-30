From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Use config file or file for repository owner's name.
Date: Wed, 30 Jan 2008 03:28:17 -0200
Message-ID: <1201670898-15076-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 06:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK5VE-0007Xh-LM
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 06:28:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbYA3F2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 00:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753779AbYA3F2U
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 00:28:20 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:37227 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508AbYA3F2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 00:28:19 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 01933700003CC;
	Wed, 30 Jan 2008 03:28:17 -0200 (BRST)
X-Mailer: git-send-email 1.5.3.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72023>

Allow to use configuration variable gitweb.owner or $GIT_DIR/owner file to
set the repository owner, it checks $GIT_DIR/owner first, then falls back to
the gitweb.owner, if none exist uses filesystem directory's owner.

Useful when we don't want to maintain project list file, and all
repository directories have to have the same owner (for example when the
same SSH account is shared for all projects, using ssh_acl to control
access instead).

Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 gitweb/gitweb.perl |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6256641..e29ad0a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1754,6 +1754,20 @@ sub git_get_project_list_from_file {
 	}
 }
 
+sub gitweb_get_project_owner {
+	my $path = shift;
+
+	$git_dir = "$projectroot/$path";
+	open my $fd, "$projectroot/$path/owner"
+		or return git_get_project_config('owner');
+	my $owner = <$fd>;
+	close $fd;
+	if (defined $owner) {
+		chomp $owner;
+	}
+	return $owner;
+}
+
 sub git_get_project_owner {
 	my $project = shift;
 	my $owner;
@@ -1767,6 +1781,10 @@ sub git_get_project_owner {
 	if (exists $gitweb_project_owner->{$project}) {
 		$owner = $gitweb_project_owner->{$project};
 	}
+
+    if (!defined $owner) {
+        $owner = gitweb_get_project_owner($project);
+    }
 	if (!defined $owner) {
 		$owner = get_file_owner("$projectroot/$project");
 	}
-- 
1.5.3.8
