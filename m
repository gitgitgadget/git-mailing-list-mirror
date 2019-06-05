Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE521F462
	for <e@80x24.org>; Wed,  5 Jun 2019 16:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfFEQZ4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 12:25:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61711 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfFEQZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 12:25:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 94881619E3;
        Wed,  5 Jun 2019 12:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=P0txqXcffgQFBUl7MapHjCPDKQ4=; b=UhvJkq
        JgzdFTspUtFUmfdmPRxJInaE9ZumJp/93oEtaaN7sF3BsCX4Dxt6j88T6tvSiYTO
        idKF4z4utK60XUOZ0Egvz1gMPTgOuvVD0h9r1MNj5ZsOsMKUsBjAtBfh+f6nKG8U
        3xixee6o0FAKcev592Uyv4H/2ORBzsoejE8UY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pzpM0tymmqhurc/Xh1nWK0wVrpcnI1u6
        ln75ZYJQ3icwf7ediCyc+TbnTfcKgaYpuLHBRh+uCSCqD3hzgVZvAUz7lDW/fLLf
        3AHy4CKf8czTqJDyzxmDplZ+LLC/fWwhAtZ434dp4V6j3Gy0jTGPIDqzuP6NjK+T
        oLZCq0NEsPk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8CB85619E2;
        Wed,  5 Jun 2019 12:25:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 86BB3619DD;
        Wed,  5 Jun 2019 12:25:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags be GPG-signed
References: <139144069.10140489.1559664262817.JavaMail.zimbra@desy.de>
        <20190605155300.26506-1-tigran.mkrtchyan@desy.de>
Date:   Wed, 05 Jun 2019 09:25:46 -0700
In-Reply-To: <20190605155300.26506-1-tigran.mkrtchyan@desy.de> (Tigran
        Mkrtchyan's message of "Wed, 5 Jun 2019 17:53:00 +0200")
Message-ID: <xmqqv9xkroc5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 93D31E04-87AE-11E9-B2EB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tigran Mkrtchyan <tigran.mkrtchyan@desy.de> writes:

> As many CI/CD tools don't allow to control command line options when
> executing `git tag` command, a default value in the configuration file
> will allow to enforce tag signing if required.

Hmm.  Would these "many" tools still allow arbigrary configuration
set to affect their operation?  It sounds like a bigger issue but it
is a separate one.

> The new config-file option tag.gpgSign enforces signed tags. Additional
> ...
> will skip the signing step.

This paragraph is well written.

> The combination of -u <key-id> and --no-sign not allowed.

This sentence lacks a verb.  Perhaps s/not allowed/is &/.  

But more importantly, I think we should justify why this "not
allowed" makes sense as the design of the feature. A plausible
alternative design would simply follow the "last one wins" paradigm,
where

    git tag -u key # "-u key" implies "-s"

    git tag -u key --no-sign # "--no-sign' trumps the implied "-s"

    git tag --no-sign -u key # "-u key"'s implication of "-s" trumps the
			     # earlier "--no-sign"

and having "[tag] gpgsign" simply adds to the implication early in
the chain to be overridden by later command line options.

Let's explain why "you cannot give -u <key> and --no-sign at the
same time" is better than "the last one wins".

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index a74e7b926d..2e5599a67f 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -64,6 +64,13 @@ OPTIONS
>  -s::
>  --sign::
>  	Make a GPG-signed tag, using the default e-mail address's key.
> +	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
> +	configuration variable if it exists, or disabled oder otherwise.
> +	See linkgit:git-config[1].
> +
> +--no-sign::
> +	Override `tag.gpgSign` configuration variable that is
> +	set to force each and every tag to be signed.
>  
>  -u <keyid>::
>  --local-user=<keyid>::

If we justify "-u and --no-sign do not mix", that design needs to be
explained to the end users in the documentation, not just in the
proposed log messsage.

