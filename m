From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: [Patch] gitweb added site css, header and footer
Date: Sat, 12 Nov 2005 17:50:30 +0000
Message-ID: <200511121750.30477.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 18:51:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EazWI-0001GC-Kg
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 18:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVKLRu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 12:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKLRu1
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 12:50:27 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:1682
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932426AbVKLRu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 12:50:27 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EazWE-0003ZJ-0n; Sat, 12 Nov 2005 17:50:26 +0000
To: kay.sievers@vrfy.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11697>

I wanted to include gitweb on my site - but with the ability to keep my own 
site header and footer.  I have therefore made a few changes to enable this 
to happen.  I also had a problem in that I had installed gitweb.cgi 
in /usr/lib/cgi-bin, and it was attempting to read indextext.html from this 
directory rather than the projectroot.

I have therefore changed it to pick up this file from projectroot, and also 
two other files header.html and footer.html which contain the html for the 
header and footer of each page.

Lastly, I have made a paramter at the top of the file for the the url to my 
site wide css file.

Signed-off-by: Alan Chandler <alan@chandlerfamily.org.uk>

I am not sure what the netiquette is with regards these changes.

I have published them as the master branch at 

http://www.chandlerfamily.org.uk/git/gitweb.git

but I have also attached a patch below (and someone can tell me if kmail does 
the "right thing")

What should one do about the changes to the variables at the top of the file, 
you will see I have changed $projectroot and $gitbin

---------

diff --git a/gitweb.cgi b/gitweb.cgi
index b8f1537..d16def4 100755
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -22,10 +22,10 @@ my $rss_link = "";
 
 # absolute fs-path which will be prepended to the project path
 #my $projectroot =	"/pub/scm";
-my $projectroot = "/home/kay/public_html/pub/scm";
+my $projectroot = "/var/lib/git";
 
 # location of the git-core binaries
-my $gitbin =		"/usr/bin";
+my $gitbin =		"/usr/local/bin";
 
 # location for temporary files needed for diffs
 my $git_temp =		"/tmp/gitweb";
@@ -33,12 +33,25 @@ my $git_temp =		"/tmp/gitweb";
 # target of the home link on top of all pages
 my $home_link =		$my_uri;
 
+#css url for overall site
+
+my $site_css_url = "/style/site.css";
+
+#page header and footer for all pages on this site
+
+my $site_header=	$projectroot."/header.html";
+my $site_footer=	$projectroot."/footer.html";
+
 # html text to include at home page
-my $home_text =		"indextext.html";
+my $home_text =		$projectroot."/indextext.html";
 
 # source of projects list
-#my $projects_list = $projectroot;
-my $projects_list = "index/index.aux";
+my $projects_list = $projectroot;
+#my $projects_list = "index/index.aux";
+
+
+
+
 
 # input validation and dispatch
 my $action = $cgi->param('a');
@@ -217,6 +230,12 @@ sub git_header_html {
 			$title .= "/$action";
 		}
 	}
+
+	my $site_css = "";
+	if (defined $site_css_url) {
+		$site_css="<link rel=\"stylesheet\" text=\"text/css\" 
href=\"$site_css_url\"/>";
+	}
+	
 	print $cgi->header(-type=>'text/html',  -charset => 'utf-8', -status=> 
$status, -expires => $expires);
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
@@ -228,6 +247,7 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 $rss_link
+$site_css
 <style type="text/css">
 body { font-family: sans-serif; font-size: 12px; margin:0px; border:solid 
#d9d8d1; border-width:1px; margin:10px; }
 a { color:#0000cc; }
@@ -284,6 +304,13 @@ a.rss_logo:hover { background-color:#ee5
 </head>
 <body>
 EOF
+
+	if (-f $site_header) {
+		open (my $fd, $site_header);
+		print <$fd>;
+		close $fd;
+	}
+
 	print "<div class=\"page_header\">\n" .
 	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" 
title=\"git documentation\">" .
 	      "<img src=\"$my_uri?a=git-logo.png\" width=\"72\" height=\"27\" 
alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
@@ -329,8 +356,15 @@ sub git_footer_html {
 	} else {
 		print $cgi->a({-href => "$my_uri?a=opml", -class => "rss_logo"}, "OPML") . 
"\n";
 	}
-	print "</div>\n" .
-	      "</body>\n" .
+	print "</div>\n";
+	if (-f $site_footer) {
+		open (my $fd, $site_footer);
+		print <$fd>;
+		close $fd;
+	}
+
+
+	print "</body>\n" .
 	      "</html>";
 }
 

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
