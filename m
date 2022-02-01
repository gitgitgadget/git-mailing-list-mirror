Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B50BC433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 19:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiBATIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 14:08:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56511 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbiBATIg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 14:08:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 493B517419E;
        Tue,  1 Feb 2022 14:08:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TLhwR/JdiAYj
        yZrk/UFLQGyPafL7Xpwtben9mwj+/GA=; b=LXsgxDvISFleJ2FnlChL4apwYra/
        ZL3o1hSrmMAW0q3BFVfmFbAkjkg5CmlM8FAEGduPRg8OJVPCAVGSMCf+UxlAg0tf
        DKMMy9NaUjlB1Cq9k5AdKkxr57IeKY4pe+PILosTi1O5ZyrYIBAmyk9/U23uRtwm
        A1EPD/FwBeHkmnU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 41CF317419D;
        Tue,  1 Feb 2022 14:08:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A3EF417419A;
        Tue,  1 Feb 2022 14:08:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 05/10] object-file API: provide a hash_object_file_oideq()
References: <cover-00.10-00000000000-20220201T144803Z-avarab@gmail.com>
        <patch-05.10-719fcfbe13c-20220201T144803Z-avarab@gmail.com>
Date:   Tue, 01 Feb 2022 11:08:32 -0800
In-Reply-To: <patch-05.10-719fcfbe13c-20220201T144803Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 1 Feb
 2022 15:53:07
        +0100")
Message-ID: <xmqq5ypye767.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 59CF7E54-8392-11EC-BED9-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Provide a new hash_object_file_oideq() for those callers of
> check_object_signature() that don't care about its streaming
> interface. I.e. at the start of that function we do:
>
> 	if (map) {
> 		hash_object_file(r->hash_algo, map, size, type, real_oid);
> 		return !oideq(oid, real_oid) ? -1 : 0;
> 	}
>
> These callers always provide a "map" (or "buf[fer]"). Let's have them
> call this simpler hash_object_file_oideq() function instead.
>
> None of them use a non-NULL "real_oid" argument, but let's provide it
> like check_object_signature() did. This'll make it easy to have these
> emit better error messages in the future as was done in
> 96e41f58fe1 (fsck: report invalid object type-path combinations,
> 2021-10-01), i.e. the die() calls here can emit not only the OID we
> expected, but also what we got.

This has a potential to moving us in the wrong direction when made
to code paths that currently fully slurp an object in-core but may
want to shrink the memory footprint by using streaming API more.

Having said that, I think all of these want to also use the in-core
version of hte object data (mostly to write them out), and they need
more work to move them in the other direction, so I'd say it is OK
to introduce the new helper to simplify these callsites.
