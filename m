From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Use feed link according to current view
Date: Mon, 31 Mar 2008 13:36:47 +0100
Message-ID: <200803311436.48745.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Jean-Baptiste Quenot" <jbq@caraldi.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 31 14:37:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgJGq-0005fD-37
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 14:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634AbYCaMhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 08:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754645AbYCaMhF
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 08:37:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:12180 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768AbYCaMhD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 08:37:03 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1863137fgb.17
        for <git@vger.kernel.org>; Mon, 31 Mar 2008 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=J68GVBnsUnLFFvr8l1c+dsHKkjo14uYJf4VX2IzyWvU=;
        b=eK6CM/GsHbHL+q6WZ13DkDf0E/b36jQjYSg8Ch1ryDZWs+LKB8zs1GmBbQBsnXPDgheTTbBAODbnykn5cC25+pmHO0OOIvAwsqs1PAaI6ZleeDLGaI9HgsKwLynzalweSNrnPXApch2EeQGcbogJyWPcQyi4j8YckcKVxrVm/ME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=c18ISh2G+9LTj7PB/7+soywr/8IBjYwEroZQkvkmWoVvm2B7WA1jV2drKyLgwBb+BqwZyAoEV22ZiOZoqwY5VSl01KXFVUhg2ucmVHrYy9UHL4tCyh+x7DxqMAOO5Tie9GcCkmiTWESyA38b41ZXtuVeUDwxq9F9y/5tAxknUkU=
Received: by 10.82.180.10 with SMTP id c10mr15572992buf.9.1206967013522;
        Mon, 31 Mar 2008 05:36:53 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.204.152])
        by mx.google.com with ESMTPS id x6sm8955022gvf.0.2008.03.31.05.36.50
        (version=SSLv3 cipher=OTHER);
        Mon, 31 Mar 2008 05:36:51 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78584>

Michael G. Noll said in comments to the "Switching my code repository
from Subversion (SVN) to git" article (http://tinyurl.com/37v67l) in
his "My digital moleskine" blog, that one of the things he is missing
in gitweb from SVN::Web is an RSS feed with news/information of the
current view (including RSS feed for single file or directory).

This is not exactly true, as since refactoring feed generation in
  "gitweb: Refactor feed generation, make output prettier, add Atom feed"
  commit-af6feeb229110a0fa77a179c2655fca08e72f879
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
to discriminate between tags and heads) it is used in feed URLs; if
$file_name ('f') is defined it is used in feed URLs.  Feed title is
set according to the kind of web feed: it is either 'log' for generic
feed, 'log of <branch>', 'history of <filename>' for generic history
(using implicit or explicit HEAD, i.e. current branch) or 'history of
<filename> on <branch>'.

There are special cases: 'heads' and 'forks' views should use OPML
providing list of available feeds; 'tags' probably also should use
OPML; there is no web feed equivalent to 'search' view.  Currently all
those cases fallback to (show) default feed.

Currently feed can have but one starting point, and does not support
negative (exclude) commit arguments.  Therefore for now for *diff
views it is chosen that feed follow the "to" part: to-name, to-commit
for 'blobdiff', 'treediff' and 'commitdiff' views.


Generating parameters for href() for feed link was separated
(refactored) into get_feed_info() subroutine.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Bcc: Michael G. Noll

The naming of a feeds (feed titles) could use some improvements,
but I've no good idea how.


 gitweb/gitweb.perl |  110 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 88 insertions(+), 22 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ec73cb1..50922bc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -587,7 +587,7 @@ exit;
 ## ======================================================================
 ## action links
 
-sub href(%) {
+sub href (%) {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
 	my $href = $params{-full} ? $my_url : $my_uri;
@@ -1443,6 +1443,46 @@ sub format_snapshot_links {
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
 
@@ -2506,30 +2546,49 @@ EOF
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
@@ -2603,10 +2662,17 @@ sub git_footer_html {
 		if (defined $descr) {
 			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
 		}
-		print $cgi->a({-href => href(action=>"rss"),
-		              -class => "rss_logo"}, "RSS") . " ";
-		print $cgi->a({-href => href(action=>"atom"),
-		              -class => "rss_logo"}, "Atom") . "\n";
+
+		my %href_params = get_feed_info();
+		$href_params{'-title'} ||= 'log';
+
+		foreach my $format qw(RSS Atom) {
+			$href_params{'action'} = lc($format);
+			print $cgi->a({-href => href(%href_params),
+			              -title => "$href_params{'-title'} $format feed",
+			              -class => "rss_logo"}, $format)."\n";
+		}
+
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
 		              -class => "rss_logo"}, "OPML") . " ";
-- 
1.5.4.4
