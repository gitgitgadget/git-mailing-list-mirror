From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required
 amount
Date: Tue, 26 Aug 2014 13:37:44 +0100
Message-ID: <53FC7F98.5070204@ramsay1.demon.co.uk>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com> <53FA0054.5060808@gmail.com> <CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com> <20140825130732.GD17288@peff.net> <xmqq8umcl0al.fsf@gitster.dls.corp.google.com> <20140826110303.GA25736@peff.net> <53FC7621.7090102@ramsay1.demon.co.uk> <20140826121359.GA29180@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWk=?= =?UTF-8?B?IE5n4buNYyBEdXk=?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:37:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMG0Y-0005nf-90
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 14:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbaHZMhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 08:37:50 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:46376 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754750AbaHZMht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 08:37:49 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 62E66400A41;
	Tue, 26 Aug 2014 13:37:38 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id F0F1D4009A3;
	Tue, 26 Aug 2014 13:37:37 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Tue, 26 Aug 2014 13:37:37 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140826121359.GA29180@peff.net>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255896>

On 26/08/14 13:14, Jeff King wrote:
> On Tue, Aug 26, 2014 at 12:57:21PM +0100, Ramsay Jones wrote:
> 
>>> +	ret = xcalloc(1, base + extra);
>>> +	va_start(ap, fmt);
>>> +	vsnprintf(ret + offset, extra, fmt, ap);
>>
>> What is the relationship between 'base' and 'offset'?
>>
>> Let me assume that base is always, depending on your compiler, either
>> equal to offset or offset+1. Yes? (I'm assuming base is always the
>> sizeof(struct whatever)). Do you need both base and offset?
> 
> It's much more complicated than that. Take "struct name_decoration", for
> instance, which looks like this:
> 
>   struct name_decoration {
> 	struct name_decoration *next;
> 	int type;
> 	char name[FLEX_ARRAY];
>   };
> 
> On my 64-bit system using gcc, sizeof() returns 16; it has to pad the
> whole thing to 64-bit alignment in case I put two of them in an array.
> But offsetof(name) is 12, since the array of char does not need the same
> alignment; it can go right after the type and make use of the padding
> bits.

Hmm, interesting. I must re-read the standard. I was convinced that the
standard *requires* any alignment padding to come *before* the name field.
(how would you put a, non-trivial, variable data structure into an array?)

ATB,
Ramsay Jones
