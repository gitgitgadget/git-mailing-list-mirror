From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: fix warnings from dd70235f5a81e (PATH_INFO)
Date: Sun, 17 Sep 2006 14:14:08 +0200
Message-ID: <20060917121408.GA19860@moooo.ath.cx>
References: <20060916210832.GV17042@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 14:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOvXL-0007gS-Pc
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 14:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbWIQMON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 08:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWIQMON
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 08:14:13 -0400
Received: from moooo.ath.cx ([85.116.203.178]:37541 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S964966AbWIQMOM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 08:14:12 -0400
To: Martin Waitz <tali@admingilde.org>
Mail-Followup-To: Martin Waitz <tali@admingilde.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060916210832.GV17042@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27190>

And removed if in if where one if is enough.
---
Martin Waitz <tali@admingilde.org> wrote:
> +	if (defined $project) {
> +		$project = undef unless $project;
> +	}
This is an if in an if, one if is enough.

> +	if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
Warning if $project is undef.
> +	} elsif ($path_info =~ m,^$project/([^/]+)$,) {
The same.
> +$git_dir = "$projectroot/$project";
The same.

We really need a gitweb test target.

Something else I noted:
> +	while ($project && !-e "$projectroot/$project/HEAD") {
Evaluating $project boolean value leads to problems if a repository is
named "0" (I dunno if there are other strings than "" and "0" which
evaluate to false in perl).  There are multiple places where this is
used so I did not change it in this patch (even added one more).
Should this be changed?
---
 gitweb/gitweb.perl |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 346c15c..4d39525 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -281,22 +281,20 @@ if (validate_input($path_info) && !defin
 	while ($project && !-e "$projectroot/$project/HEAD") {
 		$project =~ s,/*[^/]*$,,;
 	}
-	if (defined $project) {
-		$project = undef unless $project;
-	}
-	if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
+	$project = undef if !$project;
+	if ($project && $path_info =~ m,^$project/([^/]+)/(.+)$,) {
 		# we got "project.git/branch/filename"
 		$action    ||= "blob_plain";
 		$hash_base ||= $1;
 		$file_name ||= $2;
-	} elsif ($path_info =~ m,^$project/([^/]+)$,) {
+	} elsif ($project && $path_info =~ m,^$project/([^/]+)$,) {
 		# we got "project.git/branch"
 		$action ||= "shortlog";
 		$hash   ||= $1;
 	}
 }
 
-$git_dir = "$projectroot/$project";
+$git_dir = "$projectroot/$project" if $project;
 
 # dispatch
 my %actions = (
-- 
1.4.2.1.ge767
