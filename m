From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Show project's git URL on summary page
Date: Tue, 15 Aug 2006 20:03:05 +0200
Message-ID: <200608152003.05693.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Aug 15 20:02:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD3FE-0001bQ-1I
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 20:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbWHOSCZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030420AbWHOSCY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 14:02:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:34521 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030419AbWHOSCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 14:02:24 -0400
Received: by ug-out-1314.google.com with SMTP id m3so449021ugc
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 11:02:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YymS5CBFlMVi8Bfduzfru02mu8unKTxitfz6pVnmka2K62ljRC/WtAkqyqWkSN2l32NbnwvoRZp9gWgg9Z75PHLH2JnGkc8IKw9D9OAfVPiTHJD6S4FKHbM/HzsY+ZBHl0omriGS0CPO3MYRWTc4Heh3zIs2qj8CfEPmkVZq2rs=
Received: by 10.67.100.12 with SMTP id c12mr9399837ugm;
        Tue, 15 Aug 2006 11:02:22 -0700 (PDT)
Received: from host-81-190-28-152.torun.mm.pl ( [81.190.28.152])
        by mx.gmail.com with ESMTP id q40sm9751808ugc.2006.08.15.11.02.21;
        Tue, 15 Aug 2006 11:02:22 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25472>

Add support for showing multiple clone/fetch git URLs for project on
a summary page. URL for project is created from base URL and project
name.

For example for XMMS2 project (xmms.se) the git base URL would be
git://git.xmms.se/xmms2.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This probably could be combined with Aneesh Kumar patches 
  "[PATCH] gitweb: Add support for cloneurl."
  "[PATCH] gitweb: Support multiple clone urls"
which reads from clone/fetch URLs from $GIT_DIR/cloneurl file,
i.e. from $projectroot/$project/cloneurl file.  Default would be to
use base URL from @git_base_url_list, and if there is cloneurl file
for a project, use it instead.

I'm not so sure of benefits of yet another way to provide
clone/fetch URL, namely Yasushi SHOJI
  "[PATCH] gitweb: configurable home link string"

This patch is port (with improvements) of Sham Chukoury patch
  "Show project tree git url on summary page" (8e327dfbd)
for gitweb-xmms2. Should I add below line to commit message?

Signed-off-by: Sham Chukoury <eleusis@xmms.org>


 Makefile           |    2 ++
 gitweb/gitweb.perl |   18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a538710..ae77d99 100644
--- a/Makefile
+++ b/Makefile
@@ -125,6 +125,7 @@ # default configuration for gitweb
 GITWEB_CONFIG = gitweb_config.perl
 GITWEB_SITENAME =
 GITWEB_PROJECTROOT = /pub/git
+GITWEB_BASE_URL =
 GITWEB_LIST =
 GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
@@ -619,6 +620,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
 	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
+	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
 	    -e 's|++GITWEB_LIST++|$(GITWEB_LIST)|g' \
 	    -e 's|++GITWEB_HOMETEXT++|$(GITWEB_HOMETEXT)|g' \
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ab28caa..6dcf6a2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -51,6 +51,10 @@ our $logo = "++GITWEB_LOGO++";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# list of git base URLs used for URL to where fetch project from,
+# i.e. full URL is "$git_base_url/$project"
+our @git_base_url_list = ("++GIT_BASE_URL++");
+
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
 our $default_text_plain_charset  = undef;
@@ -1665,8 +1669,18 @@ sub git_summary {
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
-	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
-	      "</table>\n";
+	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+	my $is_first_url = 1;
+	foreach my $git_base_url (@git_base_url_list) {
+		next unless $git_base_url; # skip empty/zerolength URLs
+		print "<tr><td>";
+		if ($is_first_url) {
+			print "URL";
+			$is_first_url = 0;
+		}
+		print "</td><td>$git_base_url/$project</td></tr>\n";
+	}
+	print "</table>\n";
 
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
-- 
1.4.1.1
