From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 6/6] gitweb: '--cc' for merges in 'commitdiff' view
Date: Fri, 08 Jun 2007 13:33:28 +0200
Message-ID: <20070608113249.3594.65410.stgit@roke.D-201>
References: <20070608112337.3594.93976.stgit@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 08 13:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwcdX-00035N-ON
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 13:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967977AbXFHL2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 07:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967847AbXFHL2I
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 07:28:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:58839 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967335AbXFHL2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 07:28:05 -0400
Received: by ug-out-1314.google.com with SMTP id j3so931107ugf
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 04:28:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=pbniE/WEqG0fDDS+wXo2i/smcH+H91rfUSgGJtyX70dp7QyS6QJplTjSfB/+uqPgXAenU+EJ/29VahBiy4XqD2SZsy/f/AUyfXLYJaWpEzRBY1IOKk6EUz21cs3y3nQA8q90YzAzEOwY4HhnP1gVwaP0BWsOptWUKw6pFXiDiyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:subject:to:cc:date:message-id:in-reply-to:references:user-agent:mime-version:content-type:content-transfer-encoding;
        b=PrpGuVEOwgxJausjIF6SvRjdMR/2KWJuEZuK49b8U3zbDjr37+P3tiGxMEIxVAxIdCdK4AYkuzbKBKr3Wkn1PjN8OyEGSNRSWkB9Y3msRxAc/cJACSTBoD7F7hW+ilcp02/9Bv3pSM8C/vH2gcjRhjFaIZXwOdwm4n6cGsimVrc=
Received: by 10.82.127.14 with SMTP id z14mr5161192buc.1181302083810;
        Fri, 08 Jun 2007 04:28:03 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id k5sm618222nfh.2007.06.08.04.28.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jun 2007 04:28:03 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l58BXSbj003707;
	Fri, 8 Jun 2007 13:33:28 +0200
In-Reply-To: <20070608112337.3594.93976.stgit@roke.D-201>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49469>

Allow choosing between '-c' (combined diff) and '--cc' (compact
combined) diff format in 'commitdiff' view for merge (multiparent)
commits.  Default is now '--cc'.

In the bottom part of navigation bar there is link allowing to change
diff format: "combined" for '-c' (when using '--cc') and "compact" for
'--cc' (when using '-c'), just on the right of "raw" link to
'commitdiff_plain" view. 

About patchset part of diff --cc output: the difftree (whatchanged
table) has "patch" links to anchors to individual patches (on the same
page). The --cc option further compresses the patch output by
omitting some hunks; when this optimization makes all hunks disappear,
the patch is not shown (like in any other "empty diff" case). But the
fact that patch has been simplified out is not reflected in the raw
(difftree) part of diff output; the raw part is the same for '-c' and
'--cc' options. As correcting difftree is rather out of the question,
as it would require scanning patchset part before writing out
difftree, we add "Simple merge" empty diffs as a place to have anchor
to in place of those simplified out and removed patches.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Linus wanted '--cc' for merges as it is more compact. Here it is.

 gitweb/gitweb.perl |  111 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 99 insertions(+), 12 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c7acfad..a6383dc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1122,6 +1122,31 @@ sub format_diff_from_to_header {
 	return $result;
 }
 
+# create note for patch simplified by combined diff
+sub format_diff_cc_simplified {
+	my ($diffinfo, @parents) = @_;
+	my $result = '';
+
+	$result .= "<div class=\"diff header\">" .
+	           "diff --cc ";
+	if (!is_deleted($diffinfo)) {
+		$result .= $cgi->a({-href => href(action=>"blob",
+		                                  hash_base=>$hash,
+		                                  hash=>$diffinfo->{'to_id'},
+		                                  file_name=>$diffinfo->{'to_file'}),
+		                    -class => "path"},
+		                   esc_path($diffinfo->{'to_file'}));
+	} else {
+		$result .= esc_path($diffinfo->{'to_file'});
+	}
+	$result .= "</div>\n" . # class="diff header"
+	           "<div class=\"diff nodifferences\">" .
+	           "Simple merge" .
+	           "</div>\n"; # class="diff nodifferences"
+
+	return $result;
+}
+
 # format patch (diff) line (not to be used for diff headers)
 sub format_diff_line {
 	my $line = shift;
@@ -2973,13 +2998,33 @@ sub git_patchset_body {
 			# advance raw git-diff output if needed
 			$patch_idx++ if defined $diffinfo;
 
-			# read and prepare patch information
-			if (ref($difftree->[$patch_idx]) eq "HASH") {
-				# pre-parsed (or generated by hand)
-				$diffinfo = $difftree->[$patch_idx];
-			} else {
-				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
+			# compact combined diff output can have some patches skipped
+			# find which patch (using pathname of result) we are at now
+			my $to_name;
+			if ($diff_header[0] =~ m!^diff --cc "?(.*)"?$!) {
+				$to_name = $1;
 			}
+
+			do {
+				# read and prepare patch information
+				if (ref($difftree->[$patch_idx]) eq "HASH") {
+					# pre-parsed (or generated by hand)
+					$diffinfo = $difftree->[$patch_idx];
+				} else {
+					$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
+				}
+
+				# check if current raw line has no patch (it got simplified)
+				if (defined $to_name && $to_name ne $diffinfo->{'to_file'}) {
+					print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
+					      format_diff_cc_simplified($diffinfo, @hash_parents) .
+					      "</div>\n";  # class="patch"
+
+					$patch_idx++;
+					$patch_number++;
+				}
+			} until (!defined $to_name || $to_name eq $diffinfo->{'to_file'} ||
+			         $patch_idx > $#$difftree);
 			# modifies %from, %to hashes
 			parse_from_to_diffinfo($diffinfo, \%from, \%to, @hash_parents);
 			if ($diffinfo->{'nparents'}) {
@@ -3069,6 +3114,27 @@ sub git_patchset_body {
 		print "</div>\n"; # class="patch"
 	}
 
+	# for compact combined (--cc) format, with chunk and patch simpliciaction
+	# patchset might be empty, but there might be unprocessed raw lines
+	for ($patch_idx++ if $patch_number > 0;
+	     $patch_idx < @$difftree;
+	     $patch_idx++) {
+		# read and prepare patch information
+		if (ref($difftree->[$patch_idx]) eq "HASH") {
+			# pre-parsed (or generated by hand)
+			$diffinfo = $difftree->[$patch_idx];
+		} else {
+			$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
+		}
+
+		# generate anchor for "patch" links in difftree / whatchanged part
+		print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n" .
+		      format_diff_cc_simplified($diffinfo, @hash_parents) .
+		      "</div>\n";  # class="patch"
+
+		$patch_number++;
+	}
+
 	if ($patch_number == 0) {
 		if (@hash_parents > 1) {
 			print "<div class=\"diff nodifferences\">Trivial merge</div>\n";
@@ -4582,7 +4648,11 @@ sub git_commitdiff {
 		die_error(undef, "Unknown commit object");
 	}
 
-	# we need to prepare $formats_nav before any parameter munging
+	# choose format for commitdiff for merge
+	if (! defined $hash_parent && @{$co{'parents'}} > 1) {
+		$hash_parent = '--cc';
+	}
+	# we need to prepare $formats_nav before almost any parameter munging
 	my $formats_nav;
 	if ($format eq 'html') {
 		$formats_nav =
@@ -4590,7 +4660,8 @@ sub git_commitdiff {
 			                       hash=>$hash, hash_parent=>$hash_parent)},
 			        "raw");
 
-		if (defined $hash_parent) {
+		if (defined $hash_parent &&
+		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
 			# commitdiff with two commits given
 			my $hash_parent_short = $hash_parent;
 			if ($hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
@@ -4622,6 +4693,17 @@ sub git_commitdiff {
 				')';
 		} else {
 			# merge commit
+			if ($hash_parent eq '--cc') {
+				$formats_nav .= ' | ' .
+					$cgi->a({-href => href(action=>"commitdiff",
+					                       hash=>$hash, hash_parent=>'-c')},
+					        'combined');
+			} else { # $hash_parent eq '-c'
+				$formats_nav .= ' | ' .
+					$cgi->a({-href => href(action=>"commitdiff",
+					                       hash=>$hash, hash_parent=>'--cc')},
+					        'compact');
+			}
 			$formats_nav .=
 				' (merge: ' .
 				join(' ', map {
@@ -4634,9 +4716,10 @@ sub git_commitdiff {
 	}
 
 	my $hash_parent_param = $hash_parent;
-	if (!defined $hash_parent) {
+	if (!defined $hash_parent_param) {
+		# --cc for multiple parents, --root for parentless
 		$hash_parent_param =
-			@{$co{'parents'}} > 1 ? '-c' : $co{'parent'} || '--root';
+			@{$co{'parents'}} > 1 ? '--cc' : $co{'parent'} || '--root';
 	}
 
 	# read commitdiff
@@ -4713,10 +4796,14 @@ TEXT
 
 	# write patch
 	if ($format eq 'html') {
-		git_difftree_body(\@difftree, $hash, $hash_parent || @{$co{'parents'}});
+		my $use_parents = !defined $hash_parent ||
+			$hash_parent eq '-c' || $hash_parent eq '--cc';
+		git_difftree_body(\@difftree, $hash,
+		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		print "<br/>\n";
 
-		git_patchset_body($fd, \@difftree, $hash, $hash_parent || @{$co{'parents'}});
+		git_patchset_body($fd, \@difftree, $hash,
+		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		close $fd;
 		print "</div>\n"; # class="page_body"
 		git_footer_html();
