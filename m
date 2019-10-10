Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AC351F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 04:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfJJE34 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 00:29:56 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54284 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfJJE34 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 00:29:56 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 75328905AB;
        Thu, 10 Oct 2019 00:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1dOAJ7fO1K1X939MMfDDTXUSUSY=; b=MgyjX9
        jbW82in7ztJupXsi4bDJQF7ujlOkOkn0/I04y/aNJB841fdD5kb7+2WP1bCEwM9d
        EExjF8fSNmajiHk7GdtLlzOfqlrPqeFV0FQ8fHsoCI0UUyRq388cVCPJOxIykouK
        dJEawj0Oo7XqgzbYnpNub3x5hvZqmIfMNbT48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m83FlaAYtjGr8MdI0yK5oXzMt+Oo8G17
        gYcR3Rb9ViMDKXb/4llT+jtAEyq84TJv8CZAzVv5p07SviqfPBjFlPXgRuoJErM3
        Tl0ESS98CjR1YXLi5CLLfGHZ1jMPjPVMm7Z+hFhbRp5bWyQqBvUGO7Euq77UA0aH
        fxdUjuhxu/A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C1F2905AA;
        Thu, 10 Oct 2019 00:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A2D9905A9;
        Thu, 10 Oct 2019 00:29:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc:     git@vger.kernel.org, kernel-usp@googlegroups.com,
        rcdailey.lists@gmail.com, me@ttaylorr.com, peff@peff.net,
        matheus.bernardino@usp.br,
        =?utf-8?Q?B=C3=A1rbara?= Fernandes <barbara.dcf@gmail.com>
Subject: Re: [RFC WIP PATCH 2/3] tag: factor out prepare tag template code
References: <20191008184727.14337-1-lucasseikioshiro@gmail.com>
        <20191008184727.14337-3-lucasseikioshiro@gmail.com>
        <xmqqo8ypjota.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 10 Oct 2019 13:29:47 +0900
In-Reply-To: <xmqqo8ypjota.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 10 Oct 2019 11:51:13 +0900")
Message-ID: <xmqqftk1jk90.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98C6D2CC-EB16-11E9-823B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lucas Oshiro <lucasseikioshiro@gmail.com> writes:
>
>> Improve code readability by moving tag body reading to a new function called
>> get_tag_body.
>
> Quite honestly, I think the result of this splitting is harder to
> follow than the original.
>
> For example, the value of opt->message_given and the validity of
> given_msg is very closely related, so if you made the helper
> function receive non-NULL given_msg when !opt->message_given, the
> helper could only check !given_msg without having to worry about
> opt->message_given; with such a change, I could buy that the split
> improves code readability, but I do not see any such change in the
> patch.

Just to avoid misunderstanding, I am not suggesting to change the
interface into the helper you introduced to be like this

	prepare_tag_template(opt->message_given ? buf, NULL,
			     opt, prev, path, tag);

That still needs to pass the entire opt structure into the helper
and forces the helper to look at opt->cleanup_mode and behave
differently.  If a restructuring of the code can be done in such a
way that the helper no longer need to look at opt (hence no need to
pass the entire opt structure into it), I can see that the change
improves the readability of the resulting code, but I am not all
that hopeful.

On the other hand (and this is the more important hand among the two
;-), I do not mind splitting a helper function out of an existing
codepath and make the existing codepath call the new helper, so that
the same helper can be reused from another codepath later.  Not at
all.  What I do mind is to mislabel a change that is done for such a
later code reuse as one that improves readability, when it does not.

Thanks.

>> Enhance legibility by encapsulating code that loads previous tag message
>> (if any) in new function prepare_tag_template....
>
> The helper seems to be used to _write_ into path, and not load or
> read any message from either an object or a file on disk.
