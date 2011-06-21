From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Refactor git_header_html
Date: Tue, 21 Jun 2011 20:38:42 +0200
Message-ID: <20110621183550.9315.21922.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 20:39:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ5r5-00049n-7P
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 20:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766Ab1FUSjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 14:39:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34475 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab1FUSjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 14:39:12 -0400
Received: by fxm17 with SMTP id 17so135231fxm.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 11:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=DKONTdwi1Bh0OWyCd0uVjv0CahehRDWx1xRCpadW69M=;
        b=QjVQlYwrHXogcv+lUaI8OyqmO8YVfkGIPls8GbaB9UbBPxy10w+juF3RXxzpCLrTkd
         uCKOZpZuo4BHF48oY6rmGw1BKC/BzNz6qXFhDjY4Nh02lr3TjNxvRLgjPnyG1TM6GhPq
         f/Z/ukyqhPt3hOKKMJpevHS2pvWSG2eWiGkiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=izCXG1tfIRgYKnnQ0oFkQZvLjUBtCx6AxPjdQcJKsFH/4FwMyrcMuginhWztN9Vyzu
         RwTqqvj+qGhe76dPBnLhIMrSfuLYfWA21a1xuRcVIZWD1FuKZdynI9TGprxnraL2Q+Cr
         /q4Vbp8BfE8eUF8SGj+crE2VHByJgB/qkrYLE=
Received: by 10.223.6.201 with SMTP id a9mr189857faa.110.1308681551119;
        Tue, 21 Jun 2011 11:39:11 -0700 (PDT)
Received: from localhost.localdomain (abvd183.neoplus.adsl.tpnet.pl [83.8.201.183])
        by mx.google.com with ESMTPS id w15sm1459850faj.47.2011.06.21.11.39.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 11:39:09 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5LIcg1c009372;
	Tue, 21 Jun 2011 20:38:52 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176179>

Extract (factor out) the following parts into separate subroutines:
* finding correct MIME content type for HTML pages (text/html or
  application/xhtml+xml?) into get_content_type_html()
* printing <link ...> elements in HTML head into print_header_links()
* printing navigation "breadcrumbs" for given action into
  print_nav_breadcrumbs()
* printing search form into print_search_form()

This reduces git_header_html to two pages long (53 lines).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This originally was a first part of patch series improving search in
gitweb, but because it is independent improvement, it is sent as a
separate patch.

Not a regression fix, not for 1.7.6

P.S. I wonder if print_search_form() should also get passed %opts as
one of its parameters...

 gitweb/gitweb.perl |  173 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 96 insertions(+), 77 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f13b4b5..c9e6426 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3693,6 +3693,20 @@ sub get_page_title {
 	return $title;
 }
 
+sub get_content_type_html {
+	# require explicit support from the UA if we are to send the page as
+	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
+	# we have to do this because MSIE sometimes globs '*/*', pretending to
+	# support xhtml+xml but choking when it gets what it asked for.
+	if (defined $cgi->http('HTTP_ACCEPT') &&
+	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
+	    $cgi->Accept('application/xhtml+xml') != 0) {
+		return 'application/xhtml+xml';
+	} else {
+		return 'text/html';
+	}
+}
+
 sub print_feed_meta {
 	if (defined $project) {
 		my %href_params = get_feed_info();
@@ -3738,24 +3752,91 @@ sub print_feed_meta {
 	}
 }
 
+sub print_header_links {
+	my %opts = @_;
+
+	# print out each stylesheet that exist, providing backwards capability
+	# for those people who defined $stylesheet in a config file
+	if (defined $stylesheet) {
+		print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
+	} else {
+		foreach my $stylesheet (@stylesheets) {
+			next unless $stylesheet;
+			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
+		}
+	}
+	if ($opts{'-feed'}) {
+		print_feed_meta();
+	}
+	if (defined $favicon) {
+		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
+	}
+}
+
+sub print_nav_breadcrumbs {
+	my %opts = @_;
+
+	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
+	if (defined $project) {
+		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
+		if (defined $action) {
+			my $action_print = $action ;
+			if (defined $opts{-action_extra}) {
+				$action_print = $cgi->a({-href => href(action=>$action)},
+					$action);
+			}
+			print " / $action_print";
+		}
+		if (defined $opts{-action_extra}) {
+			print " / $opts{-action_extra}";
+		}
+		print "\n";
+	}
+}
+
+sub print_search_form {
+	if (!defined $searchtext) {
+		$searchtext = "";
+	}
+	my $search_hash;
+	if (defined $hash_base) {
+		$search_hash = $hash_base;
+	} elsif (defined $hash) {
+		$search_hash = $hash;
+	} else {
+		$search_hash = "HEAD";
+	}
+	my $action = $my_uri;
+	my $use_pathinfo = gitweb_check_feature('pathinfo');
+	if ($use_pathinfo) {
+		$action .= "/".esc_url($project);
+	}
+	print $cgi->startform(-method => "get", -action => $action) .
+	      "<div class=\"search\">\n" .
+	      (!$use_pathinfo &&
+	      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
+	      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
+	      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
+	      $cgi->popup_menu(-name => 'st', -default => 'commit',
+	                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
+	      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
+	      " search:\n",
+	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+	      "<span title=\"Extended regular expression\">" .
+	      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
+	                     -checked => $search_use_regexp) .
+	      "</span>" .
+	      "</div>" .
+	      $cgi->end_form() . "\n";
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
 	my %opts = @_;
 
 	my $title = get_page_title();
-	my $content_type;
-	# require explicit support from the UA if we are to send the page as
-	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
-	# we have to do this because MSIE sometimes globs '*/*', pretending to
-	# support xhtml+xml but choking when it gets what it asked for.
-	if (defined $cgi->http('HTTP_ACCEPT') &&
-	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
-	    $cgi->Accept('application/xhtml+xml') != 0) {
-		$content_type = 'application/xhtml+xml';
-	} else {
-		$content_type = 'text/html';
-	}
+	my $content_type = get_content_type_html();
 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
 	                   -status=> $status, -expires => $expires)
 		unless ($opts{'-no_http_header'});
@@ -3777,22 +3858,7 @@ EOF
 	if ($ENV{'PATH_INFO'}) {
 		print "<base href=\"".esc_url($base_url)."\" />\n";
 	}
-	# print out each stylesheet that exist, providing backwards capability
-	# for those people who defined $stylesheet in a config file
-	if (defined $stylesheet) {
-		print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
-	} else {
-		foreach my $stylesheet (@stylesheets) {
-			next unless $stylesheet;
-			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
-		}
-	}
-	print_feed_meta()
-		if ($status eq '200 OK');
-	if (defined $favicon) {
-		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
-	}
-
+	print_header_links(-feed => $status eq '200 OK');
 	print "</head>\n" .
 	      "<body>\n";
 
@@ -3809,59 +3875,12 @@ EOF
 		                         -alt => "git",
 		                         -class => "logo"}));
 	}
-	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
-	if (defined $project) {
-		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
-		if (defined $action) {
-			my $action_print = $action ;
-			if (defined $opts{-action_extra}) {
-				$action_print = $cgi->a({-href => href(action=>$action)},
-					$action);
-			}
-			print " / $action_print";
-		}
-		if (defined $opts{-action_extra}) {
-			print " / $opts{-action_extra}";
-		}
-		print "\n";
-	}
+	print_nav_breadcrumbs(%opts);
 	print "</div>\n";
 
 	my $have_search = gitweb_check_feature('search');
 	if (defined $project && $have_search) {
-		if (!defined $searchtext) {
-			$searchtext = "";
-		}
-		my $search_hash;
-		if (defined $hash_base) {
-			$search_hash = $hash_base;
-		} elsif (defined $hash) {
-			$search_hash = $hash;
-		} else {
-			$search_hash = "HEAD";
-		}
-		my $action = $my_uri;
-		my $use_pathinfo = gitweb_check_feature('pathinfo');
-		if ($use_pathinfo) {
-			$action .= "/".esc_url($project);
-		}
-		print $cgi->startform(-method => "get", -action => $action) .
-		      "<div class=\"search\">\n" .
-		      (!$use_pathinfo &&
-		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
-		      $cgi->input({-name=>"a", -value=>"search", -type=>"hidden"}) . "\n" .
-		      $cgi->input({-name=>"h", -value=>$search_hash, -type=>"hidden"}) . "\n" .
-		      $cgi->popup_menu(-name => 'st', -default => 'commit',
-		                       -values => ['commit', 'grep', 'author', 'committer', 'pickaxe']) .
-		      $cgi->sup($cgi->a({-href => href(action=>"search_help")}, "?")) .
-		      " search:\n",
-		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
-		      "<span title=\"Extended regular expression\">" .
-		      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
-		                     -checked => $search_use_regexp) .
-		      "</span>" .
-		      "</div>" .
-		      $cgi->end_form() . "\n";
+		print_search_form();
 	}
 }
 
