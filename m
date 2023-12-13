Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lVIM2iH4"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA9B0
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 06:54:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 73CB332F2E;
	Wed, 13 Dec 2023 09:54:08 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=L0baNStqwGB9h1nuMd128m+DtEbj2R+c3rMeHN
	xD6uY=; b=lVIM2iH4Q/2WRt9zNsI1FwURGGWrMFvHqgQc8rrqCdt8pDklYD7xVI
	dfW+pWXyNnj5RLEh8qBwfEUNE0OYvTw74Fdyz8wsMujD9apyarrVR7eS7LmG84pZ
	6TqsWGbiFhfn+SO1L1uRGBWeiGbgS+5HbghrnD3Gy2pPAPeeSwVUc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6BD6532F2D;
	Wed, 13 Dec 2023 09:54:08 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0D65532F2C;
	Wed, 13 Dec 2023 09:54:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Carlos =?utf-8?Q?Andr=C3=A9s_Ram=C3=ADrez_Cata=C3=B1o?=
 <antaigroupltda@gmail.com>
Subject: Re: [PATCH] mailinfo: fix out-of-bounds memory reads in
 unquote_quoted_pair()
In-Reply-To: <ZXlYIZ0Hb1kN84NU@tanuki> (Patrick Steinhardt's message of "Wed,
	13 Dec 2023 08:07:21 +0100")
References: <20231212221243.GA1656116@coredump.intra.peff.net>
	<ZXlYIZ0Hb1kN84NU@tanuki>
Date: Wed, 13 Dec 2023 06:54:03 -0800
Message-ID: <xmqqy1dynofo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75E770B8-99C7-11EE-B637-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>>  static const char *unquote_quoted_string(struct strbuf *outbuf, const char *in)
>>  {
>> -	int c;
>>  	int take_next_literally = 0;
>>  
>> -	while ((c = *in++) != 0) {
>> +	while (*in) {
>> +		int c = *in++;
>>  		if (take_next_literally == 1) {
>>  			take_next_literally = 0;
>>  		} else {
>
> I was wondering whether we want to convert `unquote_quoted_pair()` in
> the same way. It's not subject to the same issue because it doesn't
> return `in` to its callers. But it would lower the cognitive overhead a
> bit by keeping the coding style consistent. But please feel free to
> ignore this remark.

Yeah, I was wondering about the value of establishing a pattern that
can be followed safely and with clarity, too.  I also briefly
wondered how bad if we picked the "compensate for the increment done
by the last iteration before leaving the loop by returning (in-1)"
idiom (which Peff called "a hacky way") to be that universal
pattern, but this bug was a clear enough evidence that it does not
work very well in developers' minds.

I actually had trouble with the proposed update, and wondered if

-	while ((c = *in++) != 0) {
+	while ((c = *in)) {
+		in++;

is easier to follow, but then was hit by the possibility that the
same "we have incremented 'in' a bit too early" may exist if such
a loop wants to use 'in' in its body.  Wouldn't it mean that

-	while ((c = *in++) != 0) {
+	for (; c = *in; in++) {

would be even a better rewrite?

Enough bikeshedding...

> Another thing I was wondering about is the recursive nature of these
> functions, and whether it can lead to similar issues like we recently
> had when parsing revisions with stack exhaustion. I _think_ this should
> not be much of a problem in this case though, as we're talking about
> mail headers here. While the length of header values isn't restricted
> per se (the line length is restricted to 1000, but with Comment Folding
> Whitespace values can span multiple lines), but mail provdiers will sure
> clamp down on mails with a "From:" header that is megabytes in size.

Good thinking, and I think Peff's iterative rewrite would be a good
way to deal with it if it ever becomes an issue.

> So taken together, this looks good to me.

Thanks, both, for writing and reviewing.

