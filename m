Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0D3202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 03:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756390AbdKQDY2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 22:24:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52147 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755775AbdKQDY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 22:24:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B3877A05E2;
        Thu, 16 Nov 2017 22:24:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0bYb9nverID9eBSxjCZ0Wlazjww=; b=Zwnjxz
        knEUXR+4jclQYdBqmj0ow6JhXkGuMO1vR+JWzvyN6ZRYLsEPxjX7pINVuD0wi6VC
        1D9n9OCW2ba3qBer5CfRv5GdaxDPXS+IZudrI2KBWL2SYzpmWx1NRw9Zpk2FD4tP
        ip/9HH26bFDBZJA4FWi2mapx8RVX47S7NtEgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wtoP5BUNC+3Hv6b5KieP0t5rF+aCtOHE
        BJkMH9H+CoC6oL+mnSbtEf+MBecxlEyeyhUSkAh91D0VvbD7QOO0DwOmG02ZYxZY
        Qe8HnGXDEplpMuTRD7XTkZQMf7bLX7QNFwsGvPbk2VzwpNgAvTHbfM915236KPs5
        P9InYztAFlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA591A05E1;
        Thu, 16 Nov 2017 22:24:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 26295A05E0;
        Thu, 16 Nov 2017 22:24:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Michelbach <michelbach94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Documentation of post-receive hook
References: <1510872031.23230.7.camel@gmail.com>
        <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 17 Nov 2017 12:24:24 +0900
In-Reply-To: <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 17 Nov 2017 10:41:21 +0900")
Message-ID: <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0588470-CB46-11E7-9418-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>     This hook is invoked by 'git-receive-pack' on the remote repository,
>>     which happens when a 'git push' is done on a local repository and
>>     successfully transfers at least 1 commit.
>
> I am not sure "at least 1 commit" is a good phrase to use here.
> There are transfer that sends objects but no commit object, and the
> above makes it sound as if such a transfer will not trigger the
> hook.  Would
>
> 	This hook is run by 'git receive-pack' on the remote
> 	repository, after it receives objects sent by 'git push'.
>
> be clear enough to teach readers that a no-op push that recieve-pack
> does not receive any object does not trigger the hook?

Actually I take this back.  Your original observation "only when at
least one commit is transferred" is not even correct.

You can try what I just tried to make sure:

        $ git clone --no-local . ../victim
        $ cat >../victim/.git/hooks/post-receive <<\EOF
        #!/bin/sh
        (
            echo "post receive was here at $(date)"
            cat 
        ) >>../STAMP
        EOF
        $ chmod +x ../victim/.git/hooks/post-receive
        $ git push ../victim master:foo

The last "push" does not transfer any object (and obviously does not
satisfy your "at least 1 commit" requirement), but it does update
the STAMP file.  This is because it updates a ref and that is what
post-receive wants to react to, even if there is no new objects
placed in the receiving repository.

So an updated suggestion for the text would be:

     This hook is invoked by 'git-receive-pack' on the remote repository,
     which happens when a 'git push' is done on a local repository.

Oh, wait.  That is what we already have ;-).

Having said all that, there is one case that running 'git push' does
*NOT* cause 'receive-pack' to be invoked at the other end, and in
that scenario, obviously the hook cannot be run, simply because the
command that would run the hook is not run in the first place.

After the above sequence against the "victim" test repository, you
could try:

        $ git push ../victim master:foo
	Everything up-to-date

and observe that the STAMP file is not updated.

What is happening is that "git push" notices that there is nothing
gained by invoking receive-pack on the other side, because the
branch 'foo' already points at the commit at the tip of our
'master'.

So it might technically be an improvement to update the text to
mention that 'git push' does not necessarily always lead to
invocation of receive-pack, something like:

     This hook is invoked by 'git-receive-pack' on the remote
     repository, which may happen when a 'git push' is done on a
     local repository.

but then that introduces the need to make the reader understand what
"may happen" is trying to say, iow, when does a user 'push' and it
does not trigger receive-pack?

But I do not think teaching that (i.e. when does receive-pack run?)
is the job of this paragraph, whose primary objective is to teach
about this hook that is run when receive-pack is run.  So...
