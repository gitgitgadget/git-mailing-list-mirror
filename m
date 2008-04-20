From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (resend)] gitweb: Use feed link according to current view
Date: Sun, 20 Apr 2008 22:09:48 +0200
Message-ID: <200804202209.49980.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Jean-Baptiste Quenot" <jbq@caraldi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 22:10:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnfs4-0006A7-WB
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 22:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbYDTUJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756359AbYDTUJ6
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 16:09:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:20045 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755496AbYDTUJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 16:09:56 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1490403fgb.17
        for <git@vger.kernel.org>; Sun, 20 Apr 2008 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2/zBWeZeTJQTISoDX1SldlWSqAiLuwgGsvbgukCNaA8=;
        b=VANb28ZyNvpjJXaRpC4TRkpSRVWmJiHbzMF3sM0ofHSMvArwvNObLYFPdSvi2xrnMR47pCkdSEJzgBZHONREKskcSviywj4KSNpoM5sHNbeJjY5vm0rYsgFyABqHcAsVa4WAeelJzL/g+xulAhfkWRqpbhhgEK0NTmqzLN0/RAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ua3e/2wyEwMN/51dMH7QKLT7wzwm3gbz3zM8loTRse+UJfRtcpci8smV5tQzZz/X3eSsBC+aj/8ZOcxwPyjJebhDE5xARYutHSEI1FB16ud2BdiZl5aLCl1N4YMuxL9g84vdZJk70bKhk/6j4AO+fzUoUW1qTD6AddEG2SUz+3I=
Received: by 10.86.96.18 with SMTP id t18mr11323650fgb.13.1208722194858;
        Sun, 20 Apr 2008 13:09:54 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.60])
        by mx.google.com with ESMTPS id d13sm4166750fka.7.2008.04.20.13.09.50
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Apr 2008 13:09:52 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79983>

Michael G. Noll said in comments to the "Switching my code repository
from Subversion (SVN) to git" article (http://tinyurl.com/37v67l) in
his "My digital moleskine" blog, that one of the things he is missing
in gitweb from SVN::Web is an RSS feed with news/information of the
current view (including RSS feed for single file or directory).

This is not exactly true, as since refactoring feed generation in
commit-af6feeb229110a0fa77a179c2655fca08e72f879
  "gitweb: Refactor feed generation, make output prettier, add Atom feed"
gitweb can generate feeds (RSS or Atom) for history of a given branch,
history limited to a given directory, or history of a given file.
Nevertheless this required handcrafting the URL to get wanted RSS
feed.


This commit makes gitweb select feed links in the HTML header and in
page footer depending on current view (action).  It is more elaborate,
and I guess more correct, than simple patch adding $hash ('h')
parameter to *all* URLs, including feed links, by Jean-Baptiste Quenot
  Subject: [PATCH] gitweb: Add hash parameter in feed URL when a hash
           is specified in the current request
  Message-ID: <ae63f8b50803211138y6355fd11pa64cda50a1f53011@mail.gmail.com>

If $hash ('h') or $hash_base ('hb') parameter is a branch name
(i.e. it starts with 'refs/heads/'; all generated URLs use this form
to discriminate between tags and heads), it is used in feed URLs; if
$file_name ('f') is defined, it is used in feed URLs.  Feed title is
set according to the kind of web feed: it is either 'log' for generic
feed, 'log of <branch>', 'history of <filename>' for generic history
(using implicit or explicit HEAD, i.e. current branch) or 'history of
<filename> on <branch>'.

There are special cases: 'heads' and 'forks' views should use OPML
providing list of available feeds; 'tags' probably also should use
OPML; there is no web feed equivalent to 'search' view.  Currently all
those cases fallback to (show) default feed.  Such feed link uses
"generic" class, and is shown in slightly lighter color for
distinction.

Currently feed can have but one starting point, and does not support
negative (exclude) commit arguments.  Therefore for now for *diff
views it is chosen that feed follow the "to" part: to-name, to-commit
for 'blobdiff', 'treediff' and 'commitdiff' views.


Generating parameters for href() for feed link was separated
(refactored) into get_feed_info() subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is resend of earlier patch after 1.5.5 is out.

The only difference is that 'generic' links to feeds in footer are
shown in slightly lighter color, to better distinguish situation
when they refer to alternate version of the page, and when they refer
to generic feed for given project.

Comments?


 gitweb/gitweb.css  |    8 +++
 gitweb/gitweb.perl |  121 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 104 insertions(+), 25 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 446a1c3..aa0eeca 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -464,6 +464,14 @@ a.rss_logo:hover {
 	background-color: #ee5500;
 }
 
+a.rss_logo.generic {
+	background-color: #ff8800;
+}
+
+a.rss_logo.generic:hover {
+	background-color: #ee7700;
+}
+
 span.refs span {
 	padding: 0px 4px;
 	font-size: 70%;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a48bebb..0b2d9e0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -592,7 +592,7 @@ exit;
 ## ======================================================================
 ## action links
 
-sub href(%) {
+sub href (%) {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
 	my $href = $params{-full} ? $my_url : $my_uri;
@@ -1448,6 +1448,46 @@ sub format_snapshot_links {
 	}
 }
 
+## ......................................................................
+## functions returning values to be passed, perhaps after some
+## transformation, to other functions; e.g. returning arguments to href()
+
+# returns hash to be passed to href to generate gitweb URL
+# in -title key it returns description of link
+sub get_feed_info {
+	my $format = shift || 'Atom';
+	my %res = (action => lc($format));
+
+	# feed links are possible only for project views
+	return unless (defined $project);
+	# some views should link to OPML, or to generic project feed,
+	# or don't have specific feed yet (so they should use generic)
+	return if ($action =~ /^(?:tags|heads|forks|tag|search)$/x);
+
+	my $branch;
+	# branches refs uses 'refs/heads/' prefix (fullname) to differentiate
+	# from tag links; this also makes possible to detect branch links
+	if ((defined $hash_base && $hash_base =~ m!^refs/heads/(.*)$!) ||
+	    (defined $hash      && $hash      =~ m!^refs/heads/(.*)$!)) {
+		$branch = $1;
+	}
+	# find log type for feed description (title)
+	my $type = 'log';
+	if (defined $file_name) {
+		$type  = "history of $file_name";
+		$type .= "/" if ($action eq 'tree');
+		$type .= " on '$branch'" if (defined $branch);
+	} else {
+		$type = "log of $branch" if (defined $branch);
+	}
+
+	$res{-title} = $type;
+	$res{'hash'} = (defined $branch ? "refs/heads/$branch" : undef);
+	$res{'file_name'} = $file_name;
+
+	return %res;
+}
+
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -2510,30 +2550,49 @@ EOF
 		}
 	}
 	if (defined $project) {
-		printf('<link rel="alternate" title="%s log RSS feed" '.
-		       'href="%s" type="application/rss+xml" />'."\n",
-		       esc_param($project), href(action=>"rss"));
-		printf('<link rel="alternate" title="%s log RSS feed (no merges)" '.
-		       'href="%s" type="application/rss+xml" />'."\n",
-		       esc_param($project), href(action=>"rss",
-		                                 extra_options=>"--no-merges"));
-		printf('<link rel="alternate" title="%s log Atom feed" '.
-		       'href="%s" type="application/atom+xml" />'."\n",
-		       esc_param($project), href(action=>"atom"));
-		printf('<link rel="alternate" title="%s log Atom feed (no merges)" '.
-		       'href="%s" type="application/atom+xml" />'."\n",
-		       esc_param($project), href(action=>"atom",
-		                                 extra_options=>"--no-merges"));
+		my %href_params = get_feed_info();
+		if (!exists $href_params{'-title'}) {
+			$href_params{'-title'} = 'log';
+		}
+
+		foreach my $format qw(RSS Atom) {
+			my $type = lc($format);
+			my %link_attr = (
+				'-rel' => 'alternate',
+				'-title' => "$project - $href_params{'-title'} - $format feed",
+				'-type' => "application/$type+xml"
+			);
+
+			$href_params{'action'} = $type;
+			$link_attr{'-href'} = href(%href_params);
+			print "<link ".
+			      "rel=\"$link_attr{'-rel'}\" ".
+			      "title=\"$link_attr{'-title'}\" ".
+			      "href=\"$link_attr{'-href'}\" ".
+			      "type=\"$link_attr{'-type'}\" ".
+			      "/>\n";
+
+			$href_params{'extra_options'} = '--no-merges';
+			$link_attr{'-href'} = href(%href_params);
+			$link_attr{'-title'} .= ' (no merges)';
+			print "<link ".
+			      "rel=\"$link_attr{'-rel'}\" ".
+			      "title=\"$link_attr{'-title'}\" ".
+			      "href=\"$link_attr{'-href'}\" ".
+			      "type=\"$link_attr{'-type'}\" ".
+			      "/>\n";
+		}
+
 	} else {
 		printf('<link rel="alternate" title="%s projects list" '.
-		       'href="%s" type="text/plain; charset=utf-8"/>'."\n",
+		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
 		       $site_name, href(project=>undef, action=>"project_index"));
 		printf('<link rel="alternate" title="%s projects feeds" '.
-		       'href="%s" type="text/x-opml"/>'."\n",
+		       'href="%s" type="text/x-opml" />'."\n",
 		       $site_name, href(project=>undef, action=>"opml"));
 	}
 	if (defined $favicon) {
-		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
+		print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
 	}
 
 	print "</head>\n" .
@@ -2601,23 +2660,35 @@ EOF
 }
 
 sub git_footer_html {
+	my $feed_class = 'rss_logo';
+
 	print "<div class=\"page_footer\">\n";
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
 		if (defined $descr) {
 			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
 		}
-		print $cgi->a({-href => href(action=>"rss"),
-		              -class => "rss_logo"}, "RSS") . " ";
-		print $cgi->a({-href => href(action=>"atom"),
-		              -class => "rss_logo"}, "Atom") . "\n";
+
+		my %href_params = get_feed_info();
+		if (!%href_params) {
+			$feed_class .= ' generic';
+		}
+		$href_params{'-title'} ||= 'log';
+
+		foreach my $format qw(RSS Atom) {
+			$href_params{'action'} = lc($format);
+			print $cgi->a({-href => href(%href_params),
+			              -title => "$href_params{'-title'} $format feed",
+			              -class => $feed_class}, $format)."\n";
+		}
+
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
-		              -class => "rss_logo"}, "OPML") . " ";
+		              -class => $feed_class}, "OPML") . " ";
 		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
-		              -class => "rss_logo"}, "TXT") . "\n";
+		              -class => $feed_class}, "TXT") . "\n";
 	}
-	print "</div>\n" ;
+	print "</div>\n"; # class="page_footer"
 
 	if (-f $site_footer) {
 		open (my $fd, $site_footer);
-- 
1.5.5
