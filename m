Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AD1CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 16:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjIRQLR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 12:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjIRQLA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 12:11:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE612D70
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 09:01:22 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C203526837;
        Mon, 18 Sep 2023 11:56:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=UXXkEMWhufIYbs3ULq6fdnL+Ex88M+zxTH4VLc
        nWRa4=; b=e11Dp4zoo+G1ZYB/NIST9j1OEbKqgG2CKOaZ0icgDyAyaCIrog+ESM
        OR2e+42XprS8ktpVhuXoVS/dUwpwKu5tp2qj6WyRxEYraYBnnPgtglthOlLKHpbL
        51WP0VJmt9VI5jAOpyLqMwf7NKmPV32dA/xPGoRzGOhdLL4XD1Qec=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA1D926836;
        Mon, 18 Sep 2023 11:56:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F8A626833;
        Mon, 18 Sep 2023 11:56:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH v3] revision: add `--ignore-missing-links` user option
In-Reply-To: <CAOLa=ZQ9ZRmYe5b6R9ZTTpDCzb2L0UmxkeBujb2kOMSeFuwJGA@mail.gmail.com>
        (Karthik Nayak's message of "Mon, 18 Sep 2023 12:12:28 +0200")
References: <20230912155820.136111-1-karthik.188@gmail.com>
        <20230915083415.263187-1-knayak@gitlab.com>
        <xmqqfs3fe08e.fsf@gitster.g>
        <CAOLa=ZQ9ZRmYe5b6R9ZTTpDCzb2L0UmxkeBujb2kOMSeFuwJGA@mail.gmail.com>
Date:   Mon, 18 Sep 2023 08:56:39 -0700
Message-ID: <xmqqv8c7mq4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F540A228-563B-11EE-964D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>> Given the above "we merely surface a feature that already exists and
>> supported to be used by the end users from the command line" claim ...
>>
>> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
>> > index ff715d6918..5239d83c76 100644
>> > --- a/builtin/rev-list.c
>> > +++ b/builtin/rev-list.c
>> > @@ -266,7 +266,8 @@ static int finish_object(struct object *obj, const char *name UNUSED,
>> >  {
>> >       struct rev_list_info *info = cb_data;
>> >       if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
>> > -             finish_object__ma(obj);
>> > +             if (!info->revs->ignore_missing_links)
>> > +                     finish_object__ma(obj);
>> >               return 1;
>> >       }
>>
>> ... this hunk is a bit unexpected.  As a low-level plumbing command,
>> shouldn't it be left to the user who gives --ignore-missing-links
>> from their command line to specify how the missing "obj" here should
>> be dealt with by giving the "--missing=<foo>" option?  While giving
>> "allow-promisor" may not make much sense, "--missing=allow-any" may
>> of course make sense (it is the same as hardcoding the decision not
>> to call finish_object__ma() at all), and so may "--missing=print".
>>
>
> This is to be expected, in my opinion. In terms of revision.c and
> setting the `revs->ignore_missing_links` bit, the traversal will
> go throw all objects (commits and otherwise) and call
> `show_commit` or `show_object` on them.

Yes.  And the user can choose how to handle such an object here by
telling finish_object__ma() with the --missing=<how> option, so
letting them do so, instead of robbing the choice from them, would
be a more flexible design here, right?

> if a commit is
> missing, git-rev-list(1) will still barf an error, but this error

OK, yeah, I do see the need for setting the ignore-missing-links bit
for what you are doing, and --missing and --ignore-missing-links are
orthogonal options.  Getting rid of the hardcoded skipping of
finish_object__ma() would make sense from this angle, too.

Thanks.
