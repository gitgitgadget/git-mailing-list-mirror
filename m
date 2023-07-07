Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AB5EB64DA
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 22:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjGGWKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGGWK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 18:10:29 -0400
X-Greylist: delayed 324 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 15:10:26 PDT
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7091BE1
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 15:10:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1698029ECA;
        Fri,  7 Jul 2023 18:05:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=QpLjiHCGHUgPCqRorDaVTDn0g
        M9/vFOGyJLmTEBuCyk=; b=c6H5QuXR46XBObJSXLniCtKQatqHSjMe84W0L+kDB
        JOPFyvbGqVEHSZvxVbelbiGyBvGqdQSs/B/olhgm10k+a0h8gdQlFkAX1JXxFSQK
        PHdc6P0pnLEWbYdt688bOEFHK21XtizmIbCDIOOckGGQBRZbXJSRE10Rker1x+Vb
        Dw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0DE5429EC9;
        Fri,  7 Jul 2023 18:05:07 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7D03529EC2;
        Fri,  7 Jul 2023 18:05:02 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] t6135: attr magic with path pattern
Date:   Fri,  7 Jul 2023 15:04:56 -0700
Message-ID: <20230707220457.3655121-2-gitster@pobox.com>
X-Mailer: git-send-email 2.41.0-318-g061c58647e
In-Reply-To: <20230707220457.3655121-1-gitster@pobox.com>
References: <20230707220457.3655121-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5277849C-1D12-11EE-AA7D-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test coverage on attribute magic combined with path pattern
was a bit thin.  Let's add a few and make sure "(attr:X)sub" and
"(attr:X)sub/" behave the same.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6135-pathspec-with-attrs.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs=
.sh
index 457cc167c7..f63774094f 100755
--- a/t/t6135-pathspec-with-attrs.sh
+++ b/t/t6135-pathspec-with-attrs.sh
@@ -78,7 +78,17 @@ test_expect_success 'check specific set attr' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'check specific set attr (2)' '
+test_expect_success 'check set attr with pathspec pattern' '
+	echo sub/fileSetLabel >expect &&
+
+	git ls-files ":(attr:label)sub" >actual &&
+	test_cmp expect actual &&
+
+	git ls-files ":(attr:label)sub/" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check specific set attr in tree-ish' '
 	cat <<-\EOF >expect &&
 	HEAD:fileSetLabel
 	HEAD:sub/fileSetLabel
@@ -87,6 +97,16 @@ test_expect_success 'check specific set attr (2)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'check specific set attr with pathspec pattern in tr=
ee-ish' '
+	echo HEAD:sub/fileSetLabel >expect &&
+
+	git grep -l content HEAD ":(attr:label)sub" >actual &&
+	test_cmp expect actual &&
+
+	git grep -l content HEAD ":(attr:label)sub/" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'check specific unset attr' '
 	cat <<-\EOF >expect &&
 	fileUnsetLabel
--=20
2.41.0-318-g061c58647e

