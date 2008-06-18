From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: standarize HTTP status codes
Date: Wed, 18 Jun 2008 02:15:15 +0200
Message-ID: <1213748115-4038-1-git-send-email-LeWiemann@gmail.com>
References: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 02:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8lLT-00053d-N1
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 02:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756020AbYFRAPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 20:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYFRAPU
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 20:15:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:8644 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020AbYFRAPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 20:15:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so387fgg.17
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 17:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=ct6ICoAHQ966JHaWKc0ovBR0iJJjA6HNgsCUdTNN8Vg=;
        b=cTsCoCHiHMB00J3a4cCa++ju1m43KX4RPywKBUDC3htEk8YTGUFEKrCTpLEXFwJK66
         fI05h23/I36V2o/b4Ln1HEuA39c/ILscFVrkZhW1z3gHjcuQvxNp92YNCDSupDyYtFmw
         PEcESXKg2qv/mw8y6mrdz3p7cRzvu4yjaMLOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=EPEJUjCDef8uWzLgEyUe1CdWUxlbEd5STT32cKNNVfqGJKlEYWgBuaikrqDE8r3ldh
         4OwzSEgDvYPFo2/AOUHaWmu6a9EIX6Lm3qnr62/C4u9w1Uq95VcWW7vXeuVN2qVArPWd
         fQiE9LpW6I0nEQueA2N8n5UNNv4X5OenBlzLE=
Received: by 10.86.26.1 with SMTP id 1mr9617279fgz.49.1213748116569;
        Tue, 17 Jun 2008 17:15:16 -0700 (PDT)
Received: from fly ( [91.33.241.48])
        by mx.google.com with ESMTPS id 3sm14122132fge.3.2008.06.17.17.15.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 17:15:15 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8lKV-00013W-7x; Wed, 18 Jun 2008 02:15:15 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
In-Reply-To: <1213564515-14356-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85346>

Many error status codes simply default to 403 Forbidden, which is not
correct in most cases.  This patch makes gitweb return semantically
correct status codes.

For convenience the die_error function now only takes the status code
without reason as first parameter (e.g. 404 instead of "404 Not
Found"), and it now defaults to 500 (Internal Server Error), even
though the default is not used anywhere.

Also documented status code conventions in die_error.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
Changes since v1:

- Changed subject per Jakub's suggestion.
- Resolved merge conflict caused by "[PATCH v2] gitweb: quote commands
  properly when calling the shell".
- Added the following documentation to die_error (I know Jakub might
  disagree with me on the last line ;-)):

# die_error(<http_status_code>, <error_message>)
# Example: die_error(404, 'Hash not found')
# By convention, use the following status codes (as defined in RFC 2616):
# 400: Invalid or missing CGI parameters, or
#      requested object exists but has wrong type.
# 403: Requested feature (like "pickaxe" or "snapshot") not enabled on
#      this server or project.
# 404: Requested object/revision/project doesn't exist.
# 500: The server isn't configured properly, or
#      an internal error occurred (e.g. failed assertions caused by bugs), or
#      an unknown error occurred (e.g. the git binary died unexpectedly).


 gitweb/gitweb.perl |  207 ++++++++++++++++++++++++++--------------------------
 1 files changed, 102 insertions(+), 105 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3a7adae..3ca45fd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -386,7 +386,7 @@ $projects_list ||= $projectroot;
 our $action = $cgi->param('a');
 if (defined $action) {
 	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
-		die_error(undef, "Invalid action parameter");
+		die_error(400, "Invalid action parameter");
 	}
 }
 
@@ -399,21 +399,21 @@ if (defined $project) {
 	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
 	    ($strict_export && !project_in_list($project))) {
 		undef $project;
-		die_error(undef, "No such project");
+		die_error(404, "No such project");
 	}
 }
 
 our $file_name = $cgi->param('f');
 if (defined $file_name) {
 	if (!validate_pathname($file_name)) {
-		die_error(undef, "Invalid file parameter");
+		die_error(400, "Invalid file parameter");
 	}
 }
 
 our $file_parent = $cgi->param('fp');
 if (defined $file_parent) {
 	if (!validate_pathname($file_parent)) {
-		die_error(undef, "Invalid file parent parameter");
+		die_error(400, "Invalid file parent parameter");
 	}
 }
 
@@ -421,21 +421,21 @@ if (defined $file_parent) {
 our $hash = $cgi->param('h');
 if (defined $hash) {
 	if (!validate_refname($hash)) {
-		die_error(undef, "Invalid hash parameter");
+		die_error(400, "Invalid hash parameter");
 	}
 }
 
 our $hash_parent = $cgi->param('hp');
 if (defined $hash_parent) {
 	if (!validate_refname($hash_parent)) {
-		die_error(undef, "Invalid hash parent parameter");
+		die_error(400, "Invalid hash parent parameter");
 	}
 }
 
 our $hash_base = $cgi->param('hb');
 if (defined $hash_base) {
 	if (!validate_refname($hash_base)) {
-		die_error(undef, "Invalid hash base parameter");
+		die_error(400, "Invalid hash base parameter");
 	}
 }
 
@@ -447,10 +447,10 @@ our @extra_options = $cgi->param('opt');
 if (defined @extra_options) {
 	foreach my $opt (@extra_options) {
 		if (not exists $allowed_options{$opt}) {
-			die_error(undef, "Invalid option parameter");
+			die_error(400, "Invalid option parameter");
 		}
 		if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
-			die_error(undef, "Invalid option parameter for this action");
+			die_error(400, "Invalid option parameter for this action");
 		}
 	}
 }
@@ -458,7 +458,7 @@ if (defined @extra_options) {
 our $hash_parent_base = $cgi->param('hpb');
 if (defined $hash_parent_base) {
 	if (!validate_refname($hash_parent_base)) {
-		die_error(undef, "Invalid hash parent base parameter");
+		die_error(400, "Invalid hash parent base parameter");
 	}
 }
 
@@ -466,14 +466,14 @@ if (defined $hash_parent_base) {
 our $page = $cgi->param('pg');
 if (defined $page) {
 	if ($page =~ m/[^0-9]/) {
-		die_error(undef, "Invalid page parameter");
+		die_error(400, "Invalid page parameter");
 	}
 }
 
 our $searchtype = $cgi->param('st');
 if (defined $searchtype) {
 	if ($searchtype =~ m/[^a-z]/) {
-		die_error(undef, "Invalid searchtype parameter");
+		die_error(400, "Invalid searchtype parameter");
 	}
 }
 
@@ -483,7 +483,7 @@ our $searchtext = $cgi->param('s');
 our $search_regexp;
 if (defined $searchtext) {
 	if (length($searchtext) < 2) {
-		die_error(undef, "At least two characters are required for search parameter");
+		die_error(403, "At least two characters are required for search parameter");
 	}
 	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 }
@@ -580,11 +580,11 @@ if (!defined $action) {
 	}
 }
 if (!defined($actions{$action})) {
-	die_error(undef, "Unknown action");
+	die_error(400, "Unknown action");
 }
 if ($action !~ m/^(opml|project_list|project_index)$/ &&
     !$project) {
-	die_error(undef, "Project needed");
+	die_error(400, "Project needed");
 }
 $actions{$action}->();
 exit;
@@ -1665,7 +1665,7 @@ sub git_get_hash_by_path {
 	$path =~ s,/+$,,;
 
 	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
-		or die_error(undef, "Open git-ls-tree failed");
+		or die_error(500, "Open git-ls-tree failed");
 	my $line = <$fd>;
 	close $fd or return undef;
 
@@ -2127,7 +2127,7 @@ sub parse_commit {
 		"--max-count=1",
 		$commit_id,
 		"--",
-		or die_error(undef, "Open git-rev-list failed");
+		or die_error(500, "Open git-rev-list failed");
 	%co = parse_commit_text(<$fd>, 1);
 	close $fd;
 
@@ -2152,7 +2152,7 @@ sub parse_commits {
 		$commit_id,
 		"--",
 		($filename ? ($filename) : ())
-		or die_error(undef, "Open git-rev-list failed");
+		or die_error(500, "Open git-rev-list failed");
 	while (my $line = <$fd>) {
 		my %co = parse_commit_text($line);
 		push @cos, \%co;
@@ -2672,11 +2672,24 @@ sub git_footer_html {
 	      "</html>";
 }
 
+# die_error(<http_status_code>, <error_message>)
+# Example: die_error(404, 'Hash not found')
+# By convention, use the following status codes (as defined in RFC 2616):
+# 400: Invalid or missing CGI parameters, or
+#      requested object exists but has wrong type.
+# 403: Requested feature (like "pickaxe" or "snapshot") not enabled on
+#      this server or project.
+# 404: Requested object/revision/project doesn't exist.
+# 500: The server isn't configured properly, or
+#      an internal error occurred (e.g. failed assertions caused by bugs), or
+#      an unknown error occurred (e.g. the git binary died unexpectedly).
 sub die_error {
-	my $status = shift || "403 Forbidden";
-	my $error = shift || "Malformed query, file missing or permission denied";
+	my $status = shift || 500;
+	my $error = shift || "Internal server error";
 
-	git_header_html($status);
+	# Use a generic "Error" reason, e.g. "404 Error" instead of
+	# "404 Not Found".  This is permissible by RFC 2616.
+	git_header_html("$status Error");
 	print <<EOF;
 <div class="page_body">
 <br /><br />
@@ -3924,12 +3937,12 @@ sub git_search_grep_body {
 sub git_project_list {
 	my $order = $cgi->param('o');
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
-		die_error(undef, "Unknown order parameter");
+		die_error(400, "Unknown order parameter");
 	}
 
 	my @list = git_get_projects_list();
 	if (!@list) {
-		die_error(undef, "No projects found");
+		die_error(404, "No projects found");
 	}
 
 	git_header_html();
@@ -3947,12 +3960,12 @@ sub git_project_list {
 sub git_forks {
 	my $order = $cgi->param('o');
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
-		die_error(undef, "Unknown order parameter");
+		die_error(400, "Unknown order parameter");
 	}
 
 	my @list = git_get_projects_list($project);
 	if (!@list) {
-		die_error(undef, "No forks found");
+		die_error(404, "No forks found");
 	}
 
 	git_header_html();
@@ -4081,7 +4094,7 @@ sub git_tag {
 	my %tag = parse_tag($hash);
 
 	if (! %tag) {
-		die_error(undef, "Unknown tag object");
+		die_error(404, "Unknown tag object");
 	}
 
 	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
@@ -4117,26 +4130,25 @@ sub git_blame {
 	my $fd;
 	my $ftype;
 
-	my ($have_blame) = gitweb_check_feature('blame');
-	if (!$have_blame) {
-		die_error('403 Permission denied', "Permission denied");
-	}
-	die_error('404 Not Found', "File name not defined") if (!$file_name);
+	gitweb_check_feature('blame')
+	    or die_error(403, "Blame not allowed");
+
+	die_error(400, "No file name given") unless $file_name;
 	$hash_base ||= git_get_head_hash($project);
-	die_error(undef, "Couldn't find base commit") unless ($hash_base);
+	die_error(400, "Couldn't find base commit") unless ($hash_base);
 	my %co = parse_commit($hash_base)
-		or die_error(undef, "Reading commit failed");
+		or die_error(404, "Commit not found");
 	if (!defined $hash) {
 		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
-			or die_error(undef, "Error looking up file");
+			or die_error(404, "Error looking up file");
 	}
 	$ftype = git_get_type($hash);
 	if ($ftype !~ "blob") {
-		die_error('400 Bad Request', "Object is not a blob");
+		die_error(400, "Object is not a blob");
 	}
 	open ($fd, "-|", git_cmd(), "blame", '-p', '--',
 	      $file_name, $hash_base)
-		or die_error(undef, "Open git-blame failed");
+		or die_error(500, "Open git-blame failed");
 	git_header_html();
 	my $formats_nav =
 		$cgi->a({-href => href(action=>"blob", -replay=>1)},
@@ -4198,7 +4210,7 @@ HTML
 			print "</td>\n";
 		}
 		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-			or die_error(undef, "Open git-rev-parse failed");
+			or die_error(500, "Open git-rev-parse failed");
 		my $parent_commit = <$dd>;
 		close $dd;
 		chomp($parent_commit);
@@ -4255,9 +4267,9 @@ sub git_blob_plain {
 		if (defined $file_name) {
 			my $base = $hash_base || git_get_head_hash($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
-				or die_error(undef, "Error lookup file");
+				or die_error(404, "Cannot find file");
 		} else {
-			die_error(undef, "No file name defined");
+			die_error(400, "No file name defined");
 		}
 	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		# blobs defined by non-textual hash id's can be cached
@@ -4265,7 +4277,7 @@ sub git_blob_plain {
 	}
 
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
-		or die_error(undef, "Open git-cat-file blob '$hash' failed");
+		or die_error(500, "Open git-cat-file blob '$hash' failed");
 
 	# content-type (can include charset)
 	$type = blob_contenttype($fd, $file_name, $type);
@@ -4297,9 +4309,9 @@ sub git_blob {
 		if (defined $file_name) {
 			my $base = $hash_base || git_get_head_hash($project);
 			$hash = git_get_hash_by_path($base, $file_name, "blob")
-				or die_error(undef, "Error lookup file");
+				or die_error(404, "Cannot find file");
 		} else {
-			die_error(undef, "No file name defined");
+			die_error(400, "No file name defined");
 		}
 	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
 		# blobs defined by non-textual hash id's can be cached
@@ -4308,7 +4320,7 @@ sub git_blob {
 
 	my ($have_blame) = gitweb_check_feature('blame');
 	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
-		or die_error(undef, "Couldn't cat $file_name, $hash");
+		or die_error(500, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
 	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)! && -B $fd) {
 		close $fd;
@@ -4389,9 +4401,9 @@ sub git_tree {
 	}
 	$/ = "\0";
 	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
-		or die_error(undef, "Open git-ls-tree failed");
+		or die_error(500, "Open git-ls-tree failed");
 	my @entries = map { chomp; $_ } <$fd>;
-	close $fd or die_error(undef, "Reading tree failed");
+	close $fd or die_error(500, "Reading tree failed");
 	$/ = "\n";
 
 	my $refs = git_get_references();
@@ -4481,16 +4493,16 @@ sub git_snapshot {
 
 	my $format = $cgi->param('sf');
 	if (!@supported_fmts) {
-		die_error('403 Permission denied', "Permission denied");
+		die_error(403, "Snapshots not allowed");
 	}
 	# default to first supported snapshot format
 	$format ||= $supported_fmts[0];
 	if ($format !~ m/^[a-z0-9]+$/) {
-		die_error(undef, "Invalid snapshot format parameter");
+		die_error(400, "Invalid snapshot format parameter");
 	} elsif (!exists($known_snapshot_formats{$format})) {
-		die_error(undef, "Unknown snapshot format");
+		die_error(400, "Unknown snapshot format");
 	} elsif (!grep($_ eq $format, @supported_fmts)) {
-		die_error(undef, "Unsupported snapshot format");
+		die_error(403, "Unsupported snapshot format");
 	}
 
 	if (!defined $hash) {
@@ -4518,7 +4530,7 @@ sub git_snapshot {
 		-status => '200 OK');
 
 	open my $fd, "-|", $cmd
-		or die_error(undef, "Execute git-archive failed");
+		or die_error(500, "Execute git-archive failed");
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
@@ -4586,10 +4598,8 @@ sub git_log {
 
 sub git_commit {
 	$hash ||= $hash_base || "HEAD";
-	my %co = parse_commit($hash);
-	if (!%co) {
-		die_error(undef, "Unknown commit object");
-	}
+	my %co = parse_commit($hash)
+	    or die_error(404, "Unknown commit object");
 	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
@@ -4629,9 +4639,9 @@ sub git_commit {
 		@diff_opts,
 		(@$parents <= 1 ? $parent : '-c'),
 		$hash, "--"
-		or die_error(undef, "Open git-diff-tree failed");
+		or die_error(500, "Open git-diff-tree failed");
 	@difftree = map { chomp; $_ } <$fd>;
-	close $fd or die_error(undef, "Reading git-diff-tree failed");
+	close $fd or die_error(500, "Reading git-diff-tree failed");
 
 	# non-textual hash id's can be cached
 	my $expires;
@@ -4724,33 +4734,33 @@ sub git_object {
 
 		open my $fd, "-|", quote_command(
 			git_cmd(), 'cat-file', '-t', $object_id) . ' 2> /dev/null'
-			or die_error('404 Not Found', "Object does not exist");
+			or die_error(404, "Object does not exist");
 		$type = <$fd>;
 		chomp $type;
 		close $fd
-			or die_error('404 Not Found', "Object does not exist");
+			or die_error(404, "Object does not exist");
 
 	# - hash_base and file_name
 	} elsif ($hash_base && defined $file_name) {
 		$file_name =~ s,/+$,,;
 
 		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
-			or die_error('404 Not Found', "Base object does not exist");
+			or die_error(404, "Base object does not exist");
 
 		# here errors should not hapen
 		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
-			or die_error(undef, "Open git-ls-tree failed");
+			or die_error(500, "Open git-ls-tree failed");
 		my $line = <$fd>;
 		close $fd;
 
 		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
 		unless ($line && $line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/) {
-			die_error('404 Not Found', "File or directory for given base does not exist");
+			die_error(404, "File or directory for given base does not exist");
 		}
 		$type = $2;
 		$hash = $3;
 	} else {
-		die_error('404 Not Found', "Not enough information to find object");
+		die_error(400, "Not enough information to find object");
 	}
 
 	print $cgi->redirect(-uri => href(action=>$type, -full=>1,
@@ -4775,12 +4785,12 @@ sub git_blobdiff {
 			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 				$hash_parent_base, $hash_base,
 				"--", (defined $file_parent ? $file_parent : ()), $file_name
-				or die_error(undef, "Open git-diff-tree failed");
+				or die_error(500, "Open git-diff-tree failed");
 			@difftree = map { chomp; $_ } <$fd>;
 			close $fd
-				or die_error(undef, "Reading git-diff-tree failed");
+				or die_error(500, "Reading git-diff-tree failed");
 			@difftree
-				or die_error('404 Not Found', "Blob diff not found");
+				or die_error(404, "Blob diff not found");
 
 		} elsif (defined $hash &&
 		         $hash =~ /[0-9a-fA-F]{40}/) {
@@ -4789,23 +4799,23 @@ sub git_blobdiff {
 			# read filtered raw output
 			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 				$hash_parent_base, $hash_base, "--"
-				or die_error(undef, "Open git-diff-tree failed");
+				or die_error(500, "Open git-diff-tree failed");
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
 				# $hash == to_id
 				grep { /^:[0-7]{6} [0-7]{6} [0-9a-fA-F]{40} $hash/ }
 				map { chomp; $_ } <$fd>;
 			close $fd
-				or die_error(undef, "Reading git-diff-tree failed");
+				or die_error(500, "Reading git-diff-tree failed");
 			@difftree
-				or die_error('404 Not Found', "Blob diff not found");
+				or die_error(404, "Blob diff not found");
 
 		} else {
-			die_error('404 Not Found', "Missing one of the blob diff parameters");
+			die_error(400, "Missing one of the blob diff parameters");
 		}
 
 		if (@difftree > 1) {
-			die_error('404 Not Found', "Ambiguous blob diff specification");
+			die_error(400, "Ambiguous blob diff specification");
 		}
 
 		%diffinfo = parse_difftree_raw_line($difftree[0]);
@@ -4826,7 +4836,7 @@ sub git_blobdiff {
 			'-p', ($format eq 'html' ? "--full-index" : ()),
 			$hash_parent_base, $hash_base,
 			"--", (defined $file_parent ? $file_parent : ()), $file_name
-			or die_error(undef, "Open git-diff-tree failed");
+			or die_error(500, "Open git-diff-tree failed");
 	}
 
 	# old/legacy style URI
@@ -4862,9 +4872,9 @@ sub git_blobdiff {
 		open $fd, "-|", git_cmd(), "diff", @diff_opts,
 			'-p', ($format eq 'html' ? "--full-index" : ()),
 			$hash_parent, $hash, "--"
-			or die_error(undef, "Open git-diff failed");
+			or die_error(500, "Open git-diff failed");
 	} else  {
-		die_error('404 Not Found', "Missing one of the blob diff parameters")
+		die_error(400, "Missing one of the blob diff parameters")
 			unless %diffinfo;
 	}
 
@@ -4897,7 +4907,7 @@ sub git_blobdiff {
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
 	} else {
-		die_error(undef, "Unknown blobdiff format");
+		die_error(400, "Unknown blobdiff format");
 	}
 
 	# patch
@@ -4932,10 +4942,8 @@ sub git_blobdiff_plain {
 sub git_commitdiff {
 	my $format = shift || 'html';
 	$hash ||= $hash_base || "HEAD";
-	my %co = parse_commit($hash);
-	if (!%co) {
-		die_error(undef, "Unknown commit object");
-	}
+	my %co = parse_commit($hash)
+	    or die_error(404, "Unknown commit object");
 
 	# choose format for commitdiff for merge
 	if (! defined $hash_parent && @{$co{'parents'}} > 1) {
@@ -5017,7 +5025,7 @@ sub git_commitdiff {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			"--no-commit-id", "--patch-with-raw", "--full-index",
 			$hash_parent_param, $hash, "--"
-			or die_error(undef, "Open git-diff-tree failed");
+			or die_error(500, "Open git-diff-tree failed");
 
 		while (my $line = <$fd>) {
 			chomp $line;
@@ -5029,10 +5037,10 @@ sub git_commitdiff {
 	} elsif ($format eq 'plain') {
 		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
 			'-p', $hash_parent_param, $hash, "--"
-			or die_error(undef, "Open git-diff-tree failed");
+			or die_error(500, "Open git-diff-tree failed");
 
 	} else {
-		die_error(undef, "Unknown commitdiff format");
+		die_error(400, "Unknown commitdiff format");
 	}
 
 	# non-textual hash id's can be cached
@@ -5115,19 +5123,15 @@ sub git_history {
 		$page = 0;
 	}
 	my $ftype;
-	my %co = parse_commit($hash_base);
-	if (!%co) {
-		die_error(undef, "Unknown commit object");
-	}
+	my %co = parse_commit($hash_base)
+	    or die_error(404, "Unknown commit object");
 
 	my $refs = git_get_references();
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 
 	my @commitlist = parse_commits($hash_base, 101, (100 * $page),
-	                               $file_name, "--full-history");
-	if (!@commitlist) {
-		die_error('404 Not Found', "No such file or directory on given branch");
-	}
+	                               $file_name, "--full-history")
+	    or die_error(404, "No such file or directory on given branch");
 
 	if (!defined $hash && defined $file_name) {
 		# some commits could have deleted file in question,
@@ -5141,7 +5145,7 @@ sub git_history {
 		$ftype = git_get_type($hash);
 	}
 	if (!defined $ftype) {
-		die_error(undef, "Unknown type of object");
+		die_error(500, "Unknown type of object");
 	}
 
 	my $paging_nav = '';
@@ -5179,19 +5183,16 @@ sub git_history {
 }
 
 sub git_search {
-	my ($have_search) = gitweb_check_feature('search');
-	if (!$have_search) {
-		die_error('403 Permission denied', "Permission denied");
-	}
+	gitweb_check_feature('search') or die_error(403, "Search is disabled");
 	if (!defined $searchtext) {
-		die_error(undef, "Text field empty");
+		die_error(400, "Text field is empty");
 	}
 	if (!defined $hash) {
 		$hash = git_get_head_hash($project);
 	}
 	my %co = parse_commit($hash);
 	if (!%co) {
-		die_error(undef, "Unknown commit object");
+		die_error(404, "Unknown commit object");
 	}
 	if (!defined $page) {
 		$page = 0;
@@ -5201,16 +5202,12 @@ sub git_search {
 	if ($searchtype eq 'pickaxe') {
 		# pickaxe may take all resources of your box and run for several minutes
 		# with every query - so decide by yourself how public you make this feature
-		my ($have_pickaxe) = gitweb_check_feature('pickaxe');
-		if (!$have_pickaxe) {
-			die_error('403 Permission denied', "Permission denied");
-		}
+		gitweb_check_feature('pickaxe')
+		    or die_error(403, "Pickaxe is disabled");
 	}
 	if ($searchtype eq 'grep') {
-		my ($have_grep) = gitweb_check_feature('grep');
-		if (!$have_grep) {
-			die_error('403 Permission denied', "Permission denied");
-		}
+		gitweb_check_feature('grep')
+		    or die_error(403, "Grep is disabled");
 	}
 
 	git_header_html();
@@ -5484,7 +5481,7 @@ sub git_feed {
 	# Atom: http://www.atomenabled.org/developers/syndication/
 	# RSS:  http://www.notestips.com/80256B3A007F2692/1/NAMO5P9UPQ
 	if ($format ne 'rss' && $format ne 'atom') {
-		die_error(undef, "Unknown web feed format");
+		die_error(400, "Unknown web feed format");
 	}
 
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
-- 
1.5.6.rc3.7.ged9620
