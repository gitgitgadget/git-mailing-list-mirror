From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] gpg-interface: check gpg signature for correct header
Date: Tue, 14 Jun 2016 13:34:20 +0200
Message-ID: <3ccf7649-be0e-dcb8-c9a7-cdc36dc85d16@drmicha.warpmail.net>
References: <e129da8e-4e1d-c535-ca62-d2a4c2e23799@drmicha.warpmail.net>
 <2f473a993b6bc951dec76d38c11d0e600b59b8d3.1465902530.git.git@drmicha.warpmail.net>
 <20160614112006.GA15889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ZhenTian <loooseleaves@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 13:34:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCmc6-0001Y3-7H
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 13:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752376AbcFNLeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 07:34:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59039 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752358AbcFNLeX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jun 2016 07:34:23 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 59C6A21E54;
	Tue, 14 Jun 2016 07:34:22 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Tue, 14 Jun 2016 07:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=whsaJ3ypSo+0yPuu6pKipcbRTxs=; b=SpB8Yv
	EHUrPafxfpnagDipu5zwiM/3G/v0Ylp7DL/tN0K7gS1Ux/svyMJAdW+Q2UlF/eWq
	PYYGR4aAycfKjzX8CWbprg1br1KTRVCbzEX9Zq0XrrXRPYIVyEjslTYYxuBrqJz7
	7YPtlL3NIxbgC3N30qFMNHbhYgJnw0qF9rN/I=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=whsaJ3ypSo+0yPu
	u6pKipcbRTxs=; b=Q+DqOu/2VOadwrNeYUR+GaJmcOtcLnPXQOYo2eUwsV4BsNx
	ecZz7cEyFqnSfuStHvA0W4t2ProiX4gJbZagC7HOVlcPx2qLK+1PcqDkKJW8P7Fc
	ZGsshIARJ6iYEIR8LP9kZ6+TFna15xtHORhBF38TCSltfzmnKmfkXt7AFCJE=
X-Sasl-enc: Sm5WvjNnrYb3XIUZAZJuR3QNlewDITLjzwsWWW3pxZeQ 1465904061
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id AE689CC070;
	Tue, 14 Jun 2016 07:34:21 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160614112006.GA15889@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297289>

Jeff King venit, vidit, dixit 14.06.2016 13:20:
> On Tue, Jun 14, 2016 at 01:11:19PM +0200, Michael J Gruber wrote:
> 
>> When we create a signature, it may happen that gpg returns with
>> "success" but not with an actual detached signature on stdout.
>>
>> Check for the correct header to catch these cases better.
> 
> Seems like a reasonable idea.
> 
> I do worry that checking for PGP_SIGNATURE is a little fragile, though.
> We currently let you sign with gpgsm, for example, and I think this
> would break it (the verification side is not great because we don't
> recognize gpgsm headers, but this feels like a step backwards).
> 
> That wouldn't be too hard to work around with a "is this a signature"
> function that checks both types.
> 
>> diff --git a/gpg-interface.c b/gpg-interface.c
>> index c4b1e8c..664796f 100644
>> --- a/gpg-interface.c
>> +++ b/gpg-interface.c
>> @@ -185,7 +185,7 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
>>  
>>  	sigchain_pop(SIGPIPE);
>>  
>> -	if (finish_command(&gpg) || !len || len < 0)
>> +	if (finish_command(&gpg) || !len || len < 0 || strncmp(signature->buf, PGP_SIGNATURE, strlen(PGP_SIGNATURE)))
>>  		return error(_("gpg failed to sign the data"));
> 
> I think your strncmp is better spelled:
> 
>   starts_with(signature->buf, PGP_SIGNATURE);
> 
> The check for "!len" is redundant now. I think you could drop "len < 0"
> as well (and in fact, drop the "len" variable entirely), as in the error
> case we'd simply have an empty signature->len.
> 
> Your patch effectively swaps out "did we get any data" for "did we get
> the data we expect", which is what those "len" checks were doing.
> 
> -Peff
> 

My patch actually makes several tests fail, sorry. (I did check before
that I can still create signatures...) Maybe my offset in buf is wrong.

starts_with, yes.

Can't check any further now, sorry. But we do check for the
PGP_SIGNATURE in our signed objects anyways. So I feel that we can either

- tighthen the check for valid gpg signatures

or

- make our signature interface completely pluggable.

We can't have it both ways, but at least things are localised in
gpg-interface.c now.

The proposed patch is just some consistency check that does not rely on
gpg.program itself(!), or else we could simply call verify.

Michael
