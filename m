Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36F7220288
	for <e@80x24.org>; Fri, 21 Jul 2017 16:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754387AbdGUQDU (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 12:03:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754194AbdGUQDT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 12:03:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CECD995FD;
        Fri, 21 Jul 2017 12:03:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q9kjjiJQpkeaO6xUSlkvmOWEB08=; b=gvgjbv
        Kxzr9vTANxOQx9bVCna09+jdc9+QDYuiofXNnZH/uOP7pHIMUQQgS7T2Pf0HPK0P
        pAGomTRmbpQ/3+7LOLrn2qxBQxldZsLoKEnvgKZ+56ZL0HA0aPBtWpwzLhBKQWxT
        bJQD2cYKd9NtQq0m0oQpBUUAY4l6vk30i/Bb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sSc7tDHALGBxKufMCQQ1DF1uuXpuK2ms
        nXs9+t6FUJnsyWp43qaaFkZLX1rOMNeNl4/9QfjT/ZJkZP7NdUg1+mU7r1sgnY48
        shLyTj4M5puc2Q89lcOHd7UDYumdAahrOL30TiRws/bQyWQ8fFE94k7TR81MnHu0
        5JWKbZGkC+4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55011995FC;
        Fri, 21 Jul 2017 12:03:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B56E5995FA;
        Fri, 21 Jul 2017 12:03:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Blake <eblake@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
References: <20170721141530.25907-1-eblake@redhat.com>
        <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
        <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com>
Date:   Fri, 21 Jul 2017 09:03:16 -0700
In-Reply-To: <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com> (Eric Blake's
        message of "Fri, 21 Jul 2017 10:27:01 -0500")
Message-ID: <xmqqwp71hj5n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C20C8AC-6E2E-11E7-B096-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Blake <eblake@redhat.com> writes:

> You mean, something like
>
> git config --add contacts.autocc Reported-by
> git config --add contacts.autocc Suggested-by
>
> where contacts.autocc would be a new multi-valued config option
> specifying additional Tag: patterns to scrape out of the commit message?

Yes, something along that line, and you are correct to point out
that I should have mentioned the need for command-line override.

In fact, if you anticipate that the primary use of this contributed
script is as "send-email --cccmd", then we probably are better off
doing this without any configuration variables, but just add the
mechanism for command-line override of the hardcoded default.

I also should have mentioned the need for a way to say "remove all
hardcoded default and start from scratch".

> Also, putting it in 'git config' still means that it is a per-developer
> responsibility to choose which patterns to add to their list.  Is there
> any easy way to make a particular repository supply the same list for
> all developers who check it out, without them having to munge things?

That is a good point, but we should be very careful.  "Let's add
whatever configuration the project supplies to the user's repository
upon cloning" is an absolute no-no, as a malicious project can ship
something like [alias] "co" = "!rm -rf ." and unsuspecting victim to
blindly add it to the configuration.  

A standard practice we encourage is to ship a file that records the
suggested set of configuration variables as part of the source tree
and mention how to add these to their repository in README (which
you are already using to talk about how to contribute to the
project, etc.).

That would give them a chance to inspect what potential damage the
project suggestion will make to their environment (hopefully, there
is none, but the user must be given a chance to ensure that).

The extra lines you may need in your README may become something like

    Run this in your copy of the project:

    $ git config sendemail.cccmd "git contact --cc Suggested-by"

with such a scheme.
