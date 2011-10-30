From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 3/8] gitweb: Add a feature to show side-by-side diff
Date: Mon, 31 Oct 2011 00:36:22 +0100
Message-ID: <1320017787-18048-4-git-send-email-jnareb@gmail.com>
References: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Cc: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 00:41:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKf0C-0006ES-UJ
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 00:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab1J3XlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 19:41:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38444 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491Ab1J3XlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 19:41:15 -0400
Received: by mail-fx0-f46.google.com with SMTP id n17so5068665faa.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 16:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FWY8EGxA7Q65wdfD51pl65NuN3eapPGL0SHrIelaasE=;
        b=SkP9Ef32Hb5oiqVciDmjAXuJ+U+YYZiJaLA0BMPGwKda4ubg/K5qq26O9icI0nFhFD
         O1O1tgHvm3epkzMWY3UiZSWxrYgU7Rs0RHdrVC8umbVj69cpzZIjnw/aPdriYxZyJUYV
         B0MLwGATq8/r6rlgVCWRVirqNTWKvs3OU2Fys=
Received: by 10.223.14.3 with SMTP id e3mr25418055faa.25.1320018074925;
        Sun, 30 Oct 2011 16:41:14 -0700 (PDT)
Received: from localhost.localdomain (aeho24.neoplus.adsl.tpnet.pl. [79.186.196.24])
        by mx.google.com with ESMTPS id a26sm19652514fac.2.2011.10.30.16.41.13
        (version=SSLv3 cipher=OTHER);
        Sun, 30 Oct 2011 16:41:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1320017787-18048-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184482>

From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>

This commits adds to support for showing "side-by-side" style diff.
Currently you have to hand-craft the URL; navigation for selecting
diff style is to be added in the next commit.


The diff output in unified format from "git diff-tree" is reorganized to
side-by-side style chunk by chunk with format_sidebyside_diff_chunk().
This reorganization requires knowledge about diff line classification,
so format_diff_line() was renamed to process_diff_line(), and changed to
return tuple (list) consisting of class of diff line and of
HTML-formatted (but not wrapped in <div class="diff ...">...</div>) diff
line.  Wrapping is now done by caller, i.e. git_patchset_body().

Gitweb uses float+margin CSS-based layout for "side by side" diff.


You can specify style of diff with "ds" ('diff_style') query
parameter.  Currently supported values are 'inline' and 'sidebyside';
the default is 'inline'.

Another solution would be to use "opt" ('extra_options') for that...
though current use of it in gitweb seems to suggest that "opt" is more
about passing extra options to underlying git commands, and "git diff"
doesn't support '--side-by-side' like GNU diff does, (yet?).

Signed-off-by: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Heavily changed from original submission by Kato Kazuyoshi, but the
main idea, code structure (somewhat) and CSS-base layout remains.
That's why authorship remains with him; Kato, please speak up if you
would like to change this.

The decision to move some of formatting outside process_diff_line()
(formerly format_diff_line()) was not really necessary, in hindsight...

 gitweb/gitweb.perl       |  116 +++++++++++++++++++++++++++++++++++++++++----
 gitweb/static/gitweb.css |   17 +++++++
 2 files changed, 122 insertions(+), 11 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 95d278a..68629f6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -759,6 +759,7 @@ our @cgi_param_mapping = (
 	extra_options => "opt",
 	search_use_regexp => "sr",
 	ctag => "by_tag",
+	diff_style => "ds",
 	# this must be last entry (for manipulation from JavaScript)
 	javascript => "js"
 );
@@ -2317,28 +2318,27 @@ sub format_cc_diff_chunk_header {
 	return $line;
 }
 
-# format patch (diff) line (not to be used for diff headers)
-sub format_diff_line {
+# process patch (diff) line (not to be used for diff headers),
+# returning class and HTML-formatted (but not wrapped) line
+sub process_diff_line {
 	my $line = shift;
 	my ($from, $to) = @_;
 
 	my $diff_class = diff_line_class($line, $from, $to);
-	my $diff_classes = "diff";
-	$diff_classes .= " $diff_class" if ($diff_class);
 
 	chomp $line;
 	$line = untabify($line);
 
 	if ($from && $to && $line =~ m/^\@{2} /) {
 		$line = format_unidiff_chunk_header($line, $from, $to);
-		return "<div class=\"$diff_classes\">$line</div>\n";
+		return $diff_class, $line;
 
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
 		$line = format_cc_diff_chunk_header($line, $from, $to);
-		return "<div class=\"$diff_classes\">$line</div>\n";
+		return $diff_class, $line;
 
 	}
-	return "<div class=\"$diff_classes\">" . esc_html($line, -nbsp=>1) . "</div>\n";
+	return $diff_class, esc_html($line, -nbsp=>1);
 }
 
 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
@@ -4860,8 +4860,78 @@ sub git_difftree_body {
 	print "</table>\n";
 }
 
+sub print_sidebyside_diff_chunk {
+	my @chunk = @_;
+	my (@ctx, @rem, @add);
+
+	return unless @chunk;
+
+	# incomplete last line might be among removed or added lines,
+	# or both, or among context lines: find which
+	for (my $i = 1; $i < @chunk; $i++) {
+		if ($chunk[$i][0] eq 'incomplete') {
+			$chunk[$i][0] = $chunk[$i-1][0];
+		}
+	}
+
+	# guardian
+	push @chunk, ["", ""];
+
+	foreach my $line_info (@chunk) {
+		my ($class, $line) = @$line_info;
+
+		# print chunk headers
+		if ($class && $class eq 'chunk_header') {
+			print $line;
+			next;
+		}
+
+		## print from accumulator when type of class of lines change
+		# empty contents block on start rem/add block, or end of chunk
+		if (@ctx && (!$class || $class eq 'rem' || $class eq 'add')) {
+			print join '',
+				'<div class="chunk_block">',
+					'<div class="old">',
+					@ctx,
+					'</div>',
+					'<div class="new">',
+					@ctx,
+					'</div>',
+				'</div>';
+			@ctx = ();
+		}
+		# empty add/rem block on start context block, or end of chunk
+		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
+			print join '',
+				'<div class="chunk_block">',
+					'<div class="old">',
+					@rem,
+					'</div>',
+					'<div class="new">',
+					@add,
+					'</div>',
+				'</div>';
+			@rem = @add = ();
+		}
+
+		## adding lines to accumulator
+		# guardian value
+		last unless $line;
+		# rem, add or change
+		if ($class eq 'rem') {
+			push @rem, $line;
+		} elsif ($class eq 'add') {
+			push @add, $line;
+		}
+		# context line
+		if ($class eq 'ctx') {
+			push @ctx, $line;
+		}
+	}
+}
+
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($fd, $diff_style, $difftree, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];
 
 	my $is_combined = (@hash_parents > 1);
@@ -4871,6 +4941,7 @@ sub git_patchset_body {
 	my $diffinfo;
 	my $to_name;
 	my (%from, %to);
+	my @chunk; # for side-by-side diff
 
 	print "<div class=\"patchset\">\n";
 
@@ -4977,10 +5048,29 @@ sub git_patchset_body {
 
 			next PATCH if ($patch_line =~ m/^diff /);
 
-			print format_diff_line($patch_line, \%from, \%to);
+			my ($class, $line) = process_diff_line($patch_line, \%from, \%to);
+			my $diff_classes = "diff";
+			$diff_classes .= " $class" if ($class);
+			$line = "<div class=\"$diff_classes\">$line</div>\n";
+
+			if ($diff_style eq 'sidebyside' && !$is_combined) {
+				if ($class eq 'chunk_header') {
+					print_sidebyside_diff_chunk(@chunk);
+					@chunk = ( [ $class, $line ] );
+				} else {
+					push @chunk, [ $class, $line ];
+				}
+			} else {
+				# default 'inline' style and unknown styles
+				print $line;
+			}
 		}
 
 	} continue {
+		if (@chunk) {
+			print_sidebyside_diff_chunk(@chunk);
+			@chunk = ();
+		}
 		print "</div>\n"; # class="patch"
 	}
 
@@ -6976,6 +7066,7 @@ sub git_object {
 
 sub git_blobdiff {
 	my $format = shift || 'html';
+	my $diff_style = $input_params{'diff_style'} || 'inline';
 
 	my $fd;
 	my @difftree;
@@ -7085,7 +7176,8 @@ sub git_blobdiff {
 	if ($format eq 'html') {
 		print "<div class=\"page_body\">\n";
 
-		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
+		git_patchset_body($fd, $diff_style,
+		                  [ \%diffinfo ], $hash_base, $hash_parent_base);
 		close $fd;
 
 		print "</div>\n"; # class="page_body"
@@ -7113,6 +7205,7 @@ sub git_blobdiff_plain {
 sub git_commitdiff {
 	my %params = @_;
 	my $format = $params{-format} || 'html';
+	my $diff_style = $input_params{'diff_style'} || 'inline';
 
 	my ($patch_max) = gitweb_get_feature('patches');
 	if ($format eq 'patch') {
@@ -7316,7 +7409,8 @@ sub git_commitdiff {
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		print "<br/>\n";
 
-		git_patchset_body($fd, \@difftree, $hash,
+		git_patchset_body($fd, $diff_style,
+		                  \@difftree, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		close $fd;
 		print "</div>\n"; # class="page_body"
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 7d88509..21842a6 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -475,6 +475,23 @@ div.diff.nodifferences {
 	color: #600000;
 }
 
+/* side-by-side diff */
+div.chunk_block {
+	overflow: hidden;
+}
+
+div.chunk_block div.old {
+	float: left;
+	width: 50%;
+	overflow: hidden;
+}
+
+div.chunk_block div.new {
+	margin-left: 50%;
+	width: 50%;
+}
+
+
 div.index_include {
 	border: solid #d9d8d1;
 	border-width: 0px 0px 1px;
-- 
1.7.6
