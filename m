From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Verify Content-Type from smart HTTP servers
Date: Fri, 01 Feb 2013 10:09:26 -0800
Message-ID: <7vip6bc3e1.fsf@alter.siamese.dyndns.org>
References: <7v38xhf1i3.fsf@alter.siamese.dyndns.org>
 <20130201085248.GA30644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1L3h-0003sx-7X
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 19:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab3BASJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 13:09:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753156Ab3BASJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 13:09:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5211B51F;
	Fri,  1 Feb 2013 13:09:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6R8NHkvpyNYMddRtpPXAseq0uK8=; b=Myer8N
	Bcwp8icV6hjox5JkO/P64keBPwFM76Anmm/2hiIs8aHiooxQ+7VwCTG7LxokWvU8
	R5hElnnRZGXnQ50Lj9J6U/ZMzJIE8/eZgKURweQzq4vR+ksVxxFrAgtHG+HWoyCk
	RwaM1Ym+HV/UYQuh+eAi21SQ4fehbw1HFxZHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dcj+wSyMx9iHks6WusPmm0pgx3ibjaiS
	JDxLp1DAprXpyQGLyLkxF0YwcQCJhw79kU5c6JNaTihVZDtkxy3N2vN2f58Rspa9
	I45OnkaHxj8+yVv1XMgNyNecEnAqdIW7jE/V9AgBf0H2TzNz6JaD4mK8A4poIF2R
	vfb74/ZL7+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9B77B51E;
	Fri,  1 Feb 2013 13:09:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4247FB51A; Fri,  1 Feb 2013
 13:09:28 -0500 (EST)
In-Reply-To: <20130201085248.GA30644@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Feb 2013 03:52:49 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84C4D3F2-6C9A-11E2-81B3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215241>

Jeff King <peff@peff.net> writes:

> Should this be "From:" Shawn? The tone of the message and the S-O-B
> order makes it look like it.

Yes. I should have left that line when edited the format-patch
output in my MUA to say I was resending something that vger rejected
and people did not see after tweaking the patch to slip their taboo
list.

>> @@ -133,16 +135,19 @@ static struct discovery* discover_refs(const char *service)
>>  	last->buf = last->buf_alloc;
>>  
>>  	if (maybe_smart && 5 <= last->len && last->buf[4] == '#') {
>> -		/* smart HTTP response; validate that the service
>> +		/*
>> +		 * smart HTTP response; validate that the service
>>  		 * pkt-line matches our request.
>>  		 */
>> -		struct strbuf exp = STRBUF_INIT;
>> -
>> +		strbuf_addf(&exp, "application/x-%s-advertisement", service);
>> +		if (strbuf_cmp(&exp, &type))
>> +			die("invalid content-type %s", type.buf);
>
> Hmm. I wondered if it is possible for a non-smart server to send us down
> this code path, which would now complain of the bogus content-type.
> Something like an info/refs file with:
>
>   # 1
>   # the comment above is meaningless, but puts a "#" at position 4.
>
> But I note that we would already die in the next line:
>
>>  		if (packet_get_line(&buffer, &last->buf, &last->len) <= 0)
>>  			die("%s has invalid packet header", refs_url);
>
> so I do not think the patch makes anything worse. However, should we
> take this opportunity to make the "did we get a smart response" test
> more robust? That is, should we actually be checking the content-type
> in the outer conditional, and going down the smart code-path if it is
> application/x-%s-advertisement, and otherwise treating the result as
> dumb?

Does the outer caller that switches between dumb and smart actually
know what service type it is requesting (I am not familiar with the
callchain involved)?  Even if it doesn't, it may still make sense.

> As a side note, should we (can we) care about the content-type for dumb
> http? It should probably be text/plain or application/octet-stream, but
> I would not be surprised if we get a variety of random junk in the real
> world, though.

The design objective of dumb http protocol was to allow working with
any dumb bit transfer thing, so I'd prefer to keep it lenient and
allow application/x-git-loose-object-file and somesuch.

Thanks.
