From: Alp Toker <alp@atoker.com>
Subject: [PATCH] gitweb: Send XHTML as 'application/xhtml+xml' where possible
Date: Tue, 11 Jul 2006 11:19:34 +0100
Message-ID: <11526131781900-git-send-email-alp@atoker.com>
References: <11526131782190-git-send-email-alp@atoker.com>
X-From: git-owner@vger.kernel.org Tue Jul 11 12:20:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0FLV-0003jo-B9
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 12:20:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbWGKKTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 06:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWGKKTu
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 06:19:50 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:11539 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S1750943AbWGKKTt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 06:19:49 -0400
Received: by ndesk.org (Postfix, from userid 1000)
	id 0609A1645E9; Tue, 11 Jul 2006 11:19:39 +0100 (BST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.g97c7-dirty
In-Reply-To: <11526131782190-git-send-email-alp@atoker.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23702>

"The 'text/html' media type [RFC2854] is primarily for HTML, not for
XHTML. In general, this media type is NOT suitable for XHTML."

This patch makes gitweb use content negotiation to conservatively send
pages as Content-Type 'application/xhtml+xml' when the user agent
explicitly claims to support it.

It falls back to 'text/html' even if the user agent appears to
implicitly support 'application/xhtml+xml' due to a '*/*' glob, working
around an insidious bug in Internet Explorer where sending the correct
media type prevents the page from being displayed.

Signed-off-by: Alp Toker <alp@atoker.com>
---
 gitweb/gitweb.cgi |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 2e87de4..bd9b9de 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -293,7 +293,17 @@ sub git_header_html {
 			}
 		}
 	}
-	print $cgi->header(-type=>'text/html',  -charset => 'utf-8', -status=> $status, -expires => $expires);
+	my $content_type;
+	# require explicit support from the UA if we are to send the page as
+	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
+	# we have to do this because MSIE sometimes globs '*/*', pretending to
+	# support xhtml+xml but choking when it gets what it asked for.
+	if ($cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ && $cgi->Accept('application/xhtml+xml') != 0) {
+		$content_type = 'application/xhtml+xml';
+	} else {
+		$content_type = 'text/html';
+	}
+	print $cgi->header(-type=>$content_type,  -charset => 'utf-8', -status=> $status, -expires => $expires);
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
@@ -301,7 +311,7 @@ sub git_header_html {
 <!-- git web interface v$version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
 <!-- git core binaries version $git_version -->
 <head>
-<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
+<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 <link rel="stylesheet" type="text/css" href="$stylesheet"/>
-- 
1.4.1.g97c7-dirty
