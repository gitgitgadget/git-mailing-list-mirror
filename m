From: Moritz Neeb <lists@moritzneeb.de>
Subject: Re: [PATCH v3 2/7] bisect: read bisect paths with strbuf_getline()
Date: Sun, 28 Feb 2016 08:30:04 +0100
Message-ID: <56D2A1FC.4020008@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de> <56D281FD.1070707@moritzneeb.de>
 <CAPig+cRMX1DF7ffEKR4fWGY9wZjpKsaOaf4C1YdWipUGh1+8AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 28 08:30:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZvo3-00030E-46
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 08:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbcB1HaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 02:30:08 -0500
Received: from moritzneeb.de ([78.47.1.106]:37293 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbcB1HaH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 02:30:07 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id BF9751C02F;
	Sun, 28 Feb 2016 08:30:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456644605;
	bh=lrmZUuYIVGvJxTg92vVxKTZpMqhCYhR2mtjI/yUNUfE=;
	h=Subject:References:Cc:From:To:Date:In-Reply-To:From;
	b=V7UP5K9BYn/HZ2PZhJpzXnAPRpbDHCnNQE1c3KQJ+pcMuheN0+jdW5nCamxLSEni0
	 D8s5zz5P1zHkwu6JG8zw8YSJDHJ2SoD8AEmr/W4wabWA4pIrx6Qvyzg55j1AGgZ9pe
	 qYpA5UUOLpnb2uqYqA86kxtGGAIt5BCrNrp7L1TY=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAPig+cRMX1DF7ffEKR4fWGY9wZjpKsaOaf4C1YdWipUGh1+8AA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287756>

On 02/28/2016 07:33 AM, Eric Sunshine wrote:
> On Sun, Feb 28, 2016 at 12:13 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
>> The file BISECT_NAMES is written by "git rev-parse --sq-quote" via
>> sq_quote_argv() when starting a bisection. It can contain pathspecs
>> to narrow down the search. When reading it back, it should be expected that
>> sq_dequote_to_argv_array() is able to parse this file. In fact, the
>> previous commit ensures this.
>>
>> As the content is of type "text", that means there is no logic expecting
>> CR, strbuf_getline_lf() will be replaced by strbuf_getline().
>>
>> Apart from whitespace added and removed in quote.c, no more whitespaces
>> are expexted. While it is technically possible, we have never advertised
> 
> s/expexted/expected/
> 
>> this file to be editable by user, or encouraged them to do so, thus
>> the call to strbuf_trim() turns obsolete in various ways.
> 
> Not sure what "various ways" you mean. Perhaps say instead that (as a
> consequence of "not advertised or encouraged") you're tightening the
> parsing of this file by removing strbuf_trim().

Yeah that doesn't make sense. What I meant "it's neither needed for CR-removal,
nor for removal of other potential whitespace". I will rewrite the paragraph to:

Apart from whitespace added and removed in quote.c, no other whitespaces
are expected. While it is technically possible, we have never advertised
this file to be editable by user, or encouraged them to do so. As a
consequence, the parsing of BISECT_NAMES is tightened by removing
strbuf_trim().

> 
>> For the case that this file is modified nonetheless, in an invalid way
>> such that dequoting fails, the error message is broadened to both cases:
>> bad quoting and unexpected whitespace.
>>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
>> ---
>> diff --git a/bisect.c b/bisect.c
>> @@ -440,10 +440,9 @@ static void read_bisect_paths(struct argv_array *array)
>>         if (!fp)
>>                 die_errno("Could not open file '%s'", filename);
>>
>> -       while (strbuf_getline_lf(&str, fp) != EOF) {
>> -               strbuf_trim(&str);
>> +       while (strbuf_getline(&str, fp) != EOF) {
>>                 if (sq_dequote_to_argv_array(str.buf, array))
>> -                       die("Badly quoted content in file '%s': %s",
>> +                       die("Badly quoted content or unexpected whitespace in file '%s': %s",
>>                             filename, str.buf);
>>         }
>>
>> --
>> 2.4.3
