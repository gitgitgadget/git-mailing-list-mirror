Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C2A1FAE2
	for <e@80x24.org>; Tue, 13 Feb 2018 10:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934226AbeBMKob (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:44:31 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:58200 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934100AbeBMKoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:44:24 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lY4NeT0Dyr5N9lY4UeMF1k; Tue, 13 Feb 2018 10:44:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518518663;
        bh=5eieA0lgFASu1cs+S9xVhlHT5SRPzPtb8uQqa4asODs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=dczl2UDpJm62XMYbl7qMjnPRELy0LCnvrqyAGdgpc66L7nCgc8rF0U7oE1/Efxrkc
         XTLnxfa1VzgurGVvYztQJD9qwPj6Y2uWoFXT1w4cYm+n0Lt8GYvMd61uJS9eLEbIZ5
         LoreiWvMws3yes/7xLsE51HA9Tn23nq9MFZoLZeE=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=LL3zA6-E6sukvci1YHgA:9
 a=itj5TtnRmn_a-nNL:21 a=LQ8KfqHvDRH8rUZ_:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 4/4] add -p: calculate offset delta for edited patches
Date:   Tue, 13 Feb 2018 10:44:08 +0000
Message-Id: <20180213104408.9887-5-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfE5wTRufipeNhEisuPDctXkzE49Ef95s4mp1/HHS26Wpyicvc7mX7E7XAfzPQ1qu9jfaEfvsZr23LQX+sdCv9/guNl8r+Lm9PaX4SjudgbQg7szKxEer
 xYqq5OFOlpdfSJr8tHo18F7Sy89LmxBTuqgIeIYfo7qDbyy1DGiVYC8Ue/TVcIjnvEbSDKz5Uf9qrCZzNz1cYHyNjD1+7BtIQmE+KRS0gJIKiGPJ0LGtbfsH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Recount the number of preimage and postimage lines in a hunk after it
has been edited so any change in the number of insertions or deletions
can be used to adjust the offsets of subsequent hunks. If an edited
hunk is subsequently split then the offset correction will be lost. It
would be possible to fix this if it is a problem, however the code
here is still an improvement on the status quo for the common case
where an edited hunk is applied without being split.

This is also a necessary step to removing '--recount' and
'--allow-overlap' from the invocation of 'git apply'. Before
'--recount' can be removed the splitting and coalescing counting needs
to be fixed to handle a missing newline at the end of a file. In order
to remove '--allow-overlap' there needs to be i) some way of verifying
the offset data in the edited hunk (probably by correlating the
preimage (or postimage if the patch is going to be applied in reverse)
lines of the edited and unedited versions to see if they are offset or
if any leading/trailing context lines have been removed) and ii) a way of
dealing with edited hunks that change context lines that are shared
with neighbouring hunks.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 57 ++++++++++++++++++++++++++++++++++++++--------
 t/t3701-add-interactive.sh |  2 +-
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 7a0a5896bb8fa063ace29b85840849c867b874f5..f139e545a4fb9cbaa757208a44cb2b5c3ad3678a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -938,6 +938,9 @@ sub coalesce_overlapping_hunks {
 						parse_hunk_header($text->[0]);
 		unless ($_->{USE}) {
 			$ofs_delta += $o_cnt - $n_cnt;
+			# If this hunk has been edited then subtract
+			# the delta that is due to the edit.
+			$_->{OFS_DELTA} and $ofs_delta -= $_->{OFS_DELTA};
 			next;
 		}
 		if ($ofs_delta) {
@@ -945,6 +948,9 @@ sub coalesce_overlapping_hunks {
 			$_->{TEXT}->[0] = format_hunk_header($o_ofs, $o_cnt,
 							     $n_ofs, $n_cnt);
 		}
+		# If this hunk was edited then adjust the offset delta
+		# to reflect the edit.
+		$_->{OFS_DELTA} and $ofs_delta += $_->{OFS_DELTA};
 		if (defined $last_o_ctx &&
 		    $o_ofs <= $last_o_ctx &&
 		    !$_->{DIRTY} &&
@@ -1016,6 +1022,30 @@ marked for discarding."),
 marked for applying."),
 );
 
+sub recount_edited_hunk {
+	local $_;
+	my ($oldtext, $newtext) = @_;
+	my ($o_cnt, $n_cnt) = (0, 0);
+	for (@{$newtext}[1..$#{$newtext}]) {
+		my $mode = substr($_, 0, 1);
+		if ($mode eq '-') {
+			$o_cnt++;
+		} elsif ($mode eq '+') {
+			$n_cnt++;
+		} elsif ($mode eq ' ') {
+			$o_cnt++;
+			$n_cnt++;
+		}
+	}
+	my ($o_ofs, undef, $n_ofs, undef) =
+					parse_hunk_header($newtext->[0]);
+	$newtext->[0] = format_hunk_header($o_ofs, $o_cnt, $n_ofs, $n_cnt);
+	my (undef, $orig_o_cnt, undef, $orig_n_cnt) =
+					parse_hunk_header($oldtext->[0]);
+	# Return the change in the number of lines inserted by this hunk
+	return $orig_o_cnt - $orig_n_cnt - $o_cnt + $n_cnt;
+}
+
 sub edit_hunk_manually {
 	my ($oldtext) = @_;
 
@@ -1114,25 +1144,34 @@ sub prompt_yesno {
 }
 
 sub edit_hunk_loop {
-	my ($head, $hunk, $ix) = @_;
-	my $text = $hunk->[$ix]->{TEXT};
+	my ($head, $hunks, $ix) = @_;
+	my $hunk = $hunks->[$ix];
+	my $text = $hunk->{TEXT};
 
 	while (1) {
-		$text = edit_hunk_manually($text);
-		if (!defined $text) {
+		my $newtext = edit_hunk_manually($text);
+		if (!defined $newtext) {
 			return undef;
 		}
 		my $newhunk = {
-			TEXT => $text,
-			TYPE => $hunk->[$ix]->{TYPE},
+			TEXT => $newtext,
+			TYPE => $hunk->{TYPE},
 			USE => 1,
 			DIRTY => 1,
 		};
 		if (diff_applies($head,
-				 @{$hunk}[0..$ix-1],
+				 @{$hunks}[0..$ix-1],
 				 $newhunk,
-				 @{$hunk}[$ix+1..$#{$hunk}])) {
-			$newhunk->{DISPLAY} = [color_diff(@{$text})];
+				 @{$hunks}[$ix+1..$#{$hunks}])) {
+			$newhunk->{OFS_DELTA} =
+					recount_edited_hunk($text, $newtext);
+			# If this hunk has already been edited then
+			# add the offset delta of the previous edit to
+			# get the real delta from the original
+			# unedited hunk.
+			$hunk->{OFS_DELTA} and
+				$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
+			$newhunk->{DISPLAY} = [color_diff(@{$newtext})];
 			return $newhunk;
 		}
 		else {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5401d74d5804b5e43286d08a905fb96c68b02e42..5681bb2bb7e9a9c0702f8ebbcd97efbb5c5d1d58 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -563,7 +563,7 @@ test_expect_success 'add -p works with pathological context lines' '
 	test_cmp expected-1 actual
 '
 
-test_expect_failure 'add -p patch editing works with pathological context lines' '
+test_expect_success 'add -p patch editing works with pathological context lines' '
 	git reset &&
 	printf "%s\n" e y |
 	GIT_EDITOR=./editor git add -p &&
-- 
2.16.1

