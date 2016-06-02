From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 20:44:05 +0100
Message-ID: <57508C85.1090503@ramsayjones.plus.com>
References: <20160601235233.21040-1-sbeller@google.com>
 <574F800D.6070107@ramsayjones.plus.com>
 <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
 <57505105.2000801@ramsayjones.plus.com>
 <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
 <57507DFD.6010800@ramsayjones.plus.com>
 <CAGZ79ka3ku7x7BhBZJ_uHjS0pNLT7NFACUVqNKi=DvtOkSN_bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 21:44:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8YXR-0007B9-Lv
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 21:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568AbcFBToL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 15:44:11 -0400
Received: from avasout01.plus.net ([84.93.230.227]:33759 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcFBToK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 15:44:10 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 1vk61t0045VX2mk01vk7Wy; Thu, 02 Jun 2016 20:44:08 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=4LAiTokrT0sm4rKLuy4A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <CAGZ79ka3ku7x7BhBZJ_uHjS0pNLT7NFACUVqNKi=DvtOkSN_bg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296228>



On 02/06/16 20:04, Stefan Beller wrote:
> On Thu, Jun 2, 2016 at 11:42 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 02/06/16 17:10, Junio C Hamano wrote:
>>> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>>>
>>>> So, at risk of annoying you, let me continue in my ignorance a little
>>>> longer and ask: even if you have to protect all of this 'magic' from
>>>> the shell with '/" quoting, could you not use (nested) quotes to
>>>> protect the <value> part of an <attr>? For example:
>>>>
>>>>     git ls-files ':(attr:whitespace="indent,trail,space",icase)'
>>>
>>> That would be workable, I would think.  Before attr:VAR=VAL
>>> extention, supported pathspec <magic> were only single lowercase-ascii
>>> alphabet tokens, so nobody would have used " as a part of magic.  So
>>> quting with double-quote pair would work.
>>
>> I was thinking about both ' and ", so that you could do:
>>
>>    $ ./args ':(attr:whitespace="indent,trail,space",icase)'
>>     1::(attr:whitespace="indent,trail,space",icase)
>>
>>    $ ./args ":(attr:whitespace='indent,trail,space',icase)"
>>     1::(attr:whitespace='indent,trail,space',icase)
>>
>>    $ p=':(attr:whitespace="indent,trail,space",icase)'
>>    $ ./args "$p"
>>     1::(attr:whitespace="indent,trail,space",icase)
>>
>>    $ p=":(attr:whitespace=\"indent,trail,space\",icase)"
>>    $ ./args "$p"
>>     1::(attr:whitespace="indent,trail,space",icase)
>>
>> but limiting it to " would probably be OK too.
>>
>>> You'd need to come up with a way to quote a double quote that
>>> happens to be a part of VAL somehow, though.
>>
>> Yes I was assuming \ quoting as well - I just want to reduce the
>> need for such quoting (especially on windows).
>>
>>>                                              I think attribute
>>> value is limited to a string with non-whitespace letters; even
>>> though the built-in attributes that have defined meaning to the Git
>>> itself may not use values with letters beyond [-a-zA-Z0-9,], end
>>> users and projects can add arbitrary values within the allowed
>>> syntax, so it is not unconceivable that some project may have a
>>> custom attribute that lists forbidden characters in a path with
>>>
>>>       === .gitattributes ===
>>>         *.txt forbidden=`"
> 
> We restrict the 'forbidden' to follow [-a-zA-Z0-9,], so we could enforce
> it for the values, too.
> 
> 
>>
>>    $ ./args ":(attr:*.txt forbidden=\'\\\",icase)"
>>     1::(attr:*.txt forbidden=\'\",icase)
> 
> You should lose the *.txt in there, but put it at the back

Ah, yes, just shows my ignorance of the attribute system!

> 
>>  $ ./args ":(attr:forbidden=\'\\\",icase)*.txt"
> 
>>
>>    $ ./args ':(attr:*.txt forbidden=\'\''\",icase)'
>>     1::(attr:*.txt forbidden=\'\",icase)
> 
> I see, so quoting by " or ' is preferred. What if the user
> wants to do a

I think Junio wants to go with just " quoting (see other thread).

>     forbidden=',"
> 
> so we have to escape those in there, such as
> 
>     ./args ':(attr:"forbidden=\',\"")'

No, that won't work (" is not terminated), try this:

   $ ./args ':(attr:"forbidden='\'',\"")'
    1::(attr:"forbidden=',\"")
   $ 

   $ ./args ":(attr:\"forbidden=',\\\"\")"
    1::(attr:"forbidden=',\"")
   $ 

[half of the problem is just getting past the shell]

ATB,
Ramsay Jones
