Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A794320285
	for <e@80x24.org>; Thu, 24 Aug 2017 16:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbdHXQfI (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 12:35:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752751AbdHXQfH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 12:35:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13C3998754;
        Thu, 24 Aug 2017 12:35:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bHr2Cw4jwejO0ZEt8qYpysz1tBk=; b=uvRWMD
        +f10B8iv0cbjQqnxQpbKrDZhGg6SyRtyTnTn27/b5QSV/7WMJ/dpHfz97GyAbW3M
        0RKiIc3woL6tnlbtKQ3BQhUKYM81NSzqmGRUlek+fv+SJ1ylmWpUcly/DAb5l15D
        zoSM2lXdedlBCSJmK+4oUn6i3AAAXMyPNQIwo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ozt8RWpzZnvgpj9Mp90NTNWyiIFOr+NI
        0YyxTdzKNZ6O+57kXPFcmMTIrJ3e4reO4b3C6PShaq7vjU6X2qVMd13Bq1dfTzHy
        s72/B9fG2h08C0TMuHsnssUpWbAtYutuw/SdfAtKWg+GOhO4rnTq/thLUJoGnnqu
        tr11BZuVFpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BB0F98753;
        Thu, 24 Aug 2017 12:35:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FDE49874F;
        Thu, 24 Aug 2017 12:35:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
Subject: Re: What does 'git blame --before <rev> -- <file>' supposed to mean?
References: <1503254759.3881.9.camel@gmail.com>
        <20170824075848.GG3839@alpha.vpn.ikke.info>
Date:   Thu, 24 Aug 2017 09:35:03 -0700
In-Reply-To: <20170824075848.GG3839@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Thu, 24 Aug 2017 09:58:48 +0200")
Message-ID: <xmqqy3q8x6tk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F116260-88EA-11E7-B92A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Git blame takes options that are fed to git rev-list, to limit the
> commits being taken into account for blaming.
>
> The man page shows "[--since=<date>]", which is one such option, but
> before is valid as well.
>
> git blame -h shows:
>
>     <rev-opts> are documented in git-rev-list(1) 
>
> and man git-blame shows under specifying ranges (emphasis mine): 
>
>      When you are not interested in changes older than version v2.6.18,
>      or changes older than 3 weeks, *you can use revision range
>      specifiers similar to git rev-list*:
>
> So these options are not documented under git blame, but git rev-list.
>
> Perhaps the synopsis of man git-blame could be expanded so that that
> it's clear it accepts rev-list options.

While nothing in what you said is incorrect per-se, many options
that rev-list takes are parsed but then ignored by blame, simply
because they do not make much sense in the context of the command,
and "--before" is one of them.  

It is interesting to realize that "--since" (and its synonym
"--after") does make sense, unlike "--before" (and its synonym
"--until") which does not.

Let's imagine a history like this (time flows from left to right):

     --c1--c2--c4--c6--c8--c9
             \         /
             c3--c5--c7

where the tip of the history is at commit "c9", and the number in
the name of each commit denotes its timestamp.

 - "git rev-list c9" starts from "c9", and follows the chain of
   parents and would produce c9, c8, c7, c6, ..., c1, ....

 - If you add "--after 2", i.e. "git rev-list --after 2 c9" does
   exactly the same traversal as the above, but stops following the
   chain of parents for commits that is earlier than the specified
   time.

 - If you add "--before 6", i.e. "git rev-list --before 6 c9" does
   exactly the same traversal as the first one, but does not show
   the commit whose timestamp is later than the specified time.  It
   would be like saying "git rev-list c5 c6" in the above topology;
   the traversal from c9 down to c5 and c6 is done only to find c5
   and c6 to start the "real" traversal from. 

Now, "--after 2" will still show "c9", the tip you start your
traversal from, and this is important in the context of "blame".

Unlike "git rev-list" (and "git log" family of commands), which can
take more than one positive endpoints in the history (e.g. it is
perfectly sensible to ask "git log -p ^c1 c5 c6 -- myfile" in the
example topology above), "git blame" must be given exactly one
positive endpoint, as "git blame ^c1 c5 c6 -- myfile" would not make
any sense (ask: "do we want to know about myfile in c5?  or myfile
in c6?").

I think we also ignore "-n 4" in "blame -n 4 c9 -- myfile" (I didn't
check), but that is not because the operation fundamentally does not
make sense (like "--until") but because whoever wrote "blame" did
not think of the need to support it---in other words, if somebody
wants to add support for that option, I offhand do not see a
fundamental reason to reject it.

I do think appearing to take and understand and then silently
ignoring an option is bad, and it will help users if we tighten the
error checking while parsing the command line.

