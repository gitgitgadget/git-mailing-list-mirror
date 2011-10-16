From: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
Subject: [PATCH/RFC] gitweb: add the ability to show side-by-side diff on commitdiff.
Date: Mon, 17 Oct 2011 08:57:31 +0900
Message-ID: <CAFo4x0Kb651CyxoP8wxR36aDe5=Md2UV3qjh+HPo4ad6NB=Emg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 01:57:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFaac-0006fs-8f
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 01:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab1JPX5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 19:57:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45642 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab1JPX5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 19:57:53 -0400
Received: by bkbzt19 with SMTP id zt19so2943227bkb.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=3JuMBq95aMWxt5zYE5hB9ilf7Ov8u/YNe/0/xjSOND4=;
        b=amli/sNVK4mTcl14jy8e6gCxBfLtPkghOY3GgIUVZiACLtLUtL4UcdI3cmDH/Cnd2c
         QrmXDPlqrsgVZP5Ihog80B97cwOSPzDKRlanMyeb5j7i6x9XTgeXCrRNWTdyqhdmndlR
         n9gx4kZKB0SvWvc6ghYI8dDABwtZBM5RWRWOE=
Received: by 10.204.15.194 with SMTP id l2mr12442231bka.83.1318809471157; Sun,
 16 Oct 2011 16:57:51 -0700 (PDT)
Received: by 10.204.36.132 with HTTP; Sun, 16 Oct 2011 16:57:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183744>

---
Hello,

I want to add some features that provided by Trac to Gitweb.
First, I've implemented "side-by-side" style diff.

 gitweb/gitweb.perl       |   97 ++++++++++++++++++++++++++++++++++++++--------
 gitweb/static/gitweb.css |   16 ++++++++
 2 files changed, 96 insertions(+), 17 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 85d64b2..9d7609f 100755
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
@@ -2235,25 +2238,25 @@ sub format_diff_line {
 		# combined diff
 		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
 		if ($line =~ m/^\@{3}/) {
-			$diff_class = " chunk_header";
+			$diff_class = "chunk_header";
 		} elsif ($line =~ m/^\\/) {
-			$diff_class = " incomplete";
+			$diff_class = "incomplete";
 		} elsif ($prefix =~ tr/+/+/) {
-			$diff_class = " add";
+			$diff_class = "add";
 		} elsif ($prefix =~ tr/-/-/) {
-			$diff_class = " rem";
+			$diff_class = "rem";
 		}
 	} else {
 		# assume ordinary diff
 		my $char = substr($line, 0, 1);
 		if ($char eq '+') {
-			$diff_class = " add";
+			$diff_class = "add";
 		} elsif ($char eq '-') {
-			$diff_class = " rem";
+			$diff_class = "rem";
 		} elsif ($char eq '@') {
-			$diff_class = " chunk_header";
+			$diff_class = "chunk_header";
 		} elsif ($char eq "\\") {
-			$diff_class = " incomplete";
+			$diff_class = "incomplete";
 		}
 	}
 	$line = untabify($line);
@@ -2274,7 +2277,7 @@ sub format_diff_line {
 		}
 		$line = "<span class=\"chunk_info\">@@ $from_text $to_text @@</span>" .
 		        "<span class=\"section\">" . esc_html($section, -nbsp=>1) .
"</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return $diff_class, "<div class=\"diff $diff_class\">$line</div>\n";
 	} elsif ($from && $to && $line =~ m/^\@{3}/) {
 		my ($prefix, $ranges, $section) = $line =~ m/^(\@+) (.*?) \@+(.*)$/;
 		my (@from_text, @from_start, @from_nlines, $to_text, $to_start, $to_nlines);
@@ -2307,9 +2310,9 @@ sub format_diff_line {
 		}
 		$line .= " $prefix</span>" .
 		         "<span class=\"section\">" . esc_html($section, -nbsp=>1)
. "</span>";
-		return "<div class=\"diff$diff_class\">$line</div>\n";
+		return $diff_class, "<div class=\"diff $diff_class\">$line</div>\n";
 	}
-	return "<div class=\"diff$diff_class\">" . esc_html($line, -nbsp=>1)
. "</div>\n";
+	return $diff_class, "<div class=\"diff $diff_class\">" .
esc_html($line, -nbsp=>1) . "</div>\n";
 }

 # Generates undef or something like "_snapshot_" or "snapshot (_tbz2_ _zip_)",
@@ -4826,8 +4829,32 @@ sub git_difftree_body {
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
+		                 @partial,
+		                 "</div>",
+		                 "<div class='new'>",
+		                 (map {
+		                     $_->[1];
+		                 } @chunk[scalar @partial..scalar @chunk-1]),
+		                 "</div></div>");
+	} else {
+		return join '', ("<div class='chunk'><div class='",
+		                 ($first_class eq 'add' ? 'new' : 'old'),
+		                 "'>",
+		                 @partial,
+		                 "</div></div>");
+	}
+}
+
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($fd, $is_inline, $difftree, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];

 	my $is_combined = (@hash_parents > 1);
@@ -4938,12 +4965,31 @@ sub git_patchset_body {

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
+					print q{<div class='chunk'><div class='old'>},
+					      $line,
+					      q{</div><div class='new'>},
+					      $line,
+					      q{</div></div>};
+				}
+			}
 		}

 	} continue {
@@ -7022,7 +7068,7 @@ sub git_blobdiff {
 			        "raw");
 		git_header_html(undef, $expires);
 		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
-			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
+			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base,
$formats_nav . diff_nav($input_params{diff_style}));
 			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
 		} else {
 			print "<div class=\"page_nav\"><br/>$formats_nav<br/></div>\n";
@@ -7051,7 +7097,7 @@ sub git_blobdiff {
 	if ($format eq 'html') {
 		print "<div class=\"page_body\">\n";

-		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
+		git_patchset_body($fd, $input_params{diff_style} eq 'inline', [
\%diffinfo ], $hash_base, $hash_parent_base);
 		close $fd;

 		print "</div>\n"; # class="page_body"
@@ -7076,6 +7122,22 @@ sub git_blobdiff_plain {
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
@@ -7228,7 +7290,7 @@ sub git_commitdiff {
 		my $ref = format_ref_marker($refs, $co{'id'});

 		git_header_html(undef, $expires);
-		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
+		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash,
$formats_nav . diff_nav($input_params{diff_style}));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 		print "<div class=\"title_text\">\n" .
 		      "<table class=\"object_header\">\n";
@@ -7282,7 +7344,8 @@ sub git_commitdiff {
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		print "<br/>\n";

-		git_patchset_body($fd, \@difftree, $hash,
+		git_patchset_body($fd, $input_params{diff_style} eq 'inline',
+                          \@difftree, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		close $fd;
 		print "</div>\n"; # class="page_body"
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 7d88509..a6872f9 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -618,6 +618,22 @@ div.remote {
 	cursor: pointer;
 }

+/* side-by-side diff */
+div.chunk {
+    overflow: hidden;
+}
+
+div.chunk div.old {
+    float: left;
+    width: 50%;
+    overflow: hidden;
+}
+
+div.chunk div.new {
+    margin-left: 50%;
+    width: 50%;
+}
+

 /* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */

-- 
1.7.7.213.g8b0e1.dirty
