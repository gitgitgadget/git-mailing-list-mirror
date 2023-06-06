Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E198C7EE2F
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 21:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbjFFVra (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 17:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbjFFVr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 17:47:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7541E78
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 14:47:27 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 040001F505;
        Tue,  6 Jun 2023 17:47:27 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=oNfVVH81+QArO/rjzaPrpMufJ
        TsJ43/h/Z0VE33+ggk=; b=Rk58YS3R0/RMymAFLATGKTQTBCrXgiAB00evFdYVL
        oH6oL80r2otCr1MoGqCrqWAt+tmRwm04A4h/fhpj+IOjznQMSK3Q9Tuu3T+szqSr
        HiwGBw78GKC9zPHxorE68Nb0XPwVpF1gvCdMNGHJN//fnX1eAxKclwHfA0dLboKI
        b0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EFA2F1F504;
        Tue,  6 Jun 2023 17:47:26 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C25DE1F503;
        Tue,  6 Jun 2023 17:47:22 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] t/lib-gpg: require GPGSSH for GPGSSH_VERIFYTIME prereq
Date:   Tue,  6 Jun 2023 17:47:07 -0400
Message-ID: <20230606214707.55739-1-tmz@pobox.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <xmqqa5xjeqmm.fsf@gitster.g>
References: <xmqqa5xjeqmm.fsf@gitster.g>
MIME-Version: 1.0
X-Pobox-Relay-ID: B834D1E4-04B3-11EE-8EB1-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The GPGSSH_VERIFYTIME prequeq makes use of "${GNUPGHOME}" but does not
create it.  Require GPGSSH which creates the "${GNUPGHOME}" directory.

Additionally, it makes sense to require GPGSSH in GPGSSH_VERIFYTIME
because the latter builds on the former.  If we can't use GPGSSH,
there's little point in checking whether GPGSSH_VERIFYTIME is usable.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
Hi,

Junio C Hamano wrote:
>> Good idea. Perhaps:
>>
>>      test_lazy_prereq GPGSSH_VERIFYTIME '
>>              test_have_prereq GPGSSH &&
>>
>> is best there?  The GPGSSH prereq creates ${GNUPGHOME}.  It
>> may not be common, but there may be folks who want to run
>> the SSH tests and don't care about GPG.
>=20
> OK.  I'll certainly forget, so hold on to the patch and resend after
> the dust settles from the release.

Alright.  Here's that patch.  Hopefully it's not too dusty
where you are.  If so, I can re-send later. :)

Cheers,

Todd

 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 114785586a..db63aeb6ed 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -135,6 +135,7 @@ test_lazy_prereq GPGSSH '
 '
=20
 test_lazy_prereq GPGSSH_VERIFYTIME '
+	test_have_prereq GPGSSH &&
 	# Check if ssh-keygen has a verify-time option by passing an invalid da=
te to it
 	ssh-keygen -Overify-time=3DINVALID -Y check-novalidate -s doesnotmatter=
 2>&1 | grep -q -F "Invalid \"verify-time\"" &&
=20
--=20
2.41.0
