Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A11C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 07:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350899AbiDOHN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 03:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243432AbiDOHNY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 03:13:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C33E36B4D
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 00:10:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09E07184035;
        Fri, 15 Apr 2022 03:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UHfm9CKFrktw
        nocu7XICerbMgasOL7p/PzIg6ECPGCI=; b=yPoMcdDXqJk87j71J5XseBH20QPN
        mODJpNtFye5Nciy19dvtp3wTXcFUGeKDkGVniZzQHQqi1dLFASaGpaw3+OWfL0kD
        UbudYVfXfu9gmJenzXp3+LiFUtnnOWYARANjSpytn3cRiBu4hinnat8YlyJg46cc
        tdtM+K7tILpnS3k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 02A92184034;
        Fri, 15 Apr 2022 03:10:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8485D184033;
        Fri, 15 Apr 2022 03:10:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH] reftable: avoid undefined behaviour breaking t0032
References: <20220415070236.25280-1-carenas@gmail.com>
Date:   Fri, 15 Apr 2022 00:10:51 -0700
In-Reply-To: <20220415070236.25280-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Fri, 15 Apr 2022 00:02:36 -0700")
Message-ID: <xmqq8rs6g6tg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2F885CF6-BC8B-11EC-92AF-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> At least in glibc based systems, memset with a NULL first parameter
> will cause a runtime exception.

I take it to mean that the code assumes that it is OK to pass NULL
as long as length is 0 (i.e. filling the range of memory whose size
is 0 with the specified byte can happen safely no matter what the
starting address of that range is, as size=3D=3D0 by definition should
mean a no-op).  That would mean we have a rule on how members of
dest must be set: .data is allowed to be NULL only when .len is 0.

If so, I wonder if we want to guard with dest->len instead, i.e.

	if (dest->len)
		memset(dest->data, 0xff, dest->len);

With the form in this patch, i.e.

> -	memset(dest->data, 0xff, dest->len);
> +	if (dest->data)
> +		memset(dest->data, 0xff, dest->len);

we will fail to catch a bogus caller that violates the rule above
that we have on <data, len>.  But if we guard with dest->len, then
a violator of <data, len> rule will be caught by memset().

Thanks.

