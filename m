From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFH/PATCH] git-svn: adjust info to svn 1.7 and 1.8
Date: Tue, 24 Mar 2015 16:10:18 +0100
Message-ID: <2036c42d7eae00d9cce33fc5fafc729f16a0b451.1427209737.git.git@drmicha.warpmail.net>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 16:10:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaQTL-00080V-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 16:10:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbbCXPKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 11:10:23 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44342 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096AbbCXPKW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 11:10:22 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id BA71920310
	for <git@vger.kernel.org>; Tue, 24 Mar 2015 11:10:17 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 24 Mar 2015 11:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	x-sasl-enc:from:to:cc:subject:date:message-id; s=mesmtp; bh=AQIH
	dy57OkjA61/OWrdBuInMsxA=; b=CYEBjdZnNtS2G75P1faAWogY+us3ZQdc3y3J
	c1fiat9kfq/lV+CwzGcbf0GAcszGKkTyKyH4Bt5jsIsG/qgUJUQfpjhrx1B8ujJy
	4zLy8kJX3wyydKD/p9/fQ+tT7KOcSYubbveGcR5h5yWkTdDxHWM8WoIVe6ZVyMR0
	XW+i4/w=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id; s=smtpout; bh=AQIHdy57OkjA61/OWrdBuInMsxA=; b=YHA/b
	hTAbQkOrEDj3Ha8bkxAGdIDayg7nccnaeYdgG5bOxZ9AThyF1mZqwSI7at99s/Z7
	2eYF41rWeyIA15pgmuKIoNh9v8uLnkPCvA3Vcl+2EdSvCsrkXrNcRZHxjzirmxD7
	9mJ5BjYD/0uOSygGeScOO+iZnNO4M44TNIdDOQ=
X-Sasl-enc: xw0aPqaxw+nmwXjVI53WOonK72m/z7YRBfsieTeFmpZ3 1427209819
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E8DFC6801D0;
	Tue, 24 Mar 2015 11:10:19 -0400 (EDT)
X-Mailer: git-send-email 2.3.4.518.g406241f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266191>

t9119 refuses to run with svn versions greater than 1.6 since "git svn
info" does not even try to match the output of "svn info" for later
versions.

Adjust "git svn info" to match these versions and make t9119 run with
them. This requires the following changes:

* compute checksums with SHA1 instead of MD5 with svn >= 1.7.0
* omit the line "Revision: 0" for added content with svn >= 1.8.0 (TBC)
* print the "Repository UUID" line even for added content with svn >=
  1.8.0 (TBC)
* add a "Relative URL" line for svn >= 1.8.0
* add a "Working Copy Root Path" line for svn >= 1.8.0 (TBC, RFH)

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    While trying to increase my test run coverage I noticed that most of us won't
    run t9119 at all. Bad bad.
    
    My svn is 1.8.11 (r1643975) on Fedora 21.
    
    I would appreciate help with the following items:
    
    TBC = to be confirmed: confirm the svn version where this change kicked it,
    or run this patch and t9119 with an svn version other than mine. Please
    run with "-v" to make sure only the RFH item fails, see below.
    
    RFH = request for help: I couldn't figure out how to get the working
    copy root path in cmd_info.
    
    18 subtests will fail because of the RFH item.

 git-svn.perl            | 38 +++++++++++++++++++++++++++++++++-----
 t/t9119-git-svn-info.sh |  2 +-
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 36f7240..00c9cc1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1580,6 +1580,7 @@ sub cmd_info {
 	}
 
 	# canonicalize_path() will return "" to make libsvn 1.5.x happy,
+	my $rpath = $path;
 	$path = "." if $path eq "";
 
 	my $full_url = canonicalize_url( add_path_to_url( $url, $path ) );
@@ -1591,7 +1592,9 @@ sub cmd_info {
 
 	my $result = "Path: $path_arg\n";
 	$result .= "Name: " . basename($path) . "\n" if $file_type ne "dir";
+	$result .= "Working Copy Root Path: " . $gs->path . "\n" if ::compare_svn_version('1.7.0') >= 0; #TODO
 	$result .= "URL: $full_url\n";
+	$result .= "Relative URL: ^/" . $rpath . "\n" if ::compare_svn_version('1.8.0')>=0;
 
 	eval {
 		my $repos_root = $gs->repos_root;
@@ -1603,8 +1606,10 @@ sub cmd_info {
 	}
 	::_req_svn();
 	$result .= "Repository UUID: $uuid\n" unless $diff_status eq "A" &&
+		::compare_svn_version('1.8.0') < 0 &&
 		(::compare_svn_version('1.5.4') <= 0 || $file_type ne "dir");
-	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n";
+	$result .= "Revision: " . ($diff_status eq "A" ? 0 : $rev) . "\n" unless
+		$diff_status eq "A" && ::compare_svn_version('1.8.0') >= 0;
 
 	$result .= "Node Kind: " .
 		   ($file_type eq "dir" ? "directory" : "file") . "\n";
@@ -1653,19 +1658,19 @@ sub cmd_info {
 			    command_output_pipe(qw(cat-file blob), "HEAD:$path");
 			if ($file_type eq "link") {
 				my $file_name = <$fh>;
-				$checksum = md5sum("link $file_name");
+				$checksum = md5sha1sum("link $file_name");
 			} else {
-				$checksum = md5sum($fh);
+				$checksum = md5sha1sum($fh);
 			}
 			command_close_pipe($fh, $ctx);
 		} elsif ($file_type eq "link") {
 			my $file_name =
 			    command(qw(cat-file blob), "HEAD:$path");
 			$checksum =
-			    md5sum("link " . $file_name);
+			    md5sha1sum("link " . $file_name);
 		} else {
 			open FILE, "<", $path or die $!;
-			$checksum = md5sum(\*FILE);
+			$checksum = md5sha1sum(\*FILE);
 			close FILE or die $!;
 		}
 		$result .= "Checksum: " . $checksum . "\n";
@@ -2135,6 +2140,29 @@ sub md5sum {
 	return $md5->hexdigest();
 }
 
+sub md5sha1sum {
+	my $arg = shift;
+	my $ref = ref $arg;
+	my $md5;
+	if (::compare_svn_version('1.7.0') < 0)	{
+		require Digest::MD5;
+		$md5 = Digest::MD5->new();
+	} else {
+		require Digest::SHA1;
+		$md5 = Digest::SHA1->new();
+	}
+        if ($ref eq 'GLOB' || $ref eq 'IO::File' || $ref eq 'File::Temp') {
+		$md5->addfile($arg) or croak $!;
+	} elsif ($ref eq 'SCALAR') {
+		$md5->add($$arg) or croak $!;
+	} elsif (!$ref) {
+		$md5->add($arg) or croak $!;
+	} else {
+		fatal "Can't provide MD5 hash for unknown ref type: '", $ref, "'";
+	}
+	return $md5->hexdigest();
+}
+
 sub gc_directory {
 	if (can_compress() && -f $_ && basename($_) eq "unhandled.log") {
 		my $out_filename = $_ . ".gz";
diff --git a/t/t9119-git-svn-info.sh b/t/t9119-git-svn-info.sh
index f16f323..b7476c7 100755
--- a/t/t9119-git-svn-info.sh
+++ b/t/t9119-git-svn-info.sh
@@ -10,7 +10,7 @@ test_description='git svn info'
 # Tested with: svn, version 1.6.[12345689]
 v=`svn_cmd --version | sed -n -e 's/^svn, version \(1\.[0-9]*\.[0-9]*\).*$/\1/p'`
 case $v in
-1.[456].*)
+1.[45678].*)
 	;;
 *)
 	skip_all="skipping svn-info test (SVN version: $v not supported)"
-- 
2.3.4.518.g406241f
