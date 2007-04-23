From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] gitweb: Support comparing blobs with different names
Date: Mon, 23 Apr 2007 22:55:47 +0200
Message-ID: <11773617471526-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 22:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg5Zm-0001xp-M4
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 22:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbXDWUzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 16:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbXDWUzu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 16:55:50 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:55525 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbXDWUzt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 16:55:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 8F94E6836E82;
	Mon, 23 Apr 2007 22:55:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lALmRVSqQlFC; Mon, 23 Apr 2007 22:55:47 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id E520A6836E80; Mon, 23 Apr 2007 22:55:47 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45361>

Currently, blobdiff can only compare blobs with different file
names, if no hb/hpb parameters are present.

This patch adds support for comparing two blobs specified by any
combination of hb/f/h and hpb/fp/hp.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
Updated gitweb blobdiff patch to take advantage of my git-diff patch series.

 gitweb/gitweb.perl |  148 +++++++++++++++++++---------------------------------
 1 files changed, 53 insertions(+), 95 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cbd8d03..4b42f62 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3902,109 +3902,66 @@ sub git_blobdiff {
 	my $fd;
 	my @difftree;
 	my %diffinfo;
-	my $expires;
-
-	# preparing $fd and %diffinfo for git_patchset_body
-	# new style URI
-	if (defined $hash_base && defined $hash_parent_base) {
-		if (defined $file_name) {
-			# read raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-				$hash_parent_base, $hash_base,
-				"--", (defined $file_parent ? $file_parent : ()), $file_name
-				or die_error(undef, "Open git-diff-tree failed");
-			@difftree = map { chomp; $_ } <$fd>;
-			close $fd
-				or die_error(undef, "Reading git-diff-tree failed");
-			@difftree
-				or die_error('404 Not Found', "Blob diff not found");
-
-		} elsif (defined $hash &&
-		         $hash =~ /[0-9a-fA-F]{40}/) {
-			# try to find filename from $hash
-
-			# read filtered raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-				$hash_parent_base, $hash_base, "--"
-				or die_error(undef, "Open git-diff-tree failed");
-			@difftree =
-				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
-				# $hash == to_id
-				grep { /^:[0-7]{6} [0-7]{6} [0-9a-fA-F]{40} $hash/ }
-				map { chomp; $_ } <$fd>;
-			close $fd
-				or die_error(undef, "Reading git-diff-tree failed");
-			@difftree
-				or die_error('404 Not Found', "Blob diff not found");
-
-		} else {
-			die_error('404 Not Found', "Missing one of the blob diff parameters");
-		}
-
-		if (@difftree > 1) {
-			die_error('404 Not Found', "Ambiguous blob diff specification");
-		}
-
-		%diffinfo = parse_difftree_raw_line($difftree[0]);
-		$file_parent ||= $diffinfo{'from_file'} || $file_name || $diffinfo{'file'};
-		$file_name   ||= $diffinfo{'to_file'}   || $diffinfo{'file'};
+	my $expires = '+1d';
+	my $from, $to;
 
-		$hash_parent ||= $diffinfo{'from_id'};
-		$hash        ||= $diffinfo{'to_id'};
+	$file_parent ||= $file_name;
 
-		# non-textual hash id's can be cached
-		if ($hash_base =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent_base =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
+	# non-textual hash id's can be cached
+	if (defined $hash && $hash !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	} elsif (defined $hash_parent && $hash_parent !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	} elsif (defined $hash_base && $hash_base !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	} elsif (defined $hash_parent_base && $hash_parent_base !~ m/^[0-9a-fA-F]{40}$/) {
+		$expires = undef;
+	}
+
+	# if hash parameter is missing, read it from the commit.
+	if (defined $hash_base && defined $file_name && !defined $hash) {
+		$hash = git_get_hash_by_path($hash_base, $file_name);
+	}
 
-		# open patch output
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', ($format eq 'html' ? "--full-index" : ()),
-			$hash_parent_base, $hash_base,
-			"--", (defined $file_parent ? $file_parent : ()), $file_name
-			or die_error(undef, "Open git-diff-tree failed");
+	if (defined $hash_parent_base && defined $file_parent && !defined $hash_parent) {
+	    $hash_parent = git_get_hash_by_path($hash_parent_base, $file_parent);
+	}
+	
+	if (!defined $hash || ! defined $hash_parent) {
+		die_error('404 Not Found', "Missing one of the blob diff parameters");
 	}
 
-	# old/legacy style URI
-	if (!%diffinfo && # if new style URI failed
-	    defined $hash && defined $hash_parent) {
-		# fake git-diff-tree raw output
-		$diffinfo{'from_mode'} = $diffinfo{'to_mode'} = "blob";
-		$diffinfo{'from_id'} = $hash_parent;
-		$diffinfo{'to_id'}   = $hash;
-		if (defined $file_name) {
-			if (defined $file_parent) {
-				$diffinfo{'status'} = '2';
-				$diffinfo{'from_file'} = $file_parent;
-				$diffinfo{'to_file'}   = $file_name;
-			} else { # assume not renamed
-				$diffinfo{'status'} = '1';
-				$diffinfo{'from_file'} = $file_name;
-				$diffinfo{'to_file'}   = $file_name;
-			}
-		} else { # no filename given
-			$diffinfo{'status'} = '2';
-			$diffinfo{'from_file'} = $hash_parent;
-			$diffinfo{'to_file'}   = $hash;
-		}
+	if (defined $hase_base && defined $file_name) {
+		$to = $hash_base . ':' . $file_name;
+	} else {
+		$to = $hash;
+	}
 
-		# non-textual hash id's can be cached
-		if ($hash =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
+	if (defined $hase_parent_base && defined $file_parent) {
+		$from = $hash_parent_base . ':' . $file_parent;
+	} else {
+		$from = $hash_parent;
+	}
 
-		# open patch output
-		open $fd, "-|", git_cmd(), "diff", @diff_opts,
-			'-p', ($format eq 'html' ? "--full-index" : ()),
-			$hash_parent, $hash, "--"
-			or die_error(undef, "Open git-diff failed");
-	} else  {
-		die_error('404 Not Found', "Missing one of the blob diff parameters")
-			unless %diffinfo;
+	# fake git-diff-tree raw output
+	$diffinfo{'from_mode'} = $diffinfo{'to_mode'} = "blob";
+	$diffinfo{'from_id'} = $hash_parent;
+	$diffinfo{'to_id'}   = $hash;
+	if (defined $file_name) {
+		$diffinfo{'status'} = '2';
+		$diffinfo{'from_file'} = $file_parent;
+		$diffinfo{'to_file'}   = $file_name;
+	} else { # no filename given
+		$diffinfo{'status'} = '2';
+		$diffinfo{'from_file'} = $hash_parent;
+		$diffinfo{'to_file'}   = $hash;
 	}
 
+	# open patch output
+	open $fd, "-|", git_cmd(), "diff", @diff_opts, '--raw', '-p', '--full-index',
+	$from, $to, "--"
+		or die_error(undef, "Open git-diff failed");
+
 	# header
 	if ($format eq 'html') {
 		my $formats_nav =
@@ -4028,11 +3985,12 @@ sub git_blobdiff {
 		}
 
 	} elsif ($format eq 'plain') {
+		my $patch_file_name = $file_name || $hash;
 		print $cgi->header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
 			-expires => $expires,
-			-content_disposition => 'inline; filename="' . "$file_name" . '.patch"');
+			-content_disposition => 'inline; filename="' . "$patch_file_name" . '.patch"');
 
 		print "X-Git-Url: " . $cgi->self_url() . "\n\n";
 
-- 
1.5.1.1.199.g1a18-dirty
