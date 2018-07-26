Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086461F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbeGZRXy (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 13:23:54 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:50460 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbeGZRXy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 13:23:54 -0400
Received: from lindisfarne.localdomain ([89.242.182.230])
        by smtp.talktalk.net with SMTP
        id iimGfHvLPoI6LiimVfsryf; Thu, 26 Jul 2018 17:06:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1532621184;
        bh=BSVw2pDtIOEQ/I7M0SQm1cqxScObtCRXeDXwbP0UGrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=hv/x19yoIIDzsFnyXKnB75wBwz1QgISxI7bz/MgkitFJHt38CwSxBIQEGQDBYDsZ0
         9wo0FxPSROrzLMYVorrAr5IaL8foIGgBr4bHR+vkESWMMi64Bdgs435omDf0mHqU6O
         4iSAcG6gCCqI9qkNkROQEVhz03rHpEQbdolUxg5c=
X-Originating-IP: [89.242.182.230]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=tQBg3IHG1C6KDs2Ec9TG5Q==:117
 a=tQBg3IHG1C6KDs2Ec9TG5Q==:17 a=IkcTkHD0fZMA:10 a=evINK-nbAAAA:8
 a=pGLkceISAAAA:8 a=resyGrhQf7wFeiYf0FEA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
 a=X2cK4bkTbIObvAAj:21 a=0TmrHpo6DV2DRuWS:21 a=QEXdDO2ut3YA:10
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH v5 2/4] add -p: select modified lines correctly
Date:   Thu, 26 Jul 2018 16:58:52 +0100
Message-Id: <20180726155854.20832-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726155854.20832-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180726155854.20832-1-phillip.wood@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfETtKrC4aUFTmSgqhS+nIthsSi4Kqj8RNt5bg2otOFzguMJqMWOkzZdrUk775fFGONGaG5hOE8mS5E8OsrCGRHvW/xQ4dLUG+R2uDf47Yb4eFv58qlJb
 WNJzqwgU85mu3r75JRWzXf8r3k2mZT8qqF5wFP4pEX37g/nN50g/vTlB/2JJc9s2Amaw0TPSo5Y4Ra0mUkgP7GAazopgtmGA2XVJnf7Vjh5XRDdoDiiqkrOA
 oS4T6VTI8qcRdGxeUFf72bf5qZWMLk3O9jCwiYlCX1qJ+eH8gQyrqNfZeF+dY2R2mKdy5grZQavvF7GuM8f3zieREc/OfzQvXIP+OzlY2Y8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a set of lines is modified the hunk contains deletions followed
by insertions. To correctly stage a subset of the modified lines we
need to match up the selected deletions with the selected insertions
otherwise we end up with deletions and context lines followed by
insertions which is not what we want.

For example given the hunk
      1 -* a longer description of the
      2 -  first item
      3 -* second
      4 -* third
      5 +* first
      6 +  second item
      7 +* the third item

If the user selects 1,2,4–5,7 then we should generate
	-* a longer description of the
	-  first item
	+* first
	 * second
	-* third
	+* the third item

not
	-* a longer description of the
	-  first item
	 * second
	-* third
	+* first
	+* the third item

Currently the code can only cope with selections that contain the same
number of groups of insertions and deletions, though each group need
not contain the same number of insertions and deletions. If the user
wants to stage an unpaired deletion or insertion in a hunk where they
also want to stage modified lines they have to do it with two
invocations of 'git add -p'.

It would be possible to add some syntax to allow lines to be excluded
from groups to allow the user to stage such changes in a single
go. It may also be useful to allow users to explicitly group lines. If
in the example above the second item is deleted we have

      1 -* a longer description of the
      2 - first item
      3 -* second
      4 -* third
      5 +* first
      6 +* the third item

Selecting 1,2,4–6 will give an error. If lines could be grouped
explicitly then it would be possible to type something like
1,2,4,[5],6 to indicate that there are two groups of insertions giving

	-* a longer description of the
	- first item
	+* first
	 * second
	-* third
	+* the third item

We may want to be able to stage an insertion before an unselected
deletion to allow the user to stage a new paragraph before the
unmodified original in

      1 -original
      2 +a new paragraph before
      3 +original
      4 +
      5 +modified original

by specifying something like ^2-4 to give

	+a new paragraph before
	+original
	+
	 original

I'm not sure how common these cases are in real life and how much
effort it's worth putting into handling them at the moment when the
user can edit the hunk if need be. Perhaps it would be better to leave
it for future extensions when it becomes clearer what would be most
useful.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 147 ++++++++++++++++++++++++++++++++++---
 t/t3701-add-interactive.sh | 108 ++++++++++++++++++++++++++-
 2 files changed, 242 insertions(+), 13 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index cbc9e5698a..7e4daee2fc 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1015,26 +1015,47 @@ sub color_diff {
 
 use constant {
 	NO_NEWLINE => 1,
+	LAST_ADD_DEL => 2,
+	FIRST_ADD => 4
 };
 
 sub label_hunk_lines {
 	my $hunk = shift;
 	my $text = $hunk->{TEXT};
-	my (@line_flags, @lines);
+	# A block contains the insertions and deletions occurring context
+	# lines.
+	my (@blocks, @line_flags, @lines, @modes);
 	my ($block, $label, $last_mode) = (0, 0, '');
 	for my $line (1..$#{$text}) {
 		$line_flags[$line] = 0;
 		my $mode = substr($text->[$line], 0, 1);
 		if ($mode eq '\\') {
 			$line_flags[$line - 1] |= NO_NEWLINE;
 		}
+		if ($mode ne '-' and $last_mode eq '-' or
+		    $mode ne '+' and $last_mode eq '+') {
+			$line_flags[$line - 1] |= LAST_ADD_DEL;
+		}
+		if ($mode eq '+' and $last_mode ne '+') {
+			$line_flags[$line] |= FIRST_ADD;
+		}
 		if ($mode eq '-' or $mode eq '+') {
-			$lines[++$label] = $line;
+			$blocks[++$label] = $block;
+			$lines[$label] = $line;
+			$modes[$label] = $mode;
+		} elsif ($mode eq ' ' and $last_mode ne ' ') {
+			$block++;
 		}
+		$last_mode = $mode;
+	}
+	if ($last_mode eq '-' or $last_mode eq '+') {
+		$line_flags[-1] |= LAST_ADD_DEL;
 	}
 	if ($label > 1) {
 		$hunk->{LABELS} = {
+			BLOCKS => \@blocks,
 			LINES => \@lines,
+			MODES => \@modes
 		};
 		$hunk->{LINE_FLAGS} = \@line_flags;
 		return 1;
@@ -1061,11 +1082,14 @@ sub select_hunk_lines {
 		}
 	};
 
-	my ($lo, $hi) = splice(@$selected, 0, 2);
+	my ($lo, $hi, $pre_insert, $post_insert) = splice(@$selected, 0, 4);
 	# Lines with this mode will become context lines if they are
 	# not selected
 	my $context_mode = $patch_mode_flavour{IS_REVERSE} ? '+' : '-';
 	for $i (1..$#{$text}) {
+		if ($i == $lo and defined($pre_insert)) {
+			$select_lines->(@$pre_insert);
+		}
 		if ($lo <= $i and $i <= $hi) {
 			$select_lines->($i);
 		} else {
@@ -1080,8 +1104,12 @@ sub select_hunk_lines {
 			}
 		}
 		if ($i == $hi) {
+			if (defined($post_insert)) {
+				$select_lines->(@$post_insert);
+			}
 			if (@$selected) {
-				($lo, $hi) = splice(@$selected, 0, 2);
+				($lo, $hi, $pre_insert, $post_insert) =
+						splice(@$selected, 0, 4);
 			}
 		}
 	}
@@ -1104,6 +1132,108 @@ sub select_hunk_lines {
 	return $newhunk;
 }
 
+sub pair_hunk_selection {
+	my $line_flags = shift;
+	my @ret;
+	my $reverse = $patch_mode_flavour{IS_REVERSE};
+	for my $sel (@_) {
+		my $i = 0;
+		my ($del, $add) = @$sel;
+		my $ndel = @$del / 2;
+		my $nadd = @$add / 2;
+		# If there the same number of insertion and deletion
+		# groups then pair up in insertions and deletions.
+		if ($nadd == $ndel) {
+			while ($i < @{$del}) {
+				my ($ra, $rb) = $reverse ? ($add, $del) :
+							   ($del, $add);
+				my ($starta, $enda) = @{$ra}[$i, $i + 1];
+				my ($startb, $endb) = @{$rb}[$i, $i + 1];
+				if ($line_flags->[$enda] & LAST_ADD_DEL and
+				    $line_flags->[$endb] & NO_NEWLINE) {
+					$endb++;
+				}
+				if ($line_flags->[$enda] & NO_NEWLINE) {
+					$enda++;
+				}
+				push @ret, $reverse ?
+					($starta, $enda,
+					 [ $startb..$endb ], undef) :
+					($starta, $enda,
+					 undef, [ $startb..$endb ]);
+				$i += 2;
+			}
+		# If there are only deletions or only insertions or
+		# a) we're adding to the index and there is a single group
+		#    of insertions starting at the first inserted line
+		# or
+		# b) we're resetting the index and there is a single group
+		#    of deletions finishing with the last deleted line
+		# then it is okay just to have deletions followed by
+		# insertions.
+		} elsif (!$nadd or !$ndel or
+			 (!$reverse and $ndel == 1 and
+			  $line_flags->[$del->[1]] & LAST_ADD_DEL) or
+			 ($reverse and $nadd == 1 and
+			  $line_flags->[$add->[0]] & FIRST_ADD)) {
+			while ($i < @$del) {
+				my ($start, $end) = @{$del}[$i, $i + 1];
+				if ($line_flags->[$end] & NO_NEWLINE) {
+					$end++;
+				}
+				push @ret, $start, $end, undef, undef;
+				$i += 2;
+			}
+			$i = 0;
+			while ($i < @$add) {
+				my ($start, $end) = @{$add}[$i, $i + 1];
+				if ($line_flags->[$end] & NO_NEWLINE) {
+					$end++;
+				}
+				push @ret, $start, $end, undef, undef;
+				$i += 2;
+			}
+		} else {
+			printf STDERR __("unable to pair up insertions and deletions\n");
+			return undef;
+		}
+	}
+	return \@ret;
+}
+
+sub process_hunk_selection {
+	my ($labels, $line_flags) = @{shift()}{qw(LABELS LINE_FLAGS)};
+	my ($blocks, $lines, $modes) =
+				@{$labels}{qw(BLOCKS LINES MODES)};
+	my @selection = sort { $a <=> $b } @_;
+	unless (@selection) {
+		return [];
+	}
+	my $last_label = shift @selection;
+	my ($last_block, $last_line, $last_mode) =
+	    ($blocks->[$last_label], $lines->[$last_label], $modes->[$last_label]);
+	my ($del, $add) = ([], []);
+	push @{$last_mode eq '-' ? $del : $add}, $last_line;
+	my @sel;
+	for my $label (@selection) {
+		my ($block, $line, $mode) =
+			($blocks->[$label], $lines->[$label], $modes->[$label]);
+		if ($block != $last_block) {
+			push @{$last_mode eq '-' ? $del : $add}, $last_line;
+			push @sel, [ $del, $add ];
+			($del, $add) = ([], []);
+			push @{$mode eq '-' ? $del : $add}, $line;
+		} elsif ($line != $last_line + 1 or $mode ne $last_mode) {
+			push @{$last_mode eq '-' ? $del : $add}, $last_line;
+			push @{$mode eq '-' ? $del : $add}, $line;
+		}
+		($last_block, $last_line, $last_mode) = ($block, $line, $mode);
+	}
+	push @{$last_mode eq '-' ? $del : $add}, $last_line;
+	push @sel, [ $del, $add ];
+	pair_hunk_selection($line_flags, @sel);
+}
+
 sub check_hunk_label {
 	my ($max_label, $label) = @_;
 	if ($label < 1 or $label > $max_label) {
@@ -1138,14 +1268,7 @@ sub parse_hunk_selection {
 			return undef;
 		}
 	}
-	[ map {
-		my $line = $lines->[$_];
-		if ($hunk->{LINE_FLAGS}->[$line] & NO_NEWLINE) {
-			($line, $line + 1);
-		} else {
-			($line, $line);
-		}
-	} sort { $a <=> $b } keys(%selected) ];
+	return process_hunk_selection($hunk, keys(%selected));
 }
 
 sub display_hunk_lines {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5b535a22d5..1d917ad018 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -489,7 +489,7 @@ test_expect_success 'setup expected diff' '
 	EOF
 '
 
-test_expect_failure 'can stage modified lines of patch (1)' '
+test_expect_success 'can stage modified lines of patch (1)' '
 	git reset &&
 	printf "%s\n" l "1,3 7-9 12" |
 	EDITOR=: git add -p 2>error &&
@@ -498,6 +498,112 @@ test_expect_failure 'can stage modified lines of patch (1)' '
 	diff_cmp expected actual
 '
 
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	index 0889435..cc6163b 100644
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,7 @@
+	 10
+	-20
+	+twenty
+	+thirty
+	 30
+	 40
+	 50
+	-60
+	+sixty
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can stage modified lines of patch (2)' '
+	git reset &&
+	printf "%s\n" l "2,6,8,9,12" |
+	EDITOR=: git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
+'
+
+test_expect_success 'setup HEAD' '
+	git reset &&
+	git apply --cached <<-\EOF &&
+	diff --git a/test b/test
+	--- a/test
+	+++ b/test
+	@@ -3,4 +3,4 @@
+	 30
+	 40
+	 50
+	-60
+	+60
+	\ No newline at end of file
+	EOF
+	git commit
+'
+
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	index 0889435..cc6163b 100644
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,8 @@
+	-10
+	+ten
+	+twenty
+	+thirty
+	 20
+	-30
+	+fifty
+	 40
+	 50
+	 60
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can stage modified lines of patch (3)' '
+	git reset &&
+	printf "%s\n" l "11,1,3 7-9" |
+	EDITOR=: git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
+'
+
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	index 0889435..cc6163b 100644
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,8 @@
+	-10
+	+ten
+	+twenty
+	+thirty
+	 20
+	 30
+	 40
+	 50
+	-60
+	\ No newline at end of file
+	+fifty
+	EOF
+'
+
+test_expect_success 'can stage modified lines of patch (4)' '
+	git reset &&
+	printf "%s\n" l "9-6 11,1" |
+	EDITOR=: git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD >actual &&
+	diff_cmp expected actual
+'
+
 test_expect_success 'patch mode ignores unmerged entries' '
 	git reset --hard &&
 	test_commit conflict &&
-- 
2.18.0

