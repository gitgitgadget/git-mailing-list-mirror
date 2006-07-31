From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 20 (amend)] gitweb: Reordering code and dividing it into categories
Date: Mon, 31 Jul 2006 21:22:15 +0200
Message-ID: <200607312122.16767.jnareb@gmail.com>
References: <200607292239.11034.jnareb@gmail.com> <200607312048.44075.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jul 31 21:22:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7dLN-0003ZH-5m
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 21:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWGaTWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 15:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWGaTWM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 15:22:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:22409 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030341AbWGaTWG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 15:22:06 -0400
Received: by ug-out-1314.google.com with SMTP id m3so947362ugc
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 12:22:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ibZiBpsyaIZrrh3Q2pBzWLfaM5hgNRozBMhoXQJtlDMMjIim12qNXSUrCA8swSbejmUZO117gFH4Ont2p9albMpOH8rg/7f8umrtg+UnwlQTH9/A60ohBi65rV9FZ4kdkM7bVuIsw4AsrkHmf1GrjO0UvJ6jaHomVkphNOB7nXY=
Received: by 10.66.249.11 with SMTP id w11mr2933189ugh;
        Mon, 31 Jul 2006 12:22:04 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id y7sm4620842ugc.2006.07.31.12.22.02;
        Mon, 31 Jul 2006 12:22:03 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200607312048.44075.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24541>

Reorder gitweb code around, divide it into sections (categories) and
add some comments.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.cgi | 1616 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 840 insertions(+), 776 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index cb6af39..c1ee79e 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -160,21 +160,7 @@ if (defined $searchtext) {
 	$searchtext = quotemeta $searchtext;
 }
 
-sub validate_input {
-	my $input = shift;
-
-	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
-		return $input;
-	}
-	if ($input =~ m/(^|\/)(|\.|\.\.)($|\/)/) {
-		return undef;
-	}
-	if ($input =~ m/[^a-zA-Z0-9_\x80-\xff\ \t\.\/\-\+\#\~\%]/) {
-		return undef;
-	}
-	return $input;
-}
-
+# dispatch
 if (!defined $action || $action eq "summary") {
 	git_summary();
 	exit;
@@ -235,6 +221,24 @@ if (!defined $action || $action eq "summ
 	exit;
 }
 
+## ======================================================================
+## validation, quoting/unquoting and escaping
+
+sub validate_input {
+	my $input = shift;
+
+	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
+		return $input;
+	}
+	if ($input =~ m/(^|\/)(|\.|\.\.)($|\/)/) {
+		return undef;
+	}
+	if ($input =~ m/[^a-zA-Z0-9_\x80-\xff\ \t\.\/\-\+\#\~\%]/) {
+		return undef;
+	}
+	return $input;
+}
+
 # quote unsafe chars, but keep the slash, even when it's not
 # correct, but quoted slashes look too horrible in bookmarks
 sub esc_param {
@@ -264,6 +268,29 @@ sub unquote {
 	return $str;
 }
 
+## ----------------------------------------------------------------------
+## HTML aware string manipulation
+
+sub chop_str {
+	my $str = shift;
+	my $len = shift;
+	my $add_len = shift || 10;
+
+	# allow only $len chars, but don't cut a word if it would fit in $add_len
+	# if it doesn't fit, cut it if it's still longer than the dots we would add
+	$str =~ m/^(.{0,$len}[^ \/\-_:\.@]{0,$add_len})(.*)/;
+	my $body = $1;
+	my $tail = $2;
+	if (length($tail) > 4) {
+		$tail = " ...";
+		$body =~ s/&[^;]*$//; # remove chopped character entities
+	}
+	return "$body$tail";
+}
+
+## ----------------------------------------------------------------------
+## functions returning short strings
+
 # CSS class for given age value (in seconds)
 sub age_class {
 	my $age = shift;
@@ -277,202 +304,108 @@ sub age_class {
 	}
 }
 
-sub git_header_html {
-	my $status = shift || "200 OK";
-	my $expires = shift;
+# convert age in seconds to "nn units ago" string
+sub age_string {
+	my $age = shift;
+	my $age_str;
 
-	my $title = "$site_name git";
-	if (defined $project) {
-		$title .= " - $project";
-		if (defined $action) {
-			$title .= "/$action";
-			if (defined $file_name) {
-				$title .= " - $file_name";
-				if ($action eq "tree" && $file_name !~ m|/$|) {
-					$title .= "/";
-				}
-			}
-		}
-	}
-	my $content_type;
-	# require explicit support from the UA if we are to send the page as
-	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
-	# we have to do this because MSIE sometimes globs '*/*', pretending to
-	# support xhtml+xml but choking when it gets what it asked for.
-	if ($cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ && $cgi->Accept('application/xhtml+xml') != 0) {
-		$content_type = 'application/xhtml+xml';
+	if ($age > 60*60*24*365*2) {
+		$age_str = (int $age/60/60/24/365);
+		$age_str .= " years ago";
+	} elsif ($age > 60*60*24*(365/12)*2) {
+		$age_str = int $age/60/60/24/(365/12);
+		$age_str .= " months ago";
+	} elsif ($age > 60*60*24*7*2) {
+		$age_str = int $age/60/60/24/7;
+		$age_str .= " weeks ago";
+	} elsif ($age > 60*60*24*2) {
+		$age_str = int $age/60/60/24;
+		$age_str .= " days ago";
+	} elsif ($age > 60*60*2) {
+		$age_str = int $age/60/60;
+		$age_str .= " hours ago";
+	} elsif ($age > 60*2) {
+		$age_str = int $age/60;
+		$age_str .= " min ago";
+	} elsif ($age > 2) {
+		$age_str = int $age;
+		$age_str .= " sec ago";
 	} else {
-		$content_type = 'text/html';
-	}
-	print $cgi->header(-type=>$content_type, -charset => 'utf-8', -status=> $status, -expires => $expires);
-	print <<EOF;
-<?xml version="1.0" encoding="utf-8"?>
-<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
-<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
-<!-- git web interface v$version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
-<!-- git core binaries version $git_version -->
-<head>
-<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
-<meta name="robots" content="index, nofollow"/>
-<title>$title</title>
-<link rel="stylesheet" type="text/css" href="$stylesheet"/>
-$rss_link
-</head>
-<body>
-EOF
-	print "<div class=\"page_header\">\n" .
-	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
-	      "<img src=\"$my_uri?" . esc_param("a=git-logo.png") . "\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
-	      "</a>\n";
-	print $cgi->a({-href => esc_param($home_link)}, "projects") . " / ";
-	if (defined $project) {
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, esc_html($project));
-		if (defined $action) {
-			print " / $action";
-		}
-		print "\n";
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
-		$cgi->param("a", "search");
-		$cgi->param("h", $search_hash);
-		print $cgi->startform(-method => "get", -action => $my_uri) .
-		      "<div class=\"search\">\n" .
-		      $cgi->hidden(-name => "p") . "\n" .
-		      $cgi->hidden(-name => "a") . "\n" .
-		      $cgi->hidden(-name => "h") . "\n" .
-		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
-		      "</div>" .
-		      $cgi->end_form() . "\n";
+		$age_str .= " right now";
 	}
-	print "</div>\n";
+	return $age_str;
 }
 
-sub git_footer_html {
-	print "<div class=\"page_footer\">\n";
-	if (defined $project) {
-		my $descr = git_read_description($project);
-		if (defined $descr) {
-			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
-		}
-		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=rss"), -class => "rss_logo"}, "RSS") . "\n";
+# convert file mode in octal to symbolic file mode string
+sub mode_str {
+	my $mode = oct shift;
+
+	if (S_ISDIR($mode & S_IFMT)) {
+		return 'drwxr-xr-x';
+	} elsif (S_ISLNK($mode)) {
+		return 'lrwxrwxrwx';
+	} elsif (S_ISREG($mode)) {
+		# git cares only about the executable bit
+		if ($mode & S_IXUSR) {
+			return '-rwxr-xr-x';
+		} else {
+			return '-rw-r--r--';
+		};
 	} else {
-		print $cgi->a({-href => "$my_uri?" . esc_param("a=opml"), -class => "rss_logo"}, "OPML") . "\n";
+		return '----------';
 	}
-	print "</div>\n" .
-	      "</body>\n" .
-	      "</html>";
 }
 
-sub die_error {
-	my $status = shift || "403 Forbidden";
-	my $error = shift || "Malformed query, file missing or permission denied";
+# convert file mode in octal to file type string
+sub file_type {
+	my $mode = oct shift;
 
-	git_header_html($status);
-	print "<div class=\"page_body\">\n" .
-	      "<br/><br/>\n" .
-	      "$status - $error\n" .
-	      "<br/>\n" .
-	      "</div>\n";
-	git_footer_html();
-	exit;
+	if (S_ISDIR($mode & S_IFMT)) {
+		return "directory";
+	} elsif (S_ISLNK($mode)) {
+		return "symlink";
+	} elsif (S_ISREG($mode)) {
+		return "file";
+	} else {
+		return "unknown";
+	}
 }
 
-sub git_page_nav {
-	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
-	$extra = '' if !defined $extra; # pager or formats
+## ----------------------------------------------------------------------
+## functions returning short HTML fragments, or transforming HTML fragments
+## which don't beling to other sections
 
-	my @navs = qw(summary shortlog log commit commitdiff tree);
-	if ($suppress) {
-		@navs = grep { $_ ne $suppress } @navs;
-	}
+# format line of commit message or tag comment
+sub format_log_line_html {
+	my $line = shift;
 
-	my %arg = map { $_, ''} @navs;
-	if (defined $head) {
-		for (qw(commit commitdiff)) {
-			$arg{$_} = ";h=$head";
-		}
-		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
-			for (qw(shortlog log)) {
-				$arg{$_} = ";h=$head";
-			}
+	$line = esc_html($line);
+	$line =~ s/ /&nbsp;/g;
+	if ($line =~ m/([0-9a-fA-F]{40})/) {
+		my $hash_text = $1;
+		if (git_get_type($hash_text) eq "commit") {
+			my $link = $cgi->a({-class => "text", -href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_text")}, $hash_text);
+			$line =~ s/$hash_text/$link/;
 		}
 	}
-	$arg{tree} .= ";h=$treehead" if defined $treehead;
-	$arg{tree} .= ";hb=$treebase" if defined $treebase;
-
-	print "<div class=\"page_nav\">\n" .
-		(join " | ",
-		 map { $_ eq $current
-					 ? $_
-					 : $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$_$arg{$_}")}, "$_")
-				 }
-		 @navs);
-	print "<br/>\n$extra<br/>\n" .
-	      "</div>\n";
-}
-
-sub git_header_div {
-	my ($action, $title, $hash, $hash_base) = @_;
-	my $rest = '';
-
-	$rest .= ";h=$hash" if $hash;
-	$rest .= ";hb=$hash_base" if $hash_base;
-
-	print "<div class=\"header\">\n" .
-	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action$rest"),
-	               -class => "title"}, $title ? $title : $action) . "\n" .
-	      "</div>\n";
+	return $line;
 }
 
-sub git_get_paging_nav {
-	my ($action, $hash, $head, $page, $nrevs) = @_;
-	my $paging_nav;
-
-
-	if ($hash ne $head || $page) {
-		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action")}, "HEAD");
-	} else {
-		$paging_nav .= "HEAD";
-	}
-
-	if ($page > 0) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page-1)),
-							 -accesskey => "p", -title => "Alt-p"}, "prev");
-	} else {
-		$paging_nav .= " &sdot; prev";
-	}
+# format marker of refs pointing to given object
+sub git_get_referencing {
+	my ($refs, $id) = @_;
 
-	if ($nrevs >= (100 * ($page+1)-1)) {
-		$paging_nav .= " &sdot; " .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page+1)),
-							 -accesskey => "n", -title => "Alt-n"}, "next");
+	if (defined $refs->{$id}) {
+		return ' <span class="tag">' . esc_html($refs->{$id}) . '</span>';
 	} else {
-		$paging_nav .= " &sdot; next";
+		return "";
 	}
-
-	return $paging_nav;
 }
 
-sub git_get_type {
-	my $hash = shift;
-
-	open my $fd, "-|", $GIT, "cat-file", '-t', $hash or return;
-	my $type = <$fd>;
-	close $fd or return;
-	chomp $type;
-	return $type;
-}
+## ----------------------------------------------------------------------
+## git utility subroutines, invoking git commands
 
+# get HEAD ref of given project as hash
 sub git_read_head {
 	my $project = shift;
 	my $oENV = $ENV{'GIT_DIR'};
@@ -491,6 +424,57 @@ sub git_read_head {
 	return $retval;
 }
 
+# get type of given object
+sub git_get_type {
+	my $hash = shift;
+
+	open my $fd, "-|", $GIT, "cat-file", '-t', $hash or return;
+	my $type = <$fd>;
+	close $fd or return;
+	chomp $type;
+	return $type;
+}
+
+sub git_get_project_config {
+	my $key = shift;
+
+	return unless ($key);
+	$key =~ s/^gitweb\.//;
+	return if ($key =~ m/\W/);
+
+	my $val = qx($GIT repo-config --get gitweb.$key);
+	return ($val);
+}
+
+sub git_get_project_config_bool {
+	my $val = git_get_project_config (@_);
+	if ($val and $val =~ m/true|yes|on/) {
+		return (1);
+	}
+	return; # implicit false
+}
+
+# get hash of given path at given ref
+sub git_get_hash_by_path {
+	my $base = shift;
+	my $path = shift || return undef;
+
+	my $tree = $base;
+
+	open my $fd, "-|", $GIT, "ls-tree", $base, "--", $path
+		or die_error(undef, "Open git-ls-tree failed.");
+	my $line = <$fd>;
+	close $fd or return undef;
+
+	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
+	return $3;
+}
+
+## ......................................................................
+## git utility functions, directly accessing git repository
+
+# assumes that PATH is not symref
 sub git_read_hash {
 	my $path = shift;
 
@@ -513,6 +497,100 @@ sub git_read_description {
 	return $descr;
 }
 
+sub git_read_projects {
+	my @list;
+
+	if (-d $projects_list) {
+		# search in directory
+		my $dir = $projects_list;
+		opendir my ($dh), $dir or return undef;
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
+		open my ($fd), $projects_list or return undef;
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
+					owner => decode("utf8", $owner, Encode::FB_DEFAULT),
+				};
+				push @list, $pr
+			}
+		}
+		close $fd;
+	}
+	@list = sort {$a->{'path'} cmp $b->{'path'}} @list;
+	return @list;
+}
+
+sub read_info_ref {
+	my $type = shift || "";
+	my %refs;
+	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
+	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
+	open my $fd, "$projectroot/$project/info/refs" or return;
+	while (my $line = <$fd>) {
+		chomp $line;
+		# attention: for $type == "" it saves only last path part of ref name
+		# e.g. from 'refs/heads/jn/gitweb' it would leave only 'gitweb'
+		if ($line =~ m/^([0-9a-fA-F]{40})\t.*$type\/([^\^]+)/) {
+			if (defined $refs{$1}) {
+				$refs{$1} .= " / $2";
+			} else {
+				$refs{$1} = $2;
+			}
+		}
+	}
+	close $fd or return;
+	return \%refs;
+}
+
+## ----------------------------------------------------------------------
+## parse to hash functions
+
+sub date_str {
+	my $epoch = shift;
+	my $tz = shift || "-0000";
+
+	my %date;
+	my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
+	my @days = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
+	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($epoch);
+	$date{'hour'} = $hour;
+	$date{'minute'} = $min;
+	$date{'mday'} = $mday;
+	$date{'day'} = $days[$wday];
+	$date{'month'} = $months[$mon];
+	$date{'rfc2822'} = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000", $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
+	$date{'mday-time'} = sprintf "%d %s %02d:%02d", $mday, $months[$mon], $hour ,$min;
+
+	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
+	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
+	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
+	$date{'hour_local'} = $hour;
+	$date{'minute_local'} = $min;
+	$date{'tz_local'} = $tz;
+	return %date;
+}
+
 sub git_read_tag {
 	my $tag_id = shift;
 	my %tag;
@@ -548,37 +626,6 @@ sub git_read_tag {
 	return %tag
 }
 
-sub age_string {
-	my $age = shift;
-	my $age_str;
-
-	if ($age > 60*60*24*365*2) {
-		$age_str = (int $age/60/60/24/365);
-		$age_str .= " years ago";
-	} elsif ($age > 60*60*24*(365/12)*2) {
-		$age_str = int $age/60/60/24/(365/12);
-		$age_str .= " months ago";
-	} elsif ($age > 60*60*24*7*2) {
-		$age_str = int $age/60/60/24/7;
-		$age_str .= " weeks ago";
-	} elsif ($age > 60*60*24*2) {
-		$age_str = int $age/60/60/24;
-		$age_str .= " days ago";
-	} elsif ($age > 60*60*2) {
-		$age_str = int $age/60/60;
-		$age_str .= " hours ago";
-	} elsif ($age > 60*2) {
-		$age_str = int $age/60;
-		$age_str .= " min ago";
-	} elsif ($age > 2) {
-		$age_str = int $age;
-		$age_str .= " sec ago";
-	} else {
-		$age_str .= " right now";
-	}
-	return $age_str;
-}
-
 sub git_read_commit {
 	my $commit_id = shift;
 	my $commit_text = shift;
@@ -673,380 +720,8 @@ sub git_read_commit {
 	return %co;
 }
 
-sub git_diff_print {
-	my $from = shift;
-	my $from_name = shift;
-	my $to = shift;
-	my $to_name = shift;
-	my $format = shift || "html";
-
-	my $from_tmp = "/dev/null";
-	my $to_tmp = "/dev/null";
-	my $pid = $$;
-
-	# create tmp from-file
-	if (defined $from) {
-		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
-		open my $fd2, "> $from_tmp";
-		open my $fd, "-|", $GIT, "cat-file", "blob", $from;
-		my @file = <$fd>;
-		print $fd2 @file;
-		close $fd2;
-		close $fd;
-	}
-
-	# create tmp to-file
-	if (defined $to) {
-		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
-		open my $fd2, "> $to_tmp";
-		open my $fd, "-|", $GIT, "cat-file", "blob", $to;
-		my @file = <$fd>;
-		print $fd2 @file;
-		close $fd2;
-		close $fd;
-	}
-
-	open my $fd, "-|", "/usr/bin/diff -u -p -L \'$from_name\' -L \'$to_name\' $from_tmp $to_tmp";
-	if ($format eq "plain") {
-		undef $/;
-		print <$fd>;
-		$/ = "\n";
-	} else {
-		while (my $line = <$fd>) {
-			chomp $line;
-			my $char = substr($line, 0, 1);
-			my $diff_class = "";
-			if ($char eq '+') {
-				$diff_class = " add";
-			} elsif ($char eq "-") {
-				$diff_class = " rem";
-			} elsif ($char eq "@") {
-				$diff_class = " chunk_header";
-			} elsif ($char eq "\\") {
-				# skip errors
-				next;
-			}
-			while ((my $pos = index($line, "\t")) != -1) {
-				if (my $count = (8 - (($pos-1) % 8))) {
-					my $spaces = ' ' x $count;
-					$line =~ s/\t/$spaces/;
-				}
-			}
-			print "<div class=\"diff$diff_class\">" . esc_html($line) . "</div>\n";
-		}
-	}
-	close $fd;
-
-	if (defined $from) {
-		unlink($from_tmp);
-	}
-	if (defined $to) {
-		unlink($to_tmp);
-	}
-}
-
-sub mode_str {
-	my $mode = oct shift;
-
-	if (S_ISDIR($mode & S_IFMT)) {
-		return 'drwxr-xr-x';
-	} elsif (S_ISLNK($mode)) {
-		return 'lrwxrwxrwx';
-	} elsif (S_ISREG($mode)) {
-		# git cares only about the executable bit
-		if ($mode & S_IXUSR) {
-			return '-rwxr-xr-x';
-		} else {
-			return '-rw-r--r--';
-		};
-	} else {
-		return '----------';
-	}
-}
-
-sub chop_str {
-	my $str = shift;
-	my $len = shift;
-	my $add_len = shift || 10;
-
-	# allow only $len chars, but don't cut a word if it would fit in $add_len
-	# if it doesn't fit, cut it if it's still longer than the dots we would add
-	$str =~ m/^(.{0,$len}[^ \/\-_:\.@]{0,$add_len})(.*)/;
-	my $body = $1;
-	my $tail = $2;
-	if (length($tail) > 4) {
-		$tail = " ...";
-		$body =~ s/&[^;]*$//; # remove chopped character entities
-	}
-	return "$body$tail";
-}
-
-sub file_type {
-	my $mode = oct shift;
-
-	if (S_ISDIR($mode & S_IFMT)) {
-		return "directory";
-	} elsif (S_ISLNK($mode)) {
-		return "symlink";
-	} elsif (S_ISREG($mode)) {
-		return "file";
-	} else {
-		return "unknown";
-	}
-}
-
-sub format_log_line_html {
-	my $line = shift;
-
-	$line = esc_html($line);
-	$line =~ s/ /&nbsp;/g;
-	if ($line =~ m/([0-9a-fA-F]{40})/) {
-		my $hash_text = $1;
-		if (git_get_type($hash_text) eq "commit") {
-			my $link = $cgi->a({-class => "text", -href => "$my_uri?" . esc_param("p=$project;a=commit;h=$hash_text")}, $hash_text);
-			$line =~ s/$hash_text/$link/;
-		}
-	}
-	return $line;
-}
-
-sub date_str {
-	my $epoch = shift;
-	my $tz = shift || "-0000";
-
-	my %date;
-	my @months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
-	my @days = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
-	my ($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($epoch);
-	$date{'hour'} = $hour;
-	$date{'minute'} = $min;
-	$date{'mday'} = $mday;
-	$date{'day'} = $days[$wday];
-	$date{'month'} = $months[$mon];
-	$date{'rfc2822'} = sprintf "%s, %d %s %4d %02d:%02d:%02d +0000", $days[$wday], $mday, $months[$mon], 1900+$year, $hour ,$min, $sec;
-	$date{'mday-time'} = sprintf "%d %s %02d:%02d", $mday, $months[$mon], $hour ,$min;
-
-	$tz =~ m/^([+\-][0-9][0-9])([0-9][0-9])$/;
-	my $local = $epoch + ((int $1 + ($2/60)) * 3600);
-	($sec, $min, $hour, $mday, $mon, $year, $wday, $yday) = gmtime($local);
-	$date{'hour_local'} = $hour;
-	$date{'minute_local'} = $min;
-	$date{'tz_local'} = $tz;
-	return %date;
-}
-
-# git-logo (cached in browser for one day)
-sub git_logo {
-	binmode STDOUT, ':raw';
-	print $cgi->header(-type => 'image/png', -expires => '+1d');
-	# cat git-logo.png | hexdump -e '16/1 " %02x"  "\n"' | sed 's/ /\\x/g'
-	print	"\x89\x50\x4e\x47\x0d\x0a\x1a\x0a\x00\x00\x00\x0d\x49\x48\x44\x52" .
-		"\x00\x00\x00\x48\x00\x00\x00\x1b\x04\x03\x00\x00\x00\x2d\xd9\xd4" .
-		"\x2d\x00\x00\x00\x18\x50\x4c\x54\x45\xff\xff\xff\x60\x60\x5d\xb0" .
-		"\xaf\xaa\x00\x80\x00\xce\xcd\xc7\xc0\x00\x00\xe8\xe8\xe6\xf7\xf7" .
-		"\xf6\x95\x0c\xa7\x47\x00\x00\x00\x73\x49\x44\x41\x54\x28\xcf\x63" .
-		"\x48\x67\x20\x04\x4a\x5c\x18\x0a\x08\x2a\x62\x53\x61\x20\x02\x08" .
-		"\x0d\x69\x45\xac\xa1\xa1\x01\x30\x0c\x93\x60\x36\x26\x52\x91\xb1" .
-		"\x01\x11\xd6\xe1\x55\x64\x6c\x6c\xcc\x6c\x6c\x0c\xa2\x0c\x70\x2a" .
-		"\x62\x06\x2a\xc1\x62\x1d\xb3\x01\x02\x53\xa4\x08\xe8\x00\x03\x18" .
-		"\x26\x56\x11\xd4\xe1\x20\x97\x1b\xe0\xb4\x0e\x35\x24\x71\x29\x82" .
-		"\x99\x30\xb8\x93\x0a\x11\xb9\x45\x88\xc1\x8d\xa0\xa2\x44\x21\x06" .
-		"\x27\x41\x82\x40\x85\xc1\x45\x89\x20\x70\x01\x00\xa4\x3d\x21\xc5" .
-		"\x12\x1c\x9a\xfe\x00\x00\x00\x00\x49\x45\x4e\x44\xae\x42\x60\x82";
-}
-
-sub get_file_owner {
-	my $path = shift;
-
-	my ($dev, $ino, $mode, $nlink, $st_uid, $st_gid, $rdev, $size) = stat($path);
-	my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos, $dir, $shell) = getpwuid($st_uid);
-	if (!defined $gcos) {
-		return undef;
-	}
-	my $owner = $gcos;
-	$owner =~ s/[,;].*$//;
-	return decode("utf8", $owner, Encode::FB_DEFAULT);
-}
-
-sub git_read_projects {
-	my @list;
-
-	if (-d $projects_list) {
-		# search in directory
-		my $dir = $projects_list;
-		opendir my ($dh), $dir or return undef;
-		while (my $dir = readdir($dh)) {
-			if (-e "$projectroot/$dir/HEAD") {
-				my $pr = {
-					path => $dir,
-				};
-				push @list, $pr
-			}
-		}
-		closedir($dh);
-	} elsif (-f $projects_list) {
-		# read from file(url-encoded):
-		# 'git%2Fgit.git Linus+Torvalds'
-		# 'libs%2Fklibc%2Fklibc.git H.+Peter+Anvin'
-		# 'linux%2Fhotplug%2Fudev.git Greg+Kroah-Hartman'
-		open my ($fd), $projects_list or return undef;
-		while (my $line = <$fd>) {
-			chomp $line;
-			my ($path, $owner) = split ' ', $line;
-			$path = unescape($path);
-			$owner = unescape($owner);
-			if (!defined $path) {
-				next;
-			}
-			if (-e "$projectroot/$path/HEAD") {
-				my $pr = {
-					path => $path,
-					owner => decode("utf8", $owner, Encode::FB_DEFAULT),
-				};
-				push @list, $pr
-			}
-		}
-		close $fd;
-	}
-	@list = sort {$a->{'path'} cmp $b->{'path'}} @list;
-	return @list;
-}
-
-sub git_get_project_config {
-	my $key = shift;
-
-	return unless ($key);
-	$key =~ s/^gitweb\.//;
-	return if ($key =~ m/\W/);
-
-	my $val = qx($GIT repo-config --get gitweb.$key);
-	return ($val);
-}
-
-sub git_get_project_config_bool {
-	my $val = git_get_project_config (@_);
-	if ($val and $val =~ m/true|yes|on/) {
-		return (1);
-	}
-	return; # implicit false
-}
-
-sub git_project_list {
-	my @list = git_read_projects();
-	my @projects;
-	if (!@list) {
-		die_error(undef, "No project found.");
-	}
-	foreach my $pr (@list) {
-		my $head = git_read_head($pr->{'path'});
-		if (!defined $head) {
-			next;
-		}
-		$ENV{'GIT_DIR'} = "$projectroot/$pr->{'path'}";
-		my %co = git_read_commit($head);
-		if (!%co) {
-			next;
-		}
-		$pr->{'commit'} = \%co;
-		if (!defined $pr->{'descr'}) {
-			my $descr = git_read_description($pr->{'path'}) || "";
-			$pr->{'descr'} = chop_str($descr, 25, 5);
-		}
-		if (!defined $pr->{'owner'}) {
-			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
-		}
-		push @projects, $pr;
-	}
-	git_header_html();
-	if (-f $home_text) {
-		print "<div class=\"index_include\">\n";
-		open (my $fd, $home_text);
-		print <$fd>;
-		close $fd;
-		print "</div>\n";
-	}
-	print "<table class=\"project_list\">\n" .
-	      "<tr>\n";
-	if (!defined($order) || (defined($order) && ($order eq "project"))) {
-		@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
-		print "<th>Project</th>\n";
-	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=project")}, "Project") . "</th>\n";
-	}
-	if (defined($order) && ($order eq "descr")) {
-		@projects = sort {$a->{'descr'} cmp $b->{'descr'}} @projects;
-		print "<th>Description</th>\n";
-	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=descr")}, "Description") . "</th>\n";
-	}
-	if (defined($order) && ($order eq "owner")) {
-		@projects = sort {$a->{'owner'} cmp $b->{'owner'}} @projects;
-		print "<th>Owner</th>\n";
-	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=owner")}, "Owner") . "</th>\n";
-	}
-	if (defined($order) && ($order eq "age")) {
-		@projects = sort {$a->{'commit'}{'age'} <=> $b->{'commit'}{'age'}} @projects;
-		print "<th>Last Change</th>\n";
-	} else {
-		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=age")}, "Last Change") . "</th>\n";
-	}
-	print "<th></th>\n" .
-	      "</tr>\n";
-	my $alternate = 0;
-	foreach my $pr (@projects) {
-		if ($alternate) {
-			print "<tr class=\"dark\">\n";
-		} else {
-			print "<tr class=\"light\">\n";
-		}
-		$alternate ^= 1;
-		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"), -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
-		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
-		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" . $pr->{'commit'}{'age_string'} . "</td>\n" .
-		      "<td class=\"link\">" .
-		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary")}, "summary") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=shortlog")}, "shortlog") .
-		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=log")}, "log") .
-		      "</td>\n" .
-		      "</tr>\n";
-	}
-	print "</table>\n";
-	git_footer_html();
-}
-
-sub read_info_ref {
-	my $type = shift || "";
-	my %refs;
-	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
-	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
-	open my $fd, "$projectroot/$project/info/refs" or return;
-	while (my $line = <$fd>) {
-		chomp $line;
-		# attention: for $type == "" it saves only last path part of ref name
-		# e.g. from 'refs/heads/jn/gitweb' it would leave only 'gitweb'
-		if ($line =~ m/^([0-9a-fA-F]{40})\t.*$type\/([^\^]+)/) {
-			if (defined $refs{$1}) {
-				$refs{$1} .= " / $2";
-			} else {
-				$refs{$1} = $2;
-			}
-		}
-	}
-	close $fd or return;
-	return \%refs;
-}
-
-sub git_get_referencing {
-	my ($refs, $id) = @_;
-
-	if (defined $refs->{$id}) {
-		return ' <span class="tag">' . esc_html($refs->{$id}) . '</span>';
-	} else {
-		return "";
-	}
-}
+## ......................................................................
+## parse to array of hashes functions
 
 sub git_read_refs {
 	my $ref_dir = shift;
@@ -1115,6 +790,299 @@ sub git_read_refs {
 	return \@reflist;
 }
 
+## ----------------------------------------------------------------------
+## filesystem-related functions
+
+sub get_file_owner {
+	my $path = shift;
+
+	my ($dev, $ino, $mode, $nlink, $st_uid, $st_gid, $rdev, $size) = stat($path);
+	my ($name, $passwd, $uid, $gid, $quota, $comment, $gcos, $dir, $shell) = getpwuid($st_uid);
+	if (!defined $gcos) {
+		return undef;
+	}
+	my $owner = $gcos;
+	$owner =~ s/[,;].*$//;
+	return decode("utf8", $owner, Encode::FB_DEFAULT);
+}
+
+## ......................................................................
+## mimetype related functions
+
+sub mimetype_guess_file {
+	my $filename = shift;
+	my $mimemap = shift;
+	-r $mimemap or return undef;
+
+	my %mimemap;
+	open(MIME, $mimemap) or return undef;
+	while (<MIME>) {
+		my ($mime, $exts) = split(/\t+/);
+		my @exts = split(/\s+/, $exts);
+		foreach my $ext (@exts) {
+			$mimemap{$ext} = $mime;
+		}
+	}
+	close(MIME);
+
+	$filename =~ /\.(.*?)$/;
+	return $mimemap{$1};
+}
+
+sub mimetype_guess {
+	my $filename = shift;
+	my $mime;
+	$filename =~ /\./ or return undef;
+
+	if ($mimetypes_file) {
+		my $file = $mimetypes_file;
+		#$file =~ m#^/# or $file = "$projectroot/$path/$file";
+		$mime = mimetype_guess_file($filename, $file);
+	}
+	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
+	return $mime;
+}
+
+sub git_blob_plain_mimetype {
+	my $fd = shift;
+	my $filename = shift;
+
+	if ($filename) {
+		my $mime = mimetype_guess($filename);
+		$mime and return $mime;
+	}
+
+	# just in case
+	return $default_blob_plain_mimetype unless $fd;
+
+	if (-T $fd) {
+		return 'text/plain' .
+		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');
+	} elsif (! $filename) {
+		return 'application/octet-stream';
+	} elsif ($filename =~ m/\.png$/i) {
+		return 'image/png';
+	} elsif ($filename =~ m/\.gif$/i) {
+		return 'image/gif';
+	} elsif ($filename =~ m/\.jpe?g$/i) {
+		return 'image/jpeg';
+	} else {
+		return 'application/octet-stream';
+	}
+}
+
+## ======================================================================
+## functions printing HTML: header, footer, error page
+
+sub git_header_html {
+	my $status = shift || "200 OK";
+	my $expires = shift;
+
+	my $title = "$site_name git";
+	if (defined $project) {
+		$title .= " - $project";
+		if (defined $action) {
+			$title .= "/$action";
+			if (defined $file_name) {
+				$title .= " - $file_name";
+				if ($action eq "tree" && $file_name !~ m|/$|) {
+					$title .= "/";
+				}
+			}
+		}
+	}
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
+	print $cgi->header(-type=>$content_type, -charset => 'utf-8', -status=> $status, -expires => $expires);
+	print <<EOF;
+<?xml version="1.0" encoding="utf-8"?>
+<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
+<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
+<!-- git web interface v$version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
+<!-- git core binaries version $git_version -->
+<head>
+<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
+<meta name="robots" content="index, nofollow"/>
+<title>$title</title>
+<link rel="stylesheet" type="text/css" href="$stylesheet"/>
+$rss_link
+</head>
+<body>
+EOF
+	print "<div class=\"page_header\">\n" .
+	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
+	      "<img src=\"$my_uri?" . esc_param("a=git-logo.png") . "\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
+	      "</a>\n";
+	print $cgi->a({-href => esc_param($home_link)}, "projects") . " / ";
+	if (defined $project) {
+		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=summary")}, esc_html($project));
+		if (defined $action) {
+			print " / $action";
+		}
+		print "\n";
+		if (!defined $searchtext) {
+			$searchtext = "";
+		}
+		my $search_hash;
+		if (defined $hash_base) {
+			$search_hash = $hash_base;
+		} elsif (defined $hash) {
+			$search_hash = $hash;
+		} else {
+			$search_hash = "HEAD";
+		}
+		$cgi->param("a", "search");
+		$cgi->param("h", $search_hash);
+		print $cgi->startform(-method => "get", -action => $my_uri) .
+		      "<div class=\"search\">\n" .
+		      $cgi->hidden(-name => "p") . "\n" .
+		      $cgi->hidden(-name => "a") . "\n" .
+		      $cgi->hidden(-name => "h") . "\n" .
+		      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
+		      "</div>" .
+		      $cgi->end_form() . "\n";
+	}
+	print "</div>\n";
+}
+
+sub git_footer_html {
+	print "<div class=\"page_footer\">\n";
+	if (defined $project) {
+		my $descr = git_read_description($project);
+		if (defined $descr) {
+			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
+		}
+		print $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=rss"), -class => "rss_logo"}, "RSS") . "\n";
+	} else {
+		print $cgi->a({-href => "$my_uri?" . esc_param("a=opml"), -class => "rss_logo"}, "OPML") . "\n";
+	}
+	print "</div>\n" .
+	      "</body>\n" .
+	      "</html>";
+}
+
+sub die_error {
+	my $status = shift || "403 Forbidden";
+	my $error = shift || "Malformed query, file missing or permission denied";
+
+	git_header_html($status);
+	print "<div class=\"page_body\">\n" .
+	      "<br/><br/>\n" .
+	      "$status - $error\n" .
+	      "<br/>\n" .
+	      "</div>\n";
+	git_footer_html();
+	exit;
+}
+
+## ----------------------------------------------------------------------
+## functions printing or outputting HTML: navigation
+
+sub git_page_nav {
+	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
+	$extra = '' if !defined $extra; # pager or formats
+
+	my @navs = qw(summary shortlog log commit commitdiff tree);
+	if ($suppress) {
+		@navs = grep { $_ ne $suppress } @navs;
+	}
+
+	my %arg = map { $_, ''} @navs;
+	if (defined $head) {
+		for (qw(commit commitdiff)) {
+			$arg{$_} = ";h=$head";
+		}
+		if ($current =~ m/^(tree | log | shortlog | commit | commitdiff | search)$/x) {
+			for (qw(shortlog log)) {
+				$arg{$_} = ";h=$head";
+			}
+		}
+	}
+	$arg{tree} .= ";h=$treehead" if defined $treehead;
+	$arg{tree} .= ";hb=$treebase" if defined $treebase;
+
+	print "<div class=\"page_nav\">\n" .
+		(join " | ",
+		 map { $_ eq $current
+					 ? $_
+					 : $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$_$arg{$_}")}, "$_")
+				 }
+		 @navs);
+	print "<br/>\n$extra<br/>\n" .
+	      "</div>\n";
+}
+
+sub git_get_paging_nav {
+	my ($action, $hash, $head, $page, $nrevs) = @_;
+	my $paging_nav;
+
+
+	if ($hash ne $head || $page) {
+		$paging_nav .= $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action")}, "HEAD");
+	} else {
+		$paging_nav .= "HEAD";
+	}
+
+	if ($page > 0) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page-1)),
+							 -accesskey => "p", -title => "Alt-p"}, "prev");
+	} else {
+		$paging_nav .= " &sdot; prev";
+	}
+
+	if ($nrevs >= (100 * ($page+1)-1)) {
+		$paging_nav .= " &sdot; " .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action;h=$hash;pg=" . ($page+1)),
+							 -accesskey => "n", -title => "Alt-n"}, "next");
+	} else {
+		$paging_nav .= " &sdot; next";
+	}
+
+	return $paging_nav;
+}
+
+## ......................................................................
+## functions printing or outputting HTML: div
+
+sub git_header_div {
+	my ($action, $title, $hash, $hash_base) = @_;
+	my $rest = '';
+
+	$rest .= ";h=$hash" if $hash;
+	$rest .= ";hb=$hash_base" if $hash_base;
+
+	print "<div class=\"header\">\n" .
+	      $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=$action$rest"),
+	               -class => "title"}, $title ? $title : $action) . "\n" .
+	      "</div>\n";
+}
+
+sub git_print_page_path {
+	my $name = shift;
+	my $type = shift;
+
+	if (!defined $name) {
+		print "<div class=\"page_path\"><b>/</b></div>\n";
+	} elsif ($type =~ "blob") {
+		print "<div class=\"page_path\"><b>" .
+			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;f=$file_name")}, esc_html($name)) . "</b><br/></div>\n";
+	} else {
+		print "<div class=\"page_path\"><b>" . esc_html($name) . "</b><br/></div>\n";
+	}
+}
+
+## ......................................................................
+## functions printing large fragments of HTML
+
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
@@ -1265,6 +1233,191 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
+## ----------------------------------------------------------------------
+## functions printing large fragments, format as one of arguments
+
+sub git_diff_print {
+	my $from = shift;
+	my $from_name = shift;
+	my $to = shift;
+	my $to_name = shift;
+	my $format = shift || "html";
+
+	my $from_tmp = "/dev/null";
+	my $to_tmp = "/dev/null";
+	my $pid = $$;
+
+	# create tmp from-file
+	if (defined $from) {
+		$from_tmp = "$git_temp/gitweb_" . $$ . "_from";
+		open my $fd2, "> $from_tmp";
+		open my $fd, "-|", $GIT, "cat-file", "blob", $from;
+		my @file = <$fd>;
+		print $fd2 @file;
+		close $fd2;
+		close $fd;
+	}
+
+	# create tmp to-file
+	if (defined $to) {
+		$to_tmp = "$git_temp/gitweb_" . $$ . "_to";
+		open my $fd2, "> $to_tmp";
+		open my $fd, "-|", $GIT, "cat-file", "blob", $to;
+		my @file = <$fd>;
+		print $fd2 @file;
+		close $fd2;
+		close $fd;
+	}
+
+	open my $fd, "-|", "/usr/bin/diff -u -p -L \'$from_name\' -L \'$to_name\' $from_tmp $to_tmp";
+	if ($format eq "plain") {
+		undef $/;
+		print <$fd>;
+		$/ = "\n";
+	} else {
+		while (my $line = <$fd>) {
+			chomp $line;
+			my $char = substr($line, 0, 1);
+			my $diff_class = "";
+			if ($char eq '+') {
+				$diff_class = " add";
+			} elsif ($char eq "-") {
+				$diff_class = " rem";
+			} elsif ($char eq "@") {
+				$diff_class = " chunk_header";
+			} elsif ($char eq "\\") {
+				# skip errors
+				next;
+			}
+			while ((my $pos = index($line, "\t")) != -1) {
+				if (my $count = (8 - (($pos-1) % 8))) {
+					my $spaces = ' ' x $count;
+					$line =~ s/\t/$spaces/;
+				}
+			}
+			print "<div class=\"diff$diff_class\">" . esc_html($line) . "</div>\n";
+		}
+	}
+	close $fd;
+
+	if (defined $from) {
+		unlink($from_tmp);
+	}
+	if (defined $to) {
+		unlink($to_tmp);
+	}
+}
+
+
+## ======================================================================
+## ======================================================================
+## actions
+
+# git-logo (cached in browser for one day)
+sub git_logo {
+	binmode STDOUT, ':raw';
+	print $cgi->header(-type => 'image/png', -expires => '+1d');
+	# cat git-logo.png | hexdump -e '16/1 " %02x"  "\n"' | sed 's/ /\\x/g'
+	print	"\x89\x50\x4e\x47\x0d\x0a\x1a\x0a\x00\x00\x00\x0d\x49\x48\x44\x52" .
+		"\x00\x00\x00\x48\x00\x00\x00\x1b\x04\x03\x00\x00\x00\x2d\xd9\xd4" .
+		"\x2d\x00\x00\x00\x18\x50\x4c\x54\x45\xff\xff\xff\x60\x60\x5d\xb0" .
+		"\xaf\xaa\x00\x80\x00\xce\xcd\xc7\xc0\x00\x00\xe8\xe8\xe6\xf7\xf7" .
+		"\xf6\x95\x0c\xa7\x47\x00\x00\x00\x73\x49\x44\x41\x54\x28\xcf\x63" .
+		"\x48\x67\x20\x04\x4a\x5c\x18\x0a\x08\x2a\x62\x53\x61\x20\x02\x08" .
+		"\x0d\x69\x45\xac\xa1\xa1\x01\x30\x0c\x93\x60\x36\x26\x52\x91\xb1" .
+		"\x01\x11\xd6\xe1\x55\x64\x6c\x6c\xcc\x6c\x6c\x0c\xa2\x0c\x70\x2a" .
+		"\x62\x06\x2a\xc1\x62\x1d\xb3\x01\x02\x53\xa4\x08\xe8\x00\x03\x18" .
+		"\x26\x56\x11\xd4\xe1\x20\x97\x1b\xe0\xb4\x0e\x35\x24\x71\x29\x82" .
+		"\x99\x30\xb8\x93\x0a\x11\xb9\x45\x88\xc1\x8d\xa0\xa2\x44\x21\x06" .
+		"\x27\x41\x82\x40\x85\xc1\x45\x89\x20\x70\x01\x00\xa4\x3d\x21\xc5" .
+		"\x12\x1c\x9a\xfe\x00\x00\x00\x00\x49\x45\x4e\x44\xae\x42\x60\x82";
+}
+
+sub git_project_list {
+	my @list = git_read_projects();
+	my @projects;
+	if (!@list) {
+		die_error(undef, "No project found.");
+	}
+	foreach my $pr (@list) {
+		my $head = git_read_head($pr->{'path'});
+		if (!defined $head) {
+			next;
+		}
+		$ENV{'GIT_DIR'} = "$projectroot/$pr->{'path'}";
+		my %co = git_read_commit($head);
+		if (!%co) {
+			next;
+		}
+		$pr->{'commit'} = \%co;
+		if (!defined $pr->{'descr'}) {
+			my $descr = git_read_description($pr->{'path'}) || "";
+			$pr->{'descr'} = chop_str($descr, 25, 5);
+		}
+		if (!defined $pr->{'owner'}) {
+			$pr->{'owner'} = get_file_owner("$projectroot/$pr->{'path'}") || "";
+		}
+		push @projects, $pr;
+	}
+	git_header_html();
+	if (-f $home_text) {
+		print "<div class=\"index_include\">\n";
+		open (my $fd, $home_text);
+		print <$fd>;
+		close $fd;
+		print "</div>\n";
+	}
+	print "<table class=\"project_list\">\n" .
+	      "<tr>\n";
+	if (!defined($order) || (defined($order) && ($order eq "project"))) {
+		@projects = sort {$a->{'path'} cmp $b->{'path'}} @projects;
+		print "<th>Project</th>\n";
+	} else {
+		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=project")}, "Project") . "</th>\n";
+	}
+	if (defined($order) && ($order eq "descr")) {
+		@projects = sort {$a->{'descr'} cmp $b->{'descr'}} @projects;
+		print "<th>Description</th>\n";
+	} else {
+		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=descr")}, "Description") . "</th>\n";
+	}
+	if (defined($order) && ($order eq "owner")) {
+		@projects = sort {$a->{'owner'} cmp $b->{'owner'}} @projects;
+		print "<th>Owner</th>\n";
+	} else {
+		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=owner")}, "Owner") . "</th>\n";
+	}
+	if (defined($order) && ($order eq "age")) {
+		@projects = sort {$a->{'commit'}{'age'} <=> $b->{'commit'}{'age'}} @projects;
+		print "<th>Last Change</th>\n";
+	} else {
+		print "<th>" . $cgi->a({-class => "header", -href => "$my_uri?" . esc_param("o=age")}, "Last Change") . "</th>\n";
+	}
+	print "<th></th>\n" .
+	      "</tr>\n";
+	my $alternate = 0;
+	foreach my $pr (@projects) {
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td>" . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary"), -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		      "<td>" . esc_html($pr->{'descr'}) . "</td>\n" .
+		      "<td><i>" . chop_str($pr->{'owner'}, 15) . "</i></td>\n";
+		print "<td class=\"". age_class($pr->{'commit'}{'age'}) . "\">" . $pr->{'commit'}{'age_string'} . "</td>\n" .
+		      "<td class=\"link\">" .
+		      $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=summary")}, "summary") .
+		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=shortlog")}, "shortlog") .
+		      " | " . $cgi->a({-href => "$my_uri?" . esc_param("p=$pr->{'path'};a=log")}, "log") .
+		      "</td>\n" .
+		      "</tr>\n";
+	}
+	print "</table>\n";
+	git_footer_html();
+}
+
 sub git_summary {
 	my $descr = git_read_description($project) || "none";
 	my $head = git_read_head($project);
@@ -1326,20 +1479,6 @@ sub git_summary {
 	git_footer_html();
 }
 
-sub git_print_page_path {
-	my $name = shift;
-	my $type = shift;
-
-	if (!defined $name) {
-		print "<div class=\"page_path\"><b>/</b></div>\n";
-	} elsif ($type =~ "blob") {
-		print "<div class=\"page_path\"><b>" .
-			$cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=blob_plain;f=$file_name")}, esc_html($name)) . "</b><br/></div>\n";
-	} else {
-		print "<div class=\"page_path\"><b>" . esc_html($name) . "</b><br/></div>\n";
-	}
-}
-
 sub git_tag {
 	my $head = git_read_head($project);
 	git_header_html();
@@ -1546,84 +1685,6 @@ sub git_heads {
 	git_footer_html();
 }
 
-sub git_get_hash_by_path {
-	my $base = shift;
-	my $path = shift || return undef;
-
-	my $tree = $base;
-
-	open my $fd, "-|", $GIT, "ls-tree", $base, "--", $path
-		or die_error(undef, "Open git-ls-tree failed.");
-	my $line = <$fd>;
-	close $fd or return undef;
-
-	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
-	return $3;
-}
-
-sub mimetype_guess_file {
-	my $filename = shift;
-	my $mimemap = shift;
-	-r $mimemap or return undef;
-
-	my %mimemap;
-	open(MIME, $mimemap) or return undef;
-	while (<MIME>) {
-		my ($mime, $exts) = split(/\t+/);
-		my @exts = split(/\s+/, $exts);
-		foreach my $ext (@exts) {
-			$mimemap{$ext} = $mime;
-		}
-	}
-	close(MIME);
-
-	$filename =~ /\.(.*?)$/;
-	return $mimemap{$1};
-}
-
-sub mimetype_guess {
-	my $filename = shift;
-	my $mime;
-	$filename =~ /\./ or return undef;
-
-	if ($mimetypes_file) {
-		my $file = $mimetypes_file;
-		#$file =~ m#^/# or $file = "$projectroot/$path/$file";
-		$mime = mimetype_guess_file($filename, $file);
-	}
-	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
-	return $mime;
-}
-
-sub git_blob_plain_mimetype {
-	my $fd = shift;
-	my $filename = shift;
-
-	if ($filename) {
-		my $mime = mimetype_guess($filename);
-		$mime and return $mime;
-	}
-
-	# just in case
-	return $default_blob_plain_mimetype unless $fd;
-
-	if (-T $fd) {
-		return 'text/plain' .
-		       ($default_text_plain_charset ? '; charset='.$default_text_plain_charset : '');
-	} elsif (! $filename) {
-		return 'application/octet-stream';
-	} elsif ($filename =~ m/\.png$/i) {
-		return 'image/png';
-	} elsif ($filename =~ m/\.gif$/i) {
-		return 'image/gif';
-	} elsif ($filename =~ m/\.jpe?g$/i) {
-		return 'image/jpeg';
-	} else {
-		return 'application/octet-stream';
-	}
-}
-
 sub git_blob_plain {
 	if (!defined $hash) {
 		if (defined $file_name) {
@@ -1793,98 +1854,6 @@ #			      " | " . $cgi->a({-href => "$my
 	git_footer_html();
 }
 
-sub git_rss {
-	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project) 
-		or die_error(undef, "Open git-rev-list failed.");
-	my @revlist = map { chomp; $_ } <$fd>;
-	close $fd or die_error(undef, "Reading rev-list failed.");
-	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
-	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
-	      "<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
-	print "<channel>\n";
-	print "<title>$project</title>\n".
-	      "<link>" . esc_html("$my_url?p=$project;a=summary") . "</link>\n".
-	      "<description>$project log</description>\n".
-	      "<language>en</language>\n";
-
-	for (my $i = 0; $i <= $#revlist; $i++) {
-		my $commit = $revlist[$i];
-		my %co = git_read_commit($commit);
-		# we read 150, we always show 30 and the ones more recent than 48 hours
-		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
-			last;
-		}
-		my %cd = date_str($co{'committer_epoch'});
-		open $fd, "-|", $GIT, "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
-		my @difftree = map { chomp; $_ } <$fd>;
-		close $fd or next;
-		print "<item>\n" .
-		      "<title>" .
-		      sprintf("%d %s %02d:%02d", $cd{'mday'}, $cd{'month'}, $cd{'hour'}, $cd{'minute'}) . " - " . esc_html($co{'title'}) .
-		      "</title>\n" .
-		      "<author>" . esc_html($co{'author'}) . "</author>\n" .
-		      "<pubDate>$cd{'rfc2822'}</pubDate>\n" .
-		      "<guid isPermaLink=\"true\">" . esc_html("$my_url?p=$project;a=commit;h=$commit") . "</guid>\n" .
-		      "<link>" . esc_html("$my_url?p=$project;a=commit;h=$commit") . "</link>\n" .
-		      "<description>" . esc_html($co{'title'}) . "</description>\n" .
-		      "<content:encoded>" .
-		      "<![CDATA[\n";
-		my $comment = $co{'comment'};
-		foreach my $line (@$comment) {
-			$line = decode("utf8", $line, Encode::FB_DEFAULT);
-			print "$line<br/>\n";
-		}
-		print "<br/>\n";
-		foreach my $line (@difftree) {
-			if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
-				next;
-			}
-			my $file = validate_input(unquote($7));
-			$file = decode("utf8", $file, Encode::FB_DEFAULT);
-			print "$file<br/>\n";
-		}
-		print "]]>\n" .
-		      "</content:encoded>\n" .
-		      "</item>\n";
-	}
-	print "</channel></rss>";
-}
-
-sub git_opml {
-	my @list = git_read_projects();
-
-	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
-	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
-	      "<opml version=\"1.0\">\n".
-	      "<head>".
-	      "  <title>$site_name Git OPML Export</title>\n".
-	      "</head>\n".
-	      "<body>\n".
-	      "<outline text=\"git RSS feeds\">\n";
-
-	foreach my $pr (@list) {
-		my %proj = %$pr;
-		my $head = git_read_head($proj{'path'});
-		if (!defined $head) {
-			next;
-		}
-		$ENV{'GIT_DIR'} = "$projectroot/$proj{'path'}";
-		my %co = git_read_commit($head);
-		if (!%co) {
-			next;
-		}
-
-		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
-		my $rss  = "$my_url?p=$proj{'path'};a=rss";
-		my $html = "$my_url?p=$proj{'path'};a=summary";
-		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
-	}
-	print "</outline>\n".
-	      "</body>\n".
-	      "</opml>\n";
-}
-
 sub git_log {
 	my $head = git_read_head($project);
 	if (!defined $hash) {
@@ -2556,3 +2525,98 @@ sub git_shortlog {
 
 	git_footer_html();
 }
+
+## ......................................................................
+## feeds (RSS, OPML)
+
+sub git_rss {
+	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
+	open my $fd, "-|", $GIT, "rev-list", "--max-count=150", git_read_head($project)
+		or die_error(undef, "Open git-rev-list failed.");
+	my @revlist = map { chomp; $_ } <$fd>;
+	close $fd or die_error(undef, "Reading rev-list failed.");
+	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
+	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
+	      "<rss version=\"2.0\" xmlns:content=\"http://purl.org/rss/1.0/modules/content/\">\n";
+	print "<channel>\n";
+	print "<title>$project</title>\n".
+	      "<link>" . esc_html("$my_url?p=$project;a=summary") . "</link>\n".
+	      "<description>$project log</description>\n".
+	      "<language>en</language>\n";
+
+	for (my $i = 0; $i <= $#revlist; $i++) {
+		my $commit = $revlist[$i];
+		my %co = git_read_commit($commit);
+		# we read 150, we always show 30 and the ones more recent than 48 hours
+		if (($i >= 20) && ((time - $co{'committer_epoch'}) > 48*60*60)) {
+			last;
+		}
+		my %cd = date_str($co{'committer_epoch'});
+		open $fd, "-|", $GIT, "diff-tree", '-r', $co{'parent'}, $co{'id'} or next;
+		my @difftree = map { chomp; $_ } <$fd>;
+		close $fd or next;
+		print "<item>\n" .
+		      "<title>" .
+		      sprintf("%d %s %02d:%02d", $cd{'mday'}, $cd{'month'}, $cd{'hour'}, $cd{'minute'}) . " - " . esc_html($co{'title'}) .
+		      "</title>\n" .
+		      "<author>" . esc_html($co{'author'}) . "</author>\n" .
+		      "<pubDate>$cd{'rfc2822'}</pubDate>\n" .
+		      "<guid isPermaLink=\"true\">" . esc_html("$my_url?p=$project;a=commit;h=$commit") . "</guid>\n" .
+		      "<link>" . esc_html("$my_url?p=$project;a=commit;h=$commit") . "</link>\n" .
+		      "<description>" . esc_html($co{'title'}) . "</description>\n" .
+		      "<content:encoded>" .
+		      "<![CDATA[\n";
+		my $comment = $co{'comment'};
+		foreach my $line (@$comment) {
+			$line = decode("utf8", $line, Encode::FB_DEFAULT);
+			print "$line<br/>\n";
+		}
+		print "<br/>\n";
+		foreach my $line (@difftree) {
+			if (!($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/)) {
+				next;
+			}
+			my $file = validate_input(unquote($7));
+			$file = decode("utf8", $file, Encode::FB_DEFAULT);
+			print "$file<br/>\n";
+		}
+		print "]]>\n" .
+		      "</content:encoded>\n" .
+		      "</item>\n";
+	}
+	print "</channel></rss>";
+}
+
+sub git_opml {
+	my @list = git_read_projects();
+
+	print $cgi->header(-type => 'text/xml', -charset => 'utf-8');
+	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n".
+	      "<opml version=\"1.0\">\n".
+	      "<head>".
+	      "  <title>$site_name Git OPML Export</title>\n".
+	      "</head>\n".
+	      "<body>\n".
+	      "<outline text=\"git RSS feeds\">\n";
+
+	foreach my $pr (@list) {
+		my %proj = %$pr;
+		my $head = git_read_head($proj{'path'});
+		if (!defined $head) {
+			next;
+		}
+		$ENV{'GIT_DIR'} = "$projectroot/$proj{'path'}";
+		my %co = git_read_commit($head);
+		if (!%co) {
+			next;
+		}
+
+		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
+		my $rss  = "$my_url?p=$proj{'path'};a=rss";
+		my $html = "$my_url?p=$proj{'path'};a=summary";
+		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
+	}
+	print "</outline>\n".
+	      "</body>\n".
+	      "</opml>\n";
+}
-- 
1.4.1.1
