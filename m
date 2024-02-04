Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D0B65E
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 22:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707086887; cv=none; b=oqp62DF9kY66F9+VRIbIOUPUb9gep+QCL+GC8lQNQWvhdqaiIQiW5p61zqqkU2l0IaJwghmAybYZIhv4bwQ0/QyoedRwYF4Rph9ssymIob1LSX659uHdPKeT03FxtHor0Ng4zCr92eKWdXBJQR6j0vRJT8zuphggEUzhLMYM5nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707086887; c=relaxed/simple;
	bh=4YCS9PaJ+vt6t3RCLmDayH+0YVA+oQW1BlwEstrQvxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XtKdIkdLGqicWa4yux35mRHm/h/WB2qfhKsoc2bnYKu5Nl18bF6EqZ14J7yKrSr6xr74WFej+aRCvKSrvQZKlgY/U8UbBhFx5YJ5zuAlXcEJm8kxRJwqcIrYLWmyk4nwZFeCm3u5CjIlLukEqMqAwgul8MRFaWyTPKN2Y2+UHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sJOfdS+L; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sJOfdS+L"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BAABF1D90BF;
	Sun,  4 Feb 2024 17:47:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4YCS9PaJ+vt6t3RCLmDayH+0YVA+oQW1BlwEst
	rQvxs=; b=sJOfdS+Lvh6h4Th0pOBesgwhC2At9ISPbAQIfUCUOC2IhjPkjoa8np
	csDcWhpoIerX69KEMeoTWQb3cUWsznKp9aNB8T8GaQ5/VGfdKVJFyR4vouwC15mv
	b99/57XSqiqSbjIqGwJ89B0fgBdYU661CSsx4e85vCIHASOW8lFho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B1F8F1D90BE;
	Sun,  4 Feb 2024 17:47:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 191D81D90BD;
	Sun,  4 Feb 2024 17:47:58 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Quentin Bouget <ypsah@devyard.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] http: only reject basic auth credentials once they
 have been tried
In-Reply-To: <20240204185427.39664-2-ypsah@devyard.org> (Quentin Bouget's
	message of "Sun, 4 Feb 2024 19:54:26 +0100")
References: <20240204185427.39664-1-ypsah@devyard.org>
	<20240204185427.39664-2-ypsah@devyard.org>
Date: Sun, 04 Feb 2024 14:47:56 -0800
Message-ID: <xmqqfry7onhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 71379676-C3AF-11EE-A00F-25B3960A682E-77302942!pb-smtp2.pobox.com

Quentin Bouget <ypsah@devyard.org> writes:

>  	else if (results->http_code == 401) {
> -		if (http_auth.username && http_auth.password) {
> -			credential_reject(&http_auth);
> -			return HTTP_NOAUTH;
> -		} else {
> +		if ((http_auth_methods & CURLAUTH_GSSNEGOTIATE) == CURLAUTH_GSSNEGOTIATE) {
>  			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
>  			if (results->auth_avail) {
>  				http_auth_methods &= results->auth_avail;
>				http_auth_methods_restricted = 1;
>			}
>			return HTTP_REAUTH;
>		}
> +		if (http_auth.username && http_auth.password)
> +			credential_reject(&http_auth);
> +		return HTTP_NOAUTH;

A few comments and questions.

 * GSSNEGOTIATE is a synonym for NEGOTIATE since cURL 7.38.0
   (released in Sep 2014); currently the earliest version we claim
   to support is 7.19.5 (released May 2009) without imap-send, and
   we require 7.34.0 (released Dec 2013) with imap-send, so for now,
   it is prudent that this patch uses GSSNEGOTIATE.

 * Is it something that the client code of libcURL can rely on that
   these CURLAUTH_FOO macros are bitmasks [*]?  If so, wouldn't

	if ((http_auth_methods & CURLAUTH_GSSNEGOTIATE))

   be clear enough (and less risk of making typo)?

 * When we see 401, the first thing we do in the new code is to see
   if GSS is enabled in auth_methods, and if so we drop it from
   auth_methods (to prevent us from trying it again) and say REAUTH.

   - What assures us that the presense of GSS bit in auth_methods
     mean we tried GSS to get this 401?  Could it be that we tried
     basic and seeing 401 from that, but we haven't tried GSS and we
     could retry with GSS now?  Is it commonly known that GSS is
     always tried first before Basic/Digest when both are availble,
     or something like that?

   - When auth_avail was given by the cURL library, we further limit
     the auth_methods (after dropping GSS) and say REAUTH.  This is
     not a new to the updated code, but can it happen that the
     resulting restricted auth_methods bitmap becomes empty (i.e.
     REAUTH would be useless)?


Thanks.

[References]

 * https://github.com/curl/curl/blob/b8c003832d730bb2f4b9de4204675ca5d9f7a903/include/curl/curl.h#L787C4-L787C64
