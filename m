Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE6AC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DF020C09
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="g9dhL6Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgIJRDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:03:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53474 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgIJRCd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 074297605D;
        Thu, 10 Sep 2020 13:02:14 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=Hp0YNOY8GAT7/AkLoLsHudX6+
        oE=; b=g9dhL6QgxY2WlJs8v5uxWVdzWG+wiEsrX04jye19GG+vndo778mLASxv5
        0uFrkW0TJ7BEe6IYXdJVkLLNmeqeHENIoh/FbVGVE5DmXKqNt5W0Am+/FcVqcYnq
        uITUE9i3CSvaO3qEsCxkri5lK6aHFmS1iMytJFw1sURW41UjSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=l9bS0M3fRWxxrTlVOgw
        NOwF/bX419umPhl4C5Dp61M8gQu0W3chzkmD/R/2VO2b5XXU2oY2lZIERLxlVKtf
        v7heY/y8qiaGc0QfvMXNYSXMHvW0rjYxevDEcAfS6cPLq9MQ8N45HqrEBwGPT96L
        J1DiwHUM34RU92wk3vj1KztA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3BF67605C;
        Thu, 10 Sep 2020 13:02:13 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FE4F7605A;
        Thu, 10 Sep 2020 13:02:13 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 5/7] wt-status: consistently quote paths in "status --short" output
Date:   Thu, 10 Sep 2020 10:01:57 -0700
Message-Id: <20200910170159.1278781-6-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5F6387B2-F387-11EA-8EFC-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tracked paths with SP in them were cquoted in "git status --short"
output, but untracked, ignored, and unmerged paths weren't.

The test was stolen from a patch to fix output for the 'untracked'
paths by brian m. carlson, with similar tests added for 'ignored'
ones.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7508-status.sh | 27 +++++++++++++++++++++++++++
 wt-status.c       |  4 ++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e81759319f..2e9c6daf1a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -814,6 +814,33 @@ test_expect_success 'status -s without relative path=
s' '
=20
 '
=20
+cat >expect <<\EOF
+ M dir1/modified
+A  dir2/added
+A  "file with spaces"
+?? dir1/untracked
+?? dir2/modified
+?? dir2/untracked
+?? "file with spaces 2"
+?? untracked
+EOF
+
+test_expect_success 'status -s without relative paths' '
+	test_when_finished "git rm --cached \"file with spaces\"; rm -f file*" =
&&
+	>"file with spaces" &&
+	>"file with spaces 2" &&
+	>"expect with spaces" &&
+	git add "file with spaces" &&
+
+	git status -s >output &&
+	test_cmp expect output &&
+
+	git status -s --ignored >output &&
+	grep "^!! \"expect with spaces\"$" output &&
+	grep -v "^!! " output >output-wo-ignored &&
+	test_cmp expect output-wo-ignored
+'
+
 test_expect_success 'dry-run of partial commit excluding new file in ind=
ex' '
 	cat >expect <<EOF &&
 On branch master
diff --git a/wt-status.c b/wt-status.c
index adbf6958bd..7139623025 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1848,7 +1848,7 @@ static void wt_shortstatus_unmerged(struct string_l=
ist_item *it,
 	} else {
 		struct strbuf onebuf =3D STRBUF_INIT;
 		const char *one;
-		one =3D quote_path(it->string, s->prefix, &onebuf, 0);
+		one =3D quote_path(it->string, s->prefix, &onebuf, QUOTE_PATH_QUOTE_SP=
);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
 	}
@@ -1896,7 +1896,7 @@ static void wt_shortstatus_other(struct string_list=
_item *it,
 	} else {
 		struct strbuf onebuf =3D STRBUF_INIT;
 		const char *one;
-		one =3D quote_path(it->string, s->prefix, &onebuf, 0);
+		one =3D quote_path(it->string, s->prefix, &onebuf, QUOTE_PATH_QUOTE_SP=
);
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
 		printf(" %s\n", one);
 		strbuf_release(&onebuf);
--=20
2.28.0-603-ga98dad7d4d

