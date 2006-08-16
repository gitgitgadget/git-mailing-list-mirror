From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/2] gitweb: Add support for per project git URLs
Date: Wed, 16 Aug 2006 14:50:34 +0200
Message-ID: <200608161450.35118.jnareb@gmail.com>
References: <200608152003.05693.jnareb@gmail.com> <200608152303.17994.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 16 14:49:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDKqE-0003g0-WB
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 14:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWHPMtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 08:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWHPMtr
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 08:49:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:42108 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751157AbWHPMtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Aug 2006 08:49:47 -0400
Received: by wx-out-0506.google.com with SMTP id s14so112671wxc
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 05:49:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E9vh+lKk5DD9piGDEmkOWroCGWR3rfINm3wpIoISAPyBwolWyEL5fg22lXAsmhOwuBlRmSGLkWyjHv63xPi4FDElAaey/18kMNaGZIgJRDn2e18CixaylhS19UXTGzrZJTdFDfnR15X+M+gbPOSKrCh+hjHWTcufxdl9TiE9Lmc=
Received: by 10.49.8.1 with SMTP id l1mr647637nfi;
        Wed, 16 Aug 2006 05:49:46 -0700 (PDT)
Received: from host-81-190-28-152.torun.mm.pl ( [81.190.28.152])
        by mx.gmail.com with ESMTP id c1sm3533392nfe.2006.08.16.05.49.45;
        Wed, 16 Aug 2006 05:49:45 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608152303.17994.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25514>

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
Based on previous patch.

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
