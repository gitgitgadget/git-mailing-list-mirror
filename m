Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61BC20285
	for <e@80x24.org>; Thu, 24 Aug 2017 18:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753411AbdHXSyp (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 14:54:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60685 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752974AbdHXSyo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 14:54:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 217EDA8FFC;
        Thu, 24 Aug 2017 14:54:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Bg8LXpshI0j9
        IbSuLATJ2PDaFoc=; b=cbjB05VfcciyMT3gAEf68V0PBjPZAN4C6laeambJutdW
        8rs6Y72qaqviq/m0U58VNlXWKaK/VWE5Siqj3U1MI5dxYUWK3m62ZLm64FXs+TvO
        KkGO7Nrck/ZJR09glEK38PpzZVmyCsJ7goWnKvnfutSKYDldDktnFw9JGTsp038=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iIvF6C
        NSQbDd0XF8vQzENpPt42DHctUAtDzztFVnPSDiji/JYTZXw5IUtS6iU6juzdQlpK
        SiJaccC6/zVlBFMLAGxN4wgDZUwLk4N0I8eoTXqq4F6xLVaBZvbeFbkDrdA0AkOr
        un87k9tsoX33OR1eiB2aloSTjqg8dc0XjqPxI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1A137A8FFB;
        Thu, 24 Aug 2017 14:54:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86225A8FFA;
        Thu, 24 Aug 2017 14:54:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>, <peff@peff.net>
Subject: Re: [PATCH v3 2/4] imap-send: add wrapper to get server credentials if needed
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
        <9df045f4-71bd-92a1-20bb-4931e25b22c3@morey-chaisemartin.com>
        <xmqqtw0yxcsk.fsf@gitster.mtv.corp.google.com>
        <d1c39912-a847-1831-60ae-18b15359092f@morey-chaisemartin.com>
Date:   Thu, 24 Aug 2017 11:54:42 -0700
In-Reply-To: <d1c39912-a847-1831-60ae-18b15359092f@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Thu, 24 Aug 2017 08:08:31
        +0200")
Message-ID: <xmqqh8wwx0ct.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B0FDDB9C-88FD-11E7-A913-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> Le 23/08/2017 =C3=A0 22:13, Junio C Hamano a =C3=A9crit=C2=A0:
>> Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:
>>
>>> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin=
.com>
>>> ---
>>>  imap-send.c | 34 ++++++++++++++++++++--------------
>>>  1 file changed, 20 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/imap-send.c b/imap-send.c
>>> index 09f29ea95..448a4a0b3 100644
>>> --- a/imap-send.c
>>> +++ b/imap-send.c
>>> @@ -926,6 +926,25 @@ static int auth_cram_md5(struct imap_store *ctx,=
 struct imap_cmd *cmd, const cha
>>>  	return 0;
>>>  }
>>> =20
>>> +static void server_fill_credential(struct imap_server_conf *srvc, st=
ruct credential *cred)
>>> +{
>>> +	if (srvc->user && srvc->pass)
>>> +		return;
>>> +
>>> +	cred->protocol =3D xstrdup(srvc->use_ssl ? "imaps" : "imap");
>>> +	cred->host =3D xstrdup(srvc->host);
>>> +
>>> +	cred->username =3D xstrdup_or_null(srvc->user);
>>> +	cred->password =3D xstrdup_or_null(srvc->pass);
>>> +
>>> +	credential_fill(cred);
>>> +
>>> +	if (!srvc->user)
>>> +		srvc->user =3D xstrdup(cred->username);
>>> +	if (!srvc->pass)
>>> +		srvc->pass =3D xstrdup(cred->password);
>>> +}
>>> +
>> This looks straight-forward code movement.  The only thing that
>> makes me wonder is if this is "server".  The existing naming of the
>> variables screams at me that this is not "server" but is "service".
>
> I read srvc as server conf not service.

Oh, yeah, "server conf" is OK (I didn't think of it).

> But I can change the name if you prefer

Nah.  Please keep it.

