Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03071C433FE
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC0D61546
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235391AbhKQJnK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:43:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61444 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbhKQJmP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:42:15 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C98FF16C5FE;
        Wed, 17 Nov 2021 04:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8ybcGo4KnXEiggYuahSoU8u1Ujt5t+1B3O9qJEmmy84=; b=OQRU
        kGwrWjFySjTSTwKVLTrI6GFUoGUJzXEwO9xs1N6xKdxvc/GQtgnEd3pVdFBQn3r/
        v5COXnVz4f2V/4BG7nTj5qhj7M67TVt0lK1juAF07ZYwa8ANfesU3if+V95D7G2A
        XqsO1U61aWS0i7oc6OpwFxDGbjQ8V/eew8563Eg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C20E716C5FD;
        Wed, 17 Nov 2021 04:39:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2220416C5FC;
        Wed, 17 Nov 2021 04:39:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ian Wienand <iwienand@redhat.com>
Cc:     git@vger.kernel.org, Peter Kaestle <peter.kaestle@nokia.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] submodule: separate out not-found and not-empty errors
References: <YZQ5Zk0ItWvfr8sF@fedora19.localdomain>
Date:   Wed, 17 Nov 2021 01:39:08 -0800
Message-ID: <xmqqfsrv2kar.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 375C992C-478A-11EC-8A55-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ian Wienand <iwienand@redhat.com> writes:

>  			    !is_empty_dir(empty_submodule_path.buf)) {
>  				spf->result = 1;
> -				strbuf_addf(err,
> -					    _("Could not access submodule '%s'\n"),
> -					    ce->name);
> +				/* is_empty_dir also catches missing dirtectories, but report separately */
> +				if (!is_directory(empty_submodule_path.buf)) {

I was hoping that inspecting errno after is_empty_dir() returned
might be sufficient (of course, we need to clear errno before
calling is_empty_dir() if we go that route), but because this is an
error codepath that we do not need to optimize, a call to
is_directory() that incurs another system call would be fine.

> +				  strbuf_addf(err,
> +					      _("Submodule directory '%s' not found (incorrect --git-dir?)\n"),

"not found" is something the code definitely knows (eh, not quite,
but let's read on).  

But let's not make an uninformed guess.  This code didn't even check
if the user gave a --git-dir option.

If the user is advanced enough to have given "--git-dir", "not found"
should be sufficient to hint that the way the user specified the
repository location incorrectly, and a wrong "--git-dir" might be
one of the many things the user might suspect on their own.

Another problem with the message is !is_directory() can mean "there
is no filesystem entity at the path" (i.e. "submodule directory '%s'
does not exist") and it can also mean "there is a filesystem entity
at the path, but that is not a directory).  "not found" is not exactly
a good message to give in the latter case.

We are giving two messages here in this codepath.  For example, the
original one would have said something like:

	Could not access submodule 'foo'
	Submodule directory 'foo' is not empty

So I suspect that a more appropriate phrasing for the other one (the
new one you added) would be something like

	Could not access submodule 'foo'
	Path to the submodule 'foo' is not a directory

perhaps?

Thanks.


> +					      empty_submodule_path.buf);
> +				} else {
> +				  strbuf_addf(err,
> +					      _("Submodule directory '%s' is not empty\n"),
> +					      empty_submodule_path.buf);
> +				}
>  			}
>  			strbuf_release(&empty_submodule_path);
>  		}
