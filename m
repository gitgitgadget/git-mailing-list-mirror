Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35631FE4E
	for <e@80x24.org>; Tue, 12 Jul 2016 17:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbcGLRQP (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 13:16:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbcGLRQP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2016 13:16:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7A81292AA;
	Tue, 12 Jul 2016 13:16:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L12rv9Hq0nBn
	zZRaHkKPOD1Q4Jg=; b=qFImW5YJsT7jbmr1UF7ZvktgiDMeVAg/1pa4QVP+Hnyy
	O3OjtfPGI5gk8+o71Jsyz2exIg40b+lERYuGGj5UFHI82+JH5BRs4eAh+WewjG02
	460CvmgkoQA1KTEN25hrZS70PfoxIlAQo8xBv9yXh7RXLd5J54foe+Qqo2NJjQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=edGxuz
	B8k4NxLSsckQ31hE8WqTGCXscLeK9eO4sBzQpr8FakXqzhNHYU79O1t2g1l+cS7W
	QUCMMORvTkT0KDADhQtJrv3wacRtPKn3MbpnCjRM7nuoUcXuGcDKtoKYKG+ZND7D
	y+RhkUUZBMEnuEu/X8MfKk9r3aAw+Qn1HwyMQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8BED292A9;
	Tue, 12 Jul 2016 13:16:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C397292A8;
	Tue, 12 Jul 2016 13:16:13 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, michelbach94@gmail.com
Subject: Re: [PATCH 1/5] pack-objects: pass length to check_pack_crc() without truncation
References: <1466807902.28869.8.camel@gmail.com>
	<20160705170558.10906-1-pclouds@gmail.com>
	<20160705170558.10906-2-pclouds@gmail.com>
Date:	Tue, 12 Jul 2016 10:16:11 -0700
In-Reply-To: <20160705170558.10906-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Tue, 5 Jul 2016 19:05:54 +0200")
Message-ID: <xmqqoa626alg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 55ACEB24-4854-11E6-BB98-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 8f5e358..df6ecd5 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -349,7 +349,7 @@ static unsigned long write_reuse_object(struct sha1file *f, struct object_entry
>  	struct revindex_entry *revidx;
>  	off_t offset;
>  	enum object_type type = entry->type;
> -	unsigned long datalen;
> +	off_t datalen;
>  	unsigned char header[10], dheader[10];
>  	unsigned hdrlen;
>  
> diff --git a/sha1_file.c b/sha1_file.c
> index d5e1121..cb571ac 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2281,7 +2281,7 @@ void *unpack_entry(struct packed_git *p, off_t obj_offset,
>  
>  		if (do_check_packed_object_crc && p->index_version > 1) {
>  			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
> -			unsigned long len = revidx[1].offset - obj_offset;
> +			off_t len = revidx[1].offset - obj_offset;
>  			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) 

It is sad that check_pack_crc() already knew to take off_t here and
we (unknowingly) had a deliberate truncation by using ulong.
Looks obvioiusly correct.

Thanks.

{
>  				const unsigned char *sha1 =
>  					nth_packed_object_sha1(p, revidx->nr);
