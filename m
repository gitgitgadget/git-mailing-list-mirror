From: Jeffrey Middleton <jefromi@gmail.com>
Subject: Re: approxidate parsing for bad time units
Date: Mon, 10 Sep 2012 14:07:02 -0700
Message-ID: <CAFE6XRHmX6TjGu7Jte_KW82nYX7ZUw6imO1ktbUcYpNbc6ZBsA@mail.gmail.com>
References: <CAFE6XRFgQa10vTWXfxRG53W6K4U=VGqpK5sQwH7xp9GfKd=2Uw@mail.gmail.com>
 <7vehme3n49.fsf@alter.siamese.dyndns.org> <CAFE6XREG5-gwjzvyP9r_hfyY3bWSV2=Bjv9ZbXkejXQRoqYERA@mail.gmail.com>
 <20120907135452.GA1290@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:13:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBIq-0005LO-6Y
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:13:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab2IJVNs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:13:48 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:50294 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab2IJVNr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:13:47 -0400
Received: by vcbfy27 with SMTP id fy27so2024999vcb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gPT0w02sDtOzbuj5FrAtoXewhsz30Asw7yPZOJM3g90=;
        b=e5fGLxJFuUzMs9yN/5uO3UWnH1ecAdb1nwlYl0pQWga8B5T9w5RGG7Hh8AH9/t++dG
         mPH+49onyt3EJgLHc4OpHUleZebeE626l7S49RdoeG1YlbHpxA4/sXGPd6USkBndLrQ/
         5OnDPzIGgQFw6tKcwfQ23JtACDmUadO5IBPqs5jMppjgRXdwfXXq5HYU09epTlBP9ZpX
         jperWf2WjBv2pO72RuofnbcdWuNDk1nBviMxH1V7aBTl+e+dImtDX7VkxXx60bJuK2U6
         X5B8EwcW6XB4eAOdFbUKzKpns/psZhk9UGdQTFCIvfP4r8dExqqFdbzphgGZLjiDmJFG
         ifjw==
Received: by 10.220.239.209 with SMTP id kx17mr22005349vcb.41.1347311242224;
 Mon, 10 Sep 2012 14:07:22 -0700 (PDT)
Received: by 10.220.26.3 with HTTP; Mon, 10 Sep 2012 14:07:02 -0700 (PDT)
In-Reply-To: <20120907135452.GA1290@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205181>

As you mentioned, parsing "n ... [month]", and even "...n..." (e.g.
"the 3rd") as the nth day of a month is great, but in this case, I
think "n ... ago" is a pretty strong sign that that's not the intended
behavior.

My first thought was just to make it an error if the string ends in
"ago" but the date is parsed as a day of the month. You don't actually
have to come up with any typos to blacklist, just keep the "ago" from
being silently ignored. I suspect "n units ago" is by far the most
common use of the approxidate parsing in the wild, since it's
documented and has been popularized online. So throwing an error just
in that case would save essentially everyone. I hadn't even realized
it worked without "ago" until I looked at the code.

If that doesn't sound like a good plan, then yes, I agree, it'd be
tricky to catch it in the general case without breaking things.
(Levenshtein distance to the target strings instead of exact matching,
I guess, so that it could say "did you mean..." like for misspelled
commands.)

On Fri, Sep 7, 2012 at 6:54 AM, Jeff King <peff@peff.net> wrote:
>
> On Thu, Sep 06, 2012 at 02:01:30PM -0700, Jeffrey Middleton wrote:
>
> > I'm generally very happy with the fuzzy parsing. It's a great feature
> > that is designed to and in general does save users a lot of time and
> > thought. In this case I don't think it does. The problems are:
> > (1) It's not ignoring things it can't understand, it's silently
> > interpreting them in a useless way.
>
> Right, but we would then need to come up with a list of things it _does_
> understand. So right now I can say "6 June" or "6th of June" or even "6
> de June", and it works because we just ignore the cruft in the middle.
>
> So I think you'd need to either whitelist what everybody is typing, or
> blacklist some common typos (or convince people to be stricter in what
> they type).
>
> > So I do think it's worth improving. (Yes, I know, send patches; I'll
> > think about it.)
>
> You read my mind. :)
>
> -Peff
