Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6294EC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC3D613B1
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243153AbhI1Xsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:48:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50960 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhI1Xse (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:48:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FA9AF4103;
        Tue, 28 Sep 2021 19:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nkA4twUTppDQlvIh789vHMgw3sgOK2lUIX6ZOM
        MOrL8=; b=Z/bNVHAuQ46jq2d4Y5aRcB9pKoGo7FqERQSEvqbe4CGLODdA2aC18h
        WnlWwS0JkDkonzVvVGnCZa66fMrF7AJGmrReAVeAPDTy0o54DjNcqjILvcGbA0X0
        gzgQa9bPsrzqTIfpPXiHw9Qy7vQbelAu6TP/1wfkYoBoWaoJWUNEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37536F4102;
        Tue, 28 Sep 2021 19:46:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9FE31F4101;
        Tue, 28 Sep 2021 19:46:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Joey Hess <joeyh@joeyh.name>, git@vger.kernel.org
Subject: Re: [PATCH] avoid insecure use of mail in man page example
References: <20210928121648.1390915-1-joeyh@joeyh.name>
        <YVNi91WYyj3Le6UF@coredump.intra.peff.net>
Date:   Tue, 28 Sep 2021 16:46:52 -0700
In-Reply-To: <YVNi91WYyj3Le6UF@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 28 Sep 2021 14:46:15 -0400")
Message-ID: <xmqqtui4gt5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5BBA352C-20B6-11EC-B48A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 28, 2021 at 08:16:48AM -0400, Joey Hess wrote:
>
>> As recently seen in fail2ban's security hole (CVE-2021-32749),
>> piping user controlled input to mail is exploitable,
>> since a line starting with "~! foo" in the input will run command foo.
>> 
>> This example on the man page pipes to mail. It may not be exploitable.
>> git rev-list --pretty indents commit messages, which prevents the escape
>> sequence working there. It's less clear if it might be possible to embed
>> the escape sequence in a signed push certificate. The user reading the
>> man page might alter the example to do something more exploitable.
>> To encourage safe use of mail, add -E 'set escape'
>
> Seems like a good goal, but is "-E" portable?
>
> On my system, where "mail" comes from the bsd-mailx package, "-E" means
> "do not send a message with an empty body" and your example command
> barfs as it tries to deliver to the recipient "set escape".
>
> At least we'd want to make a note in the documentation saying what the
> mysterious "set escape" is doing, and that not all versions of mail
> would need / want it.

It is not the primary focus for this documentation page to teach how
to send e-mails in the first place.  Instead of risking confused
users rightly complain with "my 'mail' does not understand the -E
option---what does this do?", I wonder if it is better to just change it to

	git rev-list --pretty ...
-   fi |
-   mail -s ...    
+   fi >>/var/log/update.log

so that it illustrates what's available *out* *of* *us* to the
authors of the script, without having to teach them "mail" and other
things we are responsible for.

