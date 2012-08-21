From: Conley Owens <cco3@android.com>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Tue, 21 Aug 2012 11:33:40 -0700
Message-ID: <CAFFUb6XMGgG=6uUzd0Xs1TXWFbJhDpMz1FeFdC8jHqaRi8Y58A@mail.gmail.com>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
	<20120821023033.GB20271@sigill.intra.peff.net>
	<CAFFUb6UypNJ-8p8Hs14+QMGeU3KSG+pQX7NJTeh3OtBoTZoO3g@mail.gmail.com>
	<7vzk5ocdg7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 20:33:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3tGu-0003k1-8A
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 20:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758337Ab2HUSdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 14:33:43 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55612 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab2HUSdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 14:33:41 -0400
Received: by qcro28 with SMTP id o28so94021qcr.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 11:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=d7PmZfPg2ngritGKjaEry1aZM9M1+gZGu1s+e75nHhc=;
        b=JuRigHUwCf0LgbmWsaLSihidkS2rkfjzAZ3lnzV2HFtPCftjVoyjTUupR0JItoLmjl
         KZC1bl2+OHkQBpeui7RIDIqgN2pQej+LBV32vsLTSNEV1E2GAWhDdUxj6SDXKeXf+QL0
         7kL7b7BH5Bjw97iTzif5g7koh42zKTrxjlhPe+okxcwtmdZ+mb+k9pyApR5+ena9Jp1o
         i/GUe656VovJcJCHTMaU9RTqiau8Euvci9uYs4H8EYkERr8lVT3mzYwZxxcx8dCuvHVC
         BEolEjwSxWEhmT8Rp7APOIVSJfoAJIFtE+7K3/Kfoddg1GsIaedN9Phwl+4klZshJQNR
         ZFow==
Received: by 10.229.114.220 with SMTP id f28mr2312005qcq.107.1345574020248;
 Tue, 21 Aug 2012 11:33:40 -0700 (PDT)
Received: by 10.49.110.37 with HTTP; Tue, 21 Aug 2012 11:33:40 -0700 (PDT)
In-Reply-To: <7vzk5ocdg7.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmK7HrTK5KOO7XgPA8oR/MnE2WVlZSweXfZkZXWl/+p6Cpns19mFqsUuhF8YT4vOInyW+NC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203980>

On Tue, Aug 21, 2012 at 11:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Conley Owens <cco3@android.com> writes:
>
>> On Mon, Aug 20, 2012 at 7:30 PM, Jeff King <peff@peff.net> wrote:
>>> On Mon, Aug 20, 2012 at 06:28:57PM -0700, Conley Owens wrote:
>>>
>>>> From f64ba3c908b33a2ea5a5ad1f0e5800af76b82ce9 Mon Sep 17 00:00:00 2001
>>>> From: Conley Owens <cco3@android.com>
>>>> Date: Mon, 20 Aug 2012 18:23:40 -0700
>>>> Subject: [PATCH] Fallback on getpwuid if envar HOME is unset
>>>
>>> Please drop these lines from the message body; they are redundant with
>>> your email's headers.
>>>
>>> This seems sensible on the surface, but I'm a bit curious: why isn't
>>> $HOME set? And are there any reasons that somebody who has unset HOME
>>> would not want to fallback?  For example, running under Apache, HOME is
>>> often unset when calling CGI programs. Would it make sense for us to
>>> look in ~www-data/.gitconfig in that case?
>>
>> I think it might, but perhaps I'm wrong.  As another example, upstart strips all
>> the environment variables, so if you run a job as a particular user, that user's
>> .gitconfig will not be read unless HOME is specified.
>
> Do you mean upstart as the "replacement init.d mechanism"?  If that
> is the case, the responsibility to set up HOME was moved to the
> scripts by upstart if they rely on having a sane value in $HOME; I
> do not see it as Git's problem, as it is not the only program that
> looks at and acts on the value of $HOME [*1*].

Yes, that's the upstart I'm referring to.  This makes sense.  However, it's a
confusing situation to run into.  Would a warning about an unset $HOME be
appropriate?

>
> Where do shells (e.g. bash and dash) go when you say "cd" without
> parameter when $HOME is unset, for example?  I do not think they
> magically read from getpwent() and use the value from there to fill
> the $HOME's place.  We should follow suit.
>
>
> [Footnote]
>
> *1* I further have to suspect that enough scripts would be
> inconvenienced by such a (mis)feature in upstart that over time the
> environment scrubbing may have to be rethought in upstart, and at
> that point, this entire discussion would become moot.
>
