From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Even more support for PATH_INFO based URLs
Date: Wed, 20 Sep 2006 00:49:51 +0200
Message-ID: <200609200049.52036.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Martin Waitz <tali@admingilde.org>,
	Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Sep 20 00:49:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPoOq-0002OX-Hs
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbWISWtF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbWISWtF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:49:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:25673 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752096AbWISWtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:49:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so282514nfa
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 15:49:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qlW506D0Rb9bVugfNHpXpQnOTn0ZG120IX7/MZRR34FK2a5jbNQ2VGz5mTOgxw712KPqKa7RgR102VqM+Tei130b31vFrCvavKSpOtYnWNsxpOaIPqOfSHS2YWQVTRLF9hpKSzWPmUG1RqHwu13LlbiuyLV3uGL1LAoXqWY7mmY=
Received: by 10.78.128.15 with SMTP id a15mr4179919hud;
        Tue, 19 Sep 2006 15:49:00 -0700 (PDT)
Received: from host-81-190-31-133.torun.mm.pl ( [81.190.31.133])
        by mx.gmail.com with ESMTP id 24sm35576huf.2006.09.19.15.48.59;
        Tue, 19 Sep 2006 15:48:59 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27309>

Now the following types of path based URLs are supported:

* project              overview (summary) page of project
* project/branch       shortlog of branch
* project/branch:file  file in branch, blob_plain view
* project/branch:dir/  directory listing of dir in branch, tree view

The following shortcuts works (see explanation below):

* project/branch:      directory listing of branch, main tree view
* project/:file        file in HEAD (raw)
* project/:dir/        directory listing of dir in HEAD
* project/:            directory listing of project's HEAD

We use ':' as separator between branch (ref) name and file name
(pathname) because valid branch (ref) name cannot have ':' inside.
This limit applies to branch name only. This allow for hierarchical
branches e.g. topic branch 'topic/subtopic', separate remotes
tracking branches e.g. 'refs/remotes/origin/HEAD', and discriminate
between head (branch) and tag with the same name.

Empty branch should be interpreted as HEAD.

If pathname (the part after ':') ends with '/', we assume that pathname
is name of directory, and we want to show contents of said directory
using "tree" view. If pathname is empty, it is equivalent to '/' (top
directory).

If pathname (the part after ':') does not end with '/', we assume that
pathname is name of file, and we show contents of said file using
"blob_plain" view.

Pathname is stripped of leading '/', so we can use ':/' to separate
branch from pathname. The rationale behind support for PATH_INFO based
URLs was to support project web pages for small projects: just create
an html branch and then use an URL like
  http://nowhere.com/gitweb.cgi/project.git/html:/index.html
The ':/' syntax allow for working links between .html files served
in such way, e.g. <a href="main.html"> link inside "index.html"
would get
  http://nowhere.com/gitweb.cgi/project.git/html:/main.html.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Alternatively we could use git-cat-file -t (git_get_type subroutine)
to distinguish between trees and files (blobs), but first it would
slow gitweb somewhat (additional fork), and second git_get_type
assumes that $git_dir is set... and this variable is defined later!

See also:
  "[PATCH] gitweb: more support for PATH_INFO based URLs"
  Message-ID: <20060916210832.GV17042@admingilde.org>
  http://permalink.gmane.org/gmane.comp.version-control.git/27133
(this email should be probably posted in this thread)

 gitweb/gitweb.perl |   29 ++++++++++++++++++++---------
 1 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 9445fa7..839b232 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -274,13 +274,16 @@ sub evaluate_path_info {
 	return if defined $project;
 	my $path_info = $ENV{"PATH_INFO"};
 	return if !$path_info;
-	$path_info =~ s,(^/|/$),,gs;
-	$path_info = validate_input($path_info);
+	$path_info =~ s,^/+,,;
 	return if !$path_info;
+	# find which part of PATH_INFO is project
 	$project = $path_info;
+	$project =~ s,/+$,,;
 	while ($project && !-e "$projectroot/$project/HEAD") {
 		$project =~ s,/*[^/]*$,,;
 	}
+	# validate project
+	$project = validate_input($project);
 	if (!$project ||
 	    ($export_ok && !-e "$projectroot/$project/$export_ok") ||
 	    ($strict_export && !project_in_list($project))) {
@@ -289,15 +292,23 @@ sub evaluate_path_info {
 	}
 	# do not change any parameters if an action is given using the query string
 	return if $action;
-	if ($path_info =~ m,^$project/([^/]+)/(.+)$,) {
-		# we got "project.git/branch/filename"
-		$action    ||= "blob_plain";
-		$hash_base ||= validate_input($1);
-		$file_name ||= validate_input($2);
-	} elsif ($path_info =~ m,^$project/([^/]+)$,) {
+	$path_info =~ s,^$project/*,,;
+	my ($refname, $pathname) = split(/:/, $path_info, 2);
+	if (defined $pathname) {
+		# we got "project.git/branch:filename" or "project.git/branch:dir/"
+		# we could use git_get_type(branch:pathname), but it needs $git_dir
+		$pathname =~ s,^/+,,;
+		if (!$pathname || substr($pathname, -1) eq "/") {
+			$action  ||= "tree";
+		} else {
+			$action  ||= "blob_plain";
+		}
+		$hash_base ||= validate_input($refname);
+		$file_name ||= validate_input($pathname);
+	} elsif (defined $refname) {
 		# we got "project.git/branch"
 		$action ||= "shortlog";
-		$hash   ||= validate_input($1);
+		$hash   ||= validate_input($refname);
 	}
 }
 evaluate_path_info();
-- 
1.4.2.1
