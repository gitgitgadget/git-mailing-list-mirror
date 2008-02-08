From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] gitweb: Use the config file to set repository owner's name.
Date: Fri,  8 Feb 2008 14:38:03 -0200
Message-ID: <1202488684-13266-2-git-send-email-ribas@c3sl.ufpr.br>
References: <1202488684-13266-1-git-send-email-ribas@c3sl.ufpr.br>
Cc: gitster@pobox.com, Bruno Ribas <ribas@c3sl.ufpr.br>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 17:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNWGN-0002NA-Aj
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 17:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933864AbYBHQim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 11:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933857AbYBHQik
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 11:38:40 -0500
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:45726 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933832AbYBHQii (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 11:38:38 -0500
Received: from localhost (unknown [189.1.130.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 5A02770000438;
	Fri,  8 Feb 2008 14:38:37 -0200 (BRST)
X-Mailer: git-send-email 1.5.4.24.gce08d
In-Reply-To: <1202488684-13266-1-git-send-email-ribas@c3sl.ufpr.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73109>

Now gitweb checks if gitweb.owner exists before trying to get filesystem's
owner.

Allow to use configuration variable gitweb.owner set the repository owner,
it checks the gitweb.owner, if not set it uses filesystem directory's owner.

Useful when we don't want to maintain project list file, and all
repository directories have to have the same owner (for example when the
same SSH account is shared for all projects, using ssh_acl to control
access instead).

Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 gitweb/gitweb.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8ef2735..c8fe22a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1759,6 +1759,7 @@ sub git_get_project_owner {
 	my $owner;
 
 	return undef unless $project;
+	$git_dir = "$projectroot/$project";
 
 	if (!defined $gitweb_project_owner) {
 		git_get_project_list_from_file();
@@ -1767,8 +1768,11 @@ sub git_get_project_owner {
 	if (exists $gitweb_project_owner->{$project}) {
 		$owner = $gitweb_project_owner->{$project};
 	}
+	if (!defined $owner){
+		$owner = git_get_project_config('owner');
+	}
 	if (!defined $owner) {
-		$owner = get_file_owner("$projectroot/$project");
+		$owner = get_file_owner("$git_dir");
 	}
 
 	return $owner;
-- 
1.5.4.24.gce08d
