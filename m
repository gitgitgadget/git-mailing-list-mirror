From: Matt McCutchen <hashproduct@gmail.com>
Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple
	formats
Date: Thu, 28 Jun 2007 14:02:13 -0400
Message-ID: <1183053733.6108.0.camel@mattlaptop2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 28 20:02:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3yJw-0004Lq-LG
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 20:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658AbXF1SCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbXF1SCS
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 14:02:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:5259 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbXF1SCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 14:02:17 -0400
Received: by wx-out-0506.google.com with SMTP id h31so595766wxd
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 11:02:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ZCFuU8xzdLmicA502NcmF3Ujwp0HdSyDulADqXEn4Cgw/Mp5934ChWKTTtxsykc/6ujUNGrEKgCppdxvgurkoZjz58MAHJ+MrdaW2v2P9pIk4Nb8A748dGL2iBDwJKjHoTC+RxI+oPok0t4rU/7Lz2jBIgTx77LNUys616kk+24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Na4JGXdUg8yGUyldBWhSgsp7Dbk6ZJqwNTaJWn0teQR8ByZV6Y6YCBX79GJVr6thpubgLV5TYmsTyx2q0IS4sifyEyT8IgDK74AQg+jFlnq7jI9rkDK2AMzCF8y8p3NyWIeHIcMDdHrbPphGRoH4N94CSQOym6IBFKhIFBEJIr4=
Received: by 10.90.94.2 with SMTP id r2mr2139387agb.1183053736370;
        Thu, 28 Jun 2007 11:02:16 -0700 (PDT)
Received: from ?192.168.1.10? ( [71.163.72.121])
        by mx.google.com with ESMTP id 7sm7134866agb.2007.06.28.11.02.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jun 2007 11:02:16 -0700 (PDT)
X-Mailer: Evolution 2.10.2 (2.10.2-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51121>

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

Signed-off-by: Matt McCutchen <hashproduct@gmail.com>
---

I implemented this a while ago for my Web site.  You can see it in action at:

http://www.kepreon.com/~matt/mgear/mgear.git/

I thought I would submit it to the main project so you can adopt it if you like
it.

Matt

 gitweb/gitweb.perl |   89 +++++++++++++++++++++++++++++----------------------
 1 files changed, 51 insertions(+), 38 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index dbfb044..f36428e 100755
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
 
@@ -3280,8 +3294,6 @@ sub git_shortlog_body {
 	# uses global variable $project
 	my ($commitlist, $from, $to, $refs, $extra) = @_;
 
-	my $have_snapshot = gitweb_have_snapshot();
-
 	$from = 0 unless defined $from;
 	$to = $#{$commitlist} if (!defined $to || $#{$commitlist} < $to);
 
@@ -3308,8 +3320,9 @@ sub git_shortlog_body {
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
@@ -4194,11 +4207,16 @@ sub git_tree {
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
@@ -4211,16 +4229,11 @@ sub git_snapshot {
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
 
-- 
1.5.2.2.552.gc32f
