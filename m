From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: refspecs with '*' as part of pattern
Date: Tue, 7 Jul 2015 00:22:38 -0700
Message-ID: <CA+P7+xo=WyyJncO0Q3KMO+6kgs-g1i9KNRTtGw865Je=X5U=_g@mail.gmail.com>
References: <CA+P7+xoosLG3J5uUVakzwYoxVARs-NH4BJBtsMgw2NB39vyE6A@mail.gmail.com>
 <xmqqzj38yjpg.fsf@gitster.dls.corp.google.com> <alpine.LNX.2.00.1507062208580.2241@iabervon.iabervon.org>
 <CA+P7+xofoxdgQUng1N1NpXyALzjjmAYe++GJoA6qD+zUbZk-vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.iabervon.org>
X-From: git-owner@vger.kernel.org Tue Jul 07 09:23:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCNDi-0007sU-Dx
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 09:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbbGGHXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 03:23:05 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33459 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbbGGHW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 03:22:59 -0400
Received: by oiyy130 with SMTP id y130so135300278oiy.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vj74yLDp3uS3NtWx1gYmFhEhG1lygKvxG6Z3flrrGKw=;
        b=U6XWYjmEk7fwHdufAmJo0f6uPRx6/oVWf7Hxdrsezn2JlJ70hqZlibNXRR8M43CkxQ
         +klqDlXFUnZhPM24dU/BArkMqxvrltQ3II8y5ceyDg/OtN3wig5aAzlCOYGyHg4VZpQC
         W1ycN/lYBYBp/fwOqmSQ0CRY0WHpfMoCOZAOR8L7ihOVSD33KJE3QkbNR/7+Vcl5Rcwc
         wxK+W8OEzhBzKRooEKocAwZ6KNoEkBPbFqhf9WEVCP6P56piVXOzFwPigGAAGiV83ONt
         HMM+R7ozGHe6kBwhfPikE+WJq+qaawCcu5meBg2D4XFGTQ8Z6TCmqrCaj8MCo5oMrpE9
         24JA==
X-Received: by 10.182.143.5 with SMTP id sa5mr2625026obb.62.1436253778362;
 Tue, 07 Jul 2015 00:22:58 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Tue, 7 Jul 2015 00:22:38 -0700 (PDT)
In-Reply-To: <CA+P7+xofoxdgQUng1N1NpXyALzjjmAYe++GJoA6qD+zUbZk-vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273486>

On Mon, Jul 6, 2015 at 7:33 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Jul 6, 2015 at 7:20 PM, Daniel Barkalow
> <barkalow@iabervon.iabervon.org> wrote:
>> On Mon, 6 Jul 2015, Junio C Hamano wrote:
>>
>>> Jacob Keller <jacob.keller@gmail.com> writes:
>>>
>>> > I've been looking at the refspecs for git fetch, and noticed that
>>> > globs are partially supported. I wanted to use something like:
>>> >
>>> > refs/tags/some-prefix-*:refs/tags/some-prefix-*
>>> >
>>> > as a refspec, so that I can fetch only tags which have a specific
>>> > prefix. I know that I could use namespaces to separate tags, but
>>> > unfortunately, I am unable to fix the tag format. The specific
>>> > repository in question is also generating several tags which are not
>>> > relevant to me, in formats that are not really useful for human
>>> > consumption. I am also not able to fix this less than useful practice.
>>> >
>>> > However, I noticed that refspecs only support * as a single component.
>>> > The match algorithm works perfectly fine, as documented in
>>> > abd2bde78bd9 ("Support '*' in the middle of a refspec")
>>> >
>>> > What is the reason for not allowing slightly more arbitrary
>>> > expressions? Obviously no more than one *...
>>>
>>> I cannot seem to be able to find related discussions around that
>>> patch, so this is only my guess, but I suspect that this is to
>>> discourage people from doing something like:
>>>
>>>       refs/tags/*:refs/tags/foo-*
>>>
>>> which would open can of worms (e.g. imagine you fetch with that
>>> pathspec and then push with refs/tags/*:refs/tags/* back there;
>>> would you now get foo-v1.0.0 and foo-foo-v1.0.0 for their v1.0.0
>>> tag?) we'd prefer not having to worry about.
>>
>> That wouldn't be it, since refs/tags/*:refs/tags/foo/* would have the same
>> problem, assuming you didn't set up the push refspec carefully.
>>
>> I think it was mostly that it would be too easy to accidentally do
>> something you don't want by having some other character instead of a
>> slash, like refs/heads/*:refs/heads-*.
>>
>> Aside from the increased risk of hard-to-spot typos leading to very weird
>> behavior, nothing actually goes wrong; in fact, I've been using git with
>> that check removed for ages because I wanted a refspec like
>> refs/heads/something-*:refs/heads/*. And it works fine as a local patch,
>> since you don't need your refspec handling to interoperate with other
>> repositories.
>>
>>         -Daniel
>> *This .sig left intentionally blank*
>
>
> Which is why I suggested a patch that adds this behavior conditionally
> and only for fetch. This way you don't have to use a local patch, and
> it wouldn't hit normal users. Ideally we can add a flag that only
> enables it for refspecs that don't interoperate.
>
> Does this seem ok? If so I will go ahead and try to work up a patch
>
> Regards,
> Jake

I am working up a patch to try and get this configurable. I'll
hopefully send it out tomorrow morning sometime.

Regards,
Jake
