From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Improve projects search form
Date: Tue, 31 Jan 2012 01:20:54 +0100
Message-ID: <1327969255-26622-2-git-send-email-jnareb@gmail.com>
References: <1327969255-26622-1-git-send-email-jnareb@gmail.com>
Cc: "Bernhard R. Link" <brl+git@mail.brlink.eu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 01:20:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs1Sl-0005kr-LV
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 01:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab2AaAUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 19:20:32 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45207 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab2AaAU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 19:20:29 -0500
Received: by mail-ee0-f46.google.com with SMTP id c14so1620952eek.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 16:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0e0xG/VTd/f9hb3WwV5w9m5aBpR1Y/WAWgpyPADzd28=;
        b=iQDDedRhIkjVnWtnrSD+2dDU0xulDMEHs4tMd8if1fJVttNS32fwl0YsF8D3praFrd
         2t85IT7hrpx01TytHwUBJ+R0QXTPzKi4ytORVYqcoM4xzo9RlQlE45Jwj+TRXtAUHaaN
         S6ZwA073M3lj+yw2pO1x8Wx0/DTyjb/LySyLE=
Received: by 10.14.28.194 with SMTP id g42mr292571eea.44.1327969228932;
        Mon, 30 Jan 2012 16:20:28 -0800 (PST)
Received: from localhost.localdomain (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id b3sm28106899een.2.2012.01.30.16.20.27
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 16:20:28 -0800 (PST)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1327969255-26622-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189439>

Refactor generating project search form into git_project_search_form().
Make text field wider and add on mouse over explanation (via "title"
attribute), add an option to use regular expressions, and replace
'Search:' label with [Search] button.

Also add "List all projects" link to make it easier to go back from
search result to list of all projects (note that empty search term
is disallowed).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The major advantage is that you can use regular expression in
searching projects... well, at least there is UI for it, because you
could handcraft URL earlier anyway.

This patch was presented on git mailing list earlier.

 gitweb/gitweb.perl       |   27 ++++++++++++++++++++++-----
 gitweb/static/gitweb.css |    7 ++++++-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fa8a300..c4e0d8e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5155,6 +5155,26 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
+sub git_project_search_form {
+	my ($searchtext, $search_use_regexp);
+
+	print "<div class=\"projsearch\">\n";
+	print $cgi->startform(-method => 'get', -action => $my_uri) .
+	      $cgi->hidden(-name => 'a', -value => 'project_list') . "\n" .
+	      $cgi->textfield(-name => 's', -value => $searchtext,
+	                      -title => 'Search project by name and description',
+	                      -size => 60) . "\n" .
+	      "<span title=\"Extended regular expression\">" .
+	      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
+	                     -checked => $search_use_regexp) .
+	      "</span>\n" .
+	      $cgi->submit(-name => 'btnS', -value => 'Search') .
+	      $cgi->end_form() . "\n" .
+	      $cgi->a({-href => href(project => undef, searchtext => undef)},
+	              'List all projects') . "<br />\n";
+	print "</div>\n";
+}
+
 # fills project list info (age, description, owner, category, forks)
 # for each project in the list, removing invalid projects from
 # returned list
@@ -6022,11 +6042,8 @@ sub git_project_list {
 		insert_file($home_text);
 		print "</div>\n";
 	}
-	print $cgi->startform(-method => "get") .
-	      "<p class=\"projsearch\">Search:\n" .
-	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
-	      "</p>" .
-	      $cgi->end_form() . "\n";
+
+	git_project_search_form($searchtext, $search_use_regexp);
 	git_project_list_body(\@list, $order);
 	git_footer_html();
 }
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index c7827e8..c530355 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -520,8 +520,13 @@ div.search {
 	right: 12px
 }
 
-p.projsearch {
+div.projsearch {
 	text-align: center;
+	margin: 20px 0px;
+}
+
+div.projsearch form {
+	margin-bottom: 2px;
 }
 
 td.linenr {
-- 
1.7.6
