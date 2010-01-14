From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 8/9] gitweb: Convert output to using indirect file handle
Date: Wed, 13 Jan 2010 17:23:04 -0800
Message-ID: <1263432185-21334-9-git-send-email-warthog9@eaglescrag.net>
References: <1263432185-21334-1-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-2-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-3-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-4-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-5-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-6-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-7-git-send-email-warthog9@eaglescrag.net>
 <1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 02:23:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVERJ-0002pa-57
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 02:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab0ANBXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 20:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436Ab0ANBXY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 20:23:24 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:56022 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab0ANBXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 20:23:14 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0E1N5Lu009231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:23:13 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1263432185-21334-8-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 13 Jan 2010 17:23:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136915>

This converts the output handling of gitweb to using an indirect
file handle.  This is in preparation to add the caching layer.  This
is a slight modification to the way I was originally doing it by
passing the output around.  This should be a nop and this shouldn't
change the behavior of gitweb.  This does leave error reporting
functions (die_error specifically) continuing to output directly
as I want to garauntee those will report their errors regardless of
what may be going on with respect to the rest of the output.
---
 gitweb/gitweb.perl |  880 ++++++++++++++++++++++++++--------------------------
 1 files changed, 448 insertions(+), 432 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c4a177d..8bb323c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -450,6 +450,13 @@ our %feature = (
 		'default' => [0]},
 );
 
+# Basic file handler for all of gitweb, there are two of them.  The first
+# is the basic text/html file handler which is used for everything other
+# then the binary files, that uses a separate file handler though
+# these are both set to STDOUT for the time being.
+our $output_handler = *STDOUT;
+our $output_handler_bin = *STDOUT;
+
 sub gitweb_get_feature {
 	my ($name) = @_;
 	return unless exists $feature{$name};
@@ -3081,7 +3088,7 @@ sub insert_file {
 	my $filename = shift;
 
 	open my $fd, '<', $filename;
-	print map { to_utf8($_) } <$fd>;
+	print {$output_handler} map { to_utf8($_) } <$fd>;
 	close $fd;
 }
 
@@ -3198,10 +3205,10 @@ sub git_header_html {
 	} else {
 		$content_type = 'text/html';
 	}
-	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
+	print {$output_handler} $cgi->header(-type=>$content_type, -charset => 'utf-8',
 	                   -status=> $status, -expires => $expires);
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
-	print <<EOF;
+	print {$output_handler} <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US" lang="en-US">
@@ -3216,16 +3223,16 @@ EOF
 	# the stylesheet, favicon etc urls won't work correctly with path_info
 	# unless we set the appropriate base URL
 	if ($ENV{'PATH_INFO'}) {
-		print "<base href=\"".esc_url($base_url)."\" />\n";
+		print {$output_handler} "<base href=\"".esc_url($base_url)."\" />\n";
 	}
 	# print out each stylesheet that exist, providing backwards capability
 	# for those people who defined $stylesheet in a config file
 	if (defined $stylesheet) {
-		print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
+		print {$output_handler} '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
 	} else {
 		foreach my $stylesheet (@stylesheets) {
 			next unless $stylesheet;
-			print '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
+			print {$output_handler} '<link rel="stylesheet" type="text/css" href="'.$stylesheet.'"/>'."\n";
 		}
 	}
 	if (defined $project) {
@@ -3244,7 +3251,7 @@ EOF
 
 			$href_params{'action'} = $type;
 			$link_attr{'-href'} = href(%href_params);
-			print "<link ".
+			print {$output_handler} "<link ".
 			      "rel=\"$link_attr{'-rel'}\" ".
 			      "title=\"$link_attr{'-title'}\" ".
 			      "href=\"$link_attr{'-href'}\" ".
@@ -3254,7 +3261,7 @@ EOF
 			$href_params{'extra_options'} = '--no-merges';
 			$link_attr{'-href'} = href(%href_params);
 			$link_attr{'-title'} .= ' (no merges)';
-			print "<link ".
+			print {$output_handler} "<link ".
 			      "rel=\"$link_attr{'-rel'}\" ".
 			      "title=\"$link_attr{'-title'}\" ".
 			      "href=\"$link_attr{'-href'}\" ".
@@ -3263,37 +3270,37 @@ EOF
 		}
 
 	} else {
-		printf('<link rel="alternate" title="%s projects list" '.
+		printf( {$output_handler} '<link rel="alternate" title="%s projects list" '.
 		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
 		       $site_name, href(project=>undef, action=>"project_index"));
-		printf('<link rel="alternate" title="%s projects feeds" '.
+		printf( {$output_handler} '<link rel="alternate" title="%s projects feeds" '.
 		       'href="%s" type="text/x-opml" />'."\n",
 		       $site_name, href(project=>undef, action=>"opml"));
 	}
 	if (defined $favicon) {
-		print qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
+		print {$output_handler} qq(<link rel="shortcut icon" href="$favicon" type="image/png" />\n);
 	}
 
-	print "</head>\n" .
+	print {$output_handler} "</head>\n" .
 	      "<body>\n";
 
 	if ($site_header && -f $site_header) {
 		insert_file($site_header);
 	}
 
-	print "<div class=\"page_header\">\n" .
+	print {$output_handler} "<div class=\"page_header\">\n" .
 	      $cgi->a({-href => esc_url($logo_url),
 	               -title => $logo_label},
 	              qq(<img src="$logo" width="72" height="27" alt="git" class="logo"/>));
-	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
+	print {$output_handler} $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
-		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
+		print {$output_handler} $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
-			print " / $action";
+			print {$output_handler} " / $action";
 		}
-		print "\n";
+		print {$output_handler} "\n";
 	}
-	print "</div>\n";
+	print {$output_handler} "</div>\n";
 
 	my $have_search = gitweb_check_feature('search');
 	if (defined $project && $have_search) {
@@ -3313,7 +3320,7 @@ EOF
 		if ($use_pathinfo) {
 			$action .= "/".esc_url($project);
 		}
-		print $cgi->startform(-method => "get", -action => $action) .
+		print {$output_handler} $cgi->startform(-method => "get", -action => $action) .
 		      "<div class=\"search\">\n" .
 		      (!$use_pathinfo &&
 		      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
@@ -3336,11 +3343,11 @@ EOF
 sub git_footer_html {
 	my $feed_class = 'rss_logo';
 
-	print "<div class=\"page_footer\">\n";
+	print {$output_handler} "<div class=\"page_footer\">\n";
 	if (defined $project) {
 		my $descr = git_get_project_description($project);
 		if (defined $descr) {
-			print "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
+			print {$output_handler} "<div class=\"page_footer_text\">" . esc_html($descr) . "</div>\n";
 		}
 
 		my %href_params = get_feed_info();
@@ -3351,22 +3358,22 @@ sub git_footer_html {
 
 		foreach my $format qw(RSS Atom) {
 			$href_params{'action'} = lc($format);
-			print $cgi->a({-href => href(%href_params),
+			print {$output_handler} $cgi->a({-href => href(%href_params),
 			              -title => "$href_params{'-title'} $format feed",
 			              -class => $feed_class}, $format)."\n";
 		}
 
 	} else {
-		print $cgi->a({-href => href(project=>undef, action=>"opml"),
+		print {$output_handler} $cgi->a({-href => href(project=>undef, action=>"opml"),
 		              -class => $feed_class}, "OPML") . " ";
-		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
+		print {$output_handler} $cgi->a({-href => href(project=>undef, action=>"project_index"),
 		              -class => $feed_class}, "TXT") . "\n";
 	}
-	print "</div>\n"; # class="page_footer"
+	print {$output_handler} "</div>\n"; # class="page_footer"
 
 	if (defined $t0 && gitweb_check_feature('timed')) {
-		print "<div id=\"generating_info\">\n";
-		print 'This page took '.
+		print {$output_handler} "<div id=\"generating_info\">\n";
+		print {$output_handler} 'This page took '.
 		      '<span id="generating_time" class="time_span">'.
 		      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 		      ' seconds </span>'.
@@ -3375,26 +3382,26 @@ sub git_footer_html {
 		      $number_of_git_cmds.
 		      '</span> git commands '.
 		      " to generate.\n";
-		print "</div>\n"; # class="page_footer"
+		print {$output_handler} "</div>\n"; # class="page_footer"
 	}
 
 	if (-f $site_footer) {
 		insert_file($site_footer);
 	}
 
-	print qq!<script type="text/javascript" src="$javascript"></script>\n!;
+	print {$output_handler} qq!<script type="text/javascript" src="$javascript"></script>\n!;
 	if ($action eq 'blame_incremental') {
-		print qq!<script type="text/javascript">\n!.
+		print {$output_handler} qq!<script type="text/javascript">\n!.
 		      qq!startBlame("!. href(action=>"blame_data", -replay=>1) .qq!",\n!.
 		      qq!           "!. href() .qq!");\n!.
 		      qq!</script>\n!;
 	} elsif (gitweb_check_feature('javascript-actions')) {
-		print qq!<script type="text/javascript">\n!.
+		print {$output_handler} qq!<script type="text/javascript">\n!.
 		      qq!window.onload = fixLinks;\n!.
 		      qq!</script>\n!;
 	}
 
-	print "</body>\n" .
+	print {$output_handler} "</body>\n" .
 	      "</html>";
 }
 
@@ -3416,6 +3423,14 @@ sub die_error {
 	my $error = shift || "Internal server error";
 	my $extra = shift;
 
+	# The output handlers for die_error need to be reset to STDOUT
+	# so that half the message isn't being output to random and 
+	# half to STDOUT as expected.  This is mainly for the benefit
+	# of using git_header_html() and git_footer_html() since those
+	# internaly use the indirect print handler.
+	$output_handler = *STDOUT;
+	$output_handler_bin = *STDOUT;
+
 	my %http_responses = (
 		400 => '400 Bad Request',
 		403 => '403 Forbidden',
@@ -3484,12 +3499,12 @@ sub git_print_page_nav {
 		$arg{$label}{'_href'} = $link;
 	}
 
-	print "<div class=\"page_nav\">\n" .
+	print {$output_handler} "<div class=\"page_nav\">\n" .
 		(join " | ",
 		 map { $_ eq $current ?
 		       $_ : $cgi->a({-href => ($arg{$_}{_href} ? $arg{$_}{_href} : href(%{$arg{$_}}))}, "$_")
 		 } @navs);
-	print "<br/>\n$extra<br/>\n" .
+	print {$output_handler} "<br/>\n$extra<br/>\n" .
 	      "</div>\n";
 }
 
@@ -3530,14 +3545,14 @@ sub git_print_header_div {
 	$args{'hash'} = $hash if $hash;
 	$args{'hash_base'} = $hash_base if $hash_base;
 
-	print "<div class=\"header\">\n" .
+	print {$output_handler} "<div class=\"header\">\n" .
 	      $cgi->a({-href => href(%args), -class => "title"},
 	      $title ? $title : $action) .
 	      "\n</div>\n";
 }
 
 sub print_local_time {
-	print get_local_time(@_);
+	print {$output_handler} get_local_time(@_);
 }
 
 sub get_local_time {
@@ -3562,11 +3577,11 @@ sub git_print_authorship {
 	my $author = $co->{'author_name'};
 
 	my %ad = parse_date($co->{'author_epoch'}, $co->{'author_tz'});
-	print "<$tag class=\"author_date\">" .
+	print {$output_handler} "<$tag class=\"author_date\">" .
 	      format_search_author($author, "author", esc_html($author)) .
 	      " [$ad{'rfc2822'}";
-	print_local_time(%ad) if ($opts{-localtime});
-	print "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
+	print {$output_handler} get_local_time(%ad) if ($opts{-localtime});
+	print {$output_handler} "]" . git_get_avatar($co->{'author_email'}, -pad_before => 1)
 		  . "</$tag>\n";
 }
 
@@ -3582,7 +3597,7 @@ sub git_print_authorship_rows {
 	@people = ('author', 'committer') unless @people;
 	foreach my $who (@people) {
 		my %wd = parse_date($co->{"${who}_epoch"}, $co->{"${who}_tz"});
-		print "<tr><td>$who</td><td>" .
+		print {$output_handler} "<tr><td>$who</td><td>" .
 		      format_search_author($co->{"${who}_name"}, $who,
 			       esc_html($co->{"${who}_name"})) . " " .
 		      format_search_author($co->{"${who}_email"}, $who,
@@ -3592,8 +3607,8 @@ sub git_print_authorship_rows {
 		      "</td></tr>\n" .
 		      "<tr>" .
 		      "<td></td><td> $wd{'rfc2822'}";
-		print_local_time(%wd);
-		print "</td>" .
+		print {$output_handler} get_local_time(%wd);
+		print {$output_handler} "</td>" .
 		      "</tr>\n";
 	}
 }
@@ -3603,11 +3618,10 @@ sub git_print_page_path {
 	my $type = shift;
 	my $hb = shift;
 
-
-	print "<div class=\"page_path\">";
-	print $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
+	print {$output_handler} "<div class=\"page_path\">";
+	print {$output_handler} $cgi->a({-href => href(action=>"tree", hash_base=>$hb),
 	              -title => 'tree root'}, to_utf8("[$project]"));
-	print " / ";
+	print {$output_handler} " / ";
 	if (defined $name) {
 		my @dirname = split '/', $name;
 		my $basename = pop @dirname;
@@ -3615,25 +3629,25 @@ sub git_print_page_path {
 
 		foreach my $dir (@dirname) {
 			$fullname .= ($fullname ? '/' : '') . $dir;
-			print $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
+			print {$output_handler} $cgi->a({-href => href(action=>"tree", file_name=>$fullname,
 			                             hash_base=>$hb),
 			              -title => $fullname}, esc_path($dir));
-			print " / ";
+			print {$output_handler} " / ";
 		}
 		if (defined $type && $type eq 'blob') {
-			print $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
+			print {$output_handler} $cgi->a({-href => href(action=>"blob_plain", file_name=>$file_name,
 			                             hash_base=>$hb),
 			              -title => $name}, esc_path($basename));
 		} elsif (defined $type && $type eq 'tree') {
-			print $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
+			print {$output_handler} $cgi->a({-href => href(action=>"tree", file_name=>$file_name,
 			                             hash_base=>$hb),
 			              -title => $name}, esc_path($basename));
-			print " / ";
+			print {$output_handler} " / ";
 		} else {
-			print esc_path($basename);
+			print {$output_handler} esc_path($basename);
 		}
 	}
-	print "<br/></div>\n";
+	print {$output_handler} "<br/></div>\n";
 }
 
 sub git_print_log {
@@ -3657,7 +3671,7 @@ sub git_print_log {
 			$signoff = 1;
 			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
-				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
+				print {$output_handler} "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
 				next;
 			} else {
 				# remove signoff lines
@@ -3676,12 +3690,12 @@ sub git_print_log {
 			$empty = 0;
 		}
 
-		print format_log_line_html($line) . "<br/>\n";
+		print {$output_handler} format_log_line_html($line) . "<br/>\n";
 	}
 
 	if ($opts{'-final_empty_line'}) {
 		# end with single empty line
-		print "<br/>\n" unless $empty;
+		print {$output_handler} "<br/>\n" unless $empty;
 	}
 }
 
@@ -3754,12 +3768,12 @@ sub git_print_tree_entry {
 	# the mode of the entry, list is the name of the entry, an href,
 	# and link is the action links of the entry.
 
-	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
+	print {$output_handler} "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
 	if (exists $t->{'size'}) {
-		print "<td class=\"size\">$t->{'size'}</td>\n";
+		print {$output_handler} "<td class=\"size\">$t->{'size'}</td>\n";
 	}
 	if ($t->{'type'} eq "blob") {
-		print "<td class=\"list\">" .
+		print {$output_handler} "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 			                       file_name=>"$basedir$t->{'name'}", %base_key),
 			        -class => "list"}, esc_path($t->{'name'}));
@@ -3768,71 +3782,71 @@ sub git_print_tree_entry {
 			if ($link_target) {
 				my $norm_target = normalize_link_target($link_target, $basedir);
 				if (defined $norm_target) {
-					print " -> " .
+					print {$output_handler} " -> " .
 					      $cgi->a({-href => href(action=>"object", hash_base=>$hash_base,
 					                             file_name=>$norm_target),
 					               -title => $norm_target}, esc_path($link_target));
 				} else {
-					print " -> " . esc_path($link_target);
+					print {$output_handler} " -> " . esc_path($link_target);
 				}
 			}
 		}
-		print "</td>\n";
-		print "<td class=\"link\">";
-		print $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
+		print {$output_handler} "</td>\n";
+		print {$output_handler} "<td class=\"link\">";
+		print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}", %base_key)},
 		              "blob");
 		if ($have_blame) {
-			print " | " .
+			print {$output_handler} " | " .
 			      $cgi->a({-href => href(action=>"blame", hash=>$t->{'hash'},
 			                             file_name=>"$basedir$t->{'name'}", %base_key)},
 			              "blame");
 		}
 		if (defined $hash_base) {
-			print " | " .
+			print {$output_handler} " | " .
 			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             hash=>$t->{'hash'}, file_name=>"$basedir$t->{'name'}")},
 			              "history");
 		}
-		print " | " .
+		print {$output_handler} " | " .
 			$cgi->a({-href => href(action=>"blob_plain", hash_base=>$hash_base,
 			                       file_name=>"$basedir$t->{'name'}")},
 			        "raw");
-		print "</td>\n";
+		print {$output_handler} "</td>\n";
 
 	} elsif ($t->{'type'} eq "tree") {
-		print "<td class=\"list\">";
-		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+		print {$output_handler} "<td class=\"list\">";
+		print {$output_handler} $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}",
 		                             %base_key)},
 		              esc_path($t->{'name'}));
-		print "</td>\n";
-		print "<td class=\"link\">";
-		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
+		print {$output_handler} "</td>\n";
+		print {$output_handler} "<td class=\"link\">";
+		print {$output_handler} $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
 		                             file_name=>"$basedir$t->{'name'}",
 		                             %base_key)},
 		              "tree");
 		if (defined $hash_base) {
-			print " | " .
+			print {$output_handler} " | " .
 			      $cgi->a({-href => href(action=>"history", hash_base=>$hash_base,
 			                             file_name=>"$basedir$t->{'name'}")},
 			              "history");
 		}
-		print "</td>\n";
+		print {$output_handler} "</td>\n";
 	} else {
 		# unknown object: we can only present history for it
 		# (this includes 'commit' object, i.e. submodule support)
-		print "<td class=\"list\">" .
+		print {$output_handler} "<td class=\"list\">" .
 		      esc_path($t->{'name'}) .
 		      "</td>\n";
-		print "<td class=\"link\">";
+		print {$output_handler} "<td class=\"link\">";
 		if (defined $hash_base) {
-			print $cgi->a({-href => href(action=>"history",
+			print {$output_handler} $cgi->a({-href => href(action=>"history",
 			                             hash_base=>$hash_base,
 			                             file_name=>"$basedir$t->{'name'}")},
 			              "history");
 		}
-		print "</td>\n";
+		print {$output_handler} "</td>\n";
 	}
 }
 
@@ -3879,13 +3893,13 @@ sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
 	my $have_blame = gitweb_check_feature('blame');
-	print "<div class=\"list_head\">\n";
+	print {$output_handler} "<div class=\"list_head\">\n";
 	if ($#{$difftree} > 10) {
-		print(($#{$difftree} + 1) . " files changed:\n");
+		print {$output_handler} (($#{$difftree} + 1) . " files changed:\n");
 	}
-	print "</div>\n";
+	print {$output_handler} "</div>\n";
 
-	print "<table class=\"" .
+	print {$output_handler} "<table class=\"" .
 	      (@parents > 1 ? "combined " : "") .
 	      "diff_tree\">\n";
 
@@ -3893,11 +3907,11 @@ sub git_difftree_body {
 	my $has_header = @$difftree && @parents > 1 && $action eq 'commitdiff';
 	if ($has_header) {
 		# table header
-		print "<thead><tr>\n" .
+		print {$output_handler} "<thead><tr>\n" .
 		       "<th></th><th></th>\n"; # filename, patchN link
 		for (my $i = 0; $i < @parents; $i++) {
 			my $par = $parents[$i];
-			print "<th>" .
+			print {$output_handler} "<th>" .
 			      $cgi->a({-href => href(action=>"commitdiff",
 			                             hash=>$hash, hash_parent=>$par),
 			               -title => 'commitdiff to parent number ' .
@@ -3905,7 +3919,7 @@ sub git_difftree_body {
 			              $i+1) .
 			      "&nbsp;</th>\n";
 		}
-		print "</tr></thead>\n<tbody>\n";
+		print {$output_handler} "</tr></thead>\n<tbody>\n";
 	}
 
 	my $alternate = 1;
@@ -3914,9 +3928,9 @@ sub git_difftree_body {
 		my $diff = parsed_difftree_line($line);
 
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
 
@@ -3927,14 +3941,14 @@ sub git_difftree_body {
 
 			if (!is_deleted($diff)) {
 				# file exists in the result (child) commit
-				print "<td>" .
+				print {$output_handler} "<td>" .
 				      $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
 				                             file_name=>$diff->{'to_file'},
 				                             hash_base=>$hash),
 				              -class => "list"}, esc_path($diff->{'to_file'})) .
 				      "</td>\n";
 			} else {
-				print "<td>" .
+				print {$output_handler} "<td>" .
 				      esc_path($diff->{'to_file'}) .
 				      "</td>\n";
 			}
@@ -3942,7 +3956,7 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print "<td class=\"link\">" .
+				print {$output_handler} "<td class=\"link\">" .
 				      $cgi->a({-href => "#patch$patchno"}, "patch") .
 				      " | " .
 				      "</td>\n";
@@ -3960,9 +3974,9 @@ sub git_difftree_body {
 				$not_deleted ||= ($status ne 'D');
 
 				if ($status eq 'A') {
-					print "<td  class=\"link\" align=\"right\"> | </td>\n";
+					print {$output_handler} "<td  class=\"link\" align=\"right\"> | </td>\n";
 				} elsif ($status eq 'D') {
-					print "<td class=\"link\">" .
+					print {$output_handler} "<td class=\"link\">" .
 					      $cgi->a({-href => href(action=>"blob",
 					                             hash_base=>$hash,
 					                             hash=>$from_hash,
@@ -3971,11 +3985,11 @@ sub git_difftree_body {
 					      " | </td>\n";
 				} else {
 					if ($diff->{'to_id'} eq $from_hash) {
-						print "<td class=\"link nochange\">";
+						print {$output_handler} "<td class=\"link nochange\">";
 					} else {
-						print "<td class=\"link\">";
+						print {$output_handler} "<td class=\"link\">";
 					}
-					print $cgi->a({-href => href(action=>"blobdiff",
+					print {$output_handler} $cgi->a({-href => href(action=>"blobdiff",
 					                             hash=>$diff->{'to_id'},
 					                             hash_parent=>$from_hash,
 					                             hash_base=>$hash,
@@ -3987,24 +4001,24 @@ sub git_difftree_body {
 				}
 			}
 
-			print "<td class=\"link\">";
+			print {$output_handler} "<td class=\"link\">";
 			if ($not_deleted) {
-				print $cgi->a({-href => href(action=>"blob",
+				print {$output_handler} $cgi->a({-href => href(action=>"blob",
 				                             hash=>$diff->{'to_id'},
 				                             file_name=>$diff->{'to_file'},
 				                             hash_base=>$hash)},
 				              "blob");
-				print " | " if ($has_history);
+				print {$output_handler} " | " if ($has_history);
 			}
 			if ($has_history) {
-				print $cgi->a({-href => href(action=>"history",
+				print {$output_handler} $cgi->a({-href => href(action=>"history",
 				                             file_name=>$diff->{'to_file'},
 				                             hash_base=>$hash)},
 				              "history");
 			}
-			print "</td>\n";
+			print {$output_handler} "</td>\n";
 
-			print "</tr>\n";
+			print {$output_handler} "</tr>\n";
 			next; # instead of 'else' clause, to avoid extra indent
 		}
 		# else ordinary diff
@@ -4030,51 +4044,51 @@ sub git_difftree_body {
 			my $mode_chng = "<span class=\"file_status new\">[new $to_file_type";
 			$mode_chng   .= " with mode: $to_mode_str" if $to_mode_str;
 			$mode_chng   .= "]</span>";
-			print "<td>";
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
+			print {$output_handler} "<td>";
+			print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
-			print "</td>\n";
-			print "<td>$mode_chng</td>\n";
-			print "<td class=\"link\">";
+			print {$output_handler} "</td>\n";
+			print {$output_handler} "<td>$mode_chng</td>\n";
+			print {$output_handler} "<td class=\"link\">";
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
-				print " | ";
+				print {$output_handler} $cgi->a({-href => "#patch$patchno"}, "patch");
+				print {$output_handler} " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
+			print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff->{'file'})},
 			              "blob");
-			print "</td>\n";
+			print {$output_handler} "</td>\n";
 
 		} elsif ($diff->{'status'} eq "D") { # deleted
 			my $mode_chng = "<span class=\"file_status deleted\">[deleted $from_file_type]</span>";
-			print "<td>";
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
+			print {$output_handler} "<td>";
+			print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff->{'file'}),
 			               -class => "list"}, esc_path($diff->{'file'}));
-			print "</td>\n";
-			print "<td>$mode_chng</td>\n";
-			print "<td class=\"link\">";
+			print {$output_handler} "</td>\n";
+			print {$output_handler} "<td>$mode_chng</td>\n";
+			print {$output_handler} "<td class=\"link\">";
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch");
-				print " | ";
+				print {$output_handler} $cgi->a({-href => "#patch$patchno"}, "patch");
+				print {$output_handler} " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
+			print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$diff->{'from_id'},
 			                             hash_base=>$parent, file_name=>$diff->{'file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
-				print $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
+				print {$output_handler} $cgi->a({-href => href(action=>"blame", hash_base=>$parent,
 				                             file_name=>$diff->{'file'})},
 				              "blame") . " | ";
 			}
-			print $cgi->a({-href => href(action=>"history", hash_base=>$parent,
+			print {$output_handler} $cgi->a({-href => href(action=>"history", hash_base=>$parent,
 			                             file_name=>$diff->{'file'})},
 			              "history");
-			print "</td>\n";
+			print {$output_handler} "</td>\n";
 
 		} elsif ($diff->{'status'} eq "M" || $diff->{'status'} eq "T") { # modified, or type changed
 			my $mode_chnge = "";
@@ -4092,39 +4106,39 @@ sub git_difftree_body {
 				}
 				$mode_chnge .= "]</span>\n";
 			}
-			print "<td>";
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
+			print {$output_handler} "<td>";
+			print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff->{'file'}),
 			              -class => "list"}, esc_path($diff->{'file'}));
-			print "</td>\n";
-			print "<td>$mode_chnge</td>\n";
-			print "<td class=\"link\">";
+			print {$output_handler} "</td>\n";
+			print {$output_handler} "<td>$mode_chnge</td>\n";
+			print {$output_handler} "<td class=\"link\">";
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print {$output_handler} $cgi->a({-href => "#patch$patchno"}, "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not onlu mode changed)
-				print $cgi->a({-href => href(action=>"blobdiff",
+				print {$output_handler} $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff->{'to_id'}, hash_parent=>$diff->{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
 				                             file_name=>$diff->{'file'})},
 				              "diff") .
 				      " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
+			print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
 			                             hash_base=>$hash, file_name=>$diff->{'file'})},
 			               "blob") . " | ";
 			if ($have_blame) {
-				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
+				print {$output_handler} $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
 				                             file_name=>$diff->{'file'})},
 				              "blame") . " | ";
 			}
-			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
+			print {$output_handler} $cgi->a({-href => href(action=>"history", hash_base=>$hash,
 			                             file_name=>$diff->{'file'})},
 			              "history");
-			print "</td>\n";
+			print {$output_handler} "</td>\n";
 
 		} elsif ($diff->{'status'} eq "R" || $diff->{'status'} eq "C") { # renamed or copied
 			my %status_name = ('R' => 'moved', 'C' => 'copied');
@@ -4134,7 +4148,7 @@ sub git_difftree_body {
 				# mode also for directories, so we cannot use $to_mode_str
 				$mode_chng = sprintf(", mode: %04o", $to_mode_oct & 0777);
 			}
-			print "<td>" .
+			print {$output_handler} "<td>" .
 			      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
 			                             hash=>$diff->{'to_id'}, file_name=>$diff->{'to_file'}),
 			              -class => "list"}, esc_path($diff->{'to_file'})) . "</td>\n" .
@@ -4147,35 +4161,35 @@ sub git_difftree_body {
 			if ($action eq 'commitdiff') {
 				# link to patch
 				$patchno++;
-				print $cgi->a({-href => "#patch$patchno"}, "patch") .
+				print {$output_handler} $cgi->a({-href => "#patch$patchno"}, "patch") .
 				      " | ";
 			} elsif ($diff->{'to_id'} ne $diff->{'from_id'}) {
 				# "commit" view and modified file (not only pure rename or copy)
-				print $cgi->a({-href => href(action=>"blobdiff",
+				print {$output_handler} $cgi->a({-href => href(action=>"blobdiff",
 				                             hash=>$diff->{'to_id'}, hash_parent=>$diff->{'from_id'},
 				                             hash_base=>$hash, hash_parent_base=>$parent,
 				                             file_name=>$diff->{'to_file'}, file_parent=>$diff->{'from_file'})},
 				              "diff") .
 				      " | ";
 			}
-			print $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
+			print {$output_handler} $cgi->a({-href => href(action=>"blob", hash=>$diff->{'to_id'},
 			                             hash_base=>$parent, file_name=>$diff->{'to_file'})},
 			              "blob") . " | ";
 			if ($have_blame) {
-				print $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
+				print {$output_handler} $cgi->a({-href => href(action=>"blame", hash_base=>$hash,
 				                             file_name=>$diff->{'to_file'})},
 				              "blame") . " | ";
 			}
-			print $cgi->a({-href => href(action=>"history", hash_base=>$hash,
+			print {$output_handler} $cgi->a({-href => href(action=>"history", hash_base=>$hash,
 			                            file_name=>$diff->{'to_file'})},
 			              "history");
-			print "</td>\n";
+			print {$output_handler} "</td>\n";
 
 		} # we should not encounter Unmerged (U) or Unknown (X) status
-		print "</tr>\n";
+		print {$output_handler} "</tr>\n";
 	}
-	print "</tbody>" if $has_header;
-	print "</table>\n";
+	print {$output_handler} "</tbody>" if $has_header;
+	print {$output_handler} "</table>\n";
 }
 
 sub git_patchset_body {
@@ -4190,7 +4204,7 @@ sub git_patchset_body {
 	my $to_name;
 	my (%from, %to);
 
-	print "<div class=\"patchset\">\n";
+	print {$output_handler} "<div class=\"patchset\">\n";
 
 	# skip to first patch
 	while ($patch_line = <$fd>) {
@@ -4218,7 +4232,7 @@ sub git_patchset_body {
 		# and parse raw git-diff line if needed
 		if (is_patch_split($diffinfo, { 'to_file' => $to_name })) {
 			# this is continuation of a split patch
-			print "<div class=\"patch cont\">\n";
+			print {$output_handler} "<div class=\"patch cont\">\n";
 		} else {
 			# advance raw git-diff output if needed
 			$patch_idx++ if defined $diffinfo;
@@ -4230,7 +4244,7 @@ sub git_patchset_body {
 			# find which patch (using pathname of result) we are at now;
 			if ($is_combined) {
 				while ($to_name ne $diffinfo->{'to_file'}) {
-					print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
+					print {$output_handler} "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
 					      format_diff_cc_simplified($diffinfo, @hash_parents) .
 					      "</div>\n";  # class="patch"
 
@@ -4247,7 +4261,7 @@ sub git_patchset_body {
 
 			# this is first patch for raw difftree line with $patch_idx index
 			# we index @$difftree array from 0, but number patches from 1
-			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
+			print {$output_handler} "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
 		}
 
 		# git diff header
@@ -4255,25 +4269,25 @@ sub git_patchset_body {
 		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
 		$patch_number++;
 		# print "git diff" header
-		print format_git_diff_header_line($patch_line, $diffinfo,
+		print {$output_handler} format_git_diff_header_line($patch_line, $diffinfo,
 		                                  \%from, \%to);
 
 		# print extended diff header
-		print "<div class=\"diff extended_header\">\n";
+		print {$output_handler} "<div class=\"diff extended_header\">\n";
 	EXTENDED_HEADER:
 		while ($patch_line = <$fd>) {
 			chomp $patch_line;
 
 			last EXTENDED_HEADER if ($patch_line =~ m/^--- |^diff /);
 
-			print format_extended_diff_header_line($patch_line, $diffinfo,
+			print {$output_handler} format_extended_diff_header_line($patch_line, $diffinfo,
 			                                       \%from, \%to);
 		}
-		print "</div>\n"; # class="diff extended_header"
+		print {$output_handler} "</div>\n"; # class="diff extended_header"
 
 		# from-file/to-file diff header
 		if (! $patch_line) {
-			print "</div>\n"; # class="patch"
+			print {$output_handler} "</div>\n"; # class="patch"
 			last PATCH;
 		}
 		next PATCH if ($patch_line =~ m/^diff /);
@@ -4284,7 +4298,7 @@ sub git_patchset_body {
 		chomp $patch_line;
 		#assert($patch_line =~ m/^\+\+\+/) if DEBUG;
 
-		print format_diff_from_to_header($last_patch_line, $patch_line,
+		print {$output_handler} format_diff_from_to_header($last_patch_line, $patch_line,
 		                                 $diffinfo, \%from, \%to,
 		                                 @hash_parents);
 
@@ -4295,11 +4309,11 @@ sub git_patchset_body {
 
 			next PATCH if ($patch_line =~ m/^diff /);
 
-			print format_diff_line($patch_line, \%from, \%to);
+			print {$output_handler} format_diff_line($patch_line, \%from, \%to);
 		}
 
 	} continue {
-		print "</div>\n"; # class="patch"
+		print {$output_handler} "</div>\n"; # class="patch"
 	}
 
 	# for compact combined (--cc) format, with chunk and patch simpliciaction
@@ -4311,7 +4325,7 @@ sub git_patchset_body {
 		$diffinfo = parsed_difftree_line($difftree->[$patch_idx]);
 
 		# generate anchor for "patch" links in difftree / whatchanged part
-		print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
+		print {$output_handler} "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
 		      format_diff_cc_simplified($diffinfo, @hash_parents) .
 		      "</div>\n";  # class="patch"
 
@@ -4320,13 +4334,13 @@ sub git_patchset_body {
 
 	if ($patch_number == 0) {
 		if (@hash_parents > 1) {
-			print "<div class=\"diff nodifferences\">Trivial merge</div>\n";
+			print {$output_handler} "<div class=\"diff nodifferences\">Trivial merge</div>\n";
 		} else {
-			print "<div class=\"diff nodifferences\">No differences found</div>\n";
+			print {$output_handler} "<div class=\"diff nodifferences\">No differences found</div>\n";
 		}
 	}
 
-	print "</div>\n"; # class="patchset"
+	print {$output_handler} "</div>\n"; # class="patchset"
 }
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
@@ -4375,7 +4389,7 @@ sub fill_project_list_info {
 # print 'sort by' <th> element, generating 'sort by $name' replay link
 # if that order is not selected
 sub print_sort_th {
-	print get_sort_th(@_);
+	print {$output_handler} get_sort_th(@_);
 }
 
 sub get_sort_th {
@@ -4428,20 +4442,20 @@ sub git_project_list_body {
 			}
 		}
 		my $cloud = git_populate_project_tagcloud(\%ctags);
-		print git_show_project_tagcloud($cloud, 64);
+		print {$output_handler} git_show_project_tagcloud($cloud, 64);
 	}
 
-	print "<table class=\"project_list\">\n";
+	print {$output_handler} "<table class=\"project_list\">\n";
 	unless ($no_header) {
-		print "<tr>\n";
+		print {$output_handler} "<tr>\n";
 		if ($check_forks) {
-			print "<th></th>\n";
+			print {$output_handler} "<th></th>\n";
 		}
-		print_sort_th('project', $order, 'Project');
-		print_sort_th('descr', $order, 'Description');
-		print_sort_th('owner', $order, 'Owner');
-		print_sort_th('age', $order, 'Last Change');
-		print "<th></th>\n" . # for links
+		print {$output_handler} get_sort_th('project', $order, 'Project');
+		print {$output_handler} get_sort_th('descr', $order, 'Description');
+		print {$output_handler} get_sort_th('owner', $order, 'Owner');
+		print {$output_handler} get_sort_th('age', $order, 'Last Change');
+		print {$output_handler} "<th></th>\n" . # for links
 		      "</tr>\n";
 	}
 	my $alternate = 1;
@@ -4461,26 +4475,26 @@ sub git_project_list_body {
 		}
 
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
 		if ($check_forks) {
-			print "<td>";
+			print {$output_handler} "<td>";
 			if ($pr->{'forks'}) {
-				print "<!-- $pr->{'forks'} -->\n";
-				print $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "+");
+				print {$output_handler} "<!-- $pr->{'forks'} -->\n";
+				print {$output_handler} $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "+");
 			}
-			print "</td>\n";
+			print {$output_handler} "</td>\n";
 		}
-		print "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
-		                        -class => "list"}, esc_html($pr->{'path'})) . "</td>\n" .
+		print {$output_handler} "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
+		                        -class => "list"}, esc_html($pr->{'path'})) ."</td>\n".
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
 		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+		print {$output_handler} "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
@@ -4492,14 +4506,14 @@ sub git_project_list_body {
 		      "</tr>\n";
 	}
 	if (defined $extra) {
-		print "<tr>\n";
+		print {$output_handler} "<tr>\n";
 		if ($check_forks) {
-			print "<td></td>\n";
+			print {$output_handler} "<td></td>\n";
 		}
-		print "<td colspan=\"5\">$extra</td>\n" .
+		print {$output_handler} "<td colspan=\"5\">$extra</td>\n" .
 		      "</tr>\n";
 	}
-	print "</table>\n";
+	print {$output_handler} "</table>\n";
 }
 
 sub git_log_body {
@@ -4519,7 +4533,7 @@ sub git_log_body {
 		               "<span class=\"age\">$co{'age_string'}</span>" .
 		               esc_html($co{'title'}) . $ref,
 		               $commit);
-		print "<div class=\"title_text\">\n" .
+		print {$output_handler} "<div class=\"title_text\">\n" .
 		      "<div class=\"log_link\">\n" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") .
 		      " | " .
@@ -4529,16 +4543,16 @@ sub git_log_body {
 		      "<br/>\n" .
 		      "</div>\n";
 		      git_print_authorship(\%co, -tag => 'span');
-		      print "<br/>\n</div>\n";
+		      print {$output_handler} "<br/>\n</div>\n";
 
-		print "<div class=\"log_body\">\n";
+		print {$output_handler} "<div class=\"log_body\">\n";
 		git_print_log($co{'comment'}, -final_empty_line=> 1);
-		print "</div>\n";
+		print {$output_handler} "</div>\n";
 	}
 	if ($extra) {
-		print "<div class=\"page_nav\">\n";
-		print "$extra\n";
-		print "</div>\n";
+		print {$output_handler} "<div class=\"page_nav\">\n";
+		print {$output_handler} "$extra\n";
+		print {$output_handler} "</div>\n";
 	}
 }
 
@@ -4549,41 +4563,41 @@ sub git_shortlog_body {
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
-	print "<table class=\"shortlog\">\n";
+	print {$output_handler} "<table class=\"shortlog\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my %co = %{$commitlist->[$i]};
 		my $commit = $co{'id'};
 		my $ref = format_ref_marker($refs, $commit);
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
 		# git_summary() used print "<td><i>$co{'age_string'}</i></td>\n" .
-		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+		print {$output_handler} "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      format_author_html('td', \%co, 10) . "<td>";
-		print format_subject_html($co{'title'}, $co{'title_short'},
+		print {$output_handler} format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
 		my $snapshot_links = format_snapshot_links($commit);
 		if (defined $snapshot_links) {
-			print " | " . $snapshot_links;
+			print {$output_handler} " | " . $snapshot_links;
 		}
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "</tr>\n";
 	}
 	if (defined $extra) {
-		print "<tr>\n" .
+		print {$output_handler} "<tr>\n" .
 		      "<td colspan=\"4\">$extra</td>\n" .
 		      "</tr>\n";
 	}
-	print "</table>\n";
+	print {$output_handler} "</table>\n";
 }
 
 sub git_history_body {
@@ -4594,7 +4608,7 @@ sub git_history_body {
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} unless (defined $to && $to <= $#{$commitlist});
 
-	print "<table class=\"history\">\n";
+	print {$output_handler} "<table class=\"history\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my %co = %{$commitlist->[$i]};
@@ -4606,18 +4620,18 @@ sub git_history_body {
 		my $ref = format_ref_marker($refs, $commit);
 
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+		print {$output_handler} "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 	# shortlog:   format_author_html('td', \%co, 10)
 		      format_author_html('td', \%co, 15, 3) . "<td>";
 		# originally git_history used chop_str($co{'title'}, 50)
-		print format_subject_html($co{'title'}, $co{'title_short'},
+		print {$output_handler} format_subject_html($co{'title'}, $co{'title_short'},
 		                          href(action=>"commit", hash=>$commit), $ref);
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>$ftype, hash_base=>$commit, file_name=>$file_name)}, $ftype) . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
@@ -4627,7 +4641,7 @@ sub git_history_body {
 			my $blob_parent  = git_get_hash_by_path($commit, $file_name);
 			if (defined $blob_current && defined $blob_parent &&
 					$blob_current ne $blob_parent) {
-				print " | " .
+				print {$output_handler} " | " .
 					$cgi->a({-href => href(action=>"blobdiff",
 					                       hash=>$blob_current, hash_parent=>$blob_parent,
 					                       hash_base=>$hash_base, hash_parent_base=>$commit,
@@ -4635,15 +4649,15 @@ sub git_history_body {
 					        "diff to current");
 			}
 		}
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "</tr>\n";
 	}
 	if (defined $extra) {
-		print "<tr>\n" .
+		print {$output_handler} "<tr>\n" .
 		      "<td colspan=\"4\">$extra</td>\n" .
 		      "</tr>\n";
 	}
-	print "</table>\n";
+	print {$output_handler} "</table>\n";
 }
 
 sub git_tags_body {
@@ -4652,7 +4666,7 @@ sub git_tags_body {
 	$from = 0 unless defined $from;
 	$to = $#{$taglist} if (!defined $to || $#{$taglist} < $to);
 
-	print "<table class=\"tags\">\n";
+	print {$output_handler} "<table class=\"tags\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $taglist->[$i];
@@ -4663,50 +4677,50 @@ sub git_tags_body {
 			$comment_short = chop_str($comment, 30, 5);
 		}
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
 		if (defined $tag{'age'}) {
-			print "<td><i>$tag{'age'}</i></td>\n";
+			print {$output_handler} "<td><i>$tag{'age'}</i></td>\n";
 		} else {
-			print "<td></td>\n";
+			print {$output_handler} "<td></td>\n";
 		}
-		print "<td>" .
+		print {$output_handler} "<td>" .
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'}),
 		               -class => "list name"}, esc_html($tag{'name'})) .
 		      "</td>\n" .
 		      "<td>";
 		if (defined $comment) {
-			print format_subject_html($comment, $comment_short,
+			print {$output_handler} format_subject_html($comment, $comment_short,
 			                          href(action=>"tag", hash=>$tag{'id'}));
 		}
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "<td class=\"selflink\">";
 		if ($tag{'type'} eq "tag") {
-			print $cgi->a({-href => href(action=>"tag", hash=>$tag{'id'})}, "tag");
+			print {$output_handler} $cgi->a({-href => href(action=>"tag", hash=>$tag{'id'})}, "tag");
 		} else {
-			print "&nbsp;";
+			print {$output_handler} "&nbsp;";
 		}
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "<td class=\"link\">" . " | " .
 		      $cgi->a({-href => href(action=>$tag{'reftype'}, hash=>$tag{'refid'})}, $tag{'reftype'});
 		if ($tag{'reftype'} eq "commit") {
-			print " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'fullname'})}, "shortlog") .
+			print {$output_handler} " | " . $cgi->a({-href => href(action=>"shortlog", hash=>$tag{'fullname'})}, "shortlog") .
 			      " | " . $cgi->a({-href => href(action=>"log", hash=>$tag{'fullname'})}, "log");
 		} elsif ($tag{'reftype'} eq "blob") {
-			print " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw");
+			print {$output_handler} " | " . $cgi->a({-href => href(action=>"blob_plain", hash=>$tag{'refid'})}, "raw");
 		}
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "</tr>";
 	}
 	if (defined $extra) {
-		print "<tr>\n" .
+		print {$output_handler} "<tr>\n" .
 		      "<td colspan=\"5\">$extra</td>\n" .
 		      "</tr>\n";
 	}
-	print "</table>\n";
+	print {$output_handler} "</table>\n";
 }
 
 sub git_heads_body {
@@ -4715,19 +4729,19 @@ sub git_heads_body {
 	$from = 0 unless defined $from;
 	$to = $#{$headlist} if (!defined $to || $#{$headlist} < $to);
 
-	print "<table class=\"heads\">\n";
+	print {$output_handler} "<table class=\"heads\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
 		my %ref = %$entry;
 		my $curr = $ref{'id'} eq $head;
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td><i>$ref{'age'}</i></td>\n" .
+		print {$output_handler} "<td><i>$ref{'age'}</i></td>\n" .
 		      ($curr ? "<td class=\"current_head\">" : "<td>") .
 		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'}),
 		               -class => "list name"},esc_html($ref{'name'})) .
@@ -4740,11 +4754,11 @@ sub git_heads_body {
 		      "</tr>";
 	}
 	if (defined $extra) {
-		print "<tr>\n" .
+		print {$output_handler} "<tr>\n" .
 		      "<td colspan=\"3\">$extra</td>\n" .
 		      "</tr>\n";
 	}
-	print "</table>\n";
+	print {$output_handler} "</table>\n";
 }
 
 sub git_search_grep_body {
@@ -4752,7 +4766,7 @@ sub git_search_grep_body {
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
-	print "<table class=\"commit_search\">\n";
+	print {$output_handler} "<table class=\"commit_search\">\n";
 	my $alternate = 1;
 	for (my $i = $from; $i <= $to; $i++) {
 		my %co = %{$commitlist->[$i]};
@@ -4761,12 +4775,12 @@ sub git_search_grep_body {
 		}
 		my $commit = $co{'id'};
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
-		print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+		print {$output_handler} "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 		      format_author_html('td', \%co, 15, 5) .
 		      "<td>" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
@@ -4786,25 +4800,25 @@ sub git_search_grep_body {
 				$match = esc_html($match);
 				$trail = esc_html($trail);
 
-				print "$lead<span class=\"match\">$match</span>$trail<br />";
+				print {$output_handler} "$lead<span class=\"match\">$match</span>$trail<br />";
 			}
 		}
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "<td class=\"link\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
 		      " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$co{'id'})}, "commitdiff") .
 		      " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-		print "</td>\n" .
+		print {$output_handler} "</td>\n" .
 		      "</tr>\n";
 	}
 	if (defined $extra) {
-		print "<tr>\n" .
+		print {$output_handler} "<tr>\n" .
 		      "<td colspan=\"3\">$extra</td>\n" .
 		      "</tr>\n";
 	}
-	print "</table>\n";
+	print {$output_handler} "</table>\n";
 }
 
 ## ======================================================================
@@ -4824,11 +4838,11 @@ sub git_project_list {
 
 	git_header_html();
 	if (-f $home_text) {
-		print "<div class=\"index_include\">\n";
+		print {$output_handler} "<div class=\"index_include\">\n";
 		insert_file($home_text);
-		print "</div>\n";
+		print {$output_handler} "</div>\n";
 	}
-	print $cgi->startform(-method => "get") .
+	print {$output_handler} $cgi->startform(-method => "get") .
 	      "<p class=\"projsearch\">Search:\n" .
 	      $cgi->textfield(-name => "s", -value => $searchtext) . "\n" .
 	      "</p>" .
@@ -4858,7 +4872,7 @@ sub git_forks {
 sub git_project_index {
 	my @projects = git_get_projects_list($project);
 
-	print $cgi->header(
+	print {$output_handler} $cgi->header(
 		-type => 'text/plain',
 		-charset => 'utf-8',
 		-content_disposition => 'inline; filename="index.aux"');
@@ -4875,7 +4889,7 @@ sub git_project_index {
 		$path  =~ s/ /\+/g;
 		$owner =~ s/ /\+/g;
 
-		print "$path $owner\n";
+		print {$output_handler} "$path $owner\n";
 	}
 }
 
@@ -4902,12 +4916,12 @@ sub git_summary {
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
-	print "<div class=\"title\">&nbsp;</div>\n";
-	print "<table class=\"projects_list\">\n" .
+	print {$output_handler} "<div class=\"title\">&nbsp;</div>\n";
+	print {$output_handler} "<table class=\"projects_list\">\n" .
 	      "<tr id=\"metadata_desc\"><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr id=\"metadata_owner\"><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
 	if (defined $cd{'rfc2822'}) {
-		print "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
+		print {$output_handler} "<tr id=\"metadata_lchange\"><td>last change</td><td>$cd{'rfc2822'}</td></tr>\n";
 	}
 
 	# use per project git URL list in $projectroot/$project/cloneurl
@@ -4917,7 +4931,7 @@ sub git_summary {
 	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
 	foreach my $git_url (@url_list) {
 		next unless $git_url;
-		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
+		print {$output_handler} "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
 		$url_tag = "";
 	}
 
@@ -4926,23 +4940,23 @@ sub git_summary {
 	if ($show_ctags) {
 		my $ctags = git_get_project_ctags($project);
 		my $cloud = git_populate_project_tagcloud($ctags);
-		print "<tr id=\"metadata_ctags\"><td>Content tags:<br />";
-		print "</td>\n<td>" unless %$ctags;
-		print "<form action=\"$show_ctags\" method=\"post\"><input type=\"hidden\" name=\"p\" value=\"$project\" />Add: <input type=\"text\" name=\"t\" size=\"8\" /></form>";
-		print "</td>\n<td>" if %$ctags;
-		print git_show_project_tagcloud($cloud, 48);
-		print "</td></tr>";
+		print {$output_handler} "<tr id=\"metadata_ctags\"><td>Content tags:<br />";
+		print {$output_handler} "</td>\n<td>" unless %$ctags;
+		print {$output_handler} "<form action=\"$show_ctags\" method=\"post\"><input type=\"hidden\" name=\"p\" value=\"$project\" />Add: <input type=\"text\" name=\"t\" size=\"8\" /></form>";
+		print {$output_handler} "</td>\n<td>" if %$ctags;
+		print {$output_handler} git_show_project_tagcloud($cloud, 48);
+		print {$output_handler} "</td></tr>";
 	}
 
-	print "</table>\n";
+	print {$output_handler} "</table>\n";
 
 	# If XSS prevention is on, we don't include README.html.
 	# TODO: Allow a readme in some safe format.
 	if (!$prevent_xss && -s "$projectroot/$project/README.html") {
-		print "<div class=\"title\">readme</div>\n" .
+		print {$output_handler} "<div class=\"title\">readme</div>\n" .
 		      "<div class=\"readme\">\n";
 		insert_file("$projectroot/$project/README.html");
-		print "\n</div>\n"; # class="readme"
+		print {$output_handler} "\n</div>\n"; # class="readme"
 	}
 
 	# we need to request one more than 16 (0..15) to check if
@@ -4991,7 +5005,7 @@ sub git_tag {
 	}
 
 	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
-	print "<div class=\"title_text\">\n" .
+	print {$output_handler} "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n" .
 	      "<tr>\n" .
 	      "<td>object</td>\n" .
@@ -5003,15 +5017,15 @@ sub git_tag {
 	if (defined($tag{'author'})) {
 		git_print_authorship_rows(\%tag, 'author');
 	}
-	print "</table>\n\n" .
+	print {$output_handler} "</table>\n\n" .
 	      "</div>\n";
-	print "<div class=\"page_body\">";
+	print {$output_handler} "<div class=\"page_body\">";
 	my $comment = $tag{'comment'};
 	foreach my $line (@$comment) {
 		chomp $line;
-		print esc_html($line, -nbsp=>1) . "<br/>\n";
+		print {$output_handler} esc_html($line, -nbsp=>1) . "<br/>\n";
 	}
-	print "</div>\n";
+	print {$output_handler} "</div>\n";
 	git_footer_html();
 }
 
@@ -5062,21 +5076,23 @@ sub git_blame_common {
 
 	# incremental blame data returns early
 	if ($format eq 'data') {
-		print $cgi->header(
+		print {$output_handler} $cgi->header(
 			-type=>"text/plain", -charset => "utf-8",
 			-status=> "200 OK");
 		local $| = 1; # output autoflush
-		print while <$fd>;
+		while (<$fd>) {
+			 print {$output_handler} $_;
+		}
 		close $fd
-			or print "ERROR $!\n";
+			or die_error(500, "ERROR $!\n");
 
-		print 'END';
+		print {$output_handler} 'END';
 		if (defined $t0 && gitweb_check_feature('timed')) {
-			print ' '.
+			print {$output_handler} ' '.
 			      Time::HiRes::tv_interval($t0, [Time::HiRes::gettimeofday()]).
 			      ' '.$number_of_git_cmds;
 		}
-		print "\n";
+		print {$output_handler} "\n";
 
 		return;
 	}
@@ -5109,20 +5125,20 @@ sub git_blame_common {
 
 	# page body
 	if ($format eq 'incremental') {
-		print "<noscript>\n<div class=\"error\"><center><b>\n".
+		print {$output_handler} "<noscript>\n<div class=\"error\"><center><b>\n".
 		      "This page requires JavaScript to run.\n Use ".
 		      $cgi->a({-href => href(action=>'blame',javascript=>0,-replay=>1)},
 		              'this page').
 		      " instead.\n".
 		      "</b></center></div>\n</noscript>\n";
 
-		print qq!<div id="progress_bar" style="width: 100%; background-color: yellow"></div>\n!;
+		print {$output_handler} qq!<div id="progress_bar" style="width: 100%; background-color: yellow"></div>\n!;
 	}
 
-	print qq!<div class="page_body">\n!;
-	print qq!<div id="progress_info">... / ...</div>\n!
+	print {$output_handler} qq!<div class="page_body">\n!;
+	print {$output_handler} qq!<div id="progress_info">... / ...</div>\n!
 		if ($format eq 'incremental');
-	print qq!<table id="blame_table" class="blame" width="100%">\n!.
+	print {$output_handler} qq!<table id="blame_table" class="blame" width="100%">\n!.
 	      #qq!<col width="5.5em" /><col width="2.5em" /><col width="*" />\n!.
 	      qq!<thead>\n!.
 	      qq!<tr><th>Commit</th><th>Line</th><th>Data</th></tr>\n!.
@@ -5143,12 +5159,12 @@ sub git_blame_common {
 			chomp $line;
 			$linenr++;
 
-			print qq!<tr id="l$linenr" class="$color_class">!.
+			print {$output_handler} qq!<tr id="l$linenr" class="$color_class">!.
 			      qq!<td class="sha1"><a href=""> </a></td>!.
 			      qq!<td class="linenr">!.
 			      qq!<a class="linenr" href="">$linenr</a></td>!;
-			print qq!<td class="pre">! . esc_html($line) . "</td>\n";
-			print qq!</tr>\n!;
+			print {$output_handler} qq!<td class="pre">! . esc_html($line) . "</td>\n";
+			print {$output_handler} qq!</tr>\n!;
 		}
 
 	} else { # porcelain, i.e. ordinary blame
@@ -5189,25 +5205,25 @@ sub git_blame_common {
 			$tr_class .= ' boundary' if (exists $meta->{'boundary'});
 			$tr_class .= ' no-previous' if ($meta->{'nprevious'} == 0);
 			$tr_class .= ' multiple-previous' if ($meta->{'nprevious'} > 1);
-			print "<tr id=\"l$lineno\" class=\"$tr_class\">\n";
+			print {$output_handler} "<tr id=\"l$lineno\" class=\"$tr_class\">\n";
 			if ($group_size) {
-				print "<td class=\"sha1\"";
-				print " title=\"". esc_html($author) . ", $date\"";
-				print " rowspan=\"$group_size\"" if ($group_size > 1);
-				print ">";
-				print $cgi->a({-href => href(action=>"commit",
+				print {$output_handler} "<td class=\"sha1\"";
+				print {$output_handler} " title=\"". esc_html($author) . ", $date\"";
+				print {$output_handler} " rowspan=\"$group_size\"" if ($group_size > 1);
+				print {$output_handler} ">";
+				print {$output_handler} $cgi->a({-href => href(action=>"commit",
 				                             hash=>$full_rev,
 				                             file_name=>$file_name)},
 				              esc_html($short_rev));
 				if ($group_size >= 2) {
 					my @author_initials = ($author =~ /\b([[:upper:]])\B/g);
 					if (@author_initials) {
-						print "<br />" .
+						print {$output_handler} "<br />" .
 						      esc_html(join('', @author_initials));
 						#           or join('.', ...)
 					}
 				}
-				print "</td>\n";
+				print {$output_handler} "</td>\n";
 			}
 			# 'previous' <sha1 of parent commit> <filename at commit>
 			if (exists $meta->{'previous'} &&
@@ -5224,23 +5240,23 @@ sub git_blame_common {
 			my $blamed = href(action => 'blame',
 			                  file_name => $linenr_filename,
 			                  hash_base => $linenr_commit);
-			print "<td class=\"linenr\">";
-			print $cgi->a({ -href => "$blamed#l$orig_lineno",
+			print {$output_handler} "<td class=\"linenr\">";
+			print {$output_handler} $cgi->a({ -href => "$blamed#l$orig_lineno",
 			                -class => "linenr" },
 			              esc_html($lineno));
-			print "</td>";
-			print "<td class=\"pre\">" . esc_html($data) . "</td>\n";
-			print "</tr>\n";
+			print {$output_handler} "</td>";
+			print {$output_handler} "<td class=\"pre\">" . esc_html($data) . "</td>\n";
+			print {$output_handler} "</tr>\n";
 		} # end while
 
 	}
 
 	# footer
-	print "</tbody>\n".
+	print {$output_handler} "</tbody>\n".
 	      "</table>\n"; # class="blame"
-	print "</div>\n";   # class="blame_body"
+	print {$output_handler} "</div>\n";   # class="blame_body"
 	close $fd
-		or print "Reading blob failed\n";
+		or print {$output_handler} "Reading blob failed\n";
 
 	git_footer_html();
 }
@@ -5323,16 +5339,17 @@ sub git_blob_plain {
 	my $sandbox = $prevent_xss &&
 		$type !~ m!^(?:text/plain|image/(?:gif|png|jpeg))$!;
 
-	print $cgi->header(
+	print {$output_handler} $cgi->header(
 		-type => $type,
 		-expires => $expires,
 		-content_disposition =>
 			($sandbox ? 'attachment' : 'inline')
 			. '; filename="' . $save_as . '"');
 	local $/ = undef;
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+
+	binmode $output_handler_bin, ':raw';
+	print {$output_handler_bin} <$fd>;
+	binmode $output_handler_bin, ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
 }
 
@@ -5391,18 +5408,18 @@ sub git_blob {
 		git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 	} else {
-		print "<div class=\"page_nav\">\n" .
+		print {$output_handler} "<div class=\"page_nav\">\n" .
 		      "<br/><br/></div>\n" .
 		      "<div class=\"title\">$hash</div>\n";
 	}
 	git_print_page_path($file_name, "blob", $hash_base);
-	print "<div class=\"page_body\">\n";
+	print {$output_handler} "<div class=\"page_body\">\n";
 	if ($mimetype =~ m!^image/!) {
-		print qq!<img type="$mimetype"!;
+		print {$output_handler} qq!<img type="$mimetype"!;
 		if ($file_name) {
-			print qq! alt="$file_name" title="$file_name"!;
+			print {$output_handler} qq! alt="$file_name" title="$file_name"!;
 		}
-		print qq! src="! .
+		print {$output_handler} qq! src="! .
 		      href(action=>"blob_plain", hash=>$hash,
 		           hash_base=>$hash_base, file_name=>$file_name) .
 		      qq!" />\n!;
@@ -5412,14 +5429,14 @@ sub git_blob {
 			chomp $line;
 			$nr++;
 			$line = untabify($line);
-			printf "<div class=\"pre\"><a id=\"l%i\" href=\"" . href(-replay => 1)
+			printf {$output_handler} "<div class=\"pre\"><a id=\"l%i\" href=\"" . href(-replay => 1)
 				. "#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
 			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
 		}
 	}
 	close $fd
-		or print "Reading blob failed.\n";
-	print "</div>";
+		or print {$output_handler} "Reading blob failed.\n";
+	print {$output_handler} "</div>";
 	git_footer_html();
 }
 
@@ -5474,9 +5491,9 @@ sub git_tree {
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		undef $hash_base;
-		print "<div class=\"page_nav\">\n";
-		print "<br/><br/></div>\n";
-		print "<div class=\"title\">$hash</div>\n";
+		print {$output_handler} "<div class=\"page_nav\">\n";
+		print {$output_handler} "<br/><br/></div>\n";
+		print {$output_handler} "<div class=\"title\">$hash</div>\n";
 	}
 	if (defined $file_name) {
 		$basedir = $file_name;
@@ -5485,16 +5502,16 @@ sub git_tree {
 		}
 		git_print_page_path($file_name, 'tree', $hash_base);
 	}
-	print "<div class=\"page_body\">\n";
-	print "<table class=\"tree\">\n";
+	print {$output_handler} "<div class=\"page_body\">\n";
+	print {$output_handler} "<table class=\"tree\">\n";
 	my $alternate = 1;
 	# '..' (top directory) link if possible
 	if (defined $hash_base &&
 	    defined $file_name && $file_name =~ m![^/]+$!) {
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
 
@@ -5502,33 +5519,33 @@ sub git_tree {
 		$up =~ s!/?[^/]+$!!;
 		undef $up unless $up;
 		# based on git_print_tree_entry
-		print '<td class="mode">' . mode_str('040000') . "</td>\n";
-		print '<td class="size">&nbsp;</td>'."\n" if $show_sizes;
-		print '<td class="list">';
-		print $cgi->a({-href => href(action=>"tree",
+		print {$output_handler} '<td class="mode">' . mode_str('040000') . "</td>\n";
+		print {$output_handler} '<td class="size">&nbsp;</td>'."\n" if $show_sizes;
+		print {$output_handler} '<td class="list">';
+		print {$output_handler} $cgi->a({-href => href(action=>"tree",
 		                             hash_base=>$hash_base,
 		                             file_name=>$up)},
 		              "..");
-		print "</td>\n";
-		print "<td class=\"link\"></td>\n";
+		print {$output_handler} "</td>\n";
+		print {$output_handler} "<td class=\"link\"></td>\n";
 
-		print "</tr>\n";
+		print {$output_handler} "</tr>\n";
 	}
 	foreach my $line (@entries) {
 		my %t = parse_ls_tree_line($line, -z => 1, -l => $show_sizes);
 
 		if ($alternate) {
-			print "<tr class=\"dark\">\n";
+			print {$output_handler} "<tr class=\"dark\">\n";
 		} else {
-			print "<tr class=\"light\">\n";
+			print {$output_handler} "<tr class=\"light\">\n";
 		}
 		$alternate ^= 1;
 
 		git_print_tree_entry(\%t, $basedir, $hash_base, $have_blame);
 
-		print "</tr>\n";
+		print {$output_handler} "</tr>\n";
 	}
-	print "</table>\n" .
+	print {$output_handler} "</table>\n" .
 	      "</div>";
 	git_footer_html();
 }
@@ -5605,16 +5622,16 @@ sub git_snapshot {
 	}
 
 	$filename =~ s/(["\\])/\\$1/g;
-	print $cgi->header(
+	print {$output_handler} $cgi->header(
 		-type => $known_snapshot_formats{$format}{'type'},
 		-content_disposition => 'inline; filename="' . $filename . '"',
 		-status => '200 OK');
 
 	open my $fd, "-|", $cmd
 		or die_error(500, "Execute git-archive failed");
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	binmode $output_handler_bin, ':raw';
+	print {$output_handler_bin} <$fd>;
+	binmode $output_handler_bin, ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
 }
 
@@ -5765,11 +5782,11 @@ sub git_commit {
 	} else {
 		git_print_header_div('tree', esc_html($co{'title'}) . $ref, $co{'tree'}, $hash);
 	}
-	print "<div class=\"title_text\">\n" .
+	print {$output_handler} "<div class=\"title_text\">\n" .
 	      "<table class=\"object_header\">\n";
 	git_print_authorship_rows(\%co);
-	print "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
-	print "<tr>" .
+	print {$output_handler} "<tr><td>commit</td><td class=\"sha1\">$co{'id'}</td></tr>\n";
+	print {$output_handler} "<tr>" .
 	      "<td>tree</td>" .
 	      "<td class=\"sha1\">" .
 	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash),
@@ -5780,13 +5797,13 @@ sub git_commit {
 	              "tree");
 	my $snapshot_links = format_snapshot_links($hash);
 	if (defined $snapshot_links) {
-		print " | " . $snapshot_links;
+		print {$output_handler} " | " . $snapshot_links;
 	}
-	print "</td>" .
+	print {$output_handler} "</td>" .
 	      "</tr>\n";
 
 	foreach my $par (@$parents) {
-		print "<tr>" .
+		print {$output_handler} "<tr>" .
 		      "<td>parent</td>" .
 		      "<td class=\"sha1\">" .
 		      $cgi->a({-href => href(action=>"commit", hash=>$par),
@@ -5799,12 +5816,12 @@ sub git_commit {
 		      "</td>" .
 		      "</tr>\n";
 	}
-	print "</table>".
+	print {$output_handler} "</table>".
 	      "</div>\n";
 
-	print "<div class=\"page_body\">\n";
+	print {$output_handler} "<div class=\"page_body\">\n";
 	git_print_log($co{'comment'});
-	print "</div>\n";
+	print {$output_handler} "</div>\n";
 
 	git_difftree_body(\@difftree, $hash, @$parents);
 
@@ -5852,7 +5869,7 @@ sub git_object {
 		die_error(400, "Not enough information to find object");
 	}
 
-	print $cgi->redirect(-uri => href(action=>$type, -full=>1,
+	print {$output_handler} $cgi->redirect(-uri => href(action=>$type, -full=>1,
 	                                  hash=>$hash, hash_base=>$hash_base,
 	                                  file_name=>$file_name),
 	                     -status => '302 Found');
@@ -5943,23 +5960,23 @@ sub git_blobdiff {
 			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 		} else {
-			print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
-			print "<div class=\"title\">$hash vs $hash_parent</div>\n";
+			print {$output_handler} "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
+			print {$output_handler} "<div class=\"title\">$hash vs $hash_parent</div>\n";
 		}
 		if (defined $file_name) {
 			git_print_page_path($file_name, "blob", $hash_base);
 		} else {
-			print "<div class=\"page_path\"></div>\n";
+			print {$output_handler} "<div class=\"page_path\"></div>\n";
 		}
 
 	} elsif ($format eq 'plain') {
-		print $cgi->header(
+		print {$output_handler} $cgi->header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
 			-content_disposition => 'inline; filename="' . "$file_name" . '.patch"');
 
-		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
+		print {$output_handler} "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
 	} else {
 		die_error(400, "Unknown blobdiff format");
@@ -5967,12 +5984,12 @@ sub git_blobdiff {
 
 	# patch
 	if ($format eq 'html') {
-		print "<div class=\"page_body\">\n";
+		print {$output_handler} "<div class=\"page_body\">\n";
 
 		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
 		close $fd;
 
-		print "</div>\n"; # class="page_body"
+		print {$output_handler} "</div>\n"; # class="page_body"
 		git_footer_html();
 
 	} else {
@@ -5980,12 +5997,12 @@ sub git_blobdiff {
 			$line =~ s!a/($hash|$hash_parent)!'a/'.esc_path($diffinfo{'from_file'})!eg;
 			$line =~ s!b/($hash|$hash_parent)!'b/'.esc_path($diffinfo{'to_file'})!eg;
 
-			print $line;
+			print {$output_handler} $line;
 
 			last if $line =~ m!^\+\+\+!;
 		}
 		local $/ = undef;
-		print <$fd>;
+		print {$output_handler} <$fd>;
 		close $fd;
 	}
 }
@@ -6148,16 +6165,16 @@ sub git_commitdiff {
 		git_header_html(undef, $expires);
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
-		print "<div class=\"title_text\">\n" .
+		print {$output_handler} "<div class=\"title_text\">\n" .
 		      "<table class=\"object_header\">\n";
 		git_print_authorship_rows(\%co);
-		print "</table>".
+		print {$output_handler} "</table>".
 		      "</div>\n";
-		print "<div class=\"page_body\">\n";
+		print {$output_handler} "<div class=\"page_body\">\n";
 		if (@{$co{'comment'}} > 1) {
-			print "<div class=\"log\">\n";
+			print {$output_handler} "<div class=\"log\">\n";
 			git_print_log($co{'comment'}, -final_empty_line=> 1, -remove_title => 1);
-			print "</div>\n"; # class="log"
+			print {$output_handler} "</div>\n"; # class="log"
 		}
 
 	} elsif ($format eq 'plain') {
@@ -6165,27 +6182,27 @@ sub git_commitdiff {
 		my $tagname = git_get_rev_name_tags($hash);
 		my $filename = basename($project) . "-$hash.patch";
 
-		print $cgi->header(
+		print {$output_handler} $cgi->header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
 			-content_disposition => 'inline; filename="' . "$filename" . '"');
 		my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
-		print "From: " . to_utf8($co{'author'}) . "\n";
-		print "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n";
-		print "Subject: " . to_utf8($co{'title'}) . "\n";
+		print {$output_handler} "From: " . to_utf8($co{'author'}) . "\n";
+		print {$output_handler} "Date: $ad{'rfc2822'} ($ad{'tz_local'})\n";
+		print {$output_handler} "Subject: " . to_utf8($co{'title'}) . "\n";
 
-		print "X-Git-Tag: $tagname\n" if $tagname;
-		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
+		print {$output_handler} "X-Git-Tag: $tagname\n" if $tagname;
+		print {$output_handler} "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
 		foreach my $line (@{$co{'comment'}}) {
-			print to_utf8($line) . "\n";
+			print {$output_handler} to_utf8($line) . "\n";
 		}
-		print "---\n\n";
+		print {$output_handler} "---\n\n";
 	} elsif ($format eq 'patch') {
 		my $filename = basename($project) . "-$hash.patch";
 
-		print $cgi->header(
+		print {$output_handler} $cgi->header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
@@ -6198,24 +6215,24 @@ sub git_commitdiff {
 			$hash_parent eq '-c' || $hash_parent eq '--cc';
 		git_difftree_body(\@difftree, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
-		print "<br/>\n";
+		print {$output_handler} "<br/>\n";
 
 		git_patchset_body($fd, \@difftree, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		close $fd;
-		print "</div>\n"; # class="page_body"
+		print {$output_handler} "</div>\n"; # class="page_body"
 		git_footer_html();
 
 	} elsif ($format eq 'plain') {
 		local $/ = undef;
-		print <$fd>;
+		print {$output_handler} <$fd>;
 		close $fd
-			or print "Reading git-diff-tree failed\n";
+			or print {$output_handler} "Reading git-diff-tree failed\n";
 	} elsif ($format eq 'patch') {
 		local $/ = undef;
-		print <$fd>;
+		print {$output_handler} <$fd>;
 		close $fd
-			or print "Reading git-format-patch failed\n";
+			or print {$output_handler} "Reading git-format-patch failed\n";
 	}
 }
 
@@ -6318,7 +6335,7 @@ sub git_search {
 		git_print_page_nav('','', $hash,$co{'tree'},$hash);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
-		print "<table class=\"pickaxe search\">\n";
+		print {$output_handler} "<table class=\"pickaxe search\">\n";
 		my $alternate = 1;
 		local $/ = "\n";
 		open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
@@ -6334,24 +6351,24 @@ sub git_search {
 			if (defined $set{'commit'}) {
 				# finish previous commit
 				if (%co) {
-					print "</td>\n" .
+					print {$output_handler} "</td>\n" .
 					      "<td class=\"link\">" .
 					      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
 					      " | " .
 					      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-					print "</td>\n" .
+					print {$output_handler} "</td>\n" .
 					      "</tr>\n";
 				}
 
 				if ($alternate) {
-					print "<tr class=\"dark\">\n";
+					print {$output_handler} "<tr class=\"dark\">\n";
 				} else {
-					print "<tr class=\"light\">\n";
+					print {$output_handler} "<tr class=\"light\">\n";
 				}
 				$alternate ^= 1;
 				%co = parse_commit($set{'commit'});
 				my $author = chop_and_escape_str($co{'author_name'}, 15, 5);
-				print "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
+				print {$output_handler} "<td title=\"$co{'age_string_age'}\"><i>$co{'age_string_date'}</i></td>\n" .
 				      "<td><i>$author</i></td>\n" .
 				      "<td>" .
 				      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'}),
@@ -6360,7 +6377,7 @@ sub git_search {
 			} elsif (defined $set{'to_id'}) {
 				next if ($set{'to_id'} =~ m/^0{40}$/);
 
-				print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
+				print {$output_handler} $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
 				                             hash=>$set{'to_id'}, file_name=>$set{'to_file'}),
 				              -class => "list"},
 				              "<span class=\"match\">" . esc_path($set{'file'}) . "</span>") .
@@ -6371,23 +6388,23 @@ sub git_search {
 
 		# finish last commit (warning: repetition!)
 		if (%co) {
-			print "</td>\n" .
+			print {$output_handler} "</td>\n" .
 			      "<td class=\"link\">" .
 			      $cgi->a({-href => href(action=>"commit", hash=>$co{'id'})}, "commit") .
 			      " | " .
 			      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$co{'id'})}, "tree");
-			print "</td>\n" .
+			print {$output_handler} "</td>\n" .
 			      "</tr>\n";
 		}
 
-		print "</table>\n";
+		print {$output_handler} "</table>\n";
 	}
 
 	if ($searchtype eq 'grep') {
 		git_print_page_nav('','', $hash,$co{'tree'},$hash);
 		git_print_header_div('commit', esc_html($co{'title'}), $hash);
 
-		print "<table class=\"grep_search\">\n";
+		print {$output_handler} "<table class=\"grep_search\">\n";
 		my $alternate = 1;
 		my $matches = 0;
 		local $/ = "\n";
@@ -6406,21 +6423,21 @@ sub git_search {
 				(undef, $file, $lno, $ltext) = split(/:/, $line, 4);
 			}
 			if ($file ne $lastfile) {
-				$lastfile and print "</td></tr>\n";
+				$lastfile and print {$output_handler} "</td></tr>\n";
 				if ($alternate++) {
-					print "<tr class=\"dark\">\n";
+					print {$output_handler} "<tr class=\"dark\">\n";
 				} else {
-					print "<tr class=\"light\">\n";
+					print {$output_handler} "<tr class=\"light\">\n";
 				}
-				print "<td class=\"list\">".
+				print {$output_handler} "<td class=\"list\">".
 					$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
 							       file_name=>"$file"),
 						-class => "list"}, esc_path($file));
-				print "</td><td>\n";
+				print {$output_handler} "</td><td>\n";
 				$lastfile = $file;
 			}
 			if ($binary) {
-				print "<div class=\"binary\">Binary file</div>\n";
+				print {$output_handler} "<div class=\"binary\">Binary file</div>\n";
 			} else {
 				$ltext = untabify($ltext);
 				if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
@@ -6432,7 +6449,7 @@ sub git_search {
 				} else {
 					$ltext = esc_html($ltext, -nbsp=>1);
 				}
-				print "<div class=\"pre\">" .
+				print {$output_handler} "<div class=\"pre\">" .
 					$cgi->a({-href => href(action=>"blob", hash=>$co{'hash'},
 							       file_name=>"$file").'#l'.$lno,
 						-class => "linenr"}, sprintf('%4i', $lno))
@@ -6440,16 +6457,16 @@ sub git_search {
 			}
 		}
 		if ($lastfile) {
-			print "</td></tr>\n";
+			print {$output_handler} "</td></tr>\n";
 			if ($matches > 1000) {
-				print "<div class=\"diff nodifferences\">Too many matches, listing trimmed</div>\n";
+				print {$output_handler} "<div class=\"diff nodifferences\">Too many matches, listing trimmed</div>\n";
 			}
 		} else {
-			print "<div class=\"diff nodifferences\">No matches found</div>\n";
+			print {$output_handler} "<div class=\"diff nodifferences\">No matches found</div>\n";
 		}
 		close $fd;
 
-		print "</table>\n";
+		print {$output_handler} "</table>\n";
 	}
 	git_footer_html();
 }
@@ -6457,7 +6474,7 @@ sub git_search {
 sub git_search_help {
 	git_header_html();
 	git_print_page_nav('','', $hash,$hash,$hash);
-	print <<EOT;
+	print {$output_handler} <<EOT;
 <p><strong>Pattern</strong> is by default a normal string that is matched precisely (but without
 regard to case, except in the case of pickaxe). However, when you check the <em>re</em> checkbox,
 the pattern entered is recognized as the POSIX extended
@@ -6469,7 +6486,7 @@ insensitive).</p>
 EOT
 	my $have_grep = gitweb_check_feature('grep');
 	if ($have_grep) {
-		print <<EOT;
+		print {$output_handler} <<EOT;
 <dt><b>grep</b></dt>
 <dd>All files in the currently selected tree (HEAD unless you are explicitly browsing
     a different one) are searched for the given pattern. On large trees, this search can take
@@ -6478,7 +6495,7 @@ due to git-grep peculiarity, currently if regexp mode is turned off, the matches
 case-sensitive.</dd>
 EOT
 	}
-	print <<EOT;
+	print {$output_handler} <<EOT;
 <dt><b>author</b></dt>
 <dd>Name and e-mail of the change author and date of birth of the patch will be scanned for the given pattern.</dd>
 <dt><b>committer</b></dt>
@@ -6486,7 +6503,7 @@ EOT
 EOT
 	my $have_pickaxe = gitweb_check_feature('pickaxe');
 	if ($have_pickaxe) {
-		print <<EOT;
+		print {$output_handler} <<EOT;
 <dt><b>pickaxe</b></dt>
 <dd>All commits that caused the string to appear or disappear from any file (changes that
 added, removed or "modified" the string) will be listed. This search can take a while and
@@ -6494,7 +6511,7 @@ takes a lot of strain on the server, so please use it wisely. Note that since yo
 interested even in changes just changing the case as well, this search is case sensitive.</dd>
 EOT
 	}
-	print "</dl>\n";
+	print {$output_handler} "</dl>\n";
 	git_footer_html();
 }
 
@@ -6541,7 +6558,7 @@ sub git_feed {
 				$since = Time::ParseDate::parsedate($if_modified, GMT => 1);
 			}
 			if (defined $since && $latest_epoch <= $since) {
-				print $cgi->header(
+				print {$output_handler} $cgi->header(
 					-type => $content_type,
 					-charset => 'utf-8',
 					-last_modified => $latest_date{'rfc2822'},
@@ -6549,12 +6566,12 @@ sub git_feed {
 				return;
 			}
 		}
-		print $cgi->header(
+		print {$output_handler} $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8',
 			-last_modified => $latest_date{'rfc2822'});
 	} else {
-		print $cgi->header(
+		print {$output_handler} $cgi->header(
 			-type => $content_type,
 			-charset => 'utf-8');
 	}
@@ -6598,13 +6615,13 @@ sub git_feed {
 	} else {
 		$alt_url = href(-full=>1, action=>"summary");
 	}
-	print qq!<?xml version="1.0" encoding="utf-8"?>\n!;
+	print {$output_handler} qq!<?xml version="1.0" encoding="utf-8"?>\n!;
 	if ($format eq 'rss') {
-		print <<XML;
+		print {$output_handler} <<XML;
 <rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/">
 <channel>
 XML
-		print "<title>$title</title>\n" .
+		print {$output_handler} "<title>$title</title>\n" .
 		      "<link>$alt_url</link>\n" .
 		      "<description>$descr</description>\n" .
 		      "<language>en</language>\n" .
@@ -6614,22 +6631,22 @@ XML
 			# prefer the logo to the favicon, since RSS
 			# doesn't allow both
 			my $img = esc_url($logo || $favicon);
-			print "<image>\n" .
+			print {$output_handler} "<image>\n" .
 			      "<url>$img</url>\n" .
 			      "<title>$title</title>\n" .
 			      "<link>$alt_url</link>\n" .
 			      "</image>\n";
 		}
 		if (%latest_date) {
-			print "<pubDate>$latest_date{'rfc2822'}</pubDate>\n";
-			print "<lastBuildDate>$latest_date{'rfc2822'}</lastBuildDate>\n";
+			print {$output_handler} "<pubDate>$latest_date{'rfc2822'}</pubDate>\n";
+			print {$output_handler} "<lastBuildDate>$latest_date{'rfc2822'}</lastBuildDate>\n";
 		}
-		print "<generator>gitweb v.$version/$git_version</generator>\n";
+		print {$output_handler} "<generator>gitweb v.$version/$git_version</generator>\n";
 	} elsif ($format eq 'atom') {
-		print <<XML;
+		print {$output_handler} <<XML;
 <feed xmlns="http://www.w3.org/2005/Atom">
 XML
-		print "<title>$title</title>\n" .
+		print {$output_handler} "<title>$title</title>\n" .
 		      "<subtitle>$descr</subtitle>\n" .
 		      '<link rel="alternate" type="text/html" href="' .
 		      $alt_url . '" />' . "\n" .
@@ -6639,19 +6656,19 @@ XML
 		      # use project owner for feed author
 		      "<author><name>$owner</name></author>\n";
 		if (defined $favicon) {
-			print "<icon>" . esc_url($favicon) . "</icon>\n";
+			print {$output_handler} "<icon>" . esc_url($favicon) . "</icon>\n";
 		}
 		if (defined $logo_url) {
 			# not twice as wide as tall: 72 x 27 pixels
-			print "<logo>" . esc_url($logo) . "</logo>\n";
+			print {$output_handler} "<logo>" . esc_url($logo) . "</logo>\n";
 		}
 		if (! %latest_date) {
 			# dummy date to keep the feed valid until commits trickle in:
-			print "<updated>1970-01-01T00:00:00Z</updated>\n";
+			print {$output_handler} "<updated>1970-01-01T00:00:00Z</updated>\n";
 		} else {
-			print "<updated>$latest_date{'iso-8601'}</updated>\n";
+			print {$output_handler} "<updated>$latest_date{'iso-8601'}</updated>\n";
 		}
-		print "<generator version='$version/$git_version'>gitweb</generator>\n";
+		print {$output_handler} "<generator version='$version/$git_version'>gitweb</generator>\n";
 	}
 
 	# contents
@@ -6676,7 +6693,7 @@ XML
 		# print element (entry, item)
 		my $co_url = href(-full=>1, action=>"commitdiff", hash=>$commit);
 		if ($format eq 'rss') {
-			print "<item>\n" .
+			print {$output_handler} "<item>\n" .
 			      "<title>" . esc_html($co{'title'}) . "</title>\n" .
 			      "<author>" . esc_html($co{'author'}) . "</author>\n" .
 			      "<pubDate>$cd{'rfc2822'}</pubDate>\n" .
@@ -6686,22 +6703,22 @@ XML
 			      "<content:encoded>" .
 			      "<![CDATA[\n";
 		} elsif ($format eq 'atom') {
-			print "<entry>\n" .
+			print {$output_handler} "<entry>\n" .
 			      "<title type=\"html\">" . esc_html($co{'title'}) . "</title>\n" .
 			      "<updated>$cd{'iso-8601'}</updated>\n" .
 			      "<author>\n" .
 			      "  <name>" . esc_html($co{'author_name'}) . "</name>\n";
 			if ($co{'author_email'}) {
-				print "  <email>" . esc_html($co{'author_email'}) . "</email>\n";
+				print {$output_handler} "  <email>" . esc_html($co{'author_email'}) . "</email>\n";
 			}
-			print "</author>\n" .
+			print {$output_handler} "</author>\n" .
 			      # use committer for contributor
 			      "<contributor>\n" .
 			      "  <name>" . esc_html($co{'committer_name'}) . "</name>\n";
 			if ($co{'committer_email'}) {
-				print "  <email>" . esc_html($co{'committer_email'}) . "</email>\n";
+				print {$output_handler} "  <email>" . esc_html($co{'committer_email'}) . "</email>\n";
 			}
-			print "</contributor>\n" .
+			print {$output_handler} "</contributor>\n" .
 			      "<published>$cd{'iso-8601'}</published>\n" .
 			      "<link rel=\"alternate\" type=\"text/html\" href=\"$co_url\" />\n" .
 			      "<id>$co_url</id>\n" .
@@ -6709,19 +6726,19 @@ XML
 			      "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n";
 		}
 		my $comment = $co{'comment'};
-		print "<pre>\n";
+		print {$output_handler} "<pre>\n";
 		foreach my $line (@$comment) {
 			$line = esc_html($line);
-			print "$line\n";
+			print {$output_handler} "$line\n";
 		}
-		print "</pre><ul>\n";
+		print {$output_handler} "</pre><ul>\n";
 		foreach my $difftree_line (@difftree) {
 			my %difftree = parse_difftree_raw_line($difftree_line);
 			next if !$difftree{'from_id'};
 
 			my $file = $difftree{'file'} || $difftree{'to_file'};
 
-			print "<li>" .
+			print {$output_handler} "<li>" .
 			      "[" .
 			      $cgi->a({-href => href(-full=>1, action=>"blobdiff",
 			                             hash=>$difftree{'to_id'}, hash_parent=>$difftree{'from_id'},
@@ -6729,26 +6746,26 @@ XML
 			                             file_name=>$file, file_parent=>$difftree{'from_file'}),
 			              -title => "diff"}, 'D');
 			if ($have_blame) {
-				print $cgi->a({-href => href(-full=>1, action=>"blame",
+				print {$output_handler} $cgi->a({-href => href(-full=>1, action=>"blame",
 				                             file_name=>$file, hash_base=>$commit),
 				              -title => "blame"}, 'B');
 			}
 			# if this is not a feed of a file history
 			if (!defined $file_name || $file_name ne $file) {
-				print $cgi->a({-href => href(-full=>1, action=>"history",
+				print {$output_handler} $cgi->a({-href => href(-full=>1, action=>"history",
 				                             file_name=>$file, hash=>$commit),
 				              -title => "history"}, 'H');
 			}
 			$file = esc_path($file);
-			print "] ".
+			print {$output_handler} "] ".
 			      "$file</li>\n";
 		}
 		if ($format eq 'rss') {
-			print "</ul>]]>\n" .
+			print {$output_handler} "</ul>]]>\n" .
 			      "</content:encoded>\n" .
 			      "</item>\n";
 		} elsif ($format eq 'atom') {
-			print "</ul>\n</div>\n" .
+			print {$output_handler} "</ul>\n</div>\n" .
 			      "</content>\n" .
 			      "</entry>\n";
 		}
@@ -6756,9 +6773,9 @@ XML
 
 	# end of feed
 	if ($format eq 'rss') {
-		print "</channel>\n</rss>\n";
+		print {$output_handler} "</channel>\n</rss>\n";
 	} elsif ($format eq 'atom') {
-		print "</feed>\n";
+		print {$output_handler} "</feed>\n";
 	}
 }
 
@@ -6772,13 +6789,12 @@ sub git_atom {
 
 sub git_opml {
 	my @list = git_get_projects_list();
-
-	print $cgi->header(
+	print {$output_handler} $cgi->header(
 		-type => 'text/xml',
 		-charset => 'utf-8',
 		-content_disposition => 'inline; filename="opml.xml"');
 
-	print <<XML;
+	print {$output_handler} <<XML;
 <?xml version="1.0" encoding="utf-8"?>
 <opml version="1.0">
 <head>
@@ -6803,9 +6819,9 @@ XML
 		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
 		my $rss  = href('project' => $proj{'path'}, 'action' => 'rss', -full => 1);
 		my $html = href('project' => $proj{'path'}, 'action' => 'summary', -full => 1);
-		print "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
+		print {$output_handler} "<outline type=\"rss\" text=\"$path\" title=\"$path\" xmlUrl=\"$rss\" htmlUrl=\"$html\"/>\n";
 	}
-	print <<XML;
+	print {$output_handler} <<XML;
 </outline>
 </body>
 </opml>
-- 
1.6.5.2
