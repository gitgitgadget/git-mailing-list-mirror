Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95952207BF
	for <e@80x24.org>; Fri, 21 Apr 2017 01:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034401AbdDUBtD (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 21:49:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63271 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034398AbdDUBsD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 21:48:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6985B7F472;
        Thu, 20 Apr 2017 21:48:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=OMD+pNf8Y0pF
        nD0PA9yDOBNJOjg=; b=nCSCOTRZ0TRGeCGjmlE5vEJ5siLgVyKim1+iYJumSE7Y
        ZUEhX/tNVY2AptMQhJBtXIPrGlAbxaYm7/tnpgAZI/d6Z0WMCJ6fqrCpZf5brXX0
        DffJ81bkhxKb/9ZDwBJBf0yMMQaDkk6RNcqhQoug77l9J/Bxy/sW8ONCD5jpm9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ldrLCa
        oRSUp390P5MRiFU4I3ecHSm81ZKY4Y9ai4dmxs500IBssuYO/qMUTwe0lpktPXS5
        IJBsda1sQ8LOGDYg5rqZHneOJm6kyBeKyPOgGXrTu6hfE22GoJ/T7w8X7anZEjdz
        aN2BpcyEkqbc+bM8dIDdSmEkzANMDWW6/8KuM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 24C647F470;
        Thu, 20 Apr 2017 21:48:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07DBE7F46F;
        Thu, 20 Apr 2017 21:48:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/15] Handle fopen() errors
References: <20170420112609.26089-1-pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 18:47:59 -0700
In-Reply-To: <20170420112609.26089-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 20 Apr 2017 18:25:54 +0700")
Message-ID: <xmqqlgqu7cq8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8D660762-2634-11E7-8B7A-C260AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Some of you may recall a while back, nd/conditional-config-include
> failed on Windows because I accidentally fopen()'d a directory in a
> test, but it's not considered an serious error unless it's on Windows,
> where fopen(<dir>) returns NULL.
>
> A couple of suggestions were thrown back and forth, but I was a bit
> busy to follow up. Now that I have time, I have audited all fopen()
> calls and try to fix them up for good. There 15 patches, but they only
> change one or two lines each. I split them anyway so you can pause
> between patches and see if it really makes sense, as changes are all
> over the places.

Nicely done. =20

I wonder if it is OK to only special case ENOENT for !fp cases,
where existing code silently returns.  Perhaps it is trying to read
an optional file, and it returns silently because lack of it is
perfectly OK for the purpose of the code.  Are there cases where
this optional file is inside an optional directory, leading to
ENOTDIR, instead of ENOENT, observed and reported by your check?

