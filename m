Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A67208DB
	for <e@80x24.org>; Sat, 26 Aug 2017 01:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754684AbdHZBB1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 21:01:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59945 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754250AbdHZBBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 21:01:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E266DA2A71;
        Fri, 25 Aug 2017 21:01:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lcPRbSn+CNAz22gXWuWLjV7PT6A=; b=k0ZTEK
        DM93WPmiB1qxNYn9fhtoOxulR8luvLV6hoJ7pT2P0lg35ig0BsSTJy5M+YlE7u7f
        hXznogoA/qRua71jeABeG+LOQe6wMZ0dOT6D+FrwBJ6kv3ccPzkSL3TD8Krmv/7a
        UuQVH5izu6SBAeI6KGKzCVFNp8oSO0xYeK73A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c+vEFXjrw9sCRPSQVvvQwK6VIC/BZFaV
        zw7BRoV67R5ziZKgdtuDkpVge8U8Ua5a02ILMJzy5IqpUZYcqBqDI6I0ek7CscZz
        14cj1nPti/ZcVSwSS3M+1icPX/3tiYEIz0zY6YfoXfdoZsioHWc1kb8babKiX9wk
        60asuyZR8Rs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAD86A2A70;
        Fri, 25 Aug 2017 21:01:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43C5FA2A6E;
        Fri, 25 Aug 2017 21:01:21 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>, git@vger.kernel.org,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: git signed push server-side
References: <22944.38288.91698.811743@chiark.greenend.org.uk>
        <20170826003229.GL13924@aiede.mtv.corp.google.com>
Date:   Fri, 25 Aug 2017 18:01:19 -0700
In-Reply-To: <20170826003229.GL13924@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 25 Aug 2017 17:32:29 -0700")
Message-ID: <xmqqshgfqh0g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1312FC52-89FA-11E7-A325-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> +Dave Borowitz, who implemented push cert handling in JGit and Gerrit
> Hi Ian,
>
> Ian Jackson wrote[1]:
>
>> I have been investigating git signed pushes.  I found a number of
>> infelicities in the server side implementation which make using this
>> in practice rather difficult.  I'm emailing here (before writing
>> patches) to see what people think of my proposed changes.
>>
>> 1. PUSH_CERT_KEY has truncated keyid (Debian #852647)
>>
>> I see this:
>>   GIT_PUSH_CERT_KEY=A3DBCBC039B13D8A
>>
>> There is almost no purpose for which this 64-bit keyid can be safely
>> used.  The full key fingerprint should be provided instead.
>>
>> Proposed change: provide the full fingerprint instead.  Do this
>> for every caller of gpg-interface.c.
>
> Sounds sane.

I probably should react a bit stronger against that "instead", as
Ian will not be writing the world's first server side hook that uses
this interface.  A different variable that lets you read the full
length "in addition" I wouldn't have a problem with, as existing
scripts will continue working the same way if you did so.

But on the other hand, the value of this environment is not meant to
be used to make decision by the hook anyway, so it perhaps is OK to
change it in a backward incompatible way to break those who have
been using the value for any serious purpose.

The purpose of the signed push is not to replace authentication and
authorization.  The primary goal behind the signed push mechanism is
to allow server side hook to implement a way to store these certs in
the order it receives without losing them, and that gives a way for
the server operators to protect against claims that they are showing
what the pusher did not intend to publish.  They can say "the tip of
these branches are at this commit, because, see this, a signed cert
by the pusher asking us to put these commits at these branches" with
such a mechanism---as opposed to "we authenticated the user and here
is our server log that says that user pushed to update these refs",
which is much weaker claim that they can make without the signed
push mechanism.
