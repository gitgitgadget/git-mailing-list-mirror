Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8EBC8300B
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 04:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA11206F0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 04:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iRjEJJiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD2EgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:36:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51294 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgD2EgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 00:36:04 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30B85505F7;
        Wed, 29 Apr 2020 00:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/UfTEvlumfnW
        TvHcfF6rvfjQcI8=; b=iRjEJJiuznyO25QCZIDAj5pS70rl9hiebUxq8+FwWRBq
        yTUdHcJVeUG4GmmHSSqY+sdq1fbmWuFw7Y7LZSnjYNTtKzYwsiAQu9JdKPjvNOFq
        p8WC+Wzlp8C0XkJXtE0yYzLXD1mW06OBmjLrxpVJnk+O9G5cWzOrgIsQjtmA2Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XjU7/m
        U+33acprj9OCKusSJKMQezflvCr4CYt5g+RBIFJ2j+jCfYPVsSMU//LV5/DJ2CXR
        jb6hC5QlnJj9yBeUO1vfVMAU4vIrMPxNbkLNhEXTm7VUeT24N1J6yEbF3NOMBzIk
        b3SpItwdMCGpeg1F4YTJo+YZMSiKdsyFmvD2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 19AE9505F4;
        Wed, 29 Apr 2020 00:36:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64BF0505F1;
        Wed, 29 Apr 2020 00:36:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, dirk@ed4u.de, sunshine@sunshineco.com,
        peff@peff.net, jrnieder@gmail.com
Subject: Re: [PATCH v5] credential-store: warn instead of fatal for bogus lines from store
References: <20200428104858.28573-1-carenas@gmail.com>
        <20200429003303.93583-1-carenas@gmail.com>
Date:   Tue, 28 Apr 2020 21:36:00 -0700
In-Reply-To: <20200429003303.93583-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Tue, 28 Apr 2020 17:33:03 -0700")
Message-ID: <xmqqd07qzz67.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EDDBC35C-89D2-11EA-8AD1-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> +static char *redact_credential(const struct strbuf *line)
> +{
> +	struct strbuf redacted_line =3D STRBUF_INIT;
> +	char *at =3D strchr(line->buf, '@');
> +	char *colon;
> +	int redacted =3D 0;
> +
> +	if (at) {
> +		strbuf_addf(&redacted_line, "%.*s",
> +			(int)(at - line->buf), line->buf);
> +		colon =3D strrchr(redacted_line.buf, ':');

Just showing my ignorance, but ...

 - Is the above strrchr() that forbids a colon in the password
   intended, or should it be strchr() that only forbids a colon in
   the username instead?

 - Would it hurt to redact both username and password as sensitive?
   If not, it would certainly make it simpler to unconditionally:

                int i;
                for (i =3D 0; i < redacted_line.len; i++) {
                        if (redacted_line.buf[i] !=3D ':')
                                redacted_line.buf[i] =3D 'x';
                }

