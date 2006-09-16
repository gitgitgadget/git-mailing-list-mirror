From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] gitweb: option 'strict export'
Date: Sat, 16 Sep 2006 23:43:23 +0200
Message-ID: <20060916214323.GA21637@moooo.ath.cx>
References: <20060916192750.GA27008@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Sep 16 23:44:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOhx4-0008DR-9j
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 23:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWIPVn0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 17:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWIPVn0
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 17:43:26 -0400
Received: from moooo.ath.cx ([85.116.203.178]:21135 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751811AbWIPVnZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 17:43:25 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060916192750.GA27008@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27136>

With this option enabled gitweb will only give access to repositories
which are also shown on the overview page.
---
Matthias Lederhofer <matled@gmx.net> wrote:
> Perhaps there should be another option which allows only those
> repositories to be shown which are in $projects_list.
Here it is.  This option is probably the one more likely to be used.
It disallows access to repositories (using ?p=path/to/repository) that
are not on the projects-list-page.
---
 Makefile           |    2 ++
 gitweb/gitweb.perl |   12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 63df24c..0e17d4c 100644
--- a/Makefile
+++ b/Makefile
@@ -133,6 +133,7 @@ GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
 GITWEB_EXPORT_OK =
+GITWEB_STRICT_EXPORT =
 
 export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
 
@@ -639,6 +640,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
 	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
+	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3944d13..976f7ec 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -57,6 +57,9 @@ our $projects_list = "++GITWEB_LIST++";
 # show repository only if this file exists
 our $export_ok = "++GITWEB_EXPORT_OK++";
 
+# only allow viewing of repositories also shown on the overview page
+our $strict_export = "++GITWEB_STRICT_EXPORT++";
+
 # list of git base URLs used for URL to where fetch project from,
 # i.e. full URL is "$git_base_url/$project"
 our @git_base_url_list = ("++GITWEB_BASE_URL++");
@@ -189,7 +192,8 @@ if (defined $project) {
 	}
 	if (!(-d "$projectroot/$project") ||
 	    !(-e "$projectroot/$project/HEAD") ||
-	    ($export_ok && !(-e "$projectroot/$project/$export_ok"))) {
+	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
+	    ($strict_export && !project_in_list($project))) {
 		undef $project;
 		die_error(undef, "No such project");
 	}
@@ -384,6 +388,12 @@ sub untabify {
 	return $line;
 }
 
+sub project_in_list {
+	my $project = shift;
+	my @list = git_get_projects_list();
+	return(@list && scalar(grep { $_->{'path'} eq $project } @list) != 0);
+}
+
 ## ----------------------------------------------------------------------
 ## HTML aware string manipulation
 
-- 
1.4.2.g0ea2
