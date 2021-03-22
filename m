Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC00C433E2
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BF16192B
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 16:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhCVQSR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 12:18:17 -0400
Received: from velociraptor1.cschenk.net ([46.232.251.99]:38112 "EHLO
        velociraptor1.cschenk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhCVQSB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 12:18:01 -0400
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 12:18:01 EDT
Subject: Re: [PATCH v2] remote-curl: fall back to basic auth if Negotiate
 fails
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cschenk.net;
        s=velociraptor1_2019; t=1616429298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0OxLhmZXsn5S9ce4r3YQEaXKfeXv6uZCDbtYVLYNtEI=;
        b=rfzt0CaidUbuBZeTbr9MMZ0V4xG1PR2/6IKsQqNrr1fwWu0rtPJ9yFSZ6bAOL9ylfUXCUU
        Nrj8QVapR+9fhcAP9/le5N8FpDa81KhBneBMkNYaRjS74cotLNUGgqL29z4ObM2RmaAcTj
        TvSygBfLkGC4EEcTP3kg5GguEljBXXj4tIafiCCm/FxWHxAXGZsmGi75vqQRQqGM0mFICl
        Nx4iVraJD/+OsB/pzJDMhiFWYRO1yQLxnyxQ8u9mKQETVj1s+v4F6unIpooqocFrbQ2kRB
        9gRIAn/9JXr+9BANv5698sU78bGtYrGgKuROfmazP5dSXFC/YkPPPEjajUTbNQ==
To:     Junio C Hamano <gitster@pobox.com>,
        Christopher via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
References: <pull.849.git.1611921008282.gitgitgadget@gmail.com>
 <pull.849.v2.git.1613494656636.gitgitgadget@gmail.com>
 <xmqq35xvpr8q.fsf@gitster.c.googlers.com>
From:   Christopher Schenk <christopher@cschenk.net>
Message-ID: <2d995558-1fce-824f-ae65-bcbd3b744cb2@cschenk.net>
Date:   Mon, 22 Mar 2021 17:08:12 +0100
MIME-Version: 1.0
In-Reply-To: <xmqq35xvpr8q.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=christopher smtp.mailfrom=christopher@cschenk.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/16/21 11:44 PM, Junio C Hamano wrote:
> "Christopher via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Christopher Schenk <christopher@cschenk.net>
>>
>> When the username and password are supplied in a url like this
>> https://myuser:secret@git.exampe/myrepo.git and the server supports the
>> negotiate authenticaten method git does not fall back to basic auth and
> 
> s/method git/method, git/;
> 
>> libcurl hardly tries to authenticate with the negotiate method.
> 
> Thanks.
> 
>> Stop using the Negotiate authentication method after the first failure
>> because if it fails on the first try it will never succeed.
> 
> Is this patch needed because we are using cURL library incorrectly,
> or is it the limitation of the cURL library?
I'm no cURL expert, but in my opinon this is a limitation of the cURL 
Libary.
> 
>> V1 of this patch somehow did not make it to the mailing list so i will
>> try to send this patch again
> 
> The last paragraph does not belong to the commit log message; if
> nobody on the list saw the "v1", as far as the project is concerned,
> it never happened.
I have adapted the commit message accordingly.
> 
>> Signed-off-by: Christopher Schenk <christopher@cschenk.net>
>> ---
> 
>> diff --git a/http.c b/http.c
>> index 8b23a546afdf..36f113d46c23 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -1642,6 +1642,14 @@ static int handle_curl_result(struct slot_results *results)
>>   		return HTTP_MISSING_TARGET;
>>   	else if (results->http_code == 401) {
>>   		if (http_auth.username && http_auth.password) {
>> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
>> +			if (results->auth_avail & CURLAUTH_GSSNEGOTIATE) {
>> +				http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
>> +				http_auth_methods &= results->auth_avail;
>> +				http_auth_methods_restricted = 1;
>> +				return HTTP_REAUTH;
>> +			}
>> +#endif
>>   			credential_reject(&http_auth);
>>   			return HTTP_NOAUTH;
>>   		} else {
> 
> Hmph, is this an extension to what 4dbe6646 (remote-curl: fall back
> to Basic auth if Negotiate fails, 2015-01-08) tried to do?  What
> happens on the "else" side after the context of this patch, which
> seems to have come from:
> 
>   - 4dbe6646 (remote-curl: fall back to Basic auth if Negotiate
>     fails, 2015-01-08)
>   
>   - 840398fe (http: restrict auth methods to what the server
>     advertises, 2017-02-22), and
> 
>   - 40a18fc7 (http: add an "auto" mode for http.emptyauth,
>     2017-02-25),
> 
> looks essentially the same as what this patch is adding, and I am
> wondering if there is a room for simplification.  It almost looks
> to me that the only difference between "credential fully given" and
> other case is if we "reject" the credential after this patch.
> 
> Asking contributors who made these past contributions for input.
> 
> Thanks.
> 

I have simplified the code and sent the patch again.

Thanks.
