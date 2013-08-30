From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 02:17:07 -0500
Message-ID: <CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 09:17:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFIxJ-0002V9-5k
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 09:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152Ab3H3HRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 03:17:12 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:44710 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3H3HRK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 03:17:10 -0400
Received: by mail-lb0-f177.google.com with SMTP id p5so1522388lbi.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 00:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VUGCnwnezXQhfzJXs+sb6xu1J+LPZIenTmsslQpjOsc=;
        b=pJrClmxqLXiHWv4a4g7eB+Ge8FpQxftbSiuhUeXkLyOG8vCHGAYBDOMhoxPUHtTRqC
         8HUQf+/j7TMJ2NhEEREWLRh+m/U71uBy5cZLMHtK6gi/55lsQDq8L7NPYOShKEd3V3bg
         1CwxmChhoC2HkTHb4r3dyC9EaBIIEFY+F6QIrF5vf7x10DemrdaRtFg33gN2by7jSgvQ
         PYEXiVr2J/fa/NNwAFN/XNdG4nSQkXlH5kb/zqlvKOpGeZ7rg4EslNcSjixiHrL1TfiJ
         0nGhDGXbYxRjMb6yFgWiJwC2Ctpex5dhrqnin4xwlEnW8pNMjHkQqFKUI086CuX/5ScS
         VcdQ==
X-Received: by 10.152.29.103 with SMTP id j7mr6513277lah.7.1377847027340; Fri,
 30 Aug 2013 00:17:07 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 00:17:07 -0700 (PDT)
In-Reply-To: <7vhae7k7t1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233428>

On Fri, Aug 30, 2013 at 1:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> So that it's possible to remove certain refs from the list without
>> removing the objects that are referenced by other refs.
>>
>> For example this repository:
>>
>>   * 374e8dd (crap) crap
>>   * 4cbbf7b (test) two
>>   * d025ae0 (HEAD, master) one
>
> Can we make it more clear that your assumption is "crap" is a child
> of "test" which is a child of "master"?  Without that, the "nothing
> will come out" will not follow.
>
>> When using '--branches --except crap':
>>
>>   * 4cbbf7b (test) two
>>   * d025ae0 (HEAD, master) one
>>
>> But when using '--branches --not crap' nothing will come out.
>
> If you have a history where
>
>  - branches "master" and "maint" point at commit A;
>  - branch "next" points at commit B that is a descendant of A; and
>  - there are tags X and Y pointing at commits that are ahead of B
>    or behind A
>
> i.e.
>
>         ----X----A----B----Y
>
> what are the desired semantics for these?
>
>  (1) --branches --except maint
>
>  (2) --all --not --branches --except maint
>
>  (3) ^master next --except maint
>
> "--branches" wants to include "master", "next", and "maint", and the
> "--except" tells us we do not want to take "maint" into account, but
> should that affect what "master" wants to do (either include or
> exclude what are reachable from it)?

No, it should not. '--branches --except main' becomes 'master next'.

> As the way we parse the revisions from the command line is to mark
> "objects", not "refs", as we go, it looks like that the flag SKIP in
> this patch is placed conceptually at a wrong level.

refs are marked as well.

> I agree "--branches --except maint" is a good concept, but to
> implement what this patch wants to do properly, I suspect that the
> revision parser may need to be extended to be a two-phase process;
> the first phase will collect list of objects involved in the range
> expression without marking them with UNINTERESTING mark (that would
> also involve expanding things like --all or --branches), while
> remembering those given with --except, exclude the "except" set from
> the first set, and then finally marking the objects using the
> remainder, or something like that.

That's not necessary, this patch does the trick.

>> +                     ce = &revs->cmdline.rev[i];
>> +                     if ((ce->flags & SKIP) && !strcmp(ce->name, e->name))
>> +                             goto next;
>
> I think this SKIP will not help an object that is already tainted by
> UNINTERESTING; if it is discovered during a traversal from another
> object that will remain in the rev->commits, the travesal will stop
> there, even if a ref that is marked with SKIP will "goto next" here.

No, the traversal will continue just fine. At this point we are still
not traversing anything, simply adding the heads that will need to be
traversed later on to a list. Whether this object has been tainted by
UNINTERESTED or not is irrelevant.

If you do 'master ^maint --except master', handle_commit will return
three commits:

master -> ce->flags will have SKIP, nothing more happens
maint -> ce->flags doesn't have SKIP, processing continues, and it's
added to the list of commits, the commit has UNINTERESTING, but that
doesn't matter
master -> ce->flags will have SKIP, nothing more happens

Essentially it's the same as:

maint -> it's added to the list of commits, the commit has UNINTERESTING

So, it's exactly the same as if you had typed '^maint', which is
exactly what we want.

-- 
Felipe Contreras
