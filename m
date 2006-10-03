From: "Alan Chandler" <alan@chandlerfamily.org.uk>
Subject: [PATCH] Gitweb - provide site headers and footers
Date: Tue,  3 Oct 2006 13:49:03 +0100
Message-ID: <1159879743194-git-send-email-alan@chandlerfamily.org.uk>
Cc: git@vger.kernel.org, Alan Chandler <alan@chandlerfamily.org.uk>
X-From: git-owner@vger.kernel.org Tue Oct 03 14:49:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUjhZ-00029L-61
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 14:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWJCMsq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 08:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWJCMsq
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 08:48:46 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:51404
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932089AbWJCMsp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 08:48:45 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with smtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GUjhT-0007jX-05; Tue, 03 Oct 2006 13:48:44 +0100
Received: by kanger.home (sSMTP sendmail emulation); Tue,  3 Oct 2006 13:49:03 +0100
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28270>

From: Alan Chandler <alan@chandlerfamily.org.uk>

This allows web sites with a header and footer standard for each page
to add them to the pages produced by gitweb.

Two new variables $site_header and $site_footer are defined (default
to null) each of which can specify a file containing the header and
footer html.

In addition, if the $stylesheet variable is undefined, a new array
@stylesheets (which defaults to a single element of gitweb.css) can be
used to specify more than one style sheet.  This allows the clasical
gitweb.css styles to be retained, but a site wide style sheet used
within the header and footer areas.

Signed-off-by: Alan Chandler <alan@chandlerfamily.org.uk>
---
 Makefile           |    4 ++++
 gitweb/gitweb.perl |   45 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 401b893..32a546e 100644
--- a/Makefile
+++ b/Makefile
@@ -132,6 +132,8 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_SITE_HEADER = 
+GITWEB_SITE_FOOTER =
 
 export prefix bindir gitexecdir template_dir GIT_PYTHON_DIR
 
@@ -675,6 +677,8 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
+	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
 	    $< >$@+
 	chmod +x $@+
 	mv $@+ $@
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 44991b1..1ec4435 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -41,11 +41,19 @@ # name of your site or organization to a
 # replace this with something more descriptive for clearer bookmarks
 our $site_name = "++GITWEB_SITENAME++" || $ENV{'SERVER_NAME'} || "Untitled";
 
+# filename of html text to include at top of each page
+our $site_header = "++GITWEB_SITE_HEADER++";
 # html text to include at home page
 our $home_text = "++GITWEB_HOMETEXT++";
+# filename of html text to include at bottom of each page
+our $site_footer = "++GITWEB_SITE_FOOTER++";
+
+# URI of stylesheets
+our @stylesheets = ("++GITWEB_CSS++");
+our $stylesheet;
+# default is not to define style sheet, but it can be overwritten later
+undef $stylesheet;
 
-# URI of default stylesheet
-our $stylesheet = "++GITWEB_CSS++";
 # URI of GIT logo
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
@@ -1351,8 +1359,17 @@ sub git_header_html {
 <meta name="generator" content="gitweb/$version git/$git_version"/>
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
-<link rel="stylesheet" type="text/css" href="$stylesheet"/>
 EOF
+# print out each stylesheet that exist
+	if (defined $stylesheet) {
+#provides backwards capability for those people who define style sheet in a config file
+		print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
+	} else {
+		foreach my $stylesheet (@stylesheets) {
+			next unless $stylesheet;
+			print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
+		}
+	}
 	if (defined $project) {
 		printf('<link rel="alternate" title="%s log" '.
 		       'href="%s" type="application/rss+xml"/>'."\n",
@@ -1370,8 +1387,15 @@ EOF
 	}
 
 	print "</head>\n" .
-	      "<body>\n" .
-	      "<div class=\"page_header\">\n" .
+	      "<body>\n";
+	      
+	if (-f $site_header) {
+		open (my $fd, $site_header);
+		print <$fd>;
+		close $fd;
+	}
+	
+	print "<div class=\"page_header\">\n" .
 	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
 	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
 	      "</a>\n";
@@ -1422,8 +1446,15 @@ sub git_footer_html {
 		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
 		              -class => "rss_logo"}, "TXT") . "\n";
 	}
-	print "</div>\n" .
-	      "</body>\n" .
+	print "</div>\n" ;
+	
+	if (-f $site_footer) {
+		open (my $fd, $site_footer);
+		print <$fd>;
+		close $fd;
+	}
+	
+	print "</body>\n" .
 	      "</html>";
 }
 
-- 
1.4.2.1
