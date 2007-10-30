From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (resend)] gitweb: Fix and simplify "split patch" detection
Date: Tue, 30 Oct 2007 01:35:05 +0100
Message-ID: <11937045052921-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 01:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imf2N-00044v-JQ
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 01:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbXJ3Acm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbXJ3Acm
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 20:32:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:42765 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbXJ3Ack (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 20:32:40 -0400
Received: by ug-out-1314.google.com with SMTP id z38so34886ugc
        for <git@vger.kernel.org>; Mon, 29 Oct 2007 17:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=DkDCeYlhbVqaU7h7MhDYv+Yd/eHG8ZpAFOxI0shDXcU=;
        b=Y692NKP6Grv4H6j+58wfgPFEpR7kfaC6IOtP1LT6sKjAWHqpeMj04d/gdxz2SJizGT2C3aMyrh8859b49WJolIVm36wVffJwHdiC1tVapj+2hwH5+Km2bqADFEJSp5JOfNXD/WQYisIKpRxFlb4eOHiS9Utg7qIk30NX+hTWbuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=WkBhAStoF72SWG8NRAiYP4NTfwMyAI9IfUj/MreD3jwR8gcCW2AVBiM2QRFgVDZqoCpqyXbketG8ZCXXMMVqs6O/+ssquv6O+xHO9PS4RcHEyvORk/vWRsPOUuQAEUH9WoUDIycxZOphhDmyxKuL3qXAnQe4gIz22U72+H9f+NE=
Received: by 10.66.221.5 with SMTP id t5mr156336ugg.1193704359086;
        Mon, 29 Oct 2007 17:32:39 -0700 (PDT)
Received: from roke.D-201 ( [83.8.221.220])
        by mx.google.com with ESMTPS id r38sm129605ugc.2007.10.29.17.32.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Oct 2007 17:32:36 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l9U0Z7kp011553;
	Tue, 30 Oct 2007 01:35:07 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l9U0Z6H8011552;
	Tue, 30 Oct 2007 01:35:06 +0100
X-Mailer: git-send-email 1.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62635>

There are some cases when one line from "raw" git-diff output (raw
format) corresponds to more than one patch in the patchset git-diff
output; we call this situation "split patch". Old code misdetected
subsequent patches (for different files) with the same pre-image and
post-image as fragments of "split patch", leading to mislabeled
from-file/to-file diff header etc.

Old code used pre-image and post-image SHA-1 identifier ('from_id' and
'to_id') to check if current patch corresponds to old raw diff format
line, to find if one difftree raw line coresponds to more than one
patch in the patch format.  Now we use post-image filename for that.
This assumes that post-image filename alone can be used to identify
difftree raw line.  In the case this changes (which is unlikely
considering current diff engine) we can add 'from_id' and 'to_id'
to detect "patch splitting" together with 'to_file'.

Because old code got pre-image and post-image SHA-1 identifier for the
patch from the "index" line in extended diff header, diff header had
to be buffered.  New code takes post-image filename from "git diff"
header, which is first line of a patch; this allows to simplify
git_patchset_body code.  A side effect of resigning diff header
buffering is that there is always "diff extended_header" div, even
if extended diff header is empty.


Alternate solution would be to check when git splits patches, and do
not check if parsed info from current patch corresponds to current or
next raw diff format output line.  Git splits patches only for 'T'
(typechange) status filepair, and there always two patches
corresponding to one raw diff line.  It was not used because it would
tie gitweb code to minute details of git diff output.


While at it, use newly introduced parsed_difftree_line wrapper
subroutine in git_difftree_body.

Noticed-by: Yann Dirson <ydirson@altern.org>
Diagnosed-by: Petr Baudis <pasky@suse.cz>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Junio has decided in
  Message-ID: <7vmyw4ob7z.fsf@gitster.siamese.dyndns.org>
that tying gitweb to minute details of git diff output, namely that
we have "split patch" (two patches of patchset diff format for single
line of raw ditt format) only for typechange (status 'T') diffs.

We make other assumption instead, that post-image filename uniquely
defines line of raw git diff output. Currently diffcore is not
capable of producing other output; see Junio in
  Message-ID: <7vtzqcj9ni.fsf@gitster.siamese.dyndns.org>
This assumption simplifies git_patchset_body, as we no longer need
to cache extended diff header for "split patch" detection.

 gitweb/gitweb.perl |  152 +++++++++++++++++++++++-----------------------------
 1 files changed, 67 insertions(+), 85 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 48e21da..1537b0e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2000,6 +2000,19 @@ sub parse_difftree_raw_line {
 	return wantarray ? %res : \%res;
 }
 
+# wrapper: return parsed line of git-diff-tree "raw" output
+# (the argument might be raw line, or parsed info)
+sub parsed_difftree_line {
+	my $line_or_ref = shift;
+
+	if (ref($line_or_ref) eq "HASH") {
+		# pre-parsed (or generated by hand)
+		return $line_or_ref;
+	} else {
+		return parse_difftree_raw_line($line_or_ref);
+	}
+}
+
 # parse line of git-ls-tree output
 sub parse_ls_tree_line ($;%) {
 	my $line = shift;
@@ -2043,6 +2056,7 @@ sub parse_from_to_diffinfo {
 			}
 		}
 	} else {
+		# ordinary (not combined) diff
 		$from->{'file'} = $diffinfo->{'from_file'} || $diffinfo->{'file'};
 		if ($diffinfo->{'status'} ne "A") { # not new (added) file
 			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
@@ -2766,6 +2780,7 @@ sub git_print_tree_entry {
 ## ......................................................................
 ## functions printing large fragments of HTML
 
+# get pre-image filenames for merge (combined) diff
 sub fill_from_file_info {
 	my ($diff, @parents) = @_;
 
@@ -2782,28 +2797,25 @@ sub fill_from_file_info {
 	return $diff;
 }
 
-# parameters can be strings, or references to arrays of strings
-sub from_ids_eq {
-	my ($a, $b) = @_;
-
-	if (ref($a) eq "ARRAY" && ref($b) eq "ARRAY" && @$a == @$b) {
-		for (my $i = 0; $i < @$a; ++$i) {
-			return 0 unless ($a->[$i] eq $b->[$i]);
-		}
-		return 1;
-	} elsif (!ref($a) && !ref($b)) {
-		return $a eq $b;
-	} else {
-		return 0;
-	}
-}
-
+# is current raw difftree line of file deletion
 sub is_deleted {
 	my $diffinfo = shift;
 
 	return $diffinfo->{'to_id'} eq ('0' x 40);
 }
 
+# does patch correspond to [previous] difftree raw line
+# $diffinfo  - hashref of parsed raw diff format
+# $patchinfo - hashref of parsed patch diff format
+#              (the same keys as in $diffinfo)
+sub is_patch_split {
+	my ($diffinfo, $patchinfo) = @_;
+
+	return defined $diffinfo && defined $patchinfo
+		&& ($diffinfo->{'to_file'} || $diffinfo->{'file'}) eq $patchinfo->{'to_file'};
+}
+
+
 sub git_difftree_body {
 	my ($difftree, $hash, @parents) = @_;
 	my ($parent) = $parents[0];
@@ -2840,13 +2852,7 @@ sub git_difftree_body {
 	my $alternate = 1;
 	my $patchno = 0;
 	foreach my $line (@{$difftree}) {
-		my $diff;
-		if (ref($line) eq "HASH") {
-			# pre-parsed (or generated by hand)
-			$diff = $line;
-		} else {
-			$diff = parse_difftree_raw_line($line);
-		}
+		my $diff = parsed_difftree_line($line);
 
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
@@ -3117,10 +3123,12 @@ sub git_patchset_body {
 	my ($fd, $difftree, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];
 
+	my $is_combined = (@hash_parents > 1);
 	my $patch_idx = 0;
 	my $patch_number = 0;
 	my $patch_line;
 	my $diffinfo;
+	my $to_name;
 	my (%from, %to);
 
 	print "<div class=\"patchset\">\n";
@@ -3134,73 +3142,46 @@ sub git_patchset_body {
 
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
+		# parse "git diff" header line
+		if ($patch_line =~ m/^diff --git (\"(?:[^\\\"]*(?:\\.[^\\\"]*)*)\"|[^ "]*) (.*)$/) {
+			# $1 is from_name, which we do not use
+			$to_name = unquote($2);
+			$to_name =~ s!^b/!!;
+		} elsif ($patch_line =~ m/^diff --(cc|combined) ("?.*"?)$/) {
+			# $1 is 'cc' or 'combined', which we do not use
+			$to_name = unquote($2);
+		} else {
+			$to_name = undef;
 		}
-		my $last_patch_line = $patch_line;
 
 		# check if current patch belong to current raw line
 		# and parse raw git-diff line if needed
-		if (defined $diffinfo &&
-		    defined $from_id && defined $to_id &&
-		    from_ids_eq($diffinfo->{'from_id'}, $from_id) &&
-		    $diffinfo->{'to_id'} eq $to_id) {
+		if (is_patch_split($diffinfo, { 'to_file' => $to_name })) {
 			# this is continuation of a split patch
 			print "<div class=\"patch cont\">\n";
 		} else {
 			# advance raw git-diff output if needed
 			$patch_idx++ if defined $diffinfo;
 
-			# compact combined diff output can have some patches skipped
-			# find which patch (using pathname of result) we are at now
-			my $to_name;
-			if ($diff_header[0] =~ m!^diff --cc "?(.*)"?$!) {
-				$to_name = $1;
-			}
-
-			do {
-				# read and prepare patch information
-				if (ref($difftree->[$patch_idx]) eq "HASH") {
-					# pre-parsed (or generated by hand)
-					$diffinfo = $difftree->[$patch_idx];
-				} else {
-					$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
-				}
+			# read and prepare patch information
+			$diffinfo = parsed_difftree_line($difftree->[$patch_idx]);
 
-				# check if current raw line has no patch (it got simplified)
-				if (defined $to_name && $to_name ne $diffinfo->{'to_file'}) {
+			# compact combined diff output can have some patches skipped
+			# find which patch (using pathname of result) we are at now;
+			if ($is_combined) {
+				while ($to_name ne $diffinfo->{'to_file'}) {
 					print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
 					      format_diff_cc_simplified($diffinfo, @hash_parents) .
 					      "</div>\n";  # class="patch"
 
 					$patch_idx++;
 					$patch_number++;
+
+					last if $patch_idx > $#$difftree;
+					$diffinfo = parsed_difftree_line($difftree->[$patch_idx]);
 				}
-			} until (!defined $to_name || $to_name eq $diffinfo->{'to_file'} ||
-			         $patch_idx > $#$difftree);
+			}
 
 			# modifies %from, %to hashes
 			parse_from_to_diffinfo($diffinfo, \%from, \%to, @hash_parents);
@@ -3210,30 +3191,36 @@ sub git_patchset_body {
 			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
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
@@ -3258,16 +3245,11 @@ sub git_patchset_body {
 
 	# for compact combined (--cc) format, with chunk and patch simpliciaction
 	# patchset might be empty, but there might be unprocessed raw lines
-	for ($patch_idx++ if $patch_number > 0;
+	for (++$patch_idx if $patch_number > 0;
 	     $patch_idx < @$difftree;
-	     $patch_idx++) {
+	     ++$patch_idx) {
 		# read and prepare patch information
-		if (ref($difftree->[$patch_idx]) eq "HASH") {
-			# pre-parsed (or generated by hand)
-			$diffinfo = $difftree->[$patch_idx];
-		} else {
-			$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
-		}
+		$diffinfo = parsed_difftree_line($difftree->[$patch_idx]);
 
 		# generate anchor for "patch" links in difftree / whatchanged part
 		print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
-- 
1.5.3
