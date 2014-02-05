From: Adrian Johnson <ajohnson@redneon.com>
Subject: Re: [PATCH v2] userdiff: update Ada patterns
Date: Wed, 05 Feb 2014 21:14:29 +1030
Message-ID: <52F2160D.1040006@redneon.com>
References: <52EE234C.1060002@redneon.com>	<20140202233531.GE16196@sigill.intra.peff.net>	<52EF7E7C.3070504@redneon.com> <xmqqppn4dl0k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 11:44:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAzyA-0000yE-3l
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 11:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbaBEKoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 05:44:34 -0500
Received: from redneon.com ([66.221.1.90]:39621 "EHLO redneon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbaBEKod (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 05:44:33 -0500
Received: from bearcat.lan (ppp121-45-5-17.lns20.adl2.internode.on.net [121.45.5.17])
	by redneon.com (Postfix) with ESMTPA id 5EDBF53C0B50;
	Wed,  5 Feb 2014 21:14:32 +1030 (CST)
Received: from [192.168.1.1] (bearcat.lan [192.168.1.1])
	by bearcat.lan (Postfix) with ESMTP id 362264C901;
	Wed,  5 Feb 2014 21:14:29 +1030 (CST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqppn4dl0k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241602>

On 04/02/14 06:30, Junio C Hamano wrote:
> Adrian Johnson <ajohnson@redneon.com> writes:
> 
>> - Allow extra space in "is new" and "is separate"
>> - Fix bug in word regex for numbers
>>
>> Signed-off-by: Adrian Johnson <ajohnson@redneon.com>
>> ---
>>  t/t4034/ada/expect | 2 +-
>>  userdiff.c         | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/t4034/ada/expect b/t/t4034/ada/expect
>> index be2376e..a682d28 100644
>> --- a/t/t4034/ada/expect
>> +++ b/t/t4034/ada/expect
>> @@ -4,7 +4,7 @@
>>  <BOLD>+++ b/post<RESET>
>>  <CYAN>@@ -1,13 +1,13 @@<RESET>
>>  Ada.Text_IO.Put_Line("Hello World<RED>!<RESET><GREEN>?<RESET>");
>> -1 1e<RED>-<RESET>10 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
>> +1 <RED>1e-10<RESET><GREEN>1e10<RESET> 16#FE12#E2 3.141_592 '<RED>x<RESET><GREEN>y<RESET>'
>>  <RED>a<RESET><GREEN>x<RESET>+<RED>b a<RESET><GREEN>y x<RESET>-<RED>b<RESET>
>>  <RED>a<RESET><GREEN>y<RESET>
>>  <GREEN>x<RESET>*<RED>b a<RESET><GREEN>y x<RESET>/<RED>b<RESET>
>> diff --git a/userdiff.c b/userdiff.c
>> index ea43a03..10b61ec 100644
>> --- a/userdiff.c
>> +++ b/userdiff.c
>> @@ -15,13 +15,13 @@ static int drivers_alloc;
>>  	  word_regex "|[^[:space:]]|[\xc0-\xff][\x80-\xbf]+" }
>>  static struct userdiff_driver builtin_drivers[] = {
>>  IPATTERN("ada",
>> -	 "!^(.*[ \t])?(is new|renames|is separate)([ \t].*)?$\n"
>> +	 "!^(.*[ \t])?(is[ \t]+new|renames|is[ \t]+separate)([ \t].*)?$\n"
>>  	 "!^[ \t]*with[ \t].*$\n"
>>  	 "^[ \t]*((procedure|function)[ \t]+.*)$\n"
>>  	 "^[ \t]*((package|protected|task)[ \t]+.*)$",
>>  	 /* -- */
>>  	 "[a-zA-Z][a-zA-Z0-9_]*"
>> -	 "|[0-9][-+0-9#_.eE]"
>> +	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
> 
> This would match a lot wider than what I read you said you wanted to
> match in your previous message.  Does "-04##4_3_2Ee-9" count as a
> number, for example, or can we just ignore such syntactically
> incorrect sequence?

Maybe I am misunderstanding the purpose of the word diff regexes. I
thought the purpose of the word regex is to split lines into words, not
determine what is syntactically correct.

For example decimal number regex for pascal is: [-+0-9.e]+
and for cpp: [-+0-9.e]+[fFlL]?

These will obviously match stuff that is not a number.

> 
>>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
>>  IPATTERN("fortran",
>>  	 "!^([C*]|[ \t]*!)\n"
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
