Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE893208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 20:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbdHOUs6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 16:48:58 -0400
Received: from planetterror.mr.itd.umich.edu ([141.211.125.114]:52462 "EHLO
        planetterror.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752154AbdHOUs5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Aug 2017 16:48:57 -0400
X-Greylist: delayed 790 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Aug 2017 16:48:57 EDT
Received: FROM maleficent.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.125.12])
        By planetterror.mr.itd.umich.edu ID 59935B23.C1F64.12881;
        Tue, 15 Aug 2017 16:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1502829346;
        bh=uLLO87wH+63Z4Z9X5hLNLtl+Tl25M04EnnCuL0VUmkY=;
        h=From:To:Cc:Subject:Date;
        b=L3ZkjSMfQve9z9NHrlokCIGZT57sXqB1iujOuebtEKmiuVMZboF7HgyfI685YNdcO
         266e7lp6H2Ma1GEqB15jkP20Hh15J28UxLDBDjfA3D/su/7nG0A28EymVGKh9JU1m/
         vLLe4OwOt9Nr56GVIQTkFZiyoCgyRuuTVlai+ZydFWcdR9SncMrW3zHY1b83Vc1ogT
         mvO3xAPEZycj05edeApGOW4zvUq9WjoHS2Hzn9+l+la3cPwNn1rRb8MCGeTsIcg3YR
         otK4fw2WFwkiYeMJK3mjbQH0xCaYwn14NgIOrrcNS4fZA79mCGU7pKiKs2sJkGC46C
         KSRJ9lYhszbHQ==
Authentication-Results: maleficent.mr.itd.umich.edu;
        iprev=pass policy.iprev=99.231.24.59 (CPEe03f496bc050-CM1cabc0a3e3c0.cpe.net.cable.rogers.com);
        auth=pass smtp.auth=asottile
Received: FROM localhost.localdomain (CPEe03f496bc050-CM1cabc0a3e3c0.cpe.net.cable.rogers.com [99.231.24.59])
        By maleficent.mr.itd.umich.edu ID 59935B21.CBD13.20669;
        Authuser asottile;
        Tue, 15 Aug 2017 16:35:45 -0400
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH/RFC] git-grep: correct exit code with --quiet and -L
Date:   Tue, 15 Aug 2017 13:35:03 -0700
Message-Id: <20170815203503.12299-1-asottile@umich.edu>
X-Mailer: git-send-email 2.14.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The handling of `status_only` no longer interferes with the handling of
`unmatch_name_only`.  `--quiet` no longer affects the exit code when using
`-L`/`--files-without-match`.

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 grep.c          | 9 +++++----
 t/t7810-grep.sh | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 2efec0e..a893d09 100644
--- a/grep.c
+++ b/grep.c
@@ -1755,7 +1755,7 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 		}
 		if (hit) {
 			count++;
-			if (opt->status_only)
+			if (!opt->unmatch_name_only && opt->status_only)
 				return 1;
 			if (opt->name_only) {
 				show_name(opt, gs->name);
@@ -1820,13 +1820,14 @@ static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int colle
 	if (collect_hits)
 		return 0;
 
-	if (opt->status_only)
-		return 0;
 	if (opt->unmatch_name_only) {
 		/* We did not see any hit, so we want to show this */
-		show_name(opt, gs->name);
+		if (!opt->status_only)
+			show_name(opt, gs->name);
 		return 1;
 	}
+	if (opt->status_only)
+		return 0;
 
 	xdiff_clear_find_func(&xecfg);
 	opt->priv = NULL;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f106387..2a6679c 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -374,6 +374,11 @@ test_expect_success 'grep -L -C' '
 	test_cmp expected actual
 '
 
+test_expect_success 'grep --files-without-match --quiet' '
+	git grep --files-without-match --quiet nonexistent_string >actual &&
+	test_cmp /dev/null actual
+'
+
 cat >expected <<EOF
 file:foo mmap bar_mmap
 EOF
-- 
2.14.GIT

