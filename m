Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DFFECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 16:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIOQLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIOQLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 12:11:15 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ED498763
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 09:11:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A88A71B05F1;
        Thu, 15 Sep 2022 12:07:12 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=0W+jEkKVwde3PwCB1WKy/Fx3F
        P7sPXgMr87T+NdenFI=; b=V06qVUfXDYoPGtvTl1xiHQmF4ia3aC70UFQGOr32X
        Jcp3zRs8Mbgb1yByD2y9hNT23g0MYNiNZV0rqqv+/hwTfiGjB3PKsFv0c7LNVeNp
        A/zpAvbEwHVe981Mt1GxlRIFjIuKPMC+FehgRFhvWyM824Ea94NQBeFrxeghT0m6
        pw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1BDD1B05ED;
        Thu, 15 Sep 2022 12:07:12 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A4401B05C8;
        Thu, 15 Sep 2022 12:07:08 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] environ: GIT_FLUSH should be made a usual Boolean
Date:   Thu, 15 Sep 2022 09:06:57 -0700
Message-Id: <20220915160659.126441-4-gitster@pobox.com>
X-Mailer: git-send-email 2.37.3-780-gd940517dcb
In-Reply-To: <20220915160659.126441-1-gitster@pobox.com>
References: <xmqq8rmkpsit.fsf@gitster.g>
 <20220915160659.126441-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 72F169A8-3510-11ED-97B3-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This uses atoi() and checks if the result is not zero to decide what
to do.  Turning it into the usual Boolean environment variable to
use git_env_bool() would not break those who have been using "set to
0, or set to non-zero, that can be parsed with atoi()" values, but
will match the expectation of those who expected "true" to mean
"yes".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt | 1 +
 write-or-die.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index e2f61a1ec8..3d31252bf2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -722,6 +722,7 @@ for further details.
 	waiting for someone with sufficient permissions to fix it.
=20
 `GIT_FLUSH`::
+// NEEDSWORK: make it into a usual Boolean environment variable
 	If this environment variable is set to "1", then commands such
 	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
 	'git check-attr' and 'git check-ignore' will
diff --git a/write-or-die.c b/write-or-die.c
index c4fd91b5b4..aaa0318e82 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -23,6 +23,7 @@ void maybe_flush_or_die(FILE *f, const char *desc)
=20
 	if (f =3D=3D stdout) {
 		if (skip_stdout_flush < 0) {
+			/* NEEDSWORK: make this a normal Boolean */
 			cp =3D getenv("GIT_FLUSH");
 			if (cp)
 				skip_stdout_flush =3D (atoi(cp) =3D=3D 0);
--=20
2.37.3-780-gd940517dcb

