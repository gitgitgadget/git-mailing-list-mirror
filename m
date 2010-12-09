From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 13/18] gitweb: Add commented url & url hash to page footer
Date: Thu,  9 Dec 2010 13:57:19 -0800
Message-ID: <1291931844-28454-14-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTi-0007Gf-UG
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138Ab0LIV41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:27 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51865 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223Ab0LIV4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:56:03 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePx027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:56:01 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:56:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163342>

This is mostly a debugging tool, but it adds a small bit of information
to the footer:

<!--
	Full URL: |http://localhost/gitweb-caching/gitweb.cgi?p=/project.git;a=summary|
	URL Hash: |7a31cfb8a43f5643679eec88aa9d7981|
-->

The first bit tells you what the url that generated the page actually was, the second is
the hash used to store the file with the first two characters being used as the directory:

<cachedir>/7a/31cfb8a43f5643679eec88aa9d7981

Also useful for greping through the existing cache and finding files with unique paths that
you may want to explicitly flush.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl  |    7 +++++++
 gitweb/lib/cache.pl |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e8c028b..7f8292e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -303,6 +303,9 @@ our $fullhashpath = *STDOUT;
 our $fullhashbinpath = *STDOUT;
 our $fullhashbinpathfinal = *STDOUT;
 
+our $full_url;
+our $urlhash;
+
 # configuration for 'highlight' (http://www.andre-simon.de/)
 # match by basename
 our %highlight_basename = (
@@ -3663,6 +3666,10 @@ sub git_footer_html {
 
 	print "<div class=\"page_footer\">\n";
 	print "<div class=\"cachetime\">Cache Last Updated: ". gmtime( time ) ." GMT</div>\n";
+	print	"<!--\n".
+		"	Full URL: |$full_url|\n".
+		"	URL Hash: |$urlhash|\n".
+		"-->\n" if ($cache_enable);
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
 		if (defined $descr) {
diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index fafc028..63dbe9e 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -30,8 +30,8 @@ sub cache_fetch {
 		print "Cache directory created successfully\n";
 	}
 
-	our $full_url = "$my_url?". $ENV{'QUERY_STRING'};
-	our $urlhash = md5_hex($full_url);
+	$full_url = "$my_url?". $ENV{'QUERY_STRING'};
+	$urlhash = md5_hex($full_url);
 	our $fullhashdir = "$cachedir/". substr( $urlhash, 0, 2) ."/";
 
 	eval { mkpath( $fullhashdir, 0, 0777 ) };
-- 
1.7.2.3
