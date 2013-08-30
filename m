From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] revision: add --except option
Date: Fri, 30 Aug 2013 02:24:46 -0500
Message-ID: <CAMP44s2n8k8ZXYde_+-X3qtiWNAcYKOgqTD0NY-cuuMwmPrhzQ@mail.gmail.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<522045A1.3040409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 30 09:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFJ4f-0006mO-FD
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 09:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036Ab3H3HYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 03:24:49 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:62124 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab3H3HYs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 03:24:48 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so920504lbj.13
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wZoA5SsGTKTc23GIFupagcgexv98y+WwXlAzJc7cCCg=;
        b=okTQubBu6jRlA/5jJBabsRXEGBKkTb+ySZu1YTx4zPNLqciinnxLFQ7b5epZocuCtm
         ZKlL87xUcJAoH0iXwiePiOVwU+MnxoEffzlsnfXfxyr1oGcK4nn7JoBbTvPo1lTsTD+b
         IHjlUfg0F0IKsVSB3pRzgy801cMVnld46LOfaHZsAiJOwUvjl6atB+tbKKnaJO39LUMO
         eSls77J9O9K25ilhUJ/koSm1VYFVWQ88h3J9T5BBTszTUf/ZvghURqxVYJ0kpK5oRemc
         NKVeIM/kpstpiroOIJX6+CSxEnWCj/oGEK0iVwReGuShXOI34Hd7OOCPoMhDY3vpRLjd
         Z/Tg==
X-Received: by 10.112.198.39 with SMTP id iz7mr6715233lbc.24.1377847486854;
 Fri, 30 Aug 2013 00:24:46 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Fri, 30 Aug 2013 00:24:46 -0700 (PDT)
In-Reply-To: <522045A1.3040409@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233430>

On Fri, Aug 30, 2013 at 2:11 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 8/30/2013 7:00, schrieb Felipe Contreras:
>> So that it's possible to remove certain refs from the list without
>> removing the objects that are referenced by other refs.
>>
>> For example this repository:
>>
>>   * 374e8dd (crap) crap
>>   * 4cbbf7b (test) two
>>   * d025ae0 (HEAD, master) one
>>
>> When using '--branches --except crap':
>>
>>   * 4cbbf7b (test) two
>>   * d025ae0 (HEAD, master) one
>>
>> But when using '--branches --not crap' nothing will come out.
>
> I like the idea to be able to exclude refs from listings. My use-case is
> the following:
>
> To unclutter 'git branch' output, I rename work-in-progress branches to
> begin with "wip/", ready-to-merge branches do not carry this prefix. To
> inspect unmerged work of the latter kind of branches I would like to
> type... what?
>
>   gitk --branches --except --branches=wip --not master
>   gitk --branches --not master --except --branches=wip
>
> Would one of these work with your current patch?

The first one should work, but mostly by accident. A proper fix is not
far though:

diff --git a/revision.c b/revision.c
index 25564c1..1380cd1 100644
--- a/revision.c
+++ b/revision.c
@@ -1983,9 +1983,9 @@ static int handle_revision_pseudo_opt(const char
*submodule,
        } else if (!strcmp(arg, "--reflog")) {
                handle_reflog(revs, *flags);
        } else if (!strcmp(arg, "--not")) {
-               *flags ^= UNINTERESTING | BOTTOM;
+               *flags = UNINTERESTING | BOTTOM;
        } else if (!strcmp(arg, "--except")) {
-               *flags ^= SKIP;
+               *flags = SKIP;
        } else if (!strcmp(arg, "--no-walk")) {
                revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
        } else if (!prefixcmp(arg, "--no-walk=")) {

Then both should work.

-- 
Felipe Contreras
