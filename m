From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple
	formats
Date: Mon, 09 Jul 2007 19:21:58 -0400
Message-ID: <1184023318.9703.1.camel@mattlaptop2>
References: <3bbc18d20707091552l29fb81b6v34da9cef3ec0df58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 01:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I82Z9-0003PE-1H
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 01:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288AbXGIXWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 19:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756198AbXGIXWr
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 19:22:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:48737 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbXGIXWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 19:22:46 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1022342wxd
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 16:22:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=mv36JhX9YRen7ysk24ogmnhphlD4rp2CAfeMeqJAb/MLlJv42GZcv7uFRvJCtYkHmJmQmwanKHn9hahT+QWCwNr9YZ17VsHnHeknEqS0xOLV9u6qUo04Q5TAK0cmeorZnVQgUjJ/uzHmcfm8OXAAiGc5OigZjbQxDpCJESmF3As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=HI9UiwC+BrjMG1/UzHGkg2r9WthgNcLIqBSa2QlXhrZqJR2jNjlQMVyjMoChGpZdX1Gto5QUMGTodSx0scqFe54xnwIu1kHrisrI+IHGEpbbWLOnhJF1iVwpv0uYyDRlTrBmWwzr4DL5bmW6TjOgpBHwLHWTaIF7jNnHTXLXq+o=
Received: by 10.70.25.12 with SMTP id 12mr3333657wxy.1184023365995;
        Mon, 09 Jul 2007 16:22:45 -0700 (PDT)
Received: from ?192.168.1.10? ( [69.234.35.98])
        by mx.google.com with ESMTP id m30sm16466940elf.2007.07.09.16.22.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jul 2007 16:22:45 -0700 (PDT)
In-Reply-To: <3bbc18d20707091552l29fb81b6v34da9cef3ec0df58@mail.gmail.com>
X-Mailer: Evolution 2.10.2 (2.10.2-3.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52025>

- Centralize knowledge about snapshot formats (mime types, extensions,
  commands) in %known_snapshot_formats and improve how some of that
  information is specified.  In particular, zip files are no longer a
  special case.

- Add support for offering multiple snapshot formats to the user so
  that he/she can download a snapshot in the format he/she prefers.
  The site-wide or project configuration now gives a list of formats
  to offer, and the "_snapshot_" link is replaced with, say,
  "snapshot (_tbz2_ _zip_)".

- Fix out-of-date "tarball" -> "archive" in comment.

Alert for gitweb site administrators: This patch changes the format of
$feature{'snapshot'}{'default'} in gitweb_config.perl from a list of three
pieces of information about a single format to a list of one or more formats
you wish to offer from the set ('tgz', 'tbz2', 'zip').  Update your
gitweb_config.perl appropriately.

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
---
This revised patch converts the two remaining gitweb_have_snapshot callers and
adds the alert in the commit message.

 gitweb/gitweb.perl |  106 ++++++++++++++++++++++++++++------------------------
 1 files changed, 57 insertions(+), 49 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dc609f4..4313671 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -101,6 +101,15 @@ our $mimetypes_file = undef;
 # could be even 'utf-8' for the old behavior)
 our $fallback_encoding = 'latin1';
 
+# information about snapshot formats that gitweb is capable of serving
+# name => [mime type, filename suffix, --format for git-archive,
+#          compressor command suffix]
+our %known_snapshot_formats = (
+	'tgz'  => ['application/x-gzip' , '.tar.gz' , 'tar', '| gzip' ],
+	'tbz2' => ['application/x-bzip2', '.tar.bz2', 'tar', '| bzip2'],
+	'zip'  => ['application/zip'    , '.zip'    , 'zip', ''       ],
+);
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -131,20 +140,22 @@ our %feature = (
 		'override' => 0,
 		'default' => [0]},
 
-	# Enable the 'snapshot' link, providing a compressed tarball of any
+	# Enable the 'snapshot' link, providing a compressed archive of any
 	# tree. This can potentially generate high traffic if you have large
 	# project.
 
+	# Value is a list of formats defined in %known_snapshot_formats that
+	# you wish to offer.
 	# To disable system wide have in $GITWEB_CONFIG
-	# $feature{'snapshot'}{'default'} = [undef];
+	# $feature{'snapshot'}{'default'} = [];
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'snapshot'}{'override'} = 1;
-	# and in project config gitweb.snapshot = none|gzip|bzip2|zip;
+	# and in project config, a comma-separated list of formats or "none"
+	# to disable.  Example: gitweb.snapshot = tbz2,zip;
 	'snapshot' => {
 		'sub' => \&feature_snapshot,
 		'override' => 0,
-		#         => [content-encoding, suffix, program]
-		'default' => ['x-gzip', 'gz', 'gzip']},
+		'default' => ['tgz']},
 
 	# Enable text search, which will list the commits which match author,
 	# committer or commit text to a given string.  Enabled by default.
@@ -243,28 +254,15 @@ sub feature_blame {
 }
 
 sub feature_snapshot {
-	my ($ctype, $suffix, $command) = @_;
+	my (@fmts) = @_;
 
 	my ($val) = git_get_project_config('snapshot');
 
-	if ($val eq 'gzip') {
-		return ('x-gzip', 'gz', 'gzip');
-	} elsif ($val eq 'bzip2') {
-		return ('x-bzip2', 'bz2', 'bzip2');
-	} elsif ($val eq 'zip') {
-		return ('x-zip', 'zip', '');
-	} elsif ($val eq 'none') {
-		return ();
+	if ($val) {
+		@fmts = ($val eq 'none' ? () : split /,/, $val);
 	}
 
-	return ($ctype, $suffix, $command);
-}
-
-sub gitweb_have_snapshot {
-	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-	my $have_snapshot = (defined $ctype && defined $suffix);
-
-	return $have_snapshot;
+	return grep exists $known_snapshot_formats{$_}, @fmts;
 }
 
 sub feature_grep {
@@ -542,6 +540,7 @@ sub href(%) {
 		order => "o",
 		searchtext => "s",
 		searchtype => "st",
+		snapshot_format => "sf",
 	);
 	my %mapping = @mapping;
 
@@ -1236,6 +1235,21 @@ sub format_diff_line {
 	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
 
+# Generates undef or something like "snapshot (tbz2 zip)", linked.
+# Pass the hash.
+sub format_snapshot_links {
+	my ($hash) = @_;
+	my @snapshot_fmts = gitweb_check_feature('snapshot');
+	if (@snapshot_fmts) {
+		return "snapshot (" . join(' ', map $cgi->a(
+			{-href => href(action=>"snapshot", hash=>$hash, snapshot_format=>$_)}, "$_"),
+			@snapshot_fmts)
+		. ")";
+	} else {
+		return undef;
+	}
+}
+
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -3299,8 +3313,6 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
@@ -3327,8 +3339,9 @@ sub git_shortlog_body {
 		      $cgi->a({-href => href(action=>"commit", hash=>$commit)}, "commit") . " | " .
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff") . " | " .
 		      $cgi->a({-href => href(action=>"tree", hash=>$commit, hash_base=>$commit)}, "tree");
-		if ($have_snapshot) {
-			print " | " . $cgi->a({-href => href(action=>"snapshot", hash=>$commit)}, "snapshot");
+		my $snapshot_links = format_snapshot_links($commit);
+		if (defined $snapshot_links) {
+			print " | " . $snapshot_links;
 		}
 		print "</td>\n" .
 		      "</tr>\n";
@@ -4110,8 +4123,6 @@ sub git_blob {
 }
 
 sub git_tree {
-	my $have_snapshot = gitweb_have_snapshot();
-
 	if (!defined $hash_base) {
 		$hash_base = "HEAD";
 	}
@@ -4145,11 +4156,10 @@ sub git_tree {
 				                       hash_base=>"HEAD", file_name=>$file_name)},
 				        "HEAD"),
 		}
-		if ($have_snapshot) {
+		my $snapshot_links = format_snapshot_links($hash);
+		if (defined $snapshot_links) {
 			# FIXME: Should be available when we have no hash base as well.
-			push @views_nav,
-				$cgi->a({-href => href(action=>"snapshot", hash=>$hash)},
-				        "snapshot");
+			push @views_nav, $snapshot_links;
 		}
 		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
@@ -4213,11 +4223,16 @@ sub git_tree {
 }
 
 sub git_snapshot {
-	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
-	my $have_snapshot = (defined $ctype && defined $suffix);
-	if (!$have_snapshot) {
-		die_error('403 Permission denied', "Permission denied");
+	my @supported_fmts = gitweb_check_feature('snapshot');
+
+	my $format = $cgi->param('sf');
+	unless ($format =~ m/[a-z0-9]+/
+		&& exists($known_snapshot_formats{$format})
+		&& grep($_ eq $format, @supported_fmts)) {
+		die_error(undef, "Unsupported snapshot format");
 	}
+	my ($ctype, $suffix, $ga_format, $pipe_compressor) =
+		@{$known_snapshot_formats{$format}};
 
 	if (!defined $hash) {
 		$hash = git_get_head_hash($project);
@@ -4230,16 +4245,11 @@ sub git_snapshot {
 	my $filename = to_utf8($name);
 	$name =~ s/\047/\047\\\047\047/g;
 	my $cmd;
-	if ($suffix eq 'zip') {
-		$filename .= "-$hash.$suffix";
-		$cmd = "$git archive --format=zip --prefix=\'$name\'/ $hash";
-	} else {
-		$filename .= "-$hash.tar.$suffix";
-		$cmd = "$git archive --format=tar --prefix=\'$name\'/ $hash | $command";
-	}
+	$filename .= "-$hash$suffix";
+	$cmd = "$git archive --format=$ga_format --prefix=\'$name\'/ $hash $pipe_compressor";
 
 	print $cgi->header(
-		-type => "application/$ctype",
+		-type => "$ctype",
 		-content_disposition => 'inline; filename="' . "$filename" . '"',
 		-status => '200 OK');
 
@@ -4368,8 +4378,6 @@ sub git_commit {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', '',
 	                   $hash, $co{'tree'}, $hash,
@@ -4408,9 +4416,9 @@ sub git_commit {
 	      "<td class=\"link\">" .
 	      $cgi->a({-href => href(action=>"tree", hash=>$co{'tree'}, hash_base=>$hash)},
 	              "tree");
-	if ($have_snapshot) {
-		print " | " .
-		      $cgi->a({-href => href(action=>"snapshot", hash=>$hash)}, "snapshot");
+	my $snapshot_links = format_snapshot_links($hash);
+	if (defined $snapshot_links) {
+		print " | " . $snapshot_links;
 	}
 	print "</td>" .
 	      "</tr>\n";
-- 
1.5.3.rc0.82.g2bad2-dirty
