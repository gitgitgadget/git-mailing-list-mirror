From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2] gitweb: Refactor git_header_html
Date: Wed, 22 Jun 2011 13:50:46 +0200
Message-ID: <201106221350.47314.jnareb@gmail.com>
References: <20110621183550.9315.21922.stgit@localhost.localdomain> <7v4o3i7nkt.fsf@alter.siamese.dyndns.org> <201106220844.35431.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 13:51:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZLxq-0005Lo-6P
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 13:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab1FVLvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 07:51:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41506 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377Ab1FVLvI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 07:51:08 -0400
Received: by fxm17 with SMTP id 17so571031fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=AWtOBkDPJSI+9Ikb3c9UaZkQNO/P3f/6isxMSGMyATc=;
        b=Sm1mr/K41jnm4cDa2Xw8oibLjYC/imkJWqEAra1aZTv/CAV6BMmwtQoayX6FQ8/6Uf
         t0k4IVnm5toI8INpFMCAADJoaXdlTExHrAQYQVFgt333GAa608yjdA72frp/7rj8Z6xQ
         +50nHXxOKo8YaFdoZDvKZuXNhGQ2xBCuizcDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dEcV40ChYmlfW0rpeU13b8n6pKXkCEXRYmU1CNzUfZbk+hpcO4a7FTulKDTxyBgdG3
         SxCfZa6zdc1/BXHkIH8zdxCi23AppaWeNQd6ddZestMYr/ITnQ04Ao9RSz94XpU31wDz
         UOp0HYYkWsYlc2U7n19KNoYfvyorG/3hHzLUM=
Received: by 10.223.21.140 with SMTP id j12mr753350fab.47.1308743457901;
        Wed, 22 Jun 2011 04:50:57 -0700 (PDT)
Received: from [192.168.1.15] (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id q21sm281245fan.16.2011.06.22.04.50.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 04:50:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201106220844.35431.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176236>

Extract (factor out) the following parts into separate subroutines:
* finding correct MIME content type for HTML pages (text/html or
  application/xhtml+xml?) into get_content_type_html()
* printing <link ...> elements in HTML head into print_header_links()
* printing navigation "breadcrumbs" for given action into
  print_nav_breadcrumbs()
* printing search form into print_search_form()

This reduces git_header_html to two pages long (53 lines), making
gitweb code easier to read.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:

> Hmmm... perhaps then I should have gone with my first thought, namely
> passing $status to print_header_links().  
> 
> Will resend.

And here it is...

Interdiff:
~~~~~~~~~~

  diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
  index c9e6426..0221eb9 100755
  --- a/gitweb/gitweb.perl
  +++ b/gitweb/gitweb.perl
  @@ -3753,7 +3753,7 @@ sub print_feed_meta {
   }
   
   sub print_header_links {
  -	my %opts = @_;
  +	my $status = shift;
   
   	# print out each stylesheet that exist, providing backwards capability
   	# for those people who defined $stylesheet in a config file
  @@ -3765,9 +3765,8 @@ sub print_header_links {
   			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
   		}
   	}
  -	if ($opts{'-feed'}) {
  -		print_feed_meta();
  -	}
  +	print_feed_meta()
  +		if ($status eq '200 OK');
   	if (defined $favicon) {
   		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
   	}
  @@ -3858,7 +3857,7 @@ EOF
   	if ($ENV{'PATH_INFO'}) {
   		print "<base href=\"".esc_url($base_url)."\" />\n";
   	}
  -	print_header_links(-feed => $status eq '200 OK');
  +	print_header_links($status);
   	print "</head>\n" .
   	      "<body>\n";
   


 gitweb/gitweb.perl |  172 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 95 insertions(+), 77 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f13b4b5..0221eb9 100755
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
@@ -3738,24 +3752,90 @@ sub print_feed_meta {
 	}
 }
 
+sub print_header_links {
+	my $status = shift;
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
+	print_feed_meta()
+		if ($status eq '200 OK');
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
@@ -3777,22 +3857,7 @@ EOF
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
+	print_header_links($status);
 	print "</head>\n" .
 	      "<body>\n";
 
@@ -3809,59 +3874,12 @@ EOF
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
 
-- 
1.7.5
