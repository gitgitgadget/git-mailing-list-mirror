Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BEC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 23:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8B622207
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 23:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WX8u7XA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgIPXoi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:44:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65171 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPXog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 19:44:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1031E7E50;
        Wed, 16 Sep 2020 19:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8RcWXMOqi9CrveI/w4PkpuNbipY=; b=WX8u7X
        A4QeQv8SRr5YHCpJ7kJTnsKfevZFmu+Bz9Jaj30HdaBy1yUTTeocVV5YnKNX5qz/
        85I3O9qb4Zp1xDMb6LJMeFI4iFUj9c2nhyA3o0yGWB+4/OT8PnliVKR/FDn+7Sq6
        xOmtxgLhvfYDTAchYhOLMhpvbbm2JdzQLde28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yaw7X2pfpXOxAUiAl3Dt46LOIdBIg/B1
        OJ2WqSCwMamzWpPVPzqHLsAmC7sDR3mncKoKld+tmPB2/eg5P/cfbp/QK1Nl4Hrs
        VMGBXJc6xMaIS1kO+o7Z5pMhxXbHmCIx86/zI/Pkzn/b0im6xc583zgRmH/xVkEc
        WlbiZxsy/8M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 997ABE7E4F;
        Wed, 16 Sep 2020 19:44:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E2A4EE7E4E;
        Wed, 16 Sep 2020 19:44:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 2/2] send-pack: check atomic push before running GPG
References: <20200916114958.1123-1-worldhello.net@gmail.com>
Date:   Wed, 16 Sep 2020 16:44:28 -0700
In-Reply-To: <20200916114958.1123-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Wed, 16 Sep 2020 07:49:58 -0400")
Message-ID: <xmqqv9gdthgj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90537B5E-F876-11EA-B6E4-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> In the original "Finally, tell the other end" block, the function
> `check_to_send_update()` is also called for non-PGP-signed push.
> The 'ref->status' changed by the "Clear the status" block won't 
> make any difference for the return value of the function
> `check_to_send_update()`. Refs even with status REF_STATUS_OK and
> REF_STATUS_EXPECTING_REPORT will be sent to the server side.

Ah, yes, I re-read the code in check_to_send_update() and you're
right that it does the right thing.  I however strongly suspect it
just happens to do the right thing by accident and not by design.

I'd prefer to see a bit more tightening done to the function to
clarify the handling of these two values that are omitted from the
case arms in the switch statement, perhaps like this, as a
preliminary clean-up.

As a further clean-up, we probably should stop relying on the 'default'
label.  

There are other REF_STATUS values that are not handled explicitly,
among which REF_STATUS_ATOMIC_PUSH_FAILED looks like the most
troublesome one.

The function will return 0 (success) for ATOMIC_PUSH_FAILED, but the
current ordering of the codeflow makes sure check_to_send_update()
is *not* called after ref->status is turned into that value and that
would be the only thing that may be ensuring the correctness.  There
may be other ones we are not handling quite right.




 send-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/send-pack.c b/send-pack.c
index 632f1580ca..347fb15633 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -244,7 +244,12 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
 		return CHECK_REF_UPTODATE;
+
 	default:
+	case REF_STATUS_EXPECTING_REPORT:
+		/* already passed checks on the local side */
+	case REF_STATUS_OK:
+		/* of course this is OK */
 		return 0;
 	}
 }
