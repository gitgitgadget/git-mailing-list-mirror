From: Erik van Konijnenburg <ekonijn@xs4all.nl>
Subject: [PATCH] opml output for gitweb
Date: Tue, 14 Jun 2005 00:53:47 +0200
Message-ID: <20050614005347.A851@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dhxo7-0004Dl-MK
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 00:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVFMW5T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 18:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVFMW4e
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 18:56:34 -0400
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:61964 "EHLO
	smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S261594AbVFMWxt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 18:53:49 -0400
Received: from banaan.xs4all.nl (banaan.xs4all.nl [80.126.2.237])
	by smtp-vbr5.xs4all.nl (8.13.3/8.13.3) with ESMTP id j5DMrmxL067425;
	Tue, 14 Jun 2005 00:53:48 +0200 (CEST)
	(envelope-from konijn@banaan.xs4all.nl)
Received: (from konijn@localhost)
	by banaan.xs4all.nl (8.11.6/8.11.6) id j5DMrmH00890;
	Tue, 14 Jun 2005 00:53:48 +0200
To: Kay Sievers <kay.sievers@vrfy.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Gitweb currently has a nice orange thingy at the footer of
every page, except for the title page.

The attached patch addresses that lacuna with an OPML link,
a file format to import and export RSS collections from
feed readers.  Using this link, you can subscribe to all
RSS feeds on a git site in one go.

The patch was prepared against ftp://ehlo.org/gitweb2.cgi
and manually edited to undo localisation to my test tree.
It's only lightly tested: exporting a feed collection from
gitweb and importing it in Sage and liferea seems to work.

Regards,
Erik

Signed-off-by: Erik van Konijnenburg <ekonijn@xs4all.nl>

--- /home/konijn/gitweb2.cgi	2005-06-13 21:58:39.000000000 +0200
+++ gitweb.cgi	2005-06-14 00:31:24.000000000 +0200
@@ -50,6 +50,9 @@
 	if ($action eq "git-logo.png") {
 		git_logo();
 		exit;
+	} elsif ($action eq "opml") {
+		git_opml();
+		exit;
 	}
 } else {
 	$action = "summary";
@@ -243,7 +246,8 @@
 div.diff_info { font-family:monospace; color:#000099; background-color:#edece6; font-style:italic; }
 div.index_include { border:solid #d9d8d1; border-width:0px 0px 1px; padding:12px 8px; }
 div.search { margin:4px 8px; position:absolute; top:56px; right:12px }
-a.rss_logo { float:right; padding:3px 0px; width:35px; line-height:10px;
+a.rss_logo {
+	float:right; padding:3px 0px; width:35px; line-height:10px;
 	border:1px solid; border-color:#fcc7a5 #7d3302 #3e1a01 #ff954e;
 	color:#ffffff; background-color:#ff6600;
 	font-weight:bold; font-family:sans-serif; font-size:10px;
@@ -289,6 +293,9 @@
 		}
 		print $cgi->a({-href => "$my_uri?p=$project;a=rss", -class => "rss_logo"}, "RSS") . "\n";
 	}
+	else {
+		print $cgi->a({-href => "$my_uri?a=opml", -class => "rss_logo"}, "OPML") . "\n";
+	}
 	print "</div>\n" .
 	      "</body>\n" .
 	      "</html>";
@@ -1197,6 +1204,83 @@
 	git_footer_html();
 }
 
+sub git_opml {
+	my @list;
+	if (-d $projects_list) {
+		# search in directory
+		my $dir = $projects_list;
+		opendir my $dh, $dir or return undef;
+		while (my $dir = readdir($dh)) {
+			if (-e "$projectroot/$dir/HEAD") {
+				my $pr = {
+					path => $dir,
+				};
+				push @list, $pr
+			}
+		}
+		closedir($dh);
+	} elsif (-f $projects_list) {
+		# read from file(url-encoded):
+		# 'git%2Fgit.git Linus+Torvalds'
+		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
+		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
+		open my $fd , $projects_list or return undef;
+		while (my $line = <$fd>) {
+			chomp $line;
+			my ($path, $owner) = split ' ', $line;
+			$path = unescape($path);
+			$owner = unescape($owner);
+			if (!defined $path) {
+				next;
+			}
+			if (-e "$projectroot/$path/HEAD") {
+				my $pr = {
+					path => $path,
+					owner => $owner,
+				};
+				push @list, $pr
+			}
+		}
+		close $fd;
+	}
+
+	if (!@list) {
+		die_error(undef, "No project found.");
+	}
+	@list = sort {$a->{'path'} cmp $b->{'path'}} @list;
+
+
+	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
+	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
+	      "<opml version=\"1.0\">\n".
+	      "<head>".
+	      "  <title>Git OPML Export</title>\n".
+	      "</head>\n".
+	      "<body>\n".
+	      "  <outline text=\"Git RSS Feeds\">\n";
+
+	foreach my $pr (@list) {
+		my %proj = %$pr;
+		my $head = git_read_hash("$proj{'path'}/HEAD");
+		if (!defined $head) {
+			next;
+		}
+		$ENV{'GIT_OBJECT_DIRECTORY'} = "$projectroot/$proj{'path'}/objects";
+		my %co = git_read_commit($head);
+		if (!%co) {
+			next;
+		}
+
+		my $path = escapeHTML(chop_str($proj{'path'}, 25, 5));
+		my $rss =  "$my_url?p=$proj{'path'};a=rss";
+		my $html =  "$my_url?p=$proj{'path'};a=log";
+		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
+	}
+	print "  </outline>\n".
+	      "</body>\n".
+	      "</opml>\n";
+}
+
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
 	open my $fd, "-|", "$gitbin/git-rev-list --max-count=20 " . git_read_hash("$project/HEAD") or die_error(undef, "Open failed.");
