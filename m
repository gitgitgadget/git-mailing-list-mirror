From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: [PATCH 2/7] gitweb: Support comparing blobs with different names
Date: Mon, 16 Apr 2007 22:18:13 +0200
Message-ID: <20070416201813.GA2592@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at> <a209e0308fc80ef0623baef8dca49e61b7bafaab.1176659094.git.mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdXeX-0003Np-4A
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 22:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030949AbXDPUSR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 16:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030950AbXDPUSR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 16:18:17 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:35732 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030949AbXDPUSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 16:18:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 991A4683E788;
	Mon, 16 Apr 2007 22:18:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RefPgO5vUmxw; Mon, 16 Apr 2007 22:18:14 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 065E9683E780; Mon, 16 Apr 2007 22:18:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a209e0308fc80ef0623baef8dca49e61b7bafaab.1176659094.git.mkoegler@auto.tuwien.ac.at>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44692>

Currently, blobdiff can only compare blobs with different file
names, if no hb/hpb parameters are present.

This patch adds support for comparing two blobs specified by any
combination of hb/f/h and hpb/fp/hp.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
New version, as I found a bug in the expiration handling code.

I unified all blobdiff variants and added support for comparing blobs
with different names.

If h/hp parameter are missing, I need to generate them with
git_get_hash_by_path, as the are needed for the html header, which is
generated before parsing the git-diff output.

I currently ignore all mode changed, as they are part of the tree. I
don't think that displaying a mode change message justifes two call to
git-ls-tree for each blob diff (Currently it only calls git-ls-tree
for each missing h/hp parameter).

 gitweb/gitweb.perl |  136 ++++++++++++++++------------------------------------
 1 files changed, 41 insertions(+), 95 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cbd8d03..790041c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3902,109 +3902,54 @@ sub git_blobdiff {
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
+	my $expires = '+1d';
 
-		if (@difftree > 1) {
-			die_error('404 Not Found', "Ambiguous blob diff specification");
-		}
-
-		%diffinfo = parse_difftree_raw_line($difftree[0]);
-		$file_parent ||= $diffinfo{'from_file'} || $file_name || $diffinfo{'file'};
-		$file_name   ||= $diffinfo{'to_file'}   || $diffinfo{'file'};
-
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
 
-		# open patch output
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', ($format eq 'html' ? "--full-index" : ()),
-			$hash_parent_base, $hash_base,
-			"--", (defined $file_parent ? $file_parent : ()), $file_name
-			or die_error(undef, "Open git-diff-tree failed");
+	# if hash parameter is missing, read it from the commit.
+	if (defined $hash_base && defined $file_name && !defined $hash) {
+		$hash = git_get_hash_by_path($hash_base, $file_name);
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
+	if (defined $hash_parent_base && defined $file_parent && !defined $hash_parent) {
+	    $hash_parent = git_get_hash_by_path($hash_parent_base, $file_parent);
+	}
+	
+	if (!defined $hash || ! defined $hash_parent) {
+		die_error('404 Not Found', "Missing one of the blob diff parameters");
+	}
 
-		# non-textual hash id's can be cached
-		if ($hash =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
 
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
+	open $fd, "-|", git_cmd(), "diff", @diff_opts,
+	$hash_parent, $hash, "--"
+		or die_error(undef, "Open git-diff failed");
+
 	# header
 	if ($format eq 'html') {
 		my $formats_nav =
@@ -4028,11 +3973,12 @@ sub git_blobdiff {
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
1.5.1.1.85.gf1888
