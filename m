From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Thu, 17 Aug 2006 00:28:41 +0200
Message-ID: <11557673281583-git-send-email-tali@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org>
Cc: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Thu Aug 17 00:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDTsr-0000AM-CB
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 00:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWHPW2w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 18:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWHPW2v
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 18:28:51 -0400
Received: from agent.admingilde.org ([213.95.21.5]:13512 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932297AbWHPW2t
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 18:28:49 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GDTsW-0007Oh-8a; Thu, 17 Aug 2006 00:28:48 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2.rc2.gf055
In-Reply-To: <11557673262714-git-send-email-tali@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25535>

Allow to use the global action dispatcher for all actions by introducing
"/actions".  If no project directory is given then a / is prepended to the
action and the normal dispatcher is called.
Project list and OPML generation are now hooked into the list as "/summary"
and "/opml".

As "/" is not an allowed character in actions accepted through the CGI
parameters, it is still ensured that no normal action can be called without
giving a valid project directory.

Signed-off-by: Martin Waitz <tali@admingilde.org>
---
 gitweb/gitweb.perl |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3b6333c..9a7faab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -84,11 +84,6 @@ if (defined $action) {
 	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
 		die_error(undef, "Invalid action parameter");
 	}
-	# action which does not check rest of parameters
-	if ($action eq "opml") {
-		git_opml();
-		exit;
-	}
 }
 
 our $order = $cgi->param('o');
@@ -113,9 +108,6 @@ if (defined $project) {
 		die_error(undef, "No such project");
 	}
 	$ENV{'GIT_DIR'} = "$projectroot/$project";
-} else {
-	git_project_list();
-	exit;
 }
 
 our $file_name = $cgi->param('f');
@@ -185,12 +177,19 @@ my %actions = (
 	"search" => \&git_search,
 	"shortlog" => \&git_shortlog,
 	"summary" => \&git_summary,
+	"/summary" => \&git_project_list,
+	"/opml" => \&git_opml,
 	"tag" => \&git_tag,
 	"tags" => \&git_tags,
 	"tree" => \&git_tree,
 );
 
-$action = 'summary' if (!defined($action));
+# default action
+$action ||= 'summary';
+
+#only allow non-/ actions if we have a project directory
+$action = "/$action" if !defined($project);
+
 if (!defined($actions{$action})) {
 	die_error(undef, "Unknown action");
 }
-- 
1.4.2.rc2.gf055
