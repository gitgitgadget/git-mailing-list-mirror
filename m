From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: add --except option
Date: Mon, 2 Sep 2013 01:48:37 -0500
Message-ID: <CAMP44s3eUmA9pVfZFbXHNvDiYwp9jttSTb6DBr8JrgTfhfD+_Q@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<5220503F.2080608@viscovery.net>
	<CAMP44s0D98tggTjQsMn+-03KgSsbrh3nxYfLofpC1gfnJpEPyw@mail.gmail.com>
	<52242F61.3090404@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 02 08:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGNwM-00088J-Nu
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 08:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755484Ab3IBGsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 02:48:40 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:59085 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3IBGsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 02:48:39 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so3623040lbi.31
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 23:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NxvEwZuYiPdHbz9Oxs6GW6mXIR/jezRpIOyt6I/LxYM=;
        b=zlBQaAtF/GrDJOnibCjweTlXoDZTT1TQqNc4S2e5hOSUh6tgNsX9XD+8/iBGqjRcPL
         GvJ+jlYTDR+6lj104hCsEOur/ZRBNu/6kVKlhQyu+u2NDlHR7aJbv2dktn/1nQQEG58k
         hp4Qtv8CbkvMJ/KXdrEc9ONNox6SHNUZlXvOMC4w7HEVo/I75hbf1T+zo+4NwimUWhgQ
         PfsTHbVw0xi/EP599AQkytaRRmWJJgk+XOt9CYsSVNuwrUqFDUcslTlkogNw6JSH00mU
         f6JP94+TVM6umgQZt2iNSoDaLclidDGfnMf0AeYchoay7EOr8KZLeKlPCSS1AUg0cjI/
         rnBA==
X-Received: by 10.112.0.242 with SMTP id 18mr19372906lbh.18.1378104517992;
 Sun, 01 Sep 2013 23:48:37 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 1 Sep 2013 23:48:37 -0700 (PDT)
In-Reply-To: <52242F61.3090404@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233619>

On Mon, Sep 2, 2013 at 1:25 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/31/2013 21:27, schrieb Felipe Contreras:
>> On Fri, Aug 30, 2013 at 2:56 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 8/30/2013 8:32, schrieb Junio C Hamano:
>>>> If you have a history where
>>>>
>>>>  - branches "master" and "maint" point at commit A;
>>>>  - branch "next" points at commit B that is a descendant of A; and
>>>>  - there are tags X and Y pointing at commits that are ahead of B
>>>>    or behind A
>>>>
>>>> i.e.
>>>>
>>>>       ----X----A----B----Y
>>>>
>>>> what are the desired semantics for these?
>>>
>>> I think the simplest were that --except trumps everything and means
>>> "whatever else I say, do as if I did not mention the following".
>>
>> Actually, my patch is almost there, I attach the necessary changed
>> below to make everything work. I've added debug prints to show what
>> it's actually doing:
>>
>>>>  (1) --branches --except maint
>>>
>>> => master next
>>
>> => master next
>>
>>>>  (2) --all --not --branches --except maint
>>>
>>> => X Y --not master next
>>
>> => ^master ^next X Y HEAD
>>
>>>>  (3) ^master next --except maint
>>>
>>> => ^master next
>>
>> => ^master next
>>
>>> (4) Y next --except master next --not --branches
>>>
>>> this => Y --not maint
>>> or this => Y --not maint master next
>>
>> => Y
>>
>> Remember that maint (or rather ^maint) is after --except.
>
> Sure, but why is it not in the result? maint is not even mentioned under
> --except. Confused...

It is mentioned under --except, by --branches.

> Ah, are you treating the union of master, next, and --branches as --except
> and ignore --not?

These are the same:

Y next --except master next --not --branches
Y next --except master next --not master next maint

If you add more positive branches:

They get removed anyway by --except:

Y next master maint --except master next --not master next maint
Y master maint --except master --not master maint
Y maint --except --not maint
Y

-- 
Felipe Contreras
