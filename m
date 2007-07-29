From: "Leandro Dorileo" <ldorileo@gmail.com>
Subject: [PATCH] gitweb: localhost placeholder parser for cloneurl file
Date: Sun, 29 Jul 2007 02:54:33 -0400
Message-ID: <d68f80d90707282354l1593f2ctc0cf7a05eeb3b8e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 08:54:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF2fw-0005Uc-05
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 08:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759812AbXG2Gyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 02:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759815AbXG2Gyf
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 02:54:35 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:51335 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759711AbXG2Gye (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 02:54:34 -0400
Received: by nf-out-0910.google.com with SMTP id g13so105722nfb
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 23:54:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O8TcyJaW07XPeL5vVFLitAlDVe+ZV4Q4vzcKL5MuS3epdZXC+vNzObPcbVC88w4BmEpD6dBa5zFvi6yF++IA9Gk6UhcC6ANass4R42JzVHG9+/EtTNnpMVOef6aVWJd0jPdYobPmIShBco60ockDYfDR67IhLR+P03AdT/tM6xA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CagJYfFW+XKnzySBcqoCz0QZJVZE0pzi8xsCXoBlyr0W5YQLWkGpygN5sheEkiPBWz2FsdxoPHXQ/5rEMrFBNLU1nY6qD6esg06SYUpygQklfgFnOsvhI4Dlzd/428hVfvTN9U38wP5JZZarqZtcGf0B/QEFzNZYADCVBJrs7bg=
Received: by 10.78.193.5 with SMTP id q5mr1178844huf.1185692073202;
        Sat, 28 Jul 2007 23:54:33 -0700 (PDT)
Received: by 10.78.26.14 with HTTP; Sat, 28 Jul 2007 23:54:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54084>

Hi...

I just started to use gitweb and saw that there isn`t in the git-tree
of gitweb the feature of that link to the git url (wich we can see in
git.kernel.org:D - I didn`t understand it, was that changed/done only
for kernel.org?).
I also have a specific need. I work with my laptop and there I keep
some git repositories, these repositories are shared/published with
some coworkers but as it`s a notebook the network environment normally
changes depending where I`m, so I implemented a placeholder for
cloneurl file. Gitweb will change #localhost# by  server_name.

If your git repositories aren`t in your local machine or if your
gitweb is hosted in a specific server what you have to do (in fact
what you don`t have to do :D) is just not use it.

>From 32da24e1e18a1c5f32bfa0afdbcb6d0f2b0432f3 Mon Sep 17 00:00:00 2001
From: Leandro Dorileo <dorileo@ossystems.com.br>
Date: Sat, 28 Jul 2007 15:34:20 -0400
Subject: [PATCH] gitweb: localhost placeholder parser for cloneurl file

Implementation of a localhost placeholder parsing in git_get_project_url_list.
It`s useful in cases of gitweb being hosted in a work-station (like a notebook)
used in a local team development environment and, implementation of a git-url
link in the git project list body like in git.kernel.org.
---
 gitweb/gitweb.perl |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b381692..281d823 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1471,7 +1471,16 @@ sub git_get_project_url_list {
 	my @git_project_url_list = map { chomp; $_ } <$fd>;
 	close $fd;

-	return wantarray ? @git_project_url_list : \@git_project_url_list;
+        if(wantarray){
+            for(my $i = 0; $i < @git_project_url_list; $i++){
+                if(index(@git_project_url_list[$i], "#localhost#") != -1){
+                    @git_project_url_list[$i] =~
s/#localhost#/server_name()/eg;
+                }
+            }
+            return @git_project_url_list;
+        }else{
+            return \@git_project_url_list;
+        }
 }

 sub git_get_projects_list {
@@ -3384,8 +3393,14 @@ sub git_project_list_body {
 		      $cgi->a({-href => href(project=>$pr->{'path'},
action=>"shortlog")}, "shortlog") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'},
action=>"log")}, "log") . " | " .
 		      $cgi->a({-href => href(project=>$pr->{'path'},
action=>"tree")}, "tree") .
-		      ($pr->{'forks'} ? " | " . $cgi->a({-href =>
href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
-		      "</td>\n" .
+		      ($pr->{'forks'} ? " | " . $cgi->a({-href =>
href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '');
+
+                      my @url_list = git_get_project_url_list($pr->{'path'});
+                      if(@url_list != 0){
+                        print " | " . $cgi->a({-href => @url_list[0]}, "git");
+                      }
+
+		      print "</td>\n" .
 		      "</tr>\n";
 	}
 	if (defined $extra) {
-- 
1.5.2.4

-- 
Dorileo
