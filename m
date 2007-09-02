From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix and simplify "split patch" detection
Date: Sun, 2 Sep 2007 22:18:42 +0200
Message-ID: <200709022218.43042.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 01:59:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzLD-0000H8-Fu
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:58:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753323AbXIBX6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 19:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbXIBX6Y
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:58:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:42766 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752593AbXIBX6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 19:58:23 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1222022fkz
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 16:58:22 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=d+iJhuew28F27rFjXF/noAE85JJr8+zwcvs6+DiwZ1hObNeCYCZmZsUdIR2TnlBTSVCkyr8LbKBiw5c2Rl/BpbrC8hHH/w8bnY6g8rUKv0otqJt+vq8CKyUe6bl3R45nwGrNadzDDjwakK55iuO0OJhs17yYMl3Bg7YtwURCg8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dXjzqc91XJzfqD6LDZU8UVyd77c3ynY+xptQfHegrNBNLXTm4Wvidix8nIODEO1uR3fgroOE1Nx2rKDnwIYIGe8c3IQdkVLfio3BVhnMCoxH/psjg7j8YgpTCbPAKb2fik7KzWlbbnUCMMFKHDWXYKXFBh6XlYdk6zNHVp7o+d4=
Received: by 10.86.49.13 with SMTP id w13mr2934990fgw.1188777501725;
        Sun, 02 Sep 2007 16:58:21 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id o11sm4707846fkf.2007.09.02.16.58.17
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Sep 2007 16:58:19 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57406>

There are some cases when one line from "raw" git-diff output (raw format)
corresponds to more than one patch in the patchset git-diff output; we
call this situation "split patch". Current code misdetected subsequent
patches (for different files) with the same pre-image and post-image
as fragments of "split patch", leading to mislabeled from-file/to-file
diff header etc.


We could parse from_file and to_file (if to_file exists) from the "git
diff header" in the patch, i.e. from the "^diff" line in patchset, and
consider patch "split" or "continued" if not only pre-image and
post-image (from_id and to_id) matches, but only when also from_file
and to_file (if it exists) matches.  This has the advantage of being
generic, not depending on details of git diff output formatting, and
how patch output relates to raw diff output, but it adds yet another
complication.

Note: both from_name and to_name can be quoted and contain spaces;
their separation is nontrivial.


Alternate solution, which we did chose, is to check when git splits
patches, and do not check if parsed info from current patch corresponds
to current or next raw diff format output line.  Git splits patches
only for 'T' (typechange) status filepair, and there always two patches
corresponding to one raw diff line.

And we can get rid of buffering extended diff header and parsing it,
This simplifies git_patchset_body, making it easier to understand and
maintain.  At the other hand it fixes gitweb to git diff output details.


While at it we added 'status_str' to diffinfo output, which stores
status (also for merge commit) as a string.  This allows for easy
checking if there is given status among all for merge commit, e.g.
  $diffinfo->{'status_str'} =~ /T/

There are no users of from_ids_eq subroutine.

Noticed-by: Yann Dirson <ydirson@altern.org>
Diagnosed-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is post 1.5.3 resend of the patch
  Message-Id: <200708290208.08191.jnareb@gmail.com>
posted in the "[BUG] gitweb on repo.or.cz shows buggy commitdiff"
thread.

I'm a tiny little bit ambivalent about this patch: on one hand it
fixes the bug and simplifies git_patchset_body code making it easier
to maintain, on the other hand it ties patch handling code in gitweb
with the details of git-diff patch vs. raw output format.

 gitweb/gitweb.perl |   63 +++++++++++++++++++--------------------------------
 1 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b2bae1b..8c1e02c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1963,7 +1963,7 @@ sub parse_difftree_raw_line {
 		$res{'to_mode'} = $2;
 		$res{'from_id'} = $3;
 		$res{'to_id'} = $4;
-		$res{'status'} = $5;
+		$res{'status'} = $res{'status_str'} = $5;
 		$res{'similarity'} = $6;
 		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
 			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
@@ -1979,6 +1979,7 @@ sub parse_difftree_raw_line {
 		$res{'to_mode'} = pop @{$res{'from_mode'}};
 		$res{'from_id'} = [ split(' ', $3) ];
 		$res{'to_id'} = pop @{$res{'from_id'}};
+		$res{'status_str'} = $4;
 		$res{'status'} = [ split('', $4) ];
 		$res{'to_file'} = unquote($5);
 	}
@@ -3112,6 +3113,7 @@ sub git_patchset_body {
 	my $patch_line;
 	my $diffinfo;
 	my (%from, %to);
+	my $patches_per_difftree_line = 1;
 
 	print "<div class=\"patchset\">\n";
 
@@ -3124,42 +3126,13 @@ sub git_patchset_body {
 
  PATCH:
 	while ($patch_line) {
-		my @diff_header;
-		my ($from_id, $to_id);
-
-		# git diff header
-		#assert($patch_line =~ m/^diff /) if DEBUG;
-		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
-		$patch_number++;
-		push @diff_header, $patch_line;
-
-		# extended diff header
-	EXTENDED_HEADER:
-		while ($patch_line = <$fd>) {
-			chomp $patch_line;
-
-			last EXTENDED_HEADER if ($patch_line =~ m/^--- |^diff /);
-
-			if ($patch_line =~ m/^index ([0-9a-fA-F]{40})..([0-9a-fA-F]{40})/) {
-				$from_id = $1;
-				$to_id   = $2;
-			} elsif ($patch_line =~ m/^index ((?:[0-9a-fA-F]{40},)+[0-9a-fA-F]{40})..([0-9a-fA-F]{40})/) {
-				$from_id = [ split(',', $1) ];
-				$to_id   = $2;
-			}
-
-			push @diff_header, $patch_line;
-		}
-		my $last_patch_line = $patch_line;
 
 		# check if current patch belong to current raw line
 		# and parse raw git-diff line if needed
-		if (defined $diffinfo &&
-		    defined $from_id && defined $to_id &&
-		    from_ids_eq($diffinfo->{'from_id'}, $from_id) &&
-		    $diffinfo->{'to_id'} eq $to_id) {
+		if ($patches_per_difftree_line > 1) {
 			# this is continuation of a split patch
 			print "<div class=\"patch cont\">\n";
+			$patches_per_difftree_line--;
 		} else {
 			# advance raw git-diff output if needed
 			$patch_idx++ if defined $diffinfo;
@@ -3167,7 +3140,7 @@ sub git_patchset_body {
 			# compact combined diff output can have some patches skipped
 			# find which patch (using pathname of result) we are at now
 			my $to_name;
-			if ($diff_header[0] =~ m!^diff --cc "?(.*)"?$!) {
+			if ($patch_line =~ m!^diff --cc "?(.*)"?$!) {
 				$to_name = $1;
 			}
 
@@ -3191,6 +3164,7 @@ sub git_patchset_body {
 				}
 			} until (!defined $to_name || $to_name eq $diffinfo->{'to_file'} ||
 			         $patch_idx > $#$difftree);
+
 			# modifies %from, %to hashes
 			parse_from_to_diffinfo($diffinfo, \%from, \%to, @hash_parents);
 			if ($diffinfo->{'nparents'}) {
@@ -3232,32 +3206,43 @@ sub git_patchset_body {
 			# this is first patch for raw difftree line with $patch_idx index
 			# we index @$difftree array from 0, but number patches from 1
 			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
+
+			# typechange diff with 'T' status has two patches per one raw line
+			if ($diffinfo->{'status_str'} =~ /T/) {
+				$patches_per_difftree_line = 2;
+			}
 		}
 
+		# git diff header
+		#assert($patch_line =~ m/^diff /) if DEBUG;
+		#assert($patch_line !~ m!$/$!) if DEBUG; # is chomp-ed
+		$patch_number++;
 		# print "git diff" header
-		$patch_line = shift @diff_header;
 		print format_git_diff_header_line($patch_line, $diffinfo,
 		                                  \%from, \%to);
 
 		# print extended diff header
-		print "<div class=\"diff extended_header\">\n" if (@diff_header > 0);
+		print "<div class=\"diff extended_header\">\n";
 	EXTENDED_HEADER:
-		foreach $patch_line (@diff_header) {
+		while ($patch_line = <$fd>) {
+			chomp $patch_line;
+
+			last EXTENDED_HEADER if ($patch_line =~ m/^--- |^diff /);
+
 			print format_extended_diff_header_line($patch_line, $diffinfo,
 			                                       \%from, \%to);
 		}
-		print "</div>\n"  if (@diff_header > 0); # class="diff extended_header"
+		print "</div>\n"; # class="diff extended_header"
 
 		# from-file/to-file diff header
-		$patch_line = $last_patch_line;
 		if (! $patch_line) {
 			print "</div>\n"; # class="patch"
 			last PATCH;
 		}
 		next PATCH if ($patch_line =~ m/^diff /);
 		#assert($patch_line =~ m/^---/) if DEBUG;
-		#assert($patch_line eq $last_patch_line) if DEBUG;
 
+		my $last_patch_line = $patch_line;
 		$patch_line = <$fd>;
 		chomp $patch_line;
 		#assert($patch_line =~ m/^\+\+\+/) if DEBUG;
-- 
1.5.2.5
