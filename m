Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AA6C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 22:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbiCaWnL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 18:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239631AbiCaWnK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 18:43:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241282156E4
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 15:41:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 067E9115663;
        Thu, 31 Mar 2022 18:41:22 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LAl4DuaJcsJf
        fiB0nlCmOZzrqbvjWEGHRf9gOUOnCYg=; b=V5ssBmsWf6KZE0zPy7bMIn1KzCf8
        926/Kd0N/MbWBK58Mt5HUpStwQs/ahsglFu4anZKSs+AOTwxZ373v4Ymh37ITnp9
        IjggqeNHHqVKYZZvJyP+bwwuIgc5Wf9tSxDESirXpqhQqbJqjCRhW7hswZqyNNcx
        StkjpXw72cL6g5U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9DDB115662;
        Thu, 31 Mar 2022 18:41:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 59340115660;
        Thu, 31 Mar 2022 18:41:21 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] branch.c: simplify advice-and-die sequence
Date:   Thu, 31 Mar 2022 15:41:18 -0700
Message-Id: <20220331224118.3014407-2-gitster@pobox.com>
X-Mailer: git-send-email 2.35.1-917-g7c4048624a
In-Reply-To: <20220331224118.3014407-1-gitster@pobox.com>
References: <xmqq7d89zqys.fsf@gitster.g>
 <20220331224118.3014407-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: AFE85480-B143-11EC-A0BB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

In the dwim_branch_start(), when we cannot find an appropriate
upstream, we will die with the same message anyway, whether we
issue an advice message.

Flip the code around a bit and simplify the flow using
advise_if_enabled() function.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 branch.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/branch.c b/branch.c
index 8ee9f43539..b673143cbe 100644
--- a/branch.c
+++ b/branch.c
@@ -383,13 +383,10 @@ static void dwim_branch_start(struct repository *r,=
 const char *start_name,
 	real_ref =3D NULL;
 	if (get_oid_mb(start_name, &oid)) {
 		if (explicit_tracking) {
-			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
-				int code =3D die_message(_(upstream_missing),
-						       start_name);
-				advise(_(upstream_advice));
-				exit(code);
-			}
-			die(_(upstream_missing), start_name);
+			int code =3D die_message(_(upstream_missing), start_name);
+			advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
+					  _(upstream_advice));
+			exit(code);
 		}
 		die(_("Not a valid object name: '%s'."), start_name);
 	}
--=20
2.35.1-917-g7c4048624a

