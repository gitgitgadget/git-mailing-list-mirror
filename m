Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7F941F576
	for <e@80x24.org>; Tue, 27 Feb 2018 11:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752869AbeB0LEm (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 06:04:42 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:60020 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbeB0LE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 06:04:28 -0500
Received: from lindisfarne.localdomain ([89.242.176.20])
        by smtp.talktalk.net with SMTP
        id qd3QeQ4WdoNnDqd3aeXd10; Tue, 27 Feb 2018 11:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1519729466;
        bh=jovQExjUJ0wMJnwmRLoq93hApzVv5KVkxI9rBAx5Qjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=bjUMggba1208FcKI1xaraH7maZ8vlqnDuXg8tv18RLFOSNWgpQBmkT+RN0XsIgG6M
         lM5iZqIh0vVLShcpZniR5hXiq2JM/IiIif7Z205FGjtggO3PBF13X17t45sHNvr5F7
         po0tT4mveh3OKxRNOS+SLfP617ytJWrF0zPeo/VY=
X-Originating-IP: [89.242.176.20]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZZ9tDodA c=1 sm=1 tr=0 a=BZXIa/HMvEOrkAULb1ciZg==:117
 a=BZXIa/HMvEOrkAULb1ciZg==:17 a=evINK-nbAAAA:8 a=Vi1R3C_QCdLrTvDhwxkA:9
 a=6YDPZE5VyCnXASPI:21 a=qNE3FlwjLGDp7qyu:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v3 6/9] add -p: Adjust offsets of subsequent hunks when one is skipped
Date:   Tue, 27 Feb 2018 11:04:01 +0000
Message-Id: <20180227110404.16816-7-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180227110404.16816-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
 <20180227110404.16816-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfK0t3wZtx8x4mg/CuvfWOMZZ93gNhU3xqHdacWn1o+FYN7JmDen3+N104iIHOx0+d0tJA8cGuYBFT6P2YN9Kv260PLxASMb6qv85jKSsojEOkzo1NSdS
 GYMpWBqfulXRMSYsifKqSH1TlPzplfHjKlWUDTP+F2kW1ocgENizNvKnq0B/nC5AvtWjmrkAnTQ7rRc0+cOsQsLjAEFhBybbRlVfU1CiAy2JI9o7WYU1lyGl
 jS3HLmKfCV1/mqZNn4JN3A2u0YcV5s1NA6PqsBN2vVmgYAvKVqXJjIMmgiIfiNEOnqfw99M+BL1gq234PefyCE3+YX/c8eNVdL16FilEuA8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since commit 8cbd431082 ("git-add--interactive: replace hunk
recounting with apply --recount", 2008-7-2) if a hunk is skipped then
we rely on the context lines to apply subsequent hunks in the right
place. While this works most of the time it is possible for hunks to
end up being applied in the wrong place. To fix this adjust the offset
of subsequent hunks to correct for any change in the number of
insertions or deletions due to the skipped hunk. The change in offset
due to edited hunks that have the number of insertions or deletions
changed is ignored here, it will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl  | 15 +++++++++++++--
 t/t3701-add-interactive.sh |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8ababa6453..7a0a5896bb 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -926,14 +926,25 @@ sub coalesce_overlapping_hunks {
 	my @out = ();
 
 	my ($last_o_ctx, $last_was_dirty);
+	my $ofs_delta = 0;
 
-	for (grep { $_->{USE} } @in) {
+	for (@in) {
 		if ($_->{TYPE} ne 'hunk') {
 			push @out, $_;
 			next;
 		}
 		my $text = $_->{TEXT};
-		my ($o_ofs) = parse_hunk_header($text->[0]);
+		my ($o_ofs, $o_cnt, $n_ofs, $n_cnt) =
+						parse_hunk_header($text->[0]);
+		unless ($_->{USE}) {
+			$ofs_delta += $o_cnt - $n_cnt;
+			next;
+		}
+		if ($ofs_delta) {
+			$n_ofs += $ofs_delta;
+			$_->{TEXT}->[0] = format_hunk_header($o_ofs, $o_cnt,
+							     $n_ofs, $n_cnt);
+		}
 		if (defined $last_o_ctx &&
 		    $o_ofs <= $last_o_ctx &&
 		    !$_->{DIRTY} &&
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index da73fbdf4d..4c30aa6b6e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -541,7 +541,7 @@ test_expect_success 'set up pathological context' '
 	test_write_lines +b " a" >patch
 '
 
-test_expect_failure 'add -p works with pathological context lines' '
+test_expect_success 'add -p works with pathological context lines' '
 	git reset &&
 	printf "%s\n" n y |
 	git add -p &&
-- 
2.16.1

