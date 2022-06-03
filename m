Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F86FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 21:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346925AbiFCV2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346958AbiFCV2N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 17:28:13 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6A238BDF
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 14:28:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30CC819A3BD;
        Fri,  3 Jun 2022 17:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=cZxBC5VcEKq5
        ad3CsoIXZTbkzLzD8o0bq2tToem18Ps=; b=iGPB537TLzU+krnETrgGKcMYZUs3
        kwWAVez/zJMcgKzlxin4twLfNC9P6cmnCHCALUfblFjiIvcQHnk/eYudZ0+n/paY
        2rqr0StlNSAe9MBRdbGqXFw25SOIrQID/daEaiUnMkhWQGLctyD45EXHkzfMQjXY
        455c42EmKApFNKU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29F0819A3BC;
        Fri,  3 Jun 2022 17:28:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C956919A3BB;
        Fri,  3 Jun 2022 17:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 01/15] remote.c: don't dereference NULL in freeing loop
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
        <RFC-patch-01.15-b3a678d934a-20220603T183608Z-avarab@gmail.com>
        <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de>
Date:   Fri, 03 Jun 2022 14:28:06 -0700
In-Reply-To: <0c296c0e-bbd4-57a6-1cab-3b98c3bc8927@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 3 Jun 2022 23:07:52 +0200")
Message-ID: <xmqqilphcu8p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F9774CA-E384-11EC-B312-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> -	for (i =3D 0; i < remote->pushurl_nr; i++) {
>> +	for (i =3D 0; i < remote->pushurl_nr; i++)
>>  		free((char *)remote->pushurl[i]);
>> -	}
>>  	FREE_AND_NULL(remote->pushurl);
>
> Why set pushurl to NULL after release?  This results in an invalid stat=
e
> unless pushurl_nr und pushurl_alloc are reset to zero.  Same goes for
> the url array above -- either a simple free(3) call suffices or url_nr
> and url_alloc need to be cleared as well.

We probably should give a huge warning next to FREE_AND_NULL() about
this.  It also is an effective way to hide an existing bug under the
rug.  diff_options.pathspec might be freed prematurely which may be
noticed by a use-after-free if left to use free(), but FREE_AND_NULL()
will mislead the use-after-free caller into thinkig that "ah there is
no pathspec to be used" and produce nonsense result without crashing.

Thanks.
