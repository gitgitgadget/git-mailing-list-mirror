From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Git commit generation numbers
Date: Thu, 21 Jul 2011 08:29:33 +0200
Message-ID: <CAP8UFD2duHW7MtLVrnjE9UMyU8bzx2xbJFzot5R2CThon8Dr3w@mail.gmail.com>
References: <20110714200144.GE26918@sigill.intra.peff.net>
	<CAP8UFD3p8rv9BoPkTYSr_qRztKhWmmHgjHi0pZ6gN9YzkSX0Jw@mail.gmail.com>
	<20110718034106.GB2468@sigill.intra.peff.net>
	<201107190614.38431.chriscool@tuxfamily.org>
	<20110719200022.GB3957@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"Ted Ts'o" <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 21 08:29:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjmlQ-0004aW-T3
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 08:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131Ab1GUG3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 02:29:35 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36836 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab1GUG3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 02:29:34 -0400
Received: by gxk21 with SMTP id 21so498288gxk.19
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 23:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UlLvSKsbL7gkvYZvYX1tLBsL+TUsm4E4+PDysdkxfDA=;
        b=gX/bCe6GLnmGpsQkTuh0UKKX0mshnmSi6cBm0su9nsZ4B5W29FIQsWP/qpT8RVz5VS
         YRCZkZZoQBeragY/OQecG5afUs5mlx5hMml6OQS/XBK4DPek1clUSmGM3Fu8vOr5poID
         d2NJsrqa5oxp+ggS9+3rIbgHDcV/qssR/VFYc=
Received: by 10.147.111.3 with SMTP id o3mr5859232yam.0.1311229773960; Wed, 20
 Jul 2011 23:29:33 -0700 (PDT)
Received: by 10.146.86.2 with HTTP; Wed, 20 Jul 2011 23:29:33 -0700 (PDT)
In-Reply-To: <20110719200022.GB3957@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2011 at 10:00 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 19, 2011 at 06:14:38AM +0200, Christian Couder wrote:
>
>> Perhaps but with "git replace" you can choose to create new replace refs and
>> deprecate the old replace refs to fix this where you got it wrong.
>>
>> It would be easier to do that if "git replace" supported sub directories like
>> "refs/replace/clock-skew/ted-july-2011/", so you could manage the replace refs
>> more easily.
>
> I think all of the arguments I cut from your email are reasonable, but
> the crux of the issue comes down to this point.
>
> If you are interested in actually correcting the skew, then yes, replace
> refs are a good solution. But doing so is going to involve somebody
> looking at the commits and deciding which ones are wrong, and what they
> should be.

I think that we can help the user a lot to find the skew, and then to
decide which commits are wrong, and then to fix the skew even if the
fix we suggest is far from being perfect.

> And maybe that's a good thing to do for people who really
> care about cleaning history.

Yeah, so maybe at one point we will want to help these people even if
we have implemented automatic generation numbers. Then this means that
automated generation numbers are useful only if:

1) there are commits with skews
2) the heuristics to deal with some skew don't work
3) the user is too lazy to use the help we (can) provide to fix the skews

I think that we can probably find heuristics that will deal with at
least 95% of the cases. For example we could perhaps decide that we
don't cut off a traversal until the date difference is greater than 5
days.

Then in the hopefully few cases where there are really big skews that
won't be caught by our heuristics, (but that we can automatically
detect when fetching or commiting,) we can perhaps afford to ask the
user to do a small analysis to properly fix the skew.

I mean that at one point when things are too weird it is ok and
perhaps even a good thing to involve the user.

> But for something like "speed up revision traversal by assuming commit
> timestamps are roughly increasing", we want something very automated,
> and what is needs to say is much weaker (not "this is what this commit
> _should_ say", but rather "this commit might be right, but it is not a
> good point for cutting off a traversal"). So that's a much easier
> problem, and it's easy to do in an automated way.

Yeah, generation numbers look like an easy thing to do. And yeah,
being automated is great too. But it does not mean it is the right
thing to do. (Or perhaps we could have them but not save them in any
cache, nor in the commit object.)

> So I think while you could use replace refs to handle this issue, it is
> not always going to be the right solution, and there is room for
> something simpler (and weaker).

You know, replace refs can be used to fix or improve a lot of things
like bad authors, clock skews, bisecting on a fixed up history,
working on a larger or smaller repository than the original, and so
on. And of course for each of these problems you may find another
solution tailored to the problem at hand that will seem simpler or
easier. But in the end if you develop all these other solutions you
will have developed a lot of stuff that will be harder to maintain,
less generic, more complex and so on, that properly developed replace
refs.

Thanks,
Christian.
