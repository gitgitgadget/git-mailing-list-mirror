From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Subject: [PATCH 2/2] gitweb: add a feature to show side-by-side diff
Date: Mon, 17 Oct 2011 16:00:18 +0900
Message-ID: <CAFo4x0L4BAKnCDa1uEK0Rskd9kTsR-94D4mkYKnLGqVDnuyuBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 09:00:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhBm-0001Iv-5h
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab1JQHAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:00:40 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50862 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1JQHAj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:00:39 -0400
Received: by bkbzt19 with SMTP id zt19so3346473bkb.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 00:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=1VIcLEvcCex+mOiRsZBLG5JMkd1oavUr5e2kEoBg24o=;
        b=AWYvf6vfPL4ceErnjoTl6sdbOVHVftqA7+OK7jdM8WI82AgzIbfaLVpuC++3swfbwW
         B3M08zeYTHNHz043heT1mneleWbMZdOb/mfSbXMRk7qamYGlqZD7zoJw9wH/B24VNaxo
         HGvDXOshSySj9ozfdCXEDk+CK8VeBnzNGY/VU=
Received: by 10.204.156.1 with SMTP id u1mr13370757bkw.18.1318834838092; Mon,
 17 Oct 2011 00:00:38 -0700 (PDT)
Received: by 10.204.36.132 with HTTP; Mon, 17 Oct 2011 00:00:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183769>

gitweb currently has a feature to show diff but it doesn't support
"side-by-side" style. This modification introduces:

 * The "ds" query parameter to specify the style of diff.
 * The format_diff_chunk() to reorganize an output of diff.
 * The diff_nav() for form.
---
 gitweb/gitweb.perl       |   81 +++++++++++++++++++++++++++++++++++++++++----
 gitweb/static/gitweb.css |   15 ++++++++
 2 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 095adda..dca09dc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -757,6 +757,7 @@ our @cgi_param_mapping = (
 	extra_options => "opt",
 	search_use_regexp => "sr",
 	ctag => "by_tag",
+	diff_style => "ds",
 	# this must be last entry (for manipulation from JavaScript)
 	javascript => "js"
 );
@@ -1072,6 +1073,8 @@ sub evaluate_and_validate_params {
 		}
 		$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
 	}
+
+	$input_params{diff_style} ||= 'inline';
 }

 # path to the current git repository
@@ -2276,7 +2279,7 @@ sub format_diff_line {
 		}
 		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
 		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) .
"</span>";
-		return "$div_open$line</div>\n";
+		return $diff_class, "$div_open$line</div>\n";
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
 		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
 		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
@@ -2309,9 +2312,9 @@ sub format_diff_line {
 		}
 		$line .= " $prefix</span>" .
 		         "<span class=\"section\">" . esc_html($section, -nbsp=>1)
. "</span>";
-		return "$div_open$line</div>\n";
+		return $diff_class, "$div_open$line</div>\n";
 	}
-	return $div_open . esc_html($line, -nbsp=>1) . "</div>\n";
+	return $diff_class, $div_open . esc_html($line, -nbsp=>1) . "</div>\n";
 }

 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
@@ -4828,8 +4831,32 @@ sub git_difftree_body {
 	print "</table>\n";
 }

+sub format_diff_chunk {
+	my @chunk = @_;
+
+	my $first_class = $chunk[0]->[0];
+	my @partial = map { $_->[1] } grep { $_->[0] eq $first_class } @chunk;
+
+	if (scalar @partial < scalar @chunk) {
+		return join '', ("<div class='chunk'><div class='old'>",
+		             @partial,
+		             "</div>",
+		             "<div class='new'>",
+		             (map {
+		                 $_->[1];
+		             } @chunk[scalar @partial..scalar @chunk-1]),
+		             "</div></div>");
+	} else {
+		return join '', ("<div class='chunk'><div class='",
+		             ($first_class eq 'add' ? 'new' : 'old'),
+		             "'>",
+		             @partial,
+		             "</div></div>");
+	}
+}
+
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($fd, $is_inline, $difftree, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];

 	my $is_combined = (@hash_parents > 1);
@@ -4940,12 +4967,31 @@ sub git_patchset_body {

 		# the patch itself
 	LINE:
+		my @chunk;
 		while ($patch_line = <$fd>) {
 			chomp $patch_line;

 			next PATCH if ($patch_line =~ m/^diff /);

-			print format_diff_line($patch_line, \%from, \%to);
+			my ($class, $line) = format_diff_line($patch_line, \%from, \%to);
+			if ($is_inline) {
+				print $line;
+			} elsif ($class eq 'add' || $class eq 'rem') {
+				push @chunk, [ $class, $line ];
+			} else {
+				if (@chunk) {
+					print format_diff_chunk(@chunk);
+					@chunk = ();
+				} elsif ($class eq 'chunk_header') {
+					print $line;
+				} else {
+					print '<div class="chunk"><div class="old">',
+					      $line,
+					      '</div><div class="new">',
+					      $line,
+					      '</div></div>';
+				}
+			}
 		}

 	} continue {
@@ -7053,7 +7099,8 @@ sub git_blobdiff {
 	if ($format eq 'html') {
 		print "<div class=\"page_body\">\n";

-		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
+		git_patchset_body($fd, $input_params{diff_style} eq 'inline',
+		                  [ \%diffinfo ], $hash_base, $hash_parent_base);
 		close $fd;

 		print "</div>\n"; # class="page_body"
@@ -7078,6 +7125,22 @@ sub git_blobdiff_plain {
 	git_blobdiff('plain');
 }

+sub diff_nav {
+	my ($style) = @_;
+
+	my %pairs = (inline => 'inline', 'sidebyside' => 'side by side');
+	join '', ($cgi->start_form({ method => 'get' }),
+	          $cgi->hidden('p'),
+	          $cgi->hidden('a'),
+	          $cgi->hidden('h'),
+	          $cgi->hidden('hp'),
+	          $cgi->hidden('hb'),
+	          $cgi->hidden('hpb'),
+	          $cgi->popup_menu('ds', [keys %pairs], $style, \%pairs),
+	          $cgi->submit('change'),
+	          $cgi->end_form);
+}
+
 sub git_commitdiff {
 	my %params = @_;
 	my $format = $params{-format} || 'html';
@@ -7230,7 +7293,8 @@ sub git_commitdiff {
 		my $ref = format_ref_marker($refs, $co{'id'});

 		git_header_html(undef, $expires);
-		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
+		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash,
+		                   $formats_nav . diff_nav($input_params{diff_style}));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 		print "<div class=\"title_text\">\n" .
 		      "<table class=\"object_header\">\n";
@@ -7284,7 +7348,8 @@ sub git_commitdiff {
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		print "<br/>\n";

-		git_patchset_body($fd, \@difftree, $hash,
+		git_patchset_body($fd, $input_params{diff_style} eq 'inline',
+		                  \@difftree, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		close $fd;
 		print "</div>\n"; # class="page_body"
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 7d88509..dc84db2 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -618,6 +618,21 @@ div.remote {
 	cursor: pointer;
 }

+/* side-by-side diff */
+div.chunk {
+	overflow: hidden;
+}
+
+div.chunk div.old {
+	float: left;
+	width: 50%;
+	overflow: hidden;
+}
+
+div.chunk div.new {
+	margin-left: 50%;
+	width: 50%;
+}

 /* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */

-- 
1.7.7.213.g8b0e1.dirty
