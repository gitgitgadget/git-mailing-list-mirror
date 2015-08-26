From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC] Porting builtin/branch.c to use the printing options of ref-filter.{c,h}
Date: Wed, 26 Aug 2015 12:09:45 +0530
Message-ID: <CAOLa=ZRZpy8_KGNZL1TahEkOOdQ35e1168pwuCpkxbogRDXNnw@mail.gmail.com>
References: <CAOLa=ZRpMsFr2p=X+Z7z95W+0wGd9i5XaSDeVSmS-BUFCj6dWw@mail.gmail.com>
 <xmqq4mjnyzfy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 08:41:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUUOm-00018j-Un
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 08:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbbHZGkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 02:40:17 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36410 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbbHZGkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 02:40:16 -0400
Received: by oiev193 with SMTP id v193so115760035oie.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 23:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bMJhP7u4CuF2nW7jUO2jMRiBmJPUaeVJu2lr+YEwC7Q=;
        b=g/60dVExftwzl2ZvP0sxxtd5VoxQc+0MDJL0t+vyhXTZ29ht6IsPR0lDxhqqSHsDxh
         g+XqhrTe7iwE2lCi7eX7fl/7huQqYDChYC/xUbXFv2z+smXcAbB6dO0UDhRsZ12o1zhG
         6hKhJczlki5qheHHIESpvU8ac9JQcajMgKfbtxlH9guu+wShyPc6HSN8ezqysd6KUOBu
         Qhrog7xh8aJb6fG7E5BKvhNwRN3wJ5e/te2kCahRBKFSeKkCWMx4G/moU+mfWtmvZFjJ
         V0fVDsibHPHoKQCJgPvxMRMRIIyovQEgg+Oz8XhXESglHaVZ3WGDySNqPf9YKY0ur9VF
         PmOA==
X-Received: by 10.202.200.75 with SMTP id y72mr29729947oif.111.1440571215349;
 Tue, 25 Aug 2015 23:40:15 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Tue, 25 Aug 2015 23:39:45 -0700 (PDT)
In-Reply-To: <xmqq4mjnyzfy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276600>

On Wed, Aug 26, 2015 at 12:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I'm working on porting over the printing options of ref-filter to `git
>> branch -l`.
>> This is a follow up to
>> http://article.gmane.org/gmane.comp.version-control.git/276377
>>
>> Theres a slight issue with this which I'd like to discuss about.
>>
>> When we use `-a` option in `git branch -l`
>> It lists local branches and remotes with each having a different output format.
>> This with reference to ref-filter would mean either
>>
>> 1. Change format in between local and remote refs
>
> I thought the end result of consolidation would be for for-each-ref,
> branch -l, and tag -l to be "first collect what to show, and then
> show them according to a single format given".  How could it be
> possible to switch format?  It's not even like each element collected
> in the first phase is marked so that the second "display" phase know
> which one is which.
>

Absolutely right! Currently this is not even possible, It was just a shot in the
dark. I was just shooting out possibilities I could think of :)

>> 2. Have a format like %(if)...local check....%(then)....local branch
>> format....%(else)....remote format %(end).
>
> That, if we had a working if/then/else/end, would be a good
> demonstration of it.
>
> If this were only for internal use by "branch -l", it might be
> overkill, but the end users with for-each-ref --format options would
> want to do the same thing as built-in patterns, so it is a good goal
> to aim at.
>

I have a version of that running in my local repo, I'll probably
post a WIP soon, when I get this done.

>> I prefer the latter, but that might lead to a large format. Any suggestions?
>
> A less ambitious option might be:
>
>   3. Invent "%(refname:<some magic>)" format similar to
>      %(refname:short) but does your thing depending on the prefix
>      refs/heads/ and refs/remotes/.
>
> but that will not work if the difference between local and remote
> format is not merely textual (e.g. paint them in different color).

It's more than just colors. The whole format changes.

$ git branch -a
For local:
"%(if)%(HEAD)%(then)%(HEAD) %(color:green)%(refname:short)%(else)
%(refname:short)%(end)"
For remote:
"  remotes/%(color:red)%(refname:short)%(color:reset)%(if)%(symref)%(then)
-> %(symref:short)%(end)"



On Wed, Aug 26, 2015 at 1:36 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Hmm, yes, colors would be difficult to get with this solution. Perhaps a
> %(refname:autoprefix,autocolor) that would pick the color and do the
> textual rendering?
>

That sounds, good, probably could work on something of this sort.

-- 
Regards,
Karthik Nayak
