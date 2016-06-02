From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 19:42:05 +0100
Message-ID: <57507DFD.6010800@ramsayjones.plus.com>
References: <20160601235233.21040-1-sbeller@google.com>
 <574F800D.6070107@ramsayjones.plus.com>
 <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com>
 <57505105.2000801@ramsayjones.plus.com>
 <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, pclouds@gmail.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:42:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8XZQ-0003XB-73
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 20:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932978AbcFBSmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 14:42:12 -0400
Received: from avasout01.plus.net ([84.93.230.227]:45000 "EHLO
	avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932339AbcFBSmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 14:42:11 -0400
Received: from [10.0.2.15] ([84.92.139.254])
	by avasout01 with smtp
	id 1ui71t0045VX2mk01ui8jZ; Thu, 02 Jun 2016 19:42:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=bsGxfxui c=1 sm=1 tr=0
 a=RCQFcU9wfaUQolwYLdiqXg==:117 a=RCQFcU9wfaUQolwYLdiqXg==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=EBOSESyhAAAA:8 a=37LUcCaBeb301YVF1n0A:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296221>



On 02/06/16 17:10, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> So, at risk of annoying you, let me continue in my ignorance a little
>> longer and ask: even if you have to protect all of this 'magic' from
>> the shell with '/" quoting, could you not use (nested) quotes to
>> protect the <value> part of an <attr>? For example:
>>
>>     git ls-files ':(attr:whitespace="indent,trail,space",icase)'
> 
> That would be workable, I would think.  Before attr:VAR=VAL
> extention, supported pathspec <magic> were only single lowercase-ascii
> alphabet tokens, so nobody would have used " as a part of magic.  So
> quting with double-quote pair would work.

I was thinking about both ' and ", so that you could do:

   $ ./args ':(attr:whitespace="indent,trail,space",icase)'
    1::(attr:whitespace="indent,trail,space",icase)

   $ ./args ":(attr:whitespace='indent,trail,space',icase)"
    1::(attr:whitespace='indent,trail,space',icase)

   $ p=':(attr:whitespace="indent,trail,space",icase)'
   $ ./args "$p"
    1::(attr:whitespace="indent,trail,space",icase)

   $ p=":(attr:whitespace=\"indent,trail,space\",icase)"
   $ ./args "$p"
    1::(attr:whitespace="indent,trail,space",icase)

but limiting it to " would probably be OK too.

> You'd need to come up with a way to quote a double quote that
> happens to be a part of VAL somehow, though.

Yes I was assuming \ quoting as well - I just want to reduce the
need for such quoting (especially on windows).

>                                              I think attribute
> value is limited to a string with non-whitespace letters; even
> though the built-in attributes that have defined meaning to the Git
> itself may not use values with letters beyond [-a-zA-Z0-9,], end
> users and projects can add arbitrary values within the allowed
> syntax, so it is not unconceivable that some project may have a
> custom attribute that lists forbidden characters in a path with
> 
> 	=== .gitattributes ===
>         *.txt forbidden=`"
> 
> that tells their documentation cannot have these letters in it, or
> something like that.

Heh, yeah, that gets ugly:

   $ ./args ":(attr:*.txt forbidden=\'\\\",icase)"
    1::(attr:*.txt forbidden=\'\",icase)

   $ ./args ':(attr:*.txt forbidden=\'\''\",icase)'
    1::(attr:*.txt forbidden=\'\",icase)

[Note the initial ' 1:' above is output from args]

ATB,
Ramsay Jones
