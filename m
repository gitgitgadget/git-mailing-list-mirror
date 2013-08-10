From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 08:24:39 +0700
Message-ID: <CACsJy8BZv0nr92foiYpbscpg86awFZVerpeXcz5CuYWeg3guEA@mail.gmail.com>
References: <7v61vihg6k.fsf@alter.siamese.dyndns.org> <CALkWK0kmx8bi1ZT1CSk+iVnmmQJV4bNu1D7h1AHnRk7_TfhJ3Q@mail.gmail.com>
 <7va9ksbqpl.fsf@alter.siamese.dyndns.org> <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net> <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 10 03:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7xvi-0000NW-LM
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 03:25:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968346Ab3HJBZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 21:25:11 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:36131 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968331Ab3HJBZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 21:25:09 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so7810089oag.29
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GVjP5PHmSX9nJvljzeu0cCDOFwAGYrBNAja8KMnVGec=;
        b=ocKZs1pb07PmRaUwVoepEzOZrU3BdNy8587aK1JrdJ1OMY9NuBPLwRzIx0GwIvuF3r
         XwxGXIRxp7DzZcV+jrc2UVbTgPAxvQc2L+Ad3OMWf0B1J2DT2ZaSxAjkSjXevtoRocLH
         OtcSVhIU1FYhvH/Qv7eJebuJG1zLIWaBCcpr1/Q1ptC78aqxRnlUxrFalYcbXfBkGXKG
         eQHCI39wCuLT+Y16C+pqe2A6ua7X1b3rCuqmXSdzmHbUnNRxxrBlnBzbHDGnM2QT8l7N
         +3lDoCGo53PeLZcYOseUq6jN9wu41WkjSScqx7zssmzL7PxtLeQWJST+kEB1MLJKLBhf
         oFcw==
X-Received: by 10.60.143.68 with SMTP id sc4mr10621903oeb.24.1376097909093;
 Fri, 09 Aug 2013 18:25:09 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 9 Aug 2013 18:24:39 -0700 (PDT)
In-Reply-To: <20130809221615.GA7160@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232059>

On Sat, Aug 10, 2013 at 5:16 AM, Jeff King <peff@peff.net> wrote:
> Another solution could involve not writing the duplicate of Y in the
> first place. The reason we do not store thin-packs on disk is that you
> run into problems with cycles in the delta graph (e.g., A deltas against
> B, which deltas against C, which deltas against A; at one point you had
> a full copy of one object which let you create the cycle, but you later
> deleted it as redundant with the delta, and now you cannot reconstruct
> any of the objects).
>
> You could possibly solve this with cycle detection, though it would be
> complicated (you need to do it not just when getting rid of objects, but
> when sending a pack, to make sure you don't send a cycle of deltas that
> the other end cannot use). You _might_ be able to get by with a kind of
> "two-level" hack: consider your main pack as "group A" and newly pushed
> packs as "group B". Allow storing thin deltas on disk from group B
> against group A, but never the reverse (nor within group B). That makes
> sure you don't have cycles, and it eliminates even more I/O than any
> repacking solution (because you never write the extra copy of Y to disk
> in the first place). But I can think of two problems:
>
>   1. You still want to repack more often than every 300 packs, because
>      having many packs cost both in space, but also in object lookup
>      time (we can do a log(N) search through each pack index, but have
>      to search linearly through the set of indices).
>
>   2. As you accumulate group B packs with new objects, the deltas that
>      people send will tend to be against objects in group B. They are
>      closer to the tip of history, and therefore make better deltas for
>      history built on top.
>
> That's all just off the top of my head. There are probably other flaws,
> too, as I haven't considered it too hard.

Some refinements on this idea

 - We could keep packs in group B ordered as the packs come in. The
new pack can depend on the previous ones.
 - A group index in addition to separate index for each pack would
solve linear search object lookup problem.
-- 
Duy
