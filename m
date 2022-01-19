Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4306EC433F5
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 18:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348440AbiASSQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 13:16:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52876 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiASSQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 13:16:37 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C2CD10ABBA;
        Wed, 19 Jan 2022 13:16:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YKSP1pfV7q3Y
        fJpOlPD4WkI3lebLBmn/iOK9i+hTEys=; b=V2DA3yIFp71mLOLPveqg4gR+ANrx
        VQHEYZ0Go6kvm7nH0gmQ6ANu/AouKpWW4rCBG3tJVlrDlNg9TkmQgpyhsG5uIPSs
        EB1VjxXRR/e0FfRtgQciJZE3wnlTgcDIYvZ4FEc9kwUEImdP0YCYyKSBhMVPPRoE
        MfUSfr3mCG8uMUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4393F10ABB9;
        Wed, 19 Jan 2022 13:16:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C78910ABB8;
        Wed, 19 Jan 2022 13:16:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH] parse-options: document automatic
 PARSE_OPT_LITERAL_ARGHELP
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
        <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
        <xmqqh7a0r87q.fsf@gitster.g>
        <ba624c59-5330-360e-dc4a-432752d22fc1@web.de>
Date:   Wed, 19 Jan 2022 10:16:34 -0800
In-Reply-To: <ba624c59-5330-360e-dc4a-432752d22fc1@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 19 Jan 2022 11:56:58 +0100")
Message-ID: <xmqqlezboakd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EFDF7050-7953-11EC-B40A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The help strings for arguments are enclosed in angle brackets
> automatically.  E.g. if argh is specified as "name", "--option <name>"
> is printed, to indicate that users need to supply an actual name.  The
> flag PARSE_OPT_LITERAL_ARGHELP turns this off, so that "--option name"
> is printed instead, to indicate that the literal string needs to be
> supplied -- a rare case.
>
> This flag is enabled automatically if argh contains special characters
> like brackets.  The developer is supposed to provide any required angle
> brackets for more complicated cases.  E.g. if argh is "<start>,<end>"
> then "--option <start>,<end>" is printed.

The above does explain why we want to have this change very well,
but at least some of it would help those who are reading the comment
we touch.

> Add a comment to mention this PARSE_OPT_LITERAL_ARGHELP behavior.

But instead, the addition is only about when the flag bit is turned
on automatically.  Without understanding your

    E.g. if argh is specified as "name", "--option <name>" is
    printed, to indicate that users need to supply an actual name.

readers would not quite get from the current description "says that
argh shouldn't be enclosed in brackets" when/why it is a good idea
to add the option, I am afraid.

> Also remove the flag from option definitions for which it's inferred
> automatically.

I am not sure if this is a good move.

Because these places explicitly gave PARSE_OPT_LITERAL_ARGHELP, it
was easy to grep for them when I was trying to find an existing
practice.

Imagine, after we remove these redundant flags, we see a patch that
wants to change the set of characters that automatically flips the
flag bit on.  It is clear from the patch text why it helps one
particular OPT_STRING() or whatever the same patch adds, but how
would you make sure it will not regress _existing_ OPT_WHATEVER()
that do not use PARSE_OPT_LITERAL_ARGHELP because their argh happens
to use the character that wasn't special before?

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Somehow I feel this is not enough, but I can't pin down what's
> missing.

Let me try.

>   *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed i=
n brackets
>   *				(i.e. '<argh>') in the help message.
>   *				Useful for options with multiple parameters.
> + *				Automatically enabled if argh contains any
> + *				of the following characters: ()<>[]|
>   *   PARSE_OPT_NOCOMPLETE: by default all visible options are completa=
ble
>   *			   by git-completion.bash. This option suppresses that.
>   *   PARSE_OPT_COMP_ARG: this option forces to git-completion.bash to

PARSE_OPT_LITERAL_ARGHELP: in short-help given by "git cmd -h", the
			   "argh" member of the struct option is
			   shown in a pair of angle brackets (e.g.
			   "--option=3D<argh>"); this flag tells the
			   machinery not to add these brackets, to
			   give more control to the developer.  E.g.
			   "<start>,<end>" given to argh is shown as
			   "--option=3D<start>,<end>".

That may be a bit too much, but on the other hand, among PARSE_OPT_X
descriptions, this is the only one that needs to talk about help
text on the argument to the option.

Or we can flip it the other way, perhaps?

	Tell the machinery to give "argh" member literally in the
	short-help in "git cmd -h" output for the option.  E.g. {
	.argh =3D "(diff|raw)", .long_name =3D "show" } would give
	"--show=3D(diff|raw)".  Without the flag, "argh" is enclosed
	in a pair of angle brackets.

I dunno.


