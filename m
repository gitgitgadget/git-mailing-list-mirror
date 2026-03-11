Received: from mail-gateway-shared02.cyon.net (mail-gateway-shared02.cyon.net [194.126.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8B62D0610
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266436; cv=none; b=S0yJhxKBhOX8l1+6k3THXSPebioOkpKhO1oiIRz/G3CxLtAKws9WHAckdVGA6QP3MnIHyOick+68UKeJDNXaO1BZEh/i9q/00EU09+h9RDEvVq1kf2vaj5XJehNqUpyvYlid8GqPL4VL0hr6GNbG/ww2M+BShVQXzng0D8TKHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266436; c=relaxed/simple;
	bh=iS30zoeMLE6OBnx1feypEe93hOXeMTi4+ctwxCb4tAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQkTG2N1EkRpGBgw14bnwcHxtgxPc5ZhGKH+vSB556gqTk5BTfjh0B7Pz2O71v/dM6gXs5OVioRZtKRdKIhEJwREP6uczgcNXNj9Dlt8DPGqp/JrkEHgSc77cKI/0GYGwWxkQrbn2XH55adC18U6txGfW2HrJHBR6iHJjukD57Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared02.cyon.net with esmtpsa (TLS1.2:ECDHE_SECP256R1__RSA_SHA512__AES_256_GCM:256)
	(Exim)
	(envelope-from <dev+git@drbeat.li>)
	id 1w0RbS-00Aekf-2W
	for git@vger.kernel.org;
	Wed, 11 Mar 2026 23:00:32 +0100
Received: from [10.20.10.54] (port=49060 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.98.1)
	(envelope-from <dev+git@drbeat.li>)
	id 1w0RbN-0000000FcIj-2flh;
	Wed, 11 Mar 2026 23:00:25 +0100
Message-ID: <d9338d30-3e73-4cb7-9f8f-cc1ce21c9de4@drbeat.li>
Date: Wed, 11 Mar 2026 23:00:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] imap-send: remove two string length checks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20260311121107.1122387-1-dev+git@drbeat.li>
 <20260311121107.1122387-4-dev+git@drbeat.li> <xmqq4immp56h.fsf@gitster.g>
Content-Language: de-CH
From: Beat Bolli <dev+git@drbeat.li>
In-Reply-To: <xmqq4immp56h.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Hi Junio

On 11.03.2026 19:55, Junio C Hamano wrote:
> Beat Bolli <dev+git@drbeat.li> writes:
> 
>> At this point, these two checks verify that the ASN1_STRINGs are
>> internally consistent. This may have been ok when the fields were
>> accessed directly, but now that the API is used, is unnecessary.
>>
>> Remove the two checks.
> 
> Oswald already gave a similar comment, but
> 
>   * I am not sure what you meant by "ok" in "may have been ok".  Do
>     you mean "with raw access to the fields, it may have been made
>     send to ensure validity of ASN1_STRING"?
> 
>   * I am also not sure what you meant by "now that the API is used".
>     Who in the code uses which API function so that we do not have to
>     do our sanity checking?
> 
>     The call to host_matches() that these extra checks protect are
>     still passing raw "const char *" in this step, and the change to
>     pass ASN1_STRING does not happen until [4/4], so you did not mean
>     host_matches().  I am not sure what it is.
>     
> Thanks.

I didn't realize that the strlen() comparison was meant to check for 
embedded NULs. I'll send v2 shortly that keeps this check.

Cheers, Beat


>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>> ---
>>   imap-send.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index 2a904314dd..2bb0003f08 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -253,8 +253,6 @@ static int verify_hostname(X509 *cert, const char *hostname)
>>   			ASN1_STRING *subj_alt_str = GENERAL_NAME_get0_value(subj_alt_name, &ntype);
>>   
>>   			if (ntype == GEN_DNS &&
>> -			    strlen((const char *)ASN1_STRING_get0_data(subj_alt_str)) ==
>> -				    ASN1_STRING_length(subj_alt_str) &&
>>   			    host_matches(hostname, (const char *)ASN1_STRING_get0_data(subj_alt_str)))
>>   				found = 1;
>>   		}
>> @@ -270,8 +268,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
>>   	    (cname_entry = X509_NAME_get_entry(subj, i)) == NULL ||
>>   	    (cname = X509_NAME_ENTRY_get_data(cname_entry)) == NULL)
>>   		return error("cannot get certificate common name");
>> -	if (strlen((const char *)ASN1_STRING_get0_data(cname)) == ASN1_STRING_length(cname) &&
>> -	    host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
>> +	if (host_matches(hostname, (const char *)ASN1_STRING_get0_data(cname)))
>>   		return 0;
>>   	return error("certificate owner '%s' does not match hostname '%s'",
>>   		     ASN1_STRING_get0_data(cname), hostname);

