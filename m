Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05765C46CA1
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 17:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjIRRMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 13:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjIRRL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 13:11:58 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560E97
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 10:11:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 21A20240AF;
        Mon, 18 Sep 2023 13:11:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=MK8UholLikfBQP+37hURjrBSbFmn02nvBnMHY+
        ybcpE=; b=X9taCJEqkeptBv2b3GBDzGnWdJGAMkQaV2gy57WZ54Zbf51pmaFc/I
        rKPMSLFPfEYsfTnHImhqLCsbHmeN8UbTm0hLyP518SPh9ij8ClMUXU/r4YlKR+Hu
        c6QrwWKW2MeY7zKh8extihboSNuqal8PmD8duZNr/XLLxtqc5+Cgo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17DF1240AE;
        Mon, 18 Sep 2023 13:11:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 882B0240AB;
        Mon, 18 Sep 2023 13:11:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
In-Reply-To: <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com> (Phillip Wood's
        message of "Mon, 18 Sep 2023 14:33:56 +0100")
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
        <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
        <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
        <20230912084029.GD1630538@coredump.intra.peff.net>
        <xmqqa5tmau6e.fsf@gitster.g>
        <6dc558c6-f78c-4d9c-8444-498de8e4d22a@web.de>
        <0bf56c65-e59f-4290-8160-cce141f692d5@gmail.com>
Date:   Mon, 18 Sep 2023 10:11:45 -0700
Message-ID: <xmqqedivl832.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 729DF0B8-5646-11EE-904F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> -	resume->mode = RESUME_SHOW_PATCH;
>> +	resume->mode_int = RESUME_SHOW_PATCH;
>>   	resume->sub_mode = new_value;
>>   	return 0;
>>   }
>
> Having "mode" and "mode_int" feels a bit fragile as only "mode_int" is
> valid while parsing the options but then we want to use "mode". I
> wonder if we could get Oswald's idea of using callbacks working in a
> reasonably ergonomic way with a couple of macros. We could add an new
> OPTION_SET_ENUM member to "enum parse_opt_type" that would take a
> setter function as well as the usual void *value. To set the value it
> would pass the value pointer and an integer value to the setter
> function. We could change OPT_CMDMODE to use OPTION_SET_ENUM and take
> the name of the enum as well as the integer value we want to set for
> that option. The name of the enum would be used to generate the name
> of the setter callback which would be defined with another macro. The
> macro to generate the setter would look like
>
> #define MAKE_CMDMODE_SETTER(name) \
> 	static void parse_cmdmode_ ## name (void * var, int value) {
> 		enum name *p = var;
> 		*p = value;
> 	}

Ah, OK.  So that's how you defeat "how the size and alignment of an
enum mixes well with int is not known and depends on particular enum
type".  It is a tad sad that this relies on "void *", which means
that the caller of parse_cmdmode_resume_type cannot be forced by the
compilers to pass "enum resume_type *" to the function, though.  And
that is probably inevitable with the design as .enum_setter needs to
be of a single type, and the member in the "struct option" that
points at the destination variable must be "void *" as it has to
be capable of pointing at various different enum types.

> ...
> Then in builtin/am.c at the top level we'd add
>
> MAKE_CMDMODE_SETTER(resume_type)
>
> and change the option definitions to look like
>
> OPT_CMDMODE(0, "continue", resume_type, &resume.mode, ...)

Yup, that is ergonomic and corrects "The shape of a particular enum
may not match 'int'" issue nicely.  I do not know how severe the
problem is that it is not quite type safe that we cannot enforce
resume_type is the same as typeof(resume.mode) here, though.

Thanks.

