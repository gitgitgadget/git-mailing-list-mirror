Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BF3C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 17:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E694B207D8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uwo5krtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgIZRGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 13:06:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50667 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZRGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 13:06:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4C38F4A21;
        Sat, 26 Sep 2020 13:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rYvMIVftoWya
        Owrz6rloJWABCUc=; b=uwo5krtYEcvNr8UhrrhhJfWMDCsbc0U54vmG3bPUmVt8
        CvkmKMREoYXV1XVBHMd0w88J6YOorGRbcYU1NHQss/IE+BHjS90znlpd0Fjts2aB
        ++Z7apRUwLLzF638RGr3OwIpteepoAMOANET3F5ry2KeXOZAi0+QBBeD6V3yPDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NpUV+z
        XpOcawBHGMyEmJumkJSHsNPMcbwry/buPX3g1lD185iwfDxljklu89jiQbrgN/f4
        3n/zdD5aC46/kDCeM000JuxB/AGJszl+4eWA5hecMAihcPI4aQOvF2LAotaOiKu0
        rcXIx38nQ07XoIGs/CRpux0PniQlxpF0hukjo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBF88F4A20;
        Sat, 26 Sep 2020 13:06:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0A858F4A1F;
        Sat, 26 Sep 2020 13:06:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Barret Rhoden <brho@google.com>
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
References: <20200925055954.1111389-1-gitster@pobox.com>
        <20200925055954.1111389-3-gitster@pobox.com>
        <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
Date:   Sat, 26 Sep 2020 10:06:48 -0700
In-Reply-To: <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 26 Sep 2020 18:23:42 +0200")
Message-ID: <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AADB9190-001A-11EB-A8C4-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> When I request "Don't eat any glue!", perfectly human responses could b=
e
> "But I don't have any glue!" or "It doesn't even taste that good.", but
> I'd expect a computer program to act I bit more logical and just don't
> do it, without talking back.  Maybe that's just me.
>
> (I had been bitten by a totally different software adding such a check,
> which made it complain about my long catch-all ignore list, and I had t=
o
> craft and maintain a specific "clean" list for each deployment --
> perhaps I'm still bitter about that.)

A user who says "ignore v2.3", sees that the commit pointed at by
that release tag is not ignored, comes here to complain, and is told
to write v2.3^0 instead, would not be happy.  It is a mistake easy
to catch to help users, so I am more for than against that part of
the change.  I am completely neutral about "you told me to ignore
this, but as far as I can tell it does not even exist---did you=20
screw up when you prepared the list of stuff to ignore?" part.  I do
not mind seeing it removed.

>> +		if (kind =3D=3D OBJ_COMMIT) {
>> +			oidcpy(oid_ret, &oid);
>
> At that point we know it's an object, but cast it up to the most generi=
c
> class we have -- an object ID.  We could have set an object flag to mar=
k
> it ignored instead, which would be trivial to check later.  On the othe=
r
> hand it probably wouldn't make much of a difference -- hashmaps are
> pretty fast, and blame has lots of things to do beyond ignoring commits=
.

Quite honestly, I am not interested in the "blame --ignore" feature
itself.  It is good that you CC'ed Barret so that such an
improvement suggestion would be heard by the right party ;-).

>> @@ -815,10 +836,12 @@ static void build_ignorelist(struct blame_scoreb=
oard *sb,
>>  		if (!strcmp(i->string, ""))
>>  			oidset_clear(&sb->ignore_list);
>
> This preexisting feature is curious.  It's even documented ('An empty
> file name, "", will clear the list of revs from previously processed
> files.') and covered by t8013.6.  Why would we need such magic in
> addition to the standard negation (--no-ignore-revs-file) for clearing
> the list?  The latter counters blame.ignoreRevsFile as well. *puzzled*

I shared the puzzlement when I saw it, but ditto.

>> +void oidset_parse_file_carefully(struct oidset *set, const char *path=
,
>> +				 oidset_parse_tweak_fn fn, void *cbdata)
>>  {
>>  	FILE *fp;
>>  	struct strbuf sb =3D STRBUF_INIT;
>> @@ -66,7 +72,8 @@ void oidset_parse_file(struct oidset *set, const cha=
r *path)
>>  		if (!sb.len)
>>  			continue;
>>
>> -		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0')
>> +		if (parse_oid_hex(sb.buf, &oid, &p) || *p !=3D '\0' ||
>> +		    (fn && fn(&oid, cbdata)))
>
> OK, so this turns the basic all-I-know-is-hashes oidset loader into a
> flexible higher-order map function.  Fun, but wise?  Can't make up my
> mind.

Fun and probably useful.  It is a different matter if it is wise to
use it to (1) peel tags to commits and (2) fail on an nonexistent
object.  My take on them is (1) is probably true, and (2) is Meh ;-)

Thanks.
