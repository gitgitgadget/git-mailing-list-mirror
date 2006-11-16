X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Fuchs <asf@boinkor.net>
Subject: [PATCH] gitweb: Atom feeds (was: gitweb: Make RSS feed output prettier)
Date: Thu, 16 Nov 2006 22:45:25 +0100
Message-ID: <ejim5q$31b$1@sea.gmane.org>
References: <11635494363452-git-send-email-asf@boinkor.net> <ejdmlb$77s$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060008060503060201030705"
NNTP-Posting-Date: Thu, 16 Nov 2006 21:55:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 303
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: snark.boinkor.net
User-Agent: Thunderbird 1.5.0.8 (Macintosh/20061025)
In-Reply-To: <ejdmlb$77s$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31624>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkpCg-00087E-Bd for gcvg-git@gmane.org; Thu, 16 Nov
 2006 22:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424720AbWKPVzV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 16:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424722AbWKPVzV
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 16:55:21 -0500
Received: from main.gmane.org ([80.91.229.2]:35989 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1424720AbWKPVzU (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 16:55:20 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GkpCI-00083l-Ot for git@vger.kernel.org; Thu, 16 Nov 2006 22:55:02 +0100
Received: from snark.boinkor.net ([213.235.219.107]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 16 Nov 2006 22:55:02 +0100
Received: from asf by snark.boinkor.net with local (Gmexim 0.1 (Debian)) id
 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 16 Nov 2006 22:55:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008060503060201030705
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Jakub Narebski wrote:
> Andreas Fuchs <asf@boinkor.net> wrote:
> 
>> * Wrap the commit message in <pre>
> We use <div class="pre"> in "commit" view if I remember correctly.

That's ok for rendered HTML output, but in my experience, the way feed
readers interpret that ranges from "badly" to "not at all"; it's better
to stick to explicit structure hints only in feeds. /-:

So, this is the only thing I haven't fixed in the attached patch (:

>> * Make file names into an unordered list
> Good idea.
> 
>> * Add links (diff, conditional blame, history) to the file list.
> I'd rather keep RSS output as simple as possible, no frills.

I can see that, but it would be very useful on aggregation sites like
http://planet.sbcl.org/. You mentioned on IRC that you'd prefer to
forward-port the current RSS generation to a more modern feed format
like Atom 1.0.

I took the liberty to back out that change from the RSS generator, and
implement Atom 1.0 output that is more fully featured. For testing, I
left both in. Both feeds validate at feedvalidator.org for me, the
choice is yours (:

> esc_html does to_utf8, so to_utf8 is unnecessary (and spurious).
> But it is a good catch: esc_html is certainly needed.

The attached patch doesn't use to_utf8 on already-escaped strings anymore.

> We have introduced esc_path for escaping pathnames. Use it!

I changed that, too.

> Two unnecessary calls to git command. Use 
>      my %difftree = parse_difftree_raw_line($line)
> instead. The conditions would probably be 
>      next if (!$difftree{'from_id'});
> (or equivalent).

Thanks for the hint; I included that in the Atom output and re-worked
the RSS generator to not use the hideous regexp anymore.

> esc_url, not esc_html here. Or use the href() subroutine with -full=>1
> option (after applying the patch I send which added this to href()).

Okay; I changed all occurrences of esc_html where URLs are escaped to
use esc_url.

In addition to the above points, the attached patch emits a
Last-Changed: HTTP response header field, and doesn't compute the feed
body if the HTTP request type was HEAD. This helps keep the web server
load down for well-behaved feed readers that check if the feed needs
updating.

Hope you like it,
-- 
Andreas Fuchs, (http://|im:asf@|mailto:asf@)boinkor.net, antifuchs

--------------060008060503060201030705
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="atom-and-last-modified.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atom-and-last-modified.diff"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e54a29e..b39dc65 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -425,6 +425,7 @@ my %actions = (
 	"history" => \&git_history,
 	"log" => \&git_log,
 	"rss" => \&git_rss,
+        "atom" => \&git_atom,
 	"search" => \&git_search,
 	"search_help" => \&git_search_help,
 	"shortlog" => \&git_shortlog,
@@ -1180,7 +1181,9 @@ sub parse_date {
 	                   $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
 	$date{'mday-time'} = sprintf "%d %s %02d:%02d",
 	                     $mday, $months[$mon], $hour ,$min;
-
+        $date{'iso-8601'} = sprintf "%04d-%02d-%02dT%02d:%02d:%02dZ",
+	                   1900+$year, $mon, $mday, $hour ,$min, $sec;
+        
 	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
 	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
 	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
@@ -1653,6 +1656,9 @@ #provides backwards capability for those
 		printf('<link rel="alternate" title="%s log" '.
 		       'href="%s" type="application/rss+xml"/>'."\n",
 		       esc_param($project), href(action=>"rss"));
+                printf('<link rel="alternate" title="%s log" '.
+		       'href="%s" type="application/atom+xml"/>'."\n",
+		       esc_param($project), href(action=>"atom"));
 	} else {
 		printf('<link rel="alternate" title="%s projects list" '.
 		       'href="%s" type="text/plain; charset=utf-8"/>'."\n",
@@ -1724,6 +1730,8 @@ sub git_footer_html {
 		}
 		print $cgi->a({-href => href(action=>"rss"),
 		              -class => "rss_logo"}, "RSS") . "\n";
+		print $cgi->a({-href => href(action=>"atom"),
+		              -class => "rss_logo"}, "Atom") . "\n";
 	} else {
 		print $cgi->a({-href => href(project=>undef, action=>"opml"),
 		              -class => "rss_logo"}, "OPML") . " ";
@@ -4097,14 +4105,29 @@ sub git_rss {
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed");
-	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
+
+        my %latest_commit;
+        my %latest_date;
+        if (defined($revlist[0])) {
+                %latest_commit = parse_commit($revlist[0]);
+        	%latest_date = parse_date($latest_commit{'committer_epoch'});
+                print $cgi->header(-type => 'application/atom+xml', -charset => 'utf-8',
+        	                  -last_modified => $latest_date{'rfc2822'});
+        } else {
+		print $cgi->header(-type => 'application/atom+xml', -charset => 'utf-8');
+        }
+
+        # Optimization: skip generating the body if client asks only
+        # for Last-Modified date.
+        return if ($cgi->request_method() eq 'HEAD');
+
 	print <<XML;
 <?xml version="1.0" encoding="utf-8"?>
 <rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/">
 <channel>
-<title>$project $my_uri $my_url</title>
-<link>${\esc_html("$my_url?p=$project;a=summary")}</link>
-<description>$project log</description>
+<title>${\esc_html("$project $my_uri $my_url")}</title>
+<link>${\esc_url("$my_url?p=$project;a=summary")}</link>
+<description>${\esc_html($project)} log</description>
 <language>en</language>
 XML
 
@@ -4128,32 +4151,138 @@ XML
 		      "</title>\n" .
 		      "<author>" . esc_html($co{'author'}) . "</author>\n" .
 		      "<pubDate>$cd{'rfc2822'}</pubDate>\n" .
-		      "<guid isPermaLink=\"true\">" . esc_html("$my_url?p=$project;a=commit;h=$commit") . "</guid>\n" .
-		      "<link>" . esc_html("$my_url?p=$project;a=commit;h=$commit") . "</link>\n" .
+		      "<guid isPermaLink=\"true\">" . esc_url("$my_url?p=$project;a=commit;h=$commit") . "</guid>\n" .
+		      "<link>" . esc_url("$my_url?p=$project;a=commit;h=$commit") . "</link>\n" .
 		      "<description>" . esc_html($co{'title'}) . "</description>\n" .
 		      "<content:encoded>" .
 		      "<![CDATA[\n";
 		my $comment = $co{'comment'};
+		print "<pre>\n";
 		foreach my $line (@$comment) {
-			$line = to_utf8($line);
-			print "$line<br/>\n";
+			$line = esc_html($line);
+			print "$line\n";
 		}
-		print "<br/>\n";
+		print "</pre><ul>\n";
 		foreach my $line (@difftree) {
-			if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
-				next;
-			}
-			my $file = esc_path(unquote($7));
-			$file = to_utf8($file);
-			print "$file<br/>\n";
+			my %difftree = parse_difftree_raw_line($line);
+			next if !$difftree{'from_id'};
+                        
+			my $file_name = $difftree{'file'};
+			my $file = esc_path($file_name);
+
+			print "<li>$file</li>\n";
 		}
-		print "]]>\n" .
+		print "</ul>]]>\n" .
 		      "</content:encoded>\n" .
 		      "</item>\n";
 	}
 	print "</channel></rss>";
 }
 
+sub git_atom {
+	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=150",
+		git_get_head_hash($project), "--"
+		or die_error(undef, "Open git-rev-list failed");
+	my @revlist = map { chomp; $_ } <$fd>;
+	close $fd or die_error(undef, "Reading git-rev-list failed");
+
+        my %latest_commit;
+        my %latest_date;
+        if (defined($revlist[0])) {
+                %latest_commit = parse_commit($revlist[0]);
+        	%latest_date = parse_date($latest_commit{'committer_epoch'});
+                print $cgi->header(-type => 'application/atom+xml', -charset => 'utf-8',
+        	                  -last_modified => $latest_date{'rfc2822'});
+        } else {
+		print $cgi->header(-type => 'application/atom+xml', -charset => 'utf-8');
+        }
+
+        # Optimization: skip generating the body if client asks only
+        # for Last-Modified date.
+        return if ($cgi->request_method() eq 'HEAD');
+        
+	print <<XML;
+<?xml version="1.0" encoding="utf-8"?>
+<feed xmlns="http://www.w3.org/2005/Atom">
+<title type="html">${\esc_html("$project $my_uri $my_url")}</title>
+<link rel="alternate" type="text/html" href="${\esc_url("$my_url?p=$project;a=summary")}" />
+<link rel="self" type="application/atom+xml" href="${\esc_url("$my_url?p=$project;a=atom")}" />
+<subtitle>$project log</subtitle>
+<id>${\esc_url("$my_url?p=$project")}</id>
+XML
+        if (!defined(%latest_date)) {
+        	# dummy date to keep the feed valid until commits trickle in:
+	        print "<updated>1970-01-01T00:00:00Z</updated>";  
+        } else {
+                print "<updated>".$latest_date{'iso-8601'}."</updated>\n";
+        }
+        
+	for (my $i = 0; $i <= $#revlist; $i++) {
+		my $commit = $revlist[$i];
+		my %co = parse_commit($commit);
+		# we read 150, we always show 30 and the ones more recent than 48 hours
+		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
+			last;
+		}
+		my %cd = parse_date($co{'committer_epoch'});
+
+		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+			$co{'parent'}, $co{'id'}, "--"
+			or next;
+		my @difftree = map { chomp; $_ } <$fd>;
+		close $fd
+			or next;
+		print "<entry>\n" .
+		      "<title type=\"html\">" .
+		      esc_html($co{'author_name'}) . ": " . esc_html($co{'title'}) .
+		      "</title>\n" .
+                      "<updated>$cd{'iso-8601'}</updated>\n" .
+		      "<author><name>" . esc_html($co{'author_name'}) . "</name></author>\n" .
+		      "<published>$cd{'iso-8601'}</published>\n" .
+		      "<link rel=\"alternate\" type=\"text/html\" href=\"" .
+                        esc_url("$my_url?p=$project;a=commit;h=$commit") . "\" />\n" .
+		      "<id>" . esc_url("$my_url?p=$project;a=commit;h=$co{'id'}") . "</id>\n" .
+		      "<content type=\"html\" xml:base=\"".esc_url($my_url)."\">" .
+		      "<![CDATA[\n";
+		my $comment = $co{'comment'};
+		print "<pre>\n";
+		foreach my $line (@$comment) {
+			$line = to_utf8(esc_html($line));
+			print "$line\n";
+		}
+		print "</pre><ul>\n";
+		foreach my $line (@difftree) {
+                        my %difftree = parse_difftree_raw_line($line);
+			next if !$difftree{'from_id'};
+                        
+			my $file_name = $difftree{'file'};
+			my $file = esc_path($file_name);
+			my $parent = $co{'parent'};
+			my $hash = $difftree{'to_id'};
+			my $hashparent = $difftree{'from_id'};
+
+                        print "<li>[";
+			print "<a title=\"diff\" href=\"".
+                              esc_url("$my_url?p=$project;a=blobdiff;f=$file;h=$hash;hp=$hashparent;hb=$commit;hpb=$parent") .
+                              "\">D</a>";
+			if (gitweb_check_feature('blame')) {
+                        	print "<a title=\"blame\" href=\"".
+                                      esc_url("$my_url?p=$project;a=blame;f=$file;hb=$commit") .
+                                      "\">B</a>";
+                        }
+			print "<a title=\"history\" href=\"".
+                              esc_url("?p=$project;a=history;f=$file;h=$commit") .
+                              "\">H</a>";
+			print "] $file";
+			print "</li>\n";
+		}
+		print "</ul>]]>\n" .
+		      "</content>\n" .
+		      "</entry>\n";
+	}
+	print "</feed>";
+}
+
 sub git_opml {
 	my @list = git_get_projects_list();
 

--------------060008060503060201030705--
