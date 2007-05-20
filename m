From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/5] gitweb: Support comparing blobs with different names
Date: Sun, 20 May 2007 22:23:28 +0200
Message-ID: <11796926121641-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun May 20 22:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HprwQ-0003nX-3V
	for gcvg-git@gmane.org; Sun, 20 May 2007 22:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163AbXETUXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 16:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756032AbXETUXi
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 16:23:38 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59497 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123AbXETUXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 16:23:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id EE3187AF1C84;
	Sun, 20 May 2007 22:23:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFCHSyLtG+fX; Sun, 20 May 2007 22:23:32 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5A4C97AF1C61; Sun, 20 May 2007 22:23:32 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47902>

Currently, blobdiff can only compare blobs with different file
names, if no hb/hpb parameters are present.

This patch adds support for comparing two blobs specified by any
combination of hb/f/h and hpb/fp/hp.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 gitweb/gitweb.perl |  148 +++++++++++++++++++---------------------------------
 1 files changed, 53 insertions(+), 95 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5c7011a..63ed14f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4238,109 +4238,66 @@ sub git_blobdiff {
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
+	my $expires = '+1d';
+	my ($from, $to);
 
-		} else {
-			die_error('404 Not Found', "Missing one of the blob diff parameters");
-		}
-
-		if (@difftree > 1) {
-			die_error('404 Not Found', "Ambiguous blob diff specification");
-		}
+	$file_parent ||= $file_name;
 
-		%diffinfo = parse_difftree_raw_line($difftree[0]);
-		$file_parent ||= $diffinfo{'from_file'} || $file_name || $diffinfo{'file'};
-		$file_name   ||= $diffinfo{'to_file'}   || $diffinfo{'file'};
-
-		$hash_parent ||= $diffinfo{'from_id'};
-		$hash        ||= $diffinfo{'to_id'};
-
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
+	if (defined $hash_base && defined $file_name) {
+		$to = $hash_base . ':' . $file_name;
+	} else {
+		$to = $hash;
+	}
 
-		# non-textual hash id's can be cached
-		if ($hash =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
+	if (defined $hash_parent_base && defined $file_parent) {
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
+	open $fd, "-|", git_cmd(), "diff", @diff_opts, '-p', "--full-index",
+	($format eq 'html' ? "--raw" : ()), $from, $to, "--"
+		or die_error(undef, "Open git-diff failed");
+
 	# header
 	if ($format eq 'html') {
 		my $formats_nav =
@@ -4364,11 +4321,12 @@ sub git_blobdiff {
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
1.5.2.rc3.802.g4b4b7
