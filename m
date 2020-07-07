Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD487C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919C1206E2
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 22:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GiKuvuIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGGWVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 18:21:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59600 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGGWVd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 18:21:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCCE262EF7;
        Tue,  7 Jul 2020 18:21:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UfetMmkfUpzs+Ew/c6G2kpJ0IuE=; b=GiKuvu
        IweNI/qbDaFW3vP3jy30axzG/lZfdYoi8xrXn1zmn8cOJWZJmjgWgu6+UENFVoKS
        8JiLk8zfaQtIo8LF4yUlDqXCzXtGuSvHhxmHpXEzNhxCesmZhcislWZ9QUFa//jV
        +DXXoAQKZJP1qkP7RQEEby1RjOUwC6+7dkT8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oSj4BxX6b+4G3a5cxp7W9Ci2GNURWGnn
        XNj2S4EPOIHRfCaR73dJ1jV4hG/rc2iLZs4MwvACaRChGKuagdIjYDDSc1I/kWQw
        dA0VO7U3llGrkPqVvjpPI0HhbjWph/I6gY/GjE8w9TBd2RSK45XbMjQmyDg0W3Po
        kbXwpj3CXa0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D595D62EF6;
        Tue,  7 Jul 2020 18:21:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A94D62EF3;
        Tue,  7 Jul 2020 18:21:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/4] ref-filter: add support for %(contents:size)
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-5-chriscool@tuxfamily.org>
Date:   Tue, 07 Jul 2020 15:21:29 -0700
In-Reply-To: <20200707174049.21714-5-chriscool@tuxfamily.org> (Christian
        Couder's message of "Tue, 7 Jul 2020 19:40:49 +0200")
Message-ID: <xmqqsge32cgm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34FD0670-C0A0-11EA-A25C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +		else if (atom->u.contents.option == C_LENGTH)
> +			v->s = xstrfmt("%ld", strlen(subpos));

Please squash something like this in.  32-bit builds are failing.

 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8ec28f0535..73d8bfa86d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1257,7 +1257,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
 		else if (atom->u.contents.option == C_LENGTH)
-			v->s = xstrfmt("%ld", strlen(subpos));
+			v->s = xstrfmt("%"PRIuMAX, (uintmax_t)strlen(subpos));
 		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
 		else if (atom->u.contents.option == C_SIG)
