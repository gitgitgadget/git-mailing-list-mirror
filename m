Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0A4C2BC11
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D002098B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uvyV0io6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgIHUwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:52:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53369 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbgIHUwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 16:52:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CF4EEEE6D;
        Tue,  8 Sep 2020 16:52:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=+JoYfFsHRaiaMsZ1BVZlD24Ke
        5s=; b=uvyV0io69QTOwgPd5V3BtAVo7gYZYcAViVZ25IlLzQBvlXGUsFTpgpL7b
        bIgQ/mN/tiUHIAitfY064maYgoVY4YwatGtiyMkKElOaPOVrbPtxV4FSzRd/6pY4
        Rg4le7Y84qtIVPXFQg4Gufn0h09uXHftt/i5sCCevQqt2nVvvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=vUzlu+QIbAs8KqKd/Lc
        9swUH+ZY7w/7M9YBHbuS2Ljn6JyLANbF/fdZOr8hdWxcPYqjA8JcQe/ZqGvh22b3
        Hi4/Q85PskZMylp4kJHh5aUs5wM5VC/EzXS5h4iWnubyCBHL5f4Z8WRGlkQkreFd
        DWxVk/iGAZ5wAVKYnE7DWVDM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1666EEEE6C;
        Tue,  8 Sep 2020 16:52:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56F41EEE6B;
        Tue,  8 Sep 2020 16:52:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] wt-status: consistently quote paths in "status --short" output
Date:   Tue,  8 Sep 2020 13:52:22 -0700
Message-Id: <20200908205224.4126551-5-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-539-g66371d8995
In-Reply-To: <20200908205224.4126551-1-gitster@pobox.com>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 3744CE3A-F215-11EA-ABF1-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tracked paths with SP in them were c-quoted in "git status --short"
output, but untracked, ignored, and unmerged paths weren't.  Treat
them the same way for consistency.

The test was stolen from a patch to fix output for the 'untracked'
paths by brian m. carlson.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7508-status.sh | 21 +++++++++++++++++++++
 wt-status.c       |  4 ++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e81759319f..ef8d19c151 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -814,6 +814,27 @@ test_expect_success 'status -s without relative path=
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
+	git add "file with spaces" &&
+	git status -s >output &&
+	test_cmp expect output
+
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
2.28.0-539-g66371d8995

