Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A44920705
	for <e@80x24.org>; Thu,  7 Jul 2016 22:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbcGGWG6 (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 18:06:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752246AbcGGWG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 18:06:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CAE042A1A1;
	Thu,  7 Jul 2016 18:06:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AqLd9+Oy0nW+VCJ+ntLOXXJLgqQ=; b=J/6i8v
	/paoGhm9u9+JmHrMO2WTL7d7nCoy8/CI9Td0ZvGiTiooky7UU7JwKisophD5rCOs
	5pxpD2ozpHsNbiccnwueAn6ILo6DpffPnW4033MVRZ4L9KUaGwTAAR5/HUC3c6he
	Gv9lIpZ8gpjE5LP2xXGrTmJty5KbhQn/NxgJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HFxsq+lG1viVmHn6YYbCVhC/86TNeeHY
	Rf6VNMi3A99+1/yQkSB+8zi7Q3BOaP6zHlYr7Ij3AHfqWzgT9dCODqNVUeYt9aBt
	MibXx1RSErgwx5SXgPWMrO+UdzIufxKpQIZ8qfOGxJbJqpri4hHf++jSw5IBIBry
	wwCY7ulHVQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C28842A1A0;
	Thu,  7 Jul 2016 18:06:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C0452A19E;
	Thu,  7 Jul 2016 18:06:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-3-sbeller@google.com>
	<xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
Date:	Thu, 07 Jul 2016 15:06:53 -0700
In-Reply-To: <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
	(Stefan Beller's message of "Thu, 7 Jul 2016 14:41:37 -0700")
Message-ID: <xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DE3D0F4-448F-11E6-9746-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> No, there is no good objective reason. I added it just after the atomic
> flag as that is what I implemented.
>
> Is there a reason for a particular order of capabilities? I always considered
> it a set of strings, i.e. any order is valid and there is no preference in
> which way to put it.

That is correct, but "there is no inherent order or grouping" does
not lead to "hence it is OK to put a new thing at a random place in
the middle."

If a reviewer sees a new thing at some specific point in a
collection, when the collection is understood not to have any
specific order or grouping, it makes the reviewer doubt the
belief--there must be a reason why this was placed not at the end;
otherwise a new thing wouldn't be placed randomly at the middle.

If you place a new thing at the end, it still leaves ambiguity; it
may be there because there is no inherent order or grouping, or the
new one is sorts later than the one that used to be at the last or
somehow related to it.  

> I agree on this for all content that can be modified by the user
> (e.g. files in the work tree such as .gitmodules), but the .git/config
> file cannot be changed remotely. So I wonder how an attack would
> look like for a hosting provider or anyone else?
> We still rely on a sane system and trust /etc/gitconfig
> so we do trust the host/admin but not the user?

It is not "we" do trust; it is "we let host/admin trust itself while
making sure that they can protect themselves from their users".

>> More importantly, if we plan to make this configurable and not make
>> the limit a hardwired constant of the wire protocol, it may be
>> better to advertise push-options capability with the limit, e.g.
>> "push-options=32" (or even "push-options=1024/32"), so that the
>> client side can count and abort early?
>
> Yeah we may want to start out with a strict format here indicating
> the parameters used for evaluating the size.
> So what do these numbers mean?
>
> I assume (and hence I should document that,) that the first (1024)
> is the maximum number of bytes per push option. The second
> number (32) is the number of push options (not the number of pkts,
> as one push option may take more than one pkt if the first number is
> larger than 65k, see the NEEDSWORK comment.)
>
> Do we really need 2 numbers, or could we just have one number
> describing the maximum total size in bytes before the remote rejects
> the connection?

That's for you to decide.  push-options=32 is probably OK but it
will prevent a well-behaving "git push" from catching a request that
will be rejected, if you are basing the receiver side decision on
the other number.

The suggestion was primarily my reaction after seeing the two new
calls to die() on the receiver side, whose message I was not sure
will be given to the user who is pushing, i.e.

> When not going over ssh://, does the user see these messages?

Your "git push" will be collecting the options in a string-list
while parsing the options, so it would be able to check immediately
upon seeing the advertised capability if it will trigger this
protocol error even before making the request, which would be a good
thing to do, and I am reasonably sure we can give a better error
message if we do that on the local side without having the receiver
to tell you (for one thing, we can i18n the local side error
message more easily).

