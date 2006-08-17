From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/7] gitweb: Add support for per project git URLs
Date: Thu, 17 Aug 2006 11:21:22 +0200
Message-ID: <11558064894129-git-send-email-jnareb@gmail.com>
References: <11558064883957-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 17 11:21:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDe4K-00029F-4r
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 11:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWHQJVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 05:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWHQJVg
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 05:21:36 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:17032 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932457AbWHQJVe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 05:21:34 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7H9KPGR023242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Aug 2006 11:20:25 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7H9LTqF003689;
	Thu, 17 Aug 2006 11:21:29 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7H9LTd5003688;
	Thu, 17 Aug 2006 11:21:29 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11558064883957-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25564>

It is now possible for project to have individual clone/fetch URLs.
They are provided in new file 'cloneurl' added below project's
$GIT_DIR directory.

If there is no cloneurl file, concatenation of git base URLs with
project name is used.

This is merge of Jakub Narebski and David Rientjes
  gitweb: Show project's git URL on summary page
with Aneesh Kumar
  gitweb: Add support for cloneurl.
  gitweb: Support multiple clone urls
patches.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 gitweb/gitweb.perl |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 37a6284..7c92ac3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -533,6 +533,16 @@ sub git_get_project_description {
 	return $descr;
 }
 
+sub git_get_project_url_list {
+	my $path = shift;
+
+	open my $fd, "$projectroot/$path/cloneurl" or return undef;
+	my @git_project_url_list = map { chomp; $_ } <$fd>;
+	close $fd;
+
+	return wantarray ? @git_project_url_list : \@git_project_url_list;
+}
+
 sub git_get_projects_list {
 	my @list;
 
@@ -1697,10 +1707,14 @@ sub git_summary {
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
 	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+	# use per project git URL list in $projectroot/$project/cloneurl
+	# or make project git URL from git base URL and project name
 	my $url_tag = "URL";
-	foreach my $git_base_url (@git_base_url_list) {
-		next unless $git_base_url;
-		print "<tr><td>$url_tag</td><td>$git_base_url/$project</td></tr>\n";
+	my @url_list = git_get_project_url_list($project);
+	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
+	foreach my $git_url (@url_list) {
+		next unless $git_url;
+		print "<tr><td>$url_tag</td><td>$git_url</td></tr>\n";
 		$url_tag = "";
 	}
 	print "</table>\n";
-- 
1.4.1.1
