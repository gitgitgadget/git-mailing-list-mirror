From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v4 1/7] quote: remove leading space in sq_dequote_step
Date: Mon, 29 Feb 2016 22:45:56 +0100
Message-ID: <56D4BC14.90301@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de> <56D40301.8020007@moritzneeb.de>
 <xmqqy4a39w8b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 22:46:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaVdj-0006uv-EL
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 22:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbcB2Vp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 16:45:58 -0500
Received: from moritzneeb.de ([78.47.1.106]:41100 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbcB2Vp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 16:45:58 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 8C8CA1C058;
	Mon, 29 Feb 2016 22:45:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456782356;
	bh=JRJd2FIayrgBJkqw0PXj6UWpyox/Tes/shOvncX4OW8=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
	b=epXPhA0NWNTBsyn6R6wl/N/88w1izXm+yKxkNB/Ohqq2tKx8vFNz0XpVvePWzh5WM
	 xv0xENcZNZfgw+9bvR18hW+Ru7FR/adqNdyDb9KhCpATkavRTIOHLbiKd0wkkrIx7y
	 4vldmP/0xuugXa3BWCAkMQOn34ymZBiwoySgwQvQ=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqy4a39w8b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287911>

On 02/29/2016 08:01 PM, Junio C Hamano wrote:
> Moritz Neeb <lists@moritzneeb.de> writes:
> 
>> Because sq_quote_argv adds a leading space (which is expected in trace.c),
>> sq_dequote_step should remove this space again, such that the operations
>> of quoting and dequoting are inverse of each other.
>>
>> This patch is preparing the way to remove some excessive trimming
>> operation in bisect in the following commit.
>>
>> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
>> ---
>>  quote.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/quote.c b/quote.c
>> index fe884d2..2714f27 100644
>> --- a/quote.c
>> +++ b/quote.c
>> @@ -63,6 +63,8 @@ static char *sq_dequote_step(char *arg, char **next)
>>  	char *src = arg;
>>  	char c;
>>  
>> +	if (*src == ' ')
>> +		src++;
>>  	if (*src != '\'')
>>  		return NULL;
>>  	for (;;) {
> 
> If we look at this "for (;;)" loop, we notice that (1) it accepts as
> many spaces as there are between two quoted strings, and (2) it does
> not limit it to SP but uses isspace().
> 
> I wonder if you would instead want
> 
> 	while (isspace(*src))
>         	src++;
> 
> to be consistent?
> 

My intention was to explicitly remove the space added by
strbuf_addch(dst, ' ') in sq_quote_argv().

I think it would not make sense to remove more spaces, because for
for sq_dequote() it is defined:

	This unwraps what sq_quote() produces in place, but returns
	NULL if the input does not look like what sq_quote would have
	produced.

I understand that this counts also for the sq_dequote_array*() family.

Thanks
