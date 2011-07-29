From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 2/6] gitweb: Improve projects search form
Date: Fri, 29 Jul 2011 13:52:55 +0200
Message-ID: <1311940379-9608-3-git-send-email-jnareb@gmail.com>
References: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 13:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmldN-0005xQ-O2
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 13:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab1G2Lx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 07:53:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65163 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379Ab1G2Lx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 07:53:27 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so2225343fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 04:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jcbzp1Fs3UdW8CxH6CIubViKNfS6w/z8Ae0jacDNuhw=;
        b=fuQsIy9VUdmFdnOPxb9ozdOjDTuuMbqzABlryWOMdIilC8op5+mhCO6FPIejp1GJC8
         7349paRLrXc8ec80E+IUMkmBlJuLI2tBFHNZYOOSN/fsDOmcYm7q63UY+zDUDF3SgO8/
         hIfxLb1ogj9eiTZMNKVKeFEBGoBongDus6qlc=
Received: by 10.223.159.197 with SMTP id k5mr1704401fax.50.1311940406267;
        Fri, 29 Jul 2011 04:53:26 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id n27sm1049500faa.4.2011.07.29.04.53.24
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 04:53:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1311940379-9608-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178138>

Refactor generating project search form into git_project_search_form(),
make text field wider and add on mouse over explanation (via "title"
attribute), add an option to use regular expressions, and replace
'Search:' label with [Search] button.

Also add "List all projects" link to make it easier to go back from
search result to list of all projects.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The most useful part is the user interface for turning on regular
expression search (it was always there, but you had to hand-edit URL),
I think.

By the way, I was reminded (on #perl IRC channel on FreeNode) that
allowing regular expression search is not safe against DoS because of
recursive backtracking regexps.  If one worries about that, one can
always change regexp engine to more safe one, for example putting the
following in gitweb config file:

  use re::engine::RE2 -strict => 1;

to use RE2 fast regexp engine from Google (http://code.google.com/p/re2).

There was some concern about extended pattern '(?{ code })' that
allows running arbitrary Perl code... but re(3pm) says that "no re
'eval';" is default, which means that such construct is disallowed
when regular expression contains variable interpolation.


Note that if there is no match, you would get 'list all project' link
twice, once from search form, one from search result... but I don't
think it is something to worry about.

 gitweb/gitweb.perl       |   27 ++++++++++++++++++++++-----
 gitweb/static/gitweb.css |    7 ++++++-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7ec1621..3e69705 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4968,6 +4968,26 @@ sub git_patchset_body {
 
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
@@ -5835,11 +5855,8 @@ sub git_project_list {
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
index 7d88509..3cdaaa3 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -490,8 +490,13 @@ div.search {
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
1.7.5
