From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple
	formats
Date: Mon, 09 Jul 2007 21:14:20 -0400
Message-ID: <1184030060.11726.0.camel@mattlaptop2>
References: <7vr6nht9yq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 03:15:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I84Jl-0002XY-PF
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 03:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758816AbXGJBPC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 21:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757179AbXGJBPB
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 21:15:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:38721 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159AbXGJBPA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 21:15:00 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1045259wxd
        for <git@vger.kernel.org>; Mon, 09 Jul 2007 18:14:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=N34TJQSKjO2twgPvFxyIUPVfVfisOPE6qvxjBX2d0uxX6sedRvkTfY1C5PJ9JWe+WcVUSqVNc2w7J+zhxEr4Q1wha5A8vPwzN+o8mjmpeM+kok1BBZr43IfN5nFe95fG95Q4a72E62Au2b2exEGA7Lh3clVj2WgQIS1uNasvK3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=JAtSJYe78Zl8xsQjXgPi2fPBZj+TZ+vuqEuSKq7ODBDQMsjT8FJ39CVBGCGF+i8jkcSZKQqOVNe4u1W+/av8VbyXJDxYM8QpmbDU67lhb11yqde6xqz+6qBQmhyB1oV8LX0J+ArUwNBBUKesP2/UplYAfH7RjIVe0QcGPf1H64M=
Received: by 10.70.70.7 with SMTP id s7mr6775267wxa.1184030099360;
        Mon, 09 Jul 2007 18:14:59 -0700 (PDT)
Received: from ?192.168.1.10? ( [69.234.35.98])
        by mx.google.com with ESMTP id n29sm17484690elf.2007.07.09.18.14.55
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jul 2007 18:14:58 -0700 (PDT)
In-Reply-To: <7vr6nht9yq.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.10.2 (2.10.2-3.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52028>

- Centralize knowledge about snapshot formats (mime types, extensions,
  commands) in %known_snapshot_formats and improve how some of that
  information is specified.  In particular, zip files are no longer a
  special case.

- Add support for offering multiple snapshot formats to the user so
  that he/she can download a snapshot in the format he/she prefers.
  The site-wide or project configuration now gives a list of formats
  to offer, and if more than one format is offered, the "_snapshot_"
  link becomes something like "snapshot (_tbz2_ _zip_)".

- Fix out-of-date "tarball" -> "archive" in comment.

Alert for gitweb site administrators: This patch changes the format of
$feature{'snapshot'}{'default'} in gitweb_config.perl from a list of three
pieces of information about a single format to a list of one or more formats
you wish to offer from the set ('tgz', 'tbz2', 'zip').  Update your
gitweb_config.perl appropriately.

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
---
This third revision of the patch keeps the link as "_snapshot_" when only one
format is offered.

 gitweb/gitweb.perl |  110 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 61 insertions(+), 49 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dc609f4..b520342 100755
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
 
@@ -1236,6 +1235,25 @@ sub format_diff_line {
 	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1) . "</div>\n";
 }
 
+# Generates undef or something like "snapshot (tbz2 zip)", linked.
+# Pass the hash.
+sub format_snapshot_links {
+	my ($hash) = @_;
+	my @snapshot_fmts = gitweb_check_feature('snapshot');
+	my $num_fmts = @snapshot_fmts;
+	if ($num_fmts > 1) {
+		return "snapshot (" . join(' ', map $cgi->a(
+			{-href => href(action=>"snapshot", hash=>$hash, snapshot_format=>$_)}, "$_"),
+			@snapshot_fmts)
+		. ")";
+	} elsif ($num_fmts == 1) {
+		return $cgi->a({-href => href(action=>"snapshot", hash=>$hash,
+			snapshot_format=>$snapshot_fmts[0])}, "snapshot");
+	} else { # $num_fmts == 0
+		return undef;
+	}
+}
+
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
@@ -3299,8 +3317,6 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
@@ -3327,8 +3343,9 @@ sub git_shortlog_body {
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
@@ -4110,8 +4127,6 @@ sub git_blob {
 }
 
 sub git_tree {
-	my $have_snapshot = gitweb_have_snapshot();
-
 	if (!defined $hash_base) {
 		$hash_base = "HEAD";
 	}
@@ -4145,11 +4160,10 @@ sub git_tree {
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
@@ -4213,11 +4227,16 @@ sub git_tree {
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
@@ -4230,16 +4249,11 @@ sub git_snapshot {
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
 
@@ -4368,8 +4382,6 @@ sub git_commit {
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	git_header_html(undef, $expires);
 	git_print_page_nav('commit', '',
 	                   $hash, $co{'tree'}, $hash,
@@ -4408,9 +4420,9 @@ sub git_commit {
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
1.5.3.rc0.83.gb18a6
