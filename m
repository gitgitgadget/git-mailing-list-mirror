Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF8D1F576
	for <e@80x24.org>; Mon,  5 Mar 2018 10:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934401AbeCEK5G (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 05:57:06 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:64617 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934427AbeCEK4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 05:56:46 -0500
Received: from lindisfarne.localdomain ([92.22.16.137])
        by smtp.talktalk.net with SMTP
        id snnHeF8dCGrhCsnnQesP03; Mon, 05 Mar 2018 10:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1520247404;
        bh=EWm6U+Rsm6fn5V65OiHmF5MI98oZDRCmbQo1y27+Kn0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=UgzTXwBwhQWLbCyQxb9OPJoel0nRtDpZHtjQqHF0N/pbzbMBPcVpHakVKBfppjt3Z
         q9tkKrEBn66SWIqSNSFs9wLLaUu6LBV3p7GPjYhOQ/XPAsdIsIEwQ27TorzqnefpyV
         /TpN+3tD7e2ICNAUuVDU5ze7byRfK6/xzClplsxI=
X-Originating-IP: [92.22.16.137]
X-Spam: 0
X-OAuthority: v=2.3 cv=SORsqtnH c=1 sm=1 tr=0 a=nWy375ASyxHoIYnPohIYMA==:117
 a=nWy375ASyxHoIYnPohIYMA==:17 a=evINK-nbAAAA:8 a=Ld154R0D5bFAFSIXOvsA:9
 a=wFsPmfvjHoTz0u8l:21 a=-Bs6PxHG9H01AcE-:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 7/9] add -p: calculate offset delta for edited patches
Date:   Mon,  5 Mar 2018 10:56:28 +0000
Message-Id: <20180305105630.14407-8-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180305105630.14407-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180305105630.14407-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfIG5LJPAr8qtj+zVvkwsx2BTGcQGfMGg93xXqEvqGcOAqmux0vPv7fVoaV3wg/DrVah+wdz1YIJpoAY7MNJmV7ucyWmfPmHENQ5NcK99+P8n6SQeqK5r
 TddV0L/SlXiwb2+AZy2bneLg9aAqgfIFcDh/OgFBPUkUnBJGP0EE9kBvgaP1A0UsXwKR/YdXnUeYwR4kUhZyqpQ4T5Akw62WT0yoIZCzuJTJvLRir13G7bNT
 LO2IPpm+BUfnJm7pO53zv/qqdW6QDMuqKIKE7RNLfn3vP2z2AWslYB20800xnGACTzdhbQw0nF3EZTYrq8c3fSr3LZyJ+GhKDrKySYqhowg=
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

Notes:
    changes since v4:
     - replaced instances of
         <<conditional>> and <<statement with side effect>>;
       with
         if (<<conditional>>) {
    	<<statement with side effect>>;
         }
    
    changes since v1
     - edited hunks are now recounted before seeing if they apply in
       preparation for removing '--recount' when invoking 'git apply'
     - added sentence to commit message about the offset data being lost
       if an edited hunk is split

 git-add--interactive.perl  | 59 +++++++++++++++++++++++++++++++++++++++-------
 t/t3701-add-interactive.sh |  2 +-
 2 files changed, 51 insertions(+), 10 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 7a0a5896bb..f80372d3ad 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -938,13 +938,23 @@ sub coalesce_overlapping_hunks {
 						parse_hunk_header($text->[0]);
 		unless ($_->{USE}) {
 			$ofs_delta += $o_cnt - $n_cnt;
+			# If this hunk has been edited then subtract
+			# the delta that is due to the edit.
+			if ($_->{OFS_DELTA}) {
+				$ofs_delta -= $_->{OFS_DELTA};
+			}
 			next;
 		}
 		if ($ofs_delta) {
 			$n_ofs += $ofs_delta;
 			$_->{TEXT}->[0] = format_hunk_header($o_ofs, $o_cnt,
 							     $n_ofs, $n_cnt);
 		}
+		# If this hunk was edited then adjust the offset delta
+		# to reflect the edit.
+		if ($_->{OFS_DELTA}) {
+			$ofs_delta += $_->{OFS_DELTA};
+		}
 		if (defined $last_o_ctx &&
 		    $o_ofs <= $last_o_ctx &&
 		    !$_->{DIRTY} &&
@@ -1016,6 +1026,30 @@ marked for discarding."),
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
 
@@ -1114,25 +1148,32 @@ sub prompt_yesno {
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
+		$newhunk->{OFS_DELTA} = recount_edited_hunk($text, $newtext);
+		# If this hunk has already been edited then add the
+		# offset delta of the previous edit to get the real
+		# delta from the original unedited hunk.
+		$hunk->{OFS_DELTA} and
+				$newhunk->{OFS_DELTA} += $hunk->{OFS_DELTA};
 		if (diff_applies($head,
-				 @{$hunk}[0..$ix-1],
+				 @{$hunks}[0..$ix-1],
 				 $newhunk,
-				 @{$hunk}[$ix+1..$#{$hunk}])) {
-			$newhunk->{DISPLAY} = [color_diff(@{$text})];
+				 @{$hunks}[$ix+1..$#{$hunks}])) {
+			$newhunk->{DISPLAY} = [color_diff(@{$newtext})];
 			return $newhunk;
 		}
 		else {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index e3150a4e07..4cc9517eda 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -552,7 +552,7 @@ test_expect_success 'add -p works with pathological context lines' '
 	test_cmp expected-1 actual
 '
 
-test_expect_failure 'add -p patch editing works with pathological context lines' '
+test_expect_success 'add -p patch editing works with pathological context lines' '
 	git reset &&
 	# n q q below is in case edit fails
 	printf "%s\n" e y    n q q |
-- 
2.16.2

