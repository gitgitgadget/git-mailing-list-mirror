From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Fri, 9 Aug 2013 01:34:48 +0530
Message-ID: <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CACsJy8CGWJ07Uk8EBjfejdyshKB1NKk=_7VUoeyZWZgJFqCSkg@mail.gmail.com>
 <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 22:05:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7WSl-00032K-A4
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 22:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966319Ab3HHUFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 16:05:31 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61359 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966063Ab3HHUF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 16:05:29 -0400
Received: by mail-ie0-f177.google.com with SMTP id a11so2676363iee.36
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iyGDUCZSictWPriOD5tSjAd/wcQI6UNJc8d85RLko4U=;
        b=co7QlvSS0OfQ1o4S5EVMwWqvXyZsWvOJ1LUG3HIRfM6lWlYBo1ne1QO2zA+jqqSUjC
         JggYPvOkS4LEWkNJbwGCl4ytSWD8Hu/9cVFLshFEvyVrUoiSsMYuJaMEsV8gRyL20Xbr
         vs4gxjCgwBRtISehfxd4rKfcnN5ITkJ6quplj3DRYw2tqhU675ri1Fe3Ok8mbSyMy3bd
         rFCDHGKVR+d7pZrRFp/oGDBAs5eHs/jM8AHAPdfKhfon8kcs0sw4F5TRt31h/AjiYxXv
         ZatBXX14opDLSjVOCD146E7Rx6vHfVbNyjXOxQI9skMCK+LO3AZtpBRsFNPogL4zqWIR
         CXRA==
X-Received: by 10.50.134.9 with SMTP id pg9mr373590igb.29.1375992328924; Thu,
 08 Aug 2013 13:05:28 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Thu, 8 Aug 2013 13:04:48 -0700 (PDT)
In-Reply-To: <7vwqnw7z47.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231927>

Junio C Hamano wrote:
>> 3. After a few days of working, the gc heuristics figure out that I
>> have too much garbage and too many packs; a cleanup is required. The
>> gc --auto which doesn't tolerate fragmentation: it tries to put
>> everything into one large pack.
>
> Today's "gc --auto" skims the history shallowly and packs loose
> objects into a single _new_ pack.  If you start from a single pack
> and enough loose objects and run "gc --auto", you will have two
> packs, one intact from the original, one new.

That is when I have lots of loose objects and few packs. We are
discussing gc aggression when there are too many packs (how did we get
there in the first place if new packs aren't created?): in which case
it doesn't tolerate fragmentation, and tries to put everything in one
pack. That is both IO and CPU intensive, and we've been trying to
tackle that since the start of the thread.

> And I see from "(or when ...)" part that you do not know what you
> are talking about.  "push" will not stream existing pack to the
> other end without computation, and it never will.  It will reuse
> existing individual pieces when it can, and having data in a pack
> (even without deltifying, or as a suboptimal delta) is much better
> for push performance than having the same data in a loose object if
> only for this reason, as you do not have to recompress and reencode
> it in a different way (loose objects and undelitifed object in pack
> are encoded differently).

Certainly. A push will never use an existing pack as-is, as it's very
highly unlikely that the server requested exactly what gc --auto
packed for us locally.

Sure, undeltified objects in the pack are probably better for push
performance, but I'm talking about the majority: deltified objects.
Don't you need to apply the deltas (ie. explode the pack), before you
can recompute the deltas for the information you're sending across for
the push?

> I've treated this thread as a design discussion, not an education
> session, but the above ended up having more education material than
> anything that would advance the design.

You will need to educate your contributors and potential contributors
if you want these problems to be fixed.
