From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH] gitweb: support perl 5.6
Date: Sat, 9 Sep 2006 16:59:15 +0200
Message-ID: <20060909145914.GA25289@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 16:59:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM4In-0006RJ-J6
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 16:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWIIO7W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 10:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWIIO7W
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 10:59:22 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:31136 "EHLO rhodium.liacs.nl")
	by vger.kernel.org with ESMTP id S1751321AbWIIO7W (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 10:59:22 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id k89ExF6P030862;
	Sat, 9 Sep 2006 16:59:20 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 4E7CB3C734; Sat,  9 Sep 2006 16:59:15 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26751>

Specifically, perl 5.6 doesn't have the Encode module and
doesn't support the open "-|" list form.

Signed-off-by: Sven Verdoolage <skimo@liacs.nl>
---
This is take three.
I had missed the other binmodes in the code.

 gitweb/gitweb.perl |  102 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d89f709..7afdf33 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -12,11 +12,12 @@ use warnings;
 use CGI qw(:standard :escapeHTML -nosticky);
 use CGI::Util qw(unescape);
 use CGI::Carp qw(fatalsToBrowser);
-use Encode;
+eval { require Encode; import Encode; };
+our $have_encode = !$@;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
-binmode STDOUT, ':utf8';
+binmode STDOUT, ':utf8' if $have_encode;
 
 our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
@@ -347,10 +348,16 @@ sub esc_param {
 	return $str;
 }
 
+sub utf8_decode {
+	my $str = shift;
+	$str = decode("utf8", $str, eval "Encode::FB_DEFAULT") if $have_encode;
+	return $str;
+}
+
 # replace invalid utf8 character with SUBSTITUTION sequence
 sub esc_html {
 	my $str = shift;
-	$str = decode("utf8", $str, Encode::FB_DEFAULT);
+	$str = utf8_decode($str);
 	$str = escapeHTML($str);
 	$str =~ s/\014/^L/g; # escape FORM FEED (FF) character (e.g. in COPYING file)
 	return $str;
@@ -582,6 +589,12 @@ sub git_cmd {
 	return $GIT, '--git-dir='.$git_dir;
 }
 
+# returns pipe reading from git command with given arguments
+sub git_pipe {
+	open my $fd, "-|", join(' ', git_cmd(), @_) or return undef;
+	return $fd;
+}
+
 # returns path to the core git executable and the --git-dir parameter as string
 sub git_cmd_str {
 	return join(' ', git_cmd());
@@ -593,7 +606,7 @@ sub git_get_head_hash {
 	my $o_git_dir = $git_dir;
 	my $retval = undef;
 	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
+	if (my $fd = git_pipe("rev-parse", "--verify", "HEAD")) {
 		my $head = <$fd>;
 		close $fd;
 		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
@@ -610,7 +623,7 @@ # get type of given object
 sub git_get_type {
 	my $hash = shift;
 
-	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
+	my $fd = git_pipe("cat-file", '-t', $hash) or return;
 	my $type = <$fd>;
 	close $fd or return;
 	chomp $type;
@@ -640,7 +653,7 @@ sub git_get_hash_by_path {
 
 	my $tree = $base;
 
-	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
+	my $fd = git_pipe("ls-tree", $base, "--", $path)
 		or die_error(undef, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
@@ -719,7 +732,7 @@ sub git_get_projects_list {
 			if (-e "$projectroot/$path/HEAD") {
 				my $pr = {
 					path => $path,
-					owner => decode("utf8", $owner, Encode::FB_DEFAULT),
+					owner => utf8_decode($owner),
 				};
 				push @list, $pr
 			}
@@ -748,7 +761,7 @@ sub git_get_project_owner {
 			$pr = unescape($pr);
 			$ow = unescape($ow);
 			if ($pr eq $project) {
-				$owner = decode("utf8", $ow, Encode::FB_DEFAULT);
+				$owner = utf8_decode($ow);
 				last;
 			}
 		}
@@ -771,7 +784,7 @@ sub git_get_references {
 		open $fd, "$projectroot/$project/info/refs"
 			or return;
 	} else {
-		open $fd, "-|", git_cmd(), "ls-remote", "."
+		$fd = git_pipe("ls-remote", ".")
 			or return;
 	}
 
@@ -792,7 +805,7 @@ sub git_get_references {
 sub git_get_rev_name_tags {
 	my $hash = shift || return undef;
 
-	open my $fd, "-|", git_cmd(), "name-rev", "--tags", $hash
+	my $fd = git_pipe("name-rev", "--tags", $hash)
 		or return;
 	my $name_rev = <$fd>;
 	close $fd;
@@ -840,7 +853,7 @@ sub parse_tag {
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
+	my $fd = git_pipe("cat-file", "tag", $tag_id) or return;
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
@@ -881,7 +894,7 @@ sub parse_commit {
 		@commit_lines = @$commit_text;
 	} else {
 		$/ = "\0";
-		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", "--max-count=1", $commit_id
+		my $fd = git_pipe("rev-list", "--header", "--parents", "--max-count=1", $commit_id)
 			or return;
 		@commit_lines = split '\n', <$fd>;
 		close $fd or return;
@@ -1098,7 +1111,7 @@ sub get_file_owner {
 	}
 	my $owner = $gcos;
 	$owner =~ s/[,;].*$//;
-	return decode("utf8", $owner, Encode::FB_DEFAULT);
+	return utf8_decode($owner);
 }
 
 ## ......................................................................
@@ -2206,8 +2219,8 @@ sub git_summary {
 	}
 	print "</table>\n";
 
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=17",
-		git_get_head_hash($project)
+	my $fd = git_pipe("rev-list", "--max-count=17",
+			git_get_head_hash($project))
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2286,7 +2299,7 @@ sub git_blame2 {
 	if ($ftype !~ "blob") {
 		die_error("400 Bad Request", "Object is not a blob");
 	}
-	open ($fd, "-|", git_cmd(), "blame", '-l', $file_name, $hash_base)
+	$fd = git_pipe("blame", '-l', $file_name, $hash_base)
 		or die_error(undef, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
@@ -2352,7 +2365,7 @@ sub git_blame {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
 			or die_error(undef, "Error lookup file");
 	}
-	open ($fd, "-|", git_cmd(), "annotate", '-l', '-t', '-r', $file_name, $hash_base)
+	$fd = git_pipe("annotate", '-l', '-t', '-r', $file_name, $hash_base)
 		or die_error(undef, "Open git-annotate failed");
 	git_header_html();
 	my $formats_nav =
@@ -2473,7 +2486,7 @@ sub git_blob_plain {
 		}
 	}
 	my $type = shift;
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
+	my $fd = git_pipe("cat-file", "blob", $hash)
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 
 	$type ||= blob_mimetype($fd, $file_name);
@@ -2491,9 +2504,9 @@ sub git_blob_plain {
 		-expires=>$expires,
 		-content_disposition => "inline; filename=\"$save_as\"");
 	undef $/;
-	binmode STDOUT, ':raw';
+	binmode STDOUT, ':raw' if $have_encode;
 	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	binmode STDOUT, ':utf8' if $have_encode; # as set at the beginning of gitweb.cgi
 	$/ = "\n";
 	close $fd;
 }
@@ -2515,7 +2528,7 @@ sub git_blob {
 		}
 	}
 	my ($have_blame) = gitweb_check_feature('blame');
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
+	my $fd =git_pipe("cat-file", "blob", $hash)
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
 	if ($mimetype !~ m/^text\//) {
@@ -2580,7 +2593,7 @@ sub git_tree {
 		}
 	}
 	$/ = "\0";
-	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
+	my $fd = git_pipe("ls-tree", '-z', $hash)
 		or die_error(undef, "Open git-ls-tree failed");
 	my @entries = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading tree failed");
@@ -2648,9 +2661,9 @@ sub git_snapshot {
 	my $git_command = git_cmd_str();
 	open my $fd, "-|", "$git_command tar-tree $hash \'$project\' | $command" or
 		die_error(undef, "Execute git-tar-tree failed.");
-	binmode STDOUT, ':raw';
+	binmode STDOUT, ':raw' if $have_encode;
 	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	binmode STDOUT, ':utf8' if $have_encode; # as set at the beginning of gitweb.cgi
 	close $fd;
 
 }
@@ -2666,7 +2679,7 @@ sub git_log {
 	my $refs = git_get_references();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
+	my $fd = git_pipe("rev-list", $limit, $hash)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -2721,7 +2734,7 @@ sub git_commit {
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $parent, $hash
+	my $fd = git_pipe("diff-tree", '-r', @diff_opts, $parent, $hash)
 		or die_error(undef, "Open git-diff-tree failed");
 	my @difftree = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-diff-tree failed");
@@ -2828,8 +2841,8 @@ sub git_blobdiff {
 	if (defined $hash_base && defined $hash_parent_base) {
 		if (defined $file_name) {
 			# read raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base,
-				"--", $file_name
+			$fd = git_pipe("diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base,
+				"--", $file_name)
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree = map { chomp; $_ } <$fd>;
 			close $fd
@@ -2842,7 +2855,7 @@ sub git_blobdiff {
 			# try to find filename from $hash
 
 			# read filtered raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base
+			$fd = git_pipe("diff-tree", '-r', @diff_opts, $hash_parent_base, $hash_base)
 				or die_error(undef, "Open git-diff-tree failed");
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
@@ -2876,9 +2889,9 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
+		$fd = git_pipe("diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_base, $hash_base,
-			"--", $file_name
+			"--", $file_name)
 			or die_error(undef, "Open git-diff-tree failed");
 	}
 
@@ -2912,7 +2925,7 @@ sub git_blobdiff {
 		}
 
 		# open patch output
-		open $fd, "-|", git_cmd(), "diff", '-p', @diff_opts, $hash_parent, $hash
+		$fd = git_pipe("diff", '-p', @diff_opts, $hash_parent, $hash)
 			or die_error(undef, "Open git-diff failed");
 	} else  {
 		die_error('404 Not Found', "Missing one of the blob diff parameters")
@@ -2997,8 +3010,8 @@ sub git_commitdiff {
 	my $fd;
 	my @difftree;
 	if ($format eq 'html') {
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			"--patch-with-raw", "--full-index", $hash_parent, $hash
+		$fd = git_pipe("diff-tree", '-r', @diff_opts,
+			"--patch-with-raw", "--full-index", $hash_parent, $hash)
 			or die_error(undef, "Open git-diff-tree failed");
 
 		while (chomp(my $line = <$fd>)) {
@@ -3008,8 +3021,8 @@ sub git_commitdiff {
 		}
 
 	} elsif ($format eq 'plain') {
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', $hash_parent, $hash
+		$fd = git_pipe("diff-tree", '-r', @diff_opts,
+			'-p', $hash_parent, $hash)
 			or die_error(undef, "Open git-diff-tree failed");
 
 	} else {
@@ -3108,8 +3121,7 @@ sub git_history {
 	}
 	git_print_page_path($file_name, $ftype, $hash_base);
 
-	open my $fd, "-|",
-		git_cmd(), "rev-list", "--full-history", $hash_base, "--", $file_name;
+	my $fd = git_pipe("rev-list", "--full-history", $hash_base, "--", $file_name);
 
 	git_history_body($fd, $refs, $hash_base, $ftype);
 
@@ -3150,7 +3162,7 @@ sub git_search {
 	my $alternate = 0;
 	if ($commit_search) {
 		$/ = "\0";
-		open my $fd, "-|", git_cmd(), "rev-list", "--header", "--parents", $hash or next;
+		my $fd = git_pipe("rev-list", "--header", "--parents", $hash or next);
 		while (my $commit_text = <$fd>) {
 			if (!grep m/$searchtext/i, $commit_text) {
 				next;
@@ -3271,7 +3283,7 @@ sub git_shortlog {
 	my $refs = git_get_references();
 
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
-	open my $fd, "-|", git_cmd(), "rev-list", $limit, $hash
+	my $fd = git_pipe("rev-list", $limit, $hash)
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd;
@@ -3299,7 +3311,7 @@ ## feeds (RSS, OPML)
 
 sub git_rss {
 	# http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
-	open my $fd, "-|", git_cmd(), "rev-list", "--max-count=150", git_get_head_hash($project)
+	my $fd = git_pipe("rev-list", "--max-count=150", git_get_head_hash($project))
 		or die_error(undef, "Open git-rev-list failed");
 	my @revlist = map { chomp; $_ } <$fd>;
 	close $fd or die_error(undef, "Reading git-rev-list failed");
@@ -3322,8 +3334,8 @@ XML
 			last;
 		}
 		my %cd = parse_date($co{'committer_epoch'});
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			$co{'parent'}, $co{'id'}
+		$fd = git_pipe("diff-tree", '-r', @diff_opts,
+			$co{'parent'}, $co{'id'})
 			or next;
 		my @difftree = map { chomp; $_ } <$fd>;
 		close $fd
@@ -3341,7 +3353,7 @@ XML
 		      "<![CDATA[\n";
 		my $comment = $co{'comment'};
 		foreach my $line (@$comment) {
-			$line = decode("utf8", $line, Encode::FB_DEFAULT);
+			$line = utf8_decode($line);
 			print "$line<br/>\n";
 		}
 		print "<br/>\n";
@@ -3350,7 +3362,7 @@ XML
 				next;
 			}
 			my $file = validate_input(unquote($7));
-			$file = decode("utf8", $file, Encode::FB_DEFAULT);
+			$file = utf8_decode($file);
 			print "$file<br/>\n";
 		}
 		print "]]>\n" .
-- 
0.99.8c.g64e8-dirty
