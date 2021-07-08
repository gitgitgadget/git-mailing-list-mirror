Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08DBC07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 18:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA186162D
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 18:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhGHS3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 14:29:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51416 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhGHS3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 14:29:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92C2DD87CC;
        Thu,  8 Jul 2021 14:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GUr76UTRunrB
        UAa497lw0wzI6488+Kzmjf1IbHmcv2k=; b=rHhBIT3iF1u8LDI0RWQGeWfHVeVj
        uGUtsJCXeMZaAYg6As6Tk3L44JIi/P97jT8z5LyLlpHvEZLcAdiQdPPHbEJnLzvT
        F2+G90pFE7zbXp9yKUTHhD+TWZQ/7gQ8ban84gwpsn9XVBFtmyqlMUlhj2Df2Luw
        rj0vPFftRgTbnQY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87E5BD87CB;
        Thu,  8 Jul 2021 14:26:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A38BBD87CA;
        Thu,  8 Jul 2021 14:26:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Hu Jialun <hujialun@comp.nus.edu.sg>, git@vger.kernel.org,
        felipe.contreras@gmail.com
Subject: Re: [PATCH] commit: remove irrelavent prompt on
 `--allow-empty-message`
References: <20210707162308.2438170-1-hujialun@comp.nus.edu.sg>
        <20210708151911.2524122-1-hujialun@comp.nus.edu.sg>
        <YOciZUlWnF5ur5ec@danh.dev>
Date:   Thu, 08 Jul 2021 11:26:21 -0700
In-Reply-To: <YOciZUlWnF5ur5ec@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Thu, 8 Jul 2021 23:05:57 +0700")
Message-ID: <xmqqfswobr1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FEB39896-E019-11EB-B0DF-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

>> In other words, which of the following 3 is the most acceptable?
>>=20
>> 1. As Junio suggested, quoted above.
>
> I think this approach is the most expensive one, _() needs to query
> the gettext infrastructure, which is usually costly.
> However, I think that cost doesn't matter much since we're about to
> open an editor soon.

See note below.


>> 2.
>> status_printf(s, GIT_COLOR_NORMAL, allow_empty_message ?
>>                                    _("...") :
>> 				   _("...."), comment_line_char);
>
> install_branch_config() uses this style.
>
>>=20
>> 3.
>> const char *hint_foo =3D allow_empty_message ?
>>                        _("...") :
>> 		       _("....");
>
> builtin/remote.c:show_local_info_item() writes:
>
> 	const char *msg;
> 	if (condition)
> 		msg =3D _("some message");
> 	else
> 		msg =3D _("other message");
>
> So, I guess it's fine either way. And people will need to see the
> patch to see which one is better.

Yeah, #1 and #3 are better than the patch posted or #2 in that by
extracting the large message body out-of-line from the code that do
use the messages, they make it simpler to follow the logic that uses
these messages.  That is

	if (cleanup_mode =3D=3D CLEANUP_ALL)
		status_printf(..., hint_cleanup_all);
	else if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS)
		...;
	else /* all the rest */
		status_printf(..., hint_cleanup_space, comment_line_char);

would be far easier to follow than

	if (cleanup_mode =3D=3D CLEANUP_ALL)
		status_printf(...,=20
		condition=20
		? large-large-message-1
		: large-large-message-1-plus-note-about-empty-message);
	else if (cleanup_mode =3D=3D COMMIT_MSG_CLEANUP_SCISSORS)
		...;
	else /* all the rest */
		status_printf(...,
		condition
		? large-large-message-2
		: large-large-message-2-plus-note-about-empty-message,
		comment_line_char);

as the overall structure is easier to follow without the minute
detail of using slightly different messages depending on the
allow-empty setting.

By the way, if you want to avoid calling _() twice with the approach
#1, you can do

	hint_cleanup_all =3D N_("<cleanup and note about empty message>");
 	...

	if (condition) {
		hint_cleanup_all =3D N_("<cleanup without note>");
		...
	}

and use _(hint_cleanup_all) at the site that uses the message.
