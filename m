From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (revised)] gitweb: Show project's git URL on summary page
Date: Tue, 15 Aug 2006 23:03:17 +0200
Message-ID: <200608152303.17994.jnareb@gmail.com>
References: <200608152003.05693.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 15 23:02:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD63Y-0000Bm-4i
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 23:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWHOVCc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWHOVCc
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 17:02:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:57284 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750708AbWHOVCb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 17:02:31 -0400
Received: by nf-out-0910.google.com with SMTP id x30so452761nfb
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 14:02:30 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lHaTL5gZvLQ8bfDdWvhzrOiwfy0mC5RkjdUwnDnP5tNjqpLiBB3Ra8dg5x/ivfiiAnFuuZesXQaZrsXz/VUeX8kaPRCqzy92AN43jSXZOPObfbkiI03YGkX9qtUnoKVXhfDDXspWtvfaHQoZjFa3IVOOjfKo4+Hxvcui1Apr0kY=
Received: by 10.48.242.19 with SMTP id p19mr1883098nfh;
        Tue, 15 Aug 2006 14:02:29 -0700 (PDT)
Received: from host-81-190-28-152.torun.mm.pl ( [81.190.28.152])
        by mx.gmail.com with ESMTP id o45sm2408850nfa.2006.08.15.14.02.28;
        Tue, 15 Aug 2006 14:02:29 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608152003.05693.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25483>

>From 31e4de9f22a3b17d4ad0ac800132e4e1a0a15006 Mon Sep 17 00:00:00 2001
From: David Rientjes <rientjes@google.com>
Date: Tue, 15 Aug 2006 11:43:04 -0700
Subject: [PATCH] gitweb: Show project's git URL on summary page

Add support for showing multiple clone/fetch git URLs for project on
a summary page. URL for project is created from base URL and project
name.

For example for XMMS2 project (xmms.se) the git base URL would be
git://git.xmms.se/xmms2.

With corrections from David Rientjes <rientjes@google.com>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Makefile           |    2 ++
 gitweb/gitweb.perl |   14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

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
index ab28caa..bce3a2a 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -51,6 +51,10 @@ our $logo = "++GITWEB_LOGO++";
 # source of projects list
 our $projects_list = "++GITWEB_LIST++";
 
+# list of git base URLs used for URL to where fetch project from,
+# i.e. full URL is "$git_base_url/$project"
+our @git_base_url_list = ("++GITWEB_BASE_URL++");
+
 # default blob_plain mimetype and default charset for text/plain blob
 our $default_blob_plain_mimetype = 'text/plain';
 our $default_text_plain_charset  = undef;
@@ -1665,8 +1669,14 @@ sub git_summary {
 	print "<table cellspacing=\"0\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>$owner</td></tr>\n" .
-	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n" .
-	      "</table>\n";
+	      "<tr><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+	my $url_tag = "URL";
+	foreach my $git_base_url (@git_base_url_list) {
+		next unless $git_base_url;
+		print "<tr><td>$url_tag</td><td>$git_base_url/$project</td></tr>\n";
+		$url_tag = "";
+	}
+	print "</table>\n";
 
 	open my $fd, "-|", $GIT, "rev-list", "--max-count=17", git_get_head_hash($project)
 		or die_error(undef, "Open git-rev-list failed");
-- 
1.4.1.1
