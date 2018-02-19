Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8464E1F576
	for <e@80x24.org>; Mon, 19 Feb 2018 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBSLgc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 06:36:32 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:3676 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbeBSLgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 06:36:31 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id njk7e9rCnoNnDnjkDeU6Om; Mon, 19 Feb 2018 11:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519040189;
        bh=nFCGJrwqFeRpsZTwde4spt2jKxhZfc2/1vqnZp7vhwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=BMNcvtxxJv7vqNff78JCnoZVWJPt4denzGakYvUoMz3V2cit/50VOzvZKK9Yfu9GB
         YuW6l3eroJL04G6OiSh7ltzy/NLVufowomzfdZwJxRVm+5GUAMdExNOAF47oojVAUo
         zT5p34kP+AxFlsOh+4vDEq57D9x+WDc6M5TnYmBA=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=0u9nRGdwO4OUcHrgb04A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=5OaC2TtP7KuTKKAl:21 a=Kzwy159ovXEAju5_:21
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v1 1/3] add -p: select individual hunk lines
Date:   Mon, 19 Feb 2018 11:36:17 +0000
Message-Id: <20180219113619.26566-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180219113619.26566-1-phillip.wood@talktalk.net>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCWcaYVGn3A1ox+5JbsQBoUEvA1MFOhzLAkG/6phJm6+iLTionWELXsSEdrvQgGQ72vAawYgd0Po7OqTxD9uK7H+/1WqM2SbU2GueRGg+DruETzS++3+
 OqFk5Oau0tQs0a5DccpSo6S5PHzK3JC52tfEpfE6wlG1fvtGy4jCEzrIrl/RNzGBMQndo6hJNBGeP5C/vHPwwhnCYUxs0R06rq86WUhZ7Zl9ONT8nq4GEat9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When I end up editing hunks it is almost always because I want to
stage a subset of the lines in the hunk. Doing this by editing the
hunk is inconvenient and error prone (especially so if the patch is
going to be reversed before being applied). Instead offer an option
for add -p to stage individual lines. When the user presses 'l' the
hunk is redrawn with labels by the insertions and deletions and they
are prompted to enter a list of the lines they wish to stage. Ranges
of lines may be specified using 'a-b' where either 'a' or 'b' may be
omitted to mean all lines from 'a' to the end of the hunk or all lines
from 1 upto and including 'b'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 136 +++++++++++++++++++++++++++++++++++++++++++++
 t/t3701-add-interactive.sh |  63 +++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a64c0db57d62ab02ef718b8c8f821105132d9920..8a33796e1f6a564d0a27ba06c216dbb9848827b9 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1003,6 +1003,126 @@ sub color_diff {
 	} @_;
 }
 
+sub label_hunk_lines {
+	local $_;
+	my $hunk = shift;
+	my $i = 0;
+	my $labels = [ map { /^[-+]/ ? ++$i : 0 } @{$hunk->{TEXT}} ];
+	$i > 1 and @{$hunk}{qw(LABELS MAX_LABEL)} = ($labels, $i);
+	return $i > 1;
+}
+
+sub select_hunk_lines {
+	my ($hunk, $selected) = @_;
+	my ($text, $labels) = @{$hunk}{qw(TEXT LABELS)};
+	my ($i, $o_cnt, $n_cnt) = (0, 0, 0);
+	my ($push_eol, @newtext);
+	# Lines with this mode will become context lines if they are
+	# not selected
+	my $context_mode = $patch_mode_flavour{IS_REVERSE} ? '+' : '-';
+	for $i (1..$#{$text}) {
+		my $mode = substr($text->[$i], 0, 1);
+		if ($mode eq '\\') {
+			push @newtext, $text->[$i] if ($push_eol);
+			undef $push_eol;
+		} elsif ($labels->[$i] and $selected->[$labels->[$i]]) {
+			push @newtext, $text->[$i];
+			if ($mode eq '+') {
+				$n_cnt++;
+			} else {
+				$o_cnt++;
+			}
+			$push_eol = 1;
+		} elsif ($mode eq ' ' or $mode eq $context_mode) {
+			push @newtext, ' ' . substr($text->[$i], 1);
+			$o_cnt++; $n_cnt++;
+			$push_eol = 1;
+		} else {
+			undef $push_eol;
+		}
+	}
+	my ($o_ofs, $orig_o_cnt, $n_ofs, $orig_n_cnt) =
+					parse_hunk_header($text->[0]);
+	unshift @newtext, format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
+	my $newhunk = {
+		TEXT => \@newtext,
+		DISPLAY => [ color_diff(@newtext) ],
+		OFS_DELTA => $orig_o_cnt - $orig_n_cnt - $o_cnt + $n_cnt,
+		TYPE => $hunk->{TYPE},
+		USE => 1,
+	};
+	# If this hunk has previously been edited add the offset delta
+	# of the old hunk to get the real delta from the original
+	# hunk.
+	$hunk->{OFS_DELTA} and $newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
+	return $newhunk;
+}
+
+sub check_hunk_label {
+	my ($max_label, $label) = ($_[0]->{MAX_LABEL}, $_[1]);
+	if ($label < 1 or $label > $max_label) {
+		error_msg sprintf(__("invalid hunk line '%d'\n"), $label);
+		return 0;
+	}
+	return 1;
+}
+
+sub parse_hunk_selection {
+	local $_;
+	my ($hunk, $line) = @_;
+	my $max_label = $hunk->{MAX_LABEL};
+	my @selected = (0) x ($max_label + 1);
+	my @fields = split(/[,\s]+/, $line);
+	for (@fields) {
+		if (/^([0-9]*)-([0-9]*)$/) {
+			if ($1 eq '' and $2 eq '') {
+				error_msg __("range '-' missing upper or lower bound\n");
+				return undef;
+			}
+			my $lo = $1 eq '' ? 1 : $1;
+			my $hi = $2 eq '' ? $max_label : $2;
+			check_hunk_label($hunk, $lo) or return undef;
+			check_hunk_label($hunk, $hi) or return undef;
+			$hi < $lo and ($lo, $hi) = ($hi, $lo);
+			@selected[$lo..$hi] = (1) x (1 + $hi - $lo);
+		} elsif (/^([0-9]+)$/) {
+			check_hunk_label($hunk, $1) or return undef;
+			$selected[$1] = 1;
+		} else {
+			error_msg sprintf(__("invalid hunk line '%s'\n"), $_);
+			return undef;
+		}
+	}
+	return \@selected;
+}
+
+sub display_hunk_lines {
+	my ($display, $labels, $max_label) =
+				@{$_[0]}{qw(DISPLAY LABELS MAX_LABEL)};
+	my $width = int(log($max_label) / log(10)) + 1;
+	my $padding = ' ' x ($width + 1);
+	for my $i (0..$#{$display}) {
+		if ($labels->[$i]) {
+			printf '%*d %s', $width, $labels->[$i], $display->[$i];
+		} else {
+			print $padding . $display->[$i];
+		}
+	}
+}
+
+sub select_lines_loop {
+	my $hunk = shift;
+	display_hunk_lines($hunk);
+	my $selection = undef;
+	until (defined $selection) {
+		print colored $prompt_color, __("select lines? ");
+		my $text = <STDIN>;
+		defined $text and $text =~ /\S/ or return undef;
+		$selection = parse_hunk_selection($hunk, $text);
+	}
+	return select_hunk_lines($hunk, $selection);
+}
+
 my %edit_hunk_manually_modes = (
 	stage => N__(
 "If the patch applies cleanly, the edited hunk will immediately be
@@ -1245,6 +1365,7 @@ j - leave this hunk undecided, see next undecided hunk
 J - leave this hunk undecided, see next hunk
 k - leave this hunk undecided, see previous undecided hunk
 K - leave this hunk undecided, see previous hunk
+l - select hunk lines to use
 s - split the current hunk into smaller hunks
 e - manually edit the current hunk
 ? - print help
@@ -1461,6 +1582,9 @@ sub patch_update_file {
 		if ($hunk[$ix]{TYPE} eq 'hunk') {
 			$other .= ',e';
 		}
+		if (label_hunk_lines($hunk[$ix])) {
+			$other .= ',l';
+		}
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
@@ -1600,6 +1724,18 @@ sub patch_update_file {
 					next;
 				}
 			}
+			elsif ($line =~ /^l/) {
+				unless ($other =~ /l/) {
+					error_msg __("Cannot select line by line\n");
+					next;
+				}
+				my $newhunk = select_lines_loop($hunk[$ix]);
+				if ($newhunk) {
+					splice @hunk, $ix, 1, $newhunk;
+				} else {
+					next;
+				}
+			}
 			elsif ($other =~ /s/ && $line =~ /^s/) {
 				my @split = split_hunk($hunk[$ix]{TEXT}, $hunk[$ix]{DISPLAY});
 				if (1 < @split) {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 0fb9c0e0f140e21ef7ad467c40b9211d29f53db6..caa80327c461785949eb2b9c919c253f4bef72cc 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -342,6 +342,61 @@ test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
 	! grep "^+31" actual
 '
 
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,9 @@
+	+5
+	 10
+	 20
+	+21
+	 30
+	 40
+	 50
+	 60
+	+61
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can stage individual lines of patch' '
+	git reset &&
+	printf 61 >>test &&
+	printf "%s\n" l "-2 4" |
+	EDITOR=: git add -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD | sed /^index/d >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'setup expected diff' '
+	cat >expected <<-\EOF
+	diff --git a/test b/test
+	--- a/test
+	+++ b/test
+	@@ -1,6 +1,8 @@
+	+5
+	 10
+	 20
+	 30
+	 40
+	 50
+	 60
+	+61
+	\ No newline at end of file
+	EOF
+'
+
+test_expect_success 'can reset individual lines of patch' '
+	printf "%s\n" l 2 |
+	EDITOR=: git reset -p 2>error &&
+	test_must_be_empty error &&
+	git diff --cached HEAD | sed /^index/d >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'patch mode ignores unmerged entries' '
 	git reset --hard &&
 	test_commit conflict &&
@@ -558,4 +613,12 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'add -p selecting lines works with pathological context lines' '
+	git reset &&
+	printf "%s\n" l 2 y |
+	GIT_EDITOR=./editor git add -p &&
+	git cat-file blob :a > actual &&
+	test_cmp expected-2 actual
+'
+
 test_done
-- 
2.16.1

