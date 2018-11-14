Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F39741F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 07:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbeKNRLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 12:11:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59221 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbeKNRLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 12:11:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A203E11847B;
        Wed, 14 Nov 2018 02:09:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bFtZcPBriRyr
        aABf/6qJuSMjL9A=; b=nuE3eN5UDE2WJEjUD9m/zP16uXN9bUmi794800nb0DZf
        +cJ4PFnYLa903vXoiIMzwjuNN7XjyI1VZYj423BPLBAxOfQ2wevRGDWDr+KwxEWE
        Re2VBZ+oihVqK3xJ5WryZ6m7m9TaKgM6IdOk5lOy+HaZ7eNqFFd6OCppSYEWTso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Id3x4C
        pGBWNMV4EVuPtgp8mcFrZyV+QU3/HxHWGkPPLlwthCQ1HYJEJoexnvJS6xjGEDcQ
        PafUv8RsRQz4sQomkEpqqIPAvZfWCHg+hWjddJnRVMYxj26sl40rldPWlNwFbMqN
        g24FWC6YTWpCy88JgxCfNkWlJHX7PYJ1CEYd0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A1AF11847A;
        Wed, 14 Nov 2018 02:09:18 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 133CF118477;
        Wed, 14 Nov 2018 02:09:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Geert Jansen <gerardu@amazon.com>,
        Christian Couder <christian.couder@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH v3] index-pack: add ability to disable SHA-1 collision check
References: <20181030184331.27264-1-avarab@gmail.com>
        <20181113201910.11518-1-avarab@gmail.com>
Date:   Wed, 14 Nov 2018 16:09:17 +0900
In-Reply-To: <20181113201910.11518-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 13 Nov 2018 20:19:10 +0000")
Message-ID: <xmqqftw4nnj6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33B18ED8-E7DC-11E8-A9C7-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a new core.checkCollisions setting. On by default, it can be set
> to 'false' to disable the check for existing objects in sha1_object().
> ...
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 2004e25da2..4a3508aa9f 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -791,23 +791,24 @@ static void sha1_object(const void *data, struct =
object_entry *obj_entry,
>  {
>  	void *new_data =3D NULL;
>  	int collision_test_needed =3D 0;
> +	int do_coll_check =3D git_config_get_collision_check();
> =20
>  	assert(data || obj_entry);
> =20
> -	if (startup_info->have_repository) {
> +	if (do_coll_check && startup_info->have_repository) {
>  		read_lock();
>  		collision_test_needed =3D
>  			has_sha1_file_with_flags(oid->hash, OBJECT_INFO_QUICK);
>  		read_unlock();
>  	}
> =20
> -	if (collision_test_needed && !data) {
> +	if (do_coll_check && collision_test_needed && !data) {
>  		read_lock();
>  		if (!check_collison(obj_entry))
>  			collision_test_needed =3D 0;
>  		read_unlock();
>  	}
> -	if (collision_test_needed) {
> +	if (do_coll_check && collision_test_needed) {

If I am reading the patch correctly, The latter two changes are
totally unnecessary.  c-t-needed is true only when dO-coll_check
allowed the initial "do we even have that object?" check to kick in
and never set otherwise.

I am not all that enthused to the idea of sending a wrong message to
our users, i.e. it is sometimes OK to sacrifice the security of
collision detection.

A small change like this is easy to adjust to apply to the codebase,
even after today's codebase undergoes extensive modifications; quite
honestly, I'd prefer not having to worry about it so close to the
pre-release feature freeze.
