Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C78C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF40206D4
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 16:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fsfXHVgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgKDQXY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:23:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55521 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKDQXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 11:23:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC5B1A1AE7;
        Wed,  4 Nov 2020 11:23:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=25CoKAws7cmo
        ZYzUxTVVWzWZ5q4=; b=fsfXHVgUUZcLBs+dH15w/hz8sLklw2gzR/BmOvjobxSi
        AcIgxyWS8cURb7Ajlf2zMJMvdBSFhZE6sFYlDIkad5zRGHEImmDEh+wVEfg3oblo
        tSOcRN6OhOwJkoZzuOeEqMCb2bkM6ikbfhzigtiQttws16J3uvu+WsPKkre+FIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=T7Odmo
        u47xPsi7jFgnc7AIUYaBJc3G9jHGtZXtogDZXecITyBPlQS35cvuIJ33MhwI2nC2
        mVzi5BbCN66N71jCZn6WGJjykqicSXxBtmNAdpqe9UoWDpviYtY7c8hVTKaZto7+
        JmjVpxNS9hkl5XeSS9GsW20JcCG7WvRWL9rXs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0476A1AE6;
        Wed,  4 Nov 2020 11:23:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C5E1A1AE5;
        Wed,  4 Nov 2020 11:23:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] pack-write: use hashwrite_be32() instead of
 double-buffering array
References: <aec69531-d621-ab26-efd4-96e1ae0ed3a4@web.de>
        <20201104133653.GC3030480@coredump.intra.peff.net>
Date:   Wed, 04 Nov 2020 08:23:22 -0800
In-Reply-To: <20201104133653.GC3030480@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 4 Nov 2020 08:36:53 -0500")
Message-ID: <xmqqmtzxnlad.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F3C8A3C-1EBA-11EB-839E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Nov 01, 2020 at 09:52:12AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> hashwrite() already buffers writes, so pass the fanout table entries
>> individually via hashwrite_be32(), which also does the endianess
>> conversion for us.  This avoids a memory copy, shortens the code and
>> reduces the number of magic numbers.
>
> Yep, this seems trivially correct. The key observation is that we are
> filling the array in order:
>
>> @@ -101,20 +100,19 @@ const char *write_idx_file(const char *index_nam=
e, struct pack_idx_entry **objec
>>  	for (i =3D 0; i < 256; i++) {
>>  		struct pack_idx_entry **next =3D list;
>>  		while (next < last) {
>>  			struct pack_idx_entry *obj =3D *next;
>>  			if (obj->oid.hash[0] !=3D i)
>>  				break;
>>  			next++;
>>  		}
>> -		array[i] =3D htonl(next - sorted_by_sha);
>> +		hashwrite_be32(f, next - sorted_by_sha);
>>  		list =3D next;
>>  	}
>> -	hashwrite(f, array, 256 * 4);
>
> Perhaps obvious, but I got bit trying to do another similar conversion
> recently that was filling in the array out-of-order...

Yeah, filling an array out of order and then writing the result in
order would obviously different from writing out individual pieces
in the order the original codeflow used to fill the array.  Worse,
the order the data items are fed to hashwrite() obviously affects
the hash computed at the end.  An example of too much abstraction
biting us? ;-)


