Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084CC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 19:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiGKTjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 15:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKTjW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 15:39:22 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9F34F69F
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 12:39:21 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B45E81A6339;
        Mon, 11 Jul 2022 15:39:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z2oVdWGPyCnx
        K5qDz/OYFU8G4Z4LH1G1tuXUVOSe5L8=; b=DnTUFeVcNR0KpN6hqSigNSSI1/41
        E5MSxBh8iIPoNd18nN15dvi2c3D0nzpX3z1NjmDNVlcyj89Mnq4ngjhZJpS38sNx
        kwiKBy+8XTLm13L+L33w9Trt8hQ4tFe6nWNAHJ+5wqOZV/WewKazDt8XzhIK/gVb
        0LjQhk6vjzt+uQI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A07F1A6338;
        Mon, 11 Jul 2022 15:39:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 342331A6337;
        Mon, 11 Jul 2022 15:39:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: fsck segfault
References: <xmqqfskdieqz.fsf@gitster.g> <20220711081956.GB2038@szeder.dev>
Date:   Mon, 11 Jul 2022 12:39:16 -0700
In-Reply-To: <20220711081956.GB2038@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Mon, 11 Jul 2022 10:19:56 +0200")
Message-ID: <xmqqo7xvo2vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26BDA9CC-0151-11ED-A490-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> +		for (i =3D 0; i < 3; i++) {
>> +			struct object *obj;
>> +
>> +			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
>> +				continue;
>> +
>> +			obj =3D parse_object(the_repository, &ru->oid[i]);
>
> parse_object() can return NULL ...
>
>> +			if (!obj) {
>
> ... and here is the if statement to show an error in that case ...
>
>> +				error(_("%s: invalid sha1 pointer in resolve-undo"),
>> +				      oid_to_hex(&ru->oid[i]));
>> +				errors_found |=3D ERROR_REFS;
>> +			}
>> +			obj->flags |=3D USED;
>
> ... but then there is this line which might dereference that NULL
> pointer.
>
> Perhaps all we would need is a 'continue' at the end of that 'if
> (!obj)' block, or an else block for the last three statements, which
> should result in the same control flow?  Dunno.

Thanks for spotting.  Looking at how fsck_cache_tree() and
fsck_walk_tree() handles missing object, it sounds like the right
approach to continue after setting the errors_found bit.

>> +			fsck_put_object_name(&fsck_walk_options, &ru->oid[i],
>> +					     ":(%d):%s", i, path);
>> +			mark_object_reachable(obj);
>> +		}
>> +	}
>> +	return 0;
>> +}
