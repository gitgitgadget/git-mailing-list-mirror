Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38178C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68522176B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 06:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Kv/shuSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgIYGIv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:08:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64255 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgIYGIv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 02:08:51 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 02:08:49 EDT
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 55720E7202;
        Fri, 25 Sep 2020 02:00:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=yVISqNAIJXMkPScMnP4tGx6mM
        ek=; b=Kv/shuSl8EPgpUfVMa1pj65VJ6W/htEI+R6wqjayeqClBRjf1Fd5lsZ8H
        l5it5wQ6ZcdI4S68KczxmOebK5SZmaZOOlYRloH/WWi+ETBibNEowsz26WXY/igO
        ctu7NR6nDoAh2ERj9kzLuqexRmjHMCQiXURK4Fds6QrIjOR/nU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=dRQepsOIRH2ptHjvL5z
        MaUZ3mVf2JuSd5GHGkKOKkP5cVFaBRe0R5fLDglosapDtcePeDnI6N0Mg/nt5txH
        MgRvwhkbfDHQhZtwH0jVMPK48yzM5wH+prrlqJZbn7dE9CCFOKVsvS5Pw9DKNQ6E
        e01nF3zaxybpIUC/Q9+ai2+g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E01BE7201;
        Fri, 25 Sep 2020 02:00:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 780C6E71F3;
        Fri, 25 Sep 2020 02:00:04 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] t1506: rev-parse A..B and A...B
Date:   Thu, 24 Sep 2020 22:59:53 -0700
Message-Id: <20200925055954.1111389-4-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-718-gd8d5e3da39
In-Reply-To: <20200925055954.1111389-1-gitster@pobox.com>
References: <20200925055954.1111389-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5B46B97E-FEF4-11EA-8AEC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because these constructs can be used to parse user input to be
passed to rev-list --objects, e.g.

	range=3D$(git rev-parse v1.0..v2.0) &&
	git rev-list --objects $range | git pack-objects --stdin

the endpoints (v1.0 and v2.0 in the example) are shown without
peeling them to underlying commits, even when they are annotated
tags.  Make sure it stays that way.

While at it, ensure "rev-parse A...B" also keeps the endpoints A and
B unpeeled, even though the negative side (i.e. the merge-base
between A and B) has to become a commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1506-rev-parse-diagnosis.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis=
.sh
index dbf690b9c1..3e657e693b 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -190,6 +190,24 @@ test_expect_success 'dotdot is not an empty set' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'dotdot does not peel endpoints' '
+	git tag -a -m "annote" annotated HEAD &&
+	A=3D$(git rev-parse annotated) &&
+	H=3D$(git rev-parse annotated^0) &&
+	{
+		echo $A && echo ^$A
+	} >expect-with-two-dots &&
+	{
+		echo $A && echo $A && echo ^$H
+	} >expect-with-merge-base &&
+
+	git rev-parse annotated..annotated >actual-with-two-dots &&
+	test_cmp expect-with-two-dots actual-with-two-dots &&
+
+	git rev-parse annotated...annotated >actual-with-merge-base &&
+	test_cmp expect-with-merge-base actual-with-merge-base
+'
+
 test_expect_success 'arg before dashdash must be a revision (missing)' '
 	test_must_fail git rev-parse foobar -- 2>stderr &&
 	test_i18ngrep "bad revision" stderr
--=20
2.28.0-718-gd8d5e3da39

