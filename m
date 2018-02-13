Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3FB91F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934237AbeBMKod (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:44:33 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:44098 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934031AbeBMKoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:44:23 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lY4NeT0Dyr5N9lY4UeMF1g; Tue, 13 Feb 2018 10:44:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518518662;
        bh=D1K7PeCUFP5pTlRjtiRvNLTj1yMbH6hAkTZ6gQ+/PtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=bxs6tZoXdabptPlG70WJV8uCpu5CfOmVgVD3bwpvleV7PdsuJ3MzFzFXjzS2blQJS
         nilWrRdNVJYS6u3lNOpxJPHwYyYWI4i/JcR0sSP8ft9nbtkuOZrXhWIbBn1Xp5S7Mk
         U855IVXZv/FEvVlI24LTRZPK9PtSOT2JcrHgPQvg=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=oZ4-CATJh8xiw80YYYkA:9
 a=gLAPGeZHsaOxALxc:21 a=6VszVuB5Kd0x5fGZ:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 2/4] t3701: add failing test for pathological context lines
Date:   Tue, 13 Feb 2018 10:44:06 +0000
Message-Id: <20180213104408.9887-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213104408.9887-1-phillip.wood@talktalk.net>
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfNR7JzisyBvKFCCUs+CWAowm/8Qlu+xMInVfO06ruI+gIqOxIhN6CHZuFevq4Hxl+10DNmuQ6YON+04wIleXylaoQGXRR+VPvb+lGgYyVWOzcC334AUJ
 wNe7YPoy7diynSK3ueaSQvdR5SAugwE4iIrwpxe9eThNKHdW2xKn4NOwzZZ3AICGJjSkG8YA2JsMLav9HO9w1v94wcQaF0+tXUkqLKaJS92bcGABnC9VhGs9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a hunk is skipped by add -i the offsets of subsequent hunks are
not adjusted to account for any missing insertions due to the skipped
hunk. Most of the time this does not matter as apply uses the context
lines to apply the subsequent hunks in the correct place, however in
pathological cases the context lines will match at the now incorrect
offset and the hunk will be applied in the wrong place. The offsets of
hunks following an edited hunk that has had the number of insertions
or deletions changed also need to be updated in the same way. Add
failing tests to demonstrate this.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3701-add-interactive.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 058698df6a4a9811b9db84fb5900472c47c61798..6838698a1382b24724cfbd3be04a7054489b94af 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -541,4 +541,34 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	! grep dirty-otherwise output
 '
 
+test_expect_success 'set up pathological context' '
+	git reset --hard &&
+	test_write_lines a a a a a a a a a a a >a &&
+	git add a &&
+	git commit -m a &&
+	test_write_lines c b a a a a a a a b a a a a >a &&
+	test_write_lines     a a a a a a a b a a a a >expected-1 &&
+	test_write_lines   b a a a a a a a b a a a a >expected-2 &&
+	write_script editor <<-\EOF
+	sed /^+c/d "$1" >"$1.tmp"
+	mv "$1.tmp" "$1"
+	EOF
+'
+
+test_expect_failure 'add -p works with pathological context lines' '
+	git reset &&
+	printf "%s\n" n y |
+	git add -p &&
+	git cat-file blob :a > actual &&
+	test_cmp expected-1 actual
+'
+
+test_expect_failure 'add -p patch editing works with pathological context lines' '
+	git reset &&
+	printf "%s\n" e y |
+	GIT_EDITOR=./editor git add -p &&
+	git cat-file blob :a > actual &&
+	test_cmp expected-2 actual
+'
+
 test_done
-- 
2.16.1

