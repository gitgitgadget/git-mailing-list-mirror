Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBC1E20372
	for <e@80x24.org>; Tue, 10 Oct 2017 04:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdJJEVT (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 00:21:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750734AbdJJEVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 00:21:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29FF0ACD86;
        Tue, 10 Oct 2017 00:21:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vPa/EduAwUIa
        fkibVLpN+f6Xfy0=; b=cyEsMM69rXk3bPlNImpN97otp8lBBFixzzqLB1ienQIX
        jpVFousXu6JY71lUdyTdmrtbNBDNhpg1U+6uQOuQcej1w8jKwYrKz7ZCIS9BoOhO
        6WVtJO6906yr/VqCo024wOG2LBv14nelbR8EMkBEo65sNb0JjuJU0DYZTRuQzhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GpaJ1u
        pXflEqN524deIh8AZkzI83iAu9LBbNNM4TOS/0buu7GVg65TWI7x1XqFCTwaBwuV
        oeQp/Wc5GfFuBMPsG/Xu8Bm4LkwzJWBlMeAHe7I3ijXg32pZ2NFUOOs+lggCDfbX
        ueQPuD5hOWnn/MH1b/SeF4vZ24ifmi8McdfP0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21FB0ACD85;
        Tue, 10 Oct 2017 00:21:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DE9AACD84;
        Tue, 10 Oct 2017 00:21:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Damien =?utf-8?Q?Mari=C3=A9?= <damien@dam.io>
Subject: Re: [PATCH v3] run-command: add hint when a hook is ignored
References: <xmqqh8vcx1nh.fsf@gitster.mtv.corp.google.com>
        <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
Date:   Tue, 10 Oct 2017 13:21:16 +0900
In-Reply-To: <0102015ef0ba0273-ed29c030-7cdc-4535-a411-6cc443bd5f43-000000@eu-west-1.amazonses.com>
        ("Damien =?utf-8?Q?Mari=C3=A9=22's?= message of "Fri, 6 Oct 2017 08:07:55
 +0000")
Message-ID: <xmqqy3ojpr9f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 76041FEE-AD72-11E7-B3AA-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Mari=C3=A9 <damien@dam.io> writes:

> When an hook is present but the file is not set as executable then git =
will
> ignore the hook.
> For now this is silent which can be confusing.

Quite honestly, I do not particulary think this is confusing, and I
expect that this change will irritate many people by forcing them to
either set the advise config or move the ones that they deliberately
left unexecutable by renaming them by adding ".disabled" at the end.

But these remedies are easy enough, so let's see how well it works
by merging it to 'next' and cooking it there for a while.

I've spotted two issues during the last-minute scan; I'll squash the
fixes in in the meantime (if you are not going to change anything
other than these two, there is no need to resend corrected patches).

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1ac0ae6adb046..9abca499f725c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -351,6 +351,9 @@ advice.*::
>  	addEmbeddedRepo::
>  		Advice on what to do when you've accidentally added one
>  		git repo inside of another.
> +	ignoredHook::
> +		Advice shown if an hook is ignored because the it's not
> +		set as executable.

s/the it's not/the hook is not/;

> @@ -38,6 +39,7 @@ static struct {
>  	{ "objectnamewarning", &advice_object_name_warning },
>  	{ "rmhints", &advice_rm_hints },
>  	{ "addembeddedrepo", &advice_add_embedded_repo },
> +	{ "ignoredhook", &advice_ignored_hook},

s/ignored_hook/& /;

