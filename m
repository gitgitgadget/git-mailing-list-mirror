From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 15/18] gitweb: Add show_warning() to display an immediate warning, with refresh
Date: Thu,  9 Dec 2010 13:57:21 -0800
Message-ID: <1291931844-28454-16-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoTh-0007Gf-SX
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097Ab0LIV4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:56:25 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51868 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757469Ab0LIV4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:56:03 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LteQ1027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:56:02 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:56:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163347>

die_error() is an immediate and abrupt action.  show_warning() more or less
functions identically, except that the page generated doesn't use the
gitweb header or footer (in case they are broken) and has an auto-refresh
(10 seconds) built into it.

This makes use of print_transient_header() which is also used in the
'Generating...' page.  Currently the only warning it throws is about
the cache needing to be created.  If that fails it's a fatal error
and we call die_error()

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/lib/cache.pl |   36 +++++++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/gitweb/lib/cache.pl b/gitweb/lib/cache.pl
index 723ae9b..28e4240 100644
--- a/gitweb/lib/cache.pl
+++ b/gitweb/lib/cache.pl
@@ -25,9 +25,13 @@ sub cache_fetch {
 	my $cacheTime = 0;
 
 	if(! -d $cachedir){
-		print "*** Warning ***: Caching enabled but cache directory does not exsist.  ($cachedir)\n";
-		mkdir ("cache", 0755) || die "Cannot create cache dir - you will need to manually create";
-		print "Cache directory created successfully\n";
+		mkdir ("cache", 0755) || die_error(500, "Internal Server Error", "Cannot create cache dir () - you will need to manually create");
+		show_warning(
+				"<p>".
+				"<strong>*** Warning ***:</strong> Caching enabled but cache directory did not exsist.  ($cachedir)<br/>/\n".
+				"Cache directory created successfully\n".
+				"<p>"
+				);
 	}
 
 	$full_url = "$my_url?". $ENV{'QUERY_STRING'};
@@ -119,6 +123,32 @@ sub print_transient_header {
 	return;
 }
 
+sub show_warning {
+	$| = 1;
+
+	my $warning = esc_html(shift) || "Unknown Warning";
+
+	print_transient_header();
+
+	print <<EOF;
+<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www/w3.porg/TR/html4/strict.dtd">
+<!-- git web w/caching interface version $version, (C) 2006-2010, John 'Warthog9' Hawley <warthog9\@kernel.org> -->
+<!-- git core binaries version $git_version -->
+<head>
+<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
+<meta name="generator" content="gitweb/$version git/$git_version"/>
+<meta name="robots" content="index, nofollow"/>
+<meta http-equiv="refresh" content="10"/>
+<title>$title</title>
+</head>
+<body>
+$warning
+</body>
+</html>
+EOF
+	exit(0);
+}
+
 sub isBinaryAction {
 	my ($action) = @_;
 
-- 
1.7.2.3
