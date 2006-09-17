From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: fix warnings in PATH_INFO code and add export_ok/strict_export
Date: Sun, 17 Sep 2006 15:29:48 +0200
Message-ID: <20060917132948.GA976@moooo.ath.cx>
References: <20060916192750.GA27008@moooo.ath.cx> <20060916223027.GA32679@moooo.ath.cx> <20060916223101.GB32679@moooo.ath.cx> <7v64fm7u2q.fsf@assigned-by-dhcp.cox.net> <20060917090710.GA18153@moooo.ath.cx> <7vodte4w9w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 15:30:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOwij-0000DR-MW
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 15:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWIQN3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 09:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWIQN3w
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 09:29:52 -0400
Received: from moooo.ath.cx ([85.116.203.178]:54943 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964970AbWIQN3w (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 09:29:52 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vodte4w9w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27192>

---
Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> The PATHINFO stuff Martin Waitz did mucks with $project somewhat
> later than this part of the patch, possibly bypassing your
> checks.  Could you check what's in 'master' to see if it is
> reasonable and if not fix it up please?
This patch replaces the other two warning fixes by Jakub and me.  I've
put the whole thing in a sub-routine to keep the indentation level
low.
---
 gitweb/gitweb.perl |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 497129a..0fb8638 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -189,9 +189,6 @@ do $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 # version of the core git binary
 our $git_version = qx($GIT --version) =~ m/git version (.*)$/ ? $1 : "unknown";
 
-# path to the current git repository
-our $git_dir;
-
 $projects_list ||= $projectroot;
 
 # ======================================================================
@@ -273,30 +270,41 @@ if (defined $searchtext) {
 }
 
 # now read PATH_INFO and use it as alternative to parameters
-our $path_info = $ENV{"PATH_INFO"};
-$path_info =~ s|^/||;
-$path_info =~ s|/$||;
-if (validate_input($path_info) && !defined $project) {
+sub evaluate_path_info {
+	return if defined $project;
+	my $path_info = $ENV{"PATH_INFO"};
+	return if !$path_info;
+	$path_info =~ s,(^/|/$),,gs;
+	$path_info = validate_input($path_info);
+	return if !$path_info;
 	$project = $path_info;
 	while ($project && !-e "$projectroot/$project/HEAD") {
 		$project =~ s,/*[^/]*$,,;
 	}
-	if (defined $project) {
-		$project = undef unless $project;
+	if (!$project ||
+	    ($export_ok && !-e "$projectroot/$project/$export_ok") ||
+	    ($strict_export && !project_in_list($project))) {
+		undef $project;
+		return;
 	}
+	# do not change any parameters if an action is given using the query string
+	return if $action;
 	if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
 		# we got "project.git/branch/filename"
 		$action    ||= "blob_plain";
-		$hash_base ||= $1;
-		$file_name ||= $2;
+		$hash_base ||= validate_input($1);
+		$file_name ||= validate_input($2);
 	} elsif ($path_info =~ m,^$project/([^/]+)$,) {
 		# we got "project.git/branch"
 		$action ||= "shortlog";
-		$hash   ||= $1;
+		$hash   ||= validate_input($1);
 	}
 }
+evaluate_path_info();
 
-$git_dir = "$projectroot/$project";
+# path to the current git repository
+our $git_dir;
+$git_dir = "$projectroot/$project" if $project;
 
 # dispatch
 my %actions = (
-- 
1.4.2.1.ge767
