Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F772070D
	for <e@80x24.org>; Fri,  8 Jul 2016 18:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbcGHSk0 (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 14:40:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755939AbcGHSkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 14:40:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5895028964;
	Fri,  8 Jul 2016 14:39:56 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B6Cw7XwGEwu0fr6pxxgJn69wTNY=; b=I3r2hc
	yEyDy8YnR+3YglxEJ5d3eOzenVH8y03Ii0bn0to+Or3oqVMLXAR6JBWG/PIm07kY
	8d+eOMi+3Oa2gmahOluj7K8/0dCkytEWOIG/dggUlXQvEv+a8KHXZhajKLGvOvgw
	80B9ZDuE9ISH4SEO7tKo4VClXlVRfdlfg62ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yYaMb2G1x6aMI0cgfYWTqxCcmcOKyc8O
	6sh3YMFMkD6uKfDrx53WaIlaM093lNcv54ODAKeZMqcopLnWOVAIssaO6JiCqKYI
	zknIb0LPWFBVu/BLoMOolYQVHPKGnFmKgKSI++PsQ2+94LNfYrH2YsTWX0eh0cTY
	Q5fEDXO5vAo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4FB2428963;
	Fri,  8 Jul 2016 14:39:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CC84C28962;
	Fri,  8 Jul 2016 14:39:55 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-3-sbeller@google.com>
	<xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
	<xmqqh9c1nlvm.fsf@gitster.mtv.corp.google.com>
	<20160708175821.GA29326@google.com>
Date:	Fri, 08 Jul 2016 11:39:53 -0700
In-Reply-To: <20160708175821.GA29326@google.com> (Jonathan Nieder's message of
	"Fri, 8 Jul 2016 10:58:21 -0700")
Message-ID: <xmqqshvkkm86.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DB85E64-453B-11E6-9264-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Junio C Hamano wrote:
>> Stefan Beller <sbeller@google.com> writes:
>
>>>> More importantly, if we plan to make this configurable and not make
>>>> the limit a hardwired constant of the wire protocol, it may be
>>>> better to advertise push-options capability with the limit, e.g.
>>>> "push-options=32" (or even "push-options=1024/32"), so that the
>>>> client side can count and abort early?
>
> Sorry to butt into the conversation late, but: I am not yet convinced.
>
> Is the idea that if the push options were very large, this would save
> the client from the cost of sending them?  

Not really.  I have no strong opinion on the benefit of limiting
number/size.  Stefan limited the number/size at the receiving end
and made receiving end die with its message.  I was merely trying to
tweak the arrangement so that the sending end can complain with its
own message, possibly in its own language, especially because it was
unclear to me if the die() message on the receiving end would always
go back to the sending end correctly.

> But this comes with a
> downside: the server doesn't get to send an error message about
> where 
> the maximum number of push options can come from (e.g., with a link to
> a page where the limit can be adjusted, or with an explanation of when
> clients tend to run into this problem and what they should do
> instead).

Hmm, interesting point.  That would be better told by the receiving
end, as the way to configure it (if offered) would be different from
installation to installation.

> So I'd like to propose an alternative. What if the client tells the
> server the number of push options early on (and possibly also a cap on
> the length of those push options)?  That way, the client doesn't have
> to waste bit sending the push options but the server gets an
> opportunity to send a helpful error message on sideband 3.
>
> 	server> HEAD\0push-options ...
> 	client> ... commands ...
> 	client> push-options 2
> 	client> my-first-option
> 	client> my-second-option

