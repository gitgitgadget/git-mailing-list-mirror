From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Mon, 13 Aug 2012 09:09:20 -0700
Message-ID: <CAOeW2eHprw73+zqVbJRird1eE7ayU_KjCUSoieYsGi1rbL5QBQ@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
	<7vhas7fefs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 18:09:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0xCp-0002wv-0A
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 18:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab2HMQJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 12:09:22 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:48045 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab2HMQJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 12:09:21 -0400
Received: by ghrr11 with SMTP id r11so3168971ghr.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qokqHAd0VELR05k6AwCm3Bdm+nh+eOaJRNZ4FErkZgQ=;
        b=EB66NK9TE6I4VX9QS7qmxFoaDiwZ0P/Hy4BNTiJW3CHXDc8AquwKLxMdEtWDi+YKfz
         ohOkN7+2QlpVJ408Grb1wNyy7RWvCnnyFY8eprs0Cea0ktg7SwVGBi89ECR0YF46FL5l
         3wyNCMhwcg8/TTHlWy/aFK8Krg2SdrGKibzRyeWEvm/vRKLvFYYzGe/Xa5c17Fugb0uk
         Sc/ohh8QXXu5UzTJ+ua7eqWQjDip/w0yS/fADigHYJzze/68zbZ58u6ssO7CeQTUaySr
         2BqduRE2FgekA8gImHIZobW7jTT2mTthg6s6Iq/65iWAwfObApzZ4f81RVoLgvjdaJfh
         Eaxg==
Received: by 10.68.136.137 with SMTP id qa9mr16865439pbb.140.1344874160041;
 Mon, 13 Aug 2012 09:09:20 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Mon, 13 Aug 2012 09:09:20 -0700 (PDT)
In-Reply-To: <7vhas7fefs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203341>

On Mon, Aug 13, 2012 at 12:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> y@google.com writes:
>
> [Administrivia: I somehow doubt y@google.com would reach you, and
> futzed with the To: line above]

:-( Sorry, sendemail.from now set. (I apparently answered "y" instead
of just <enter> to accept the default.)

> I actually think --no-walk, especially when given any negative
> revision, that sorts is fundamentally a flawed concept (it led to
> the inconsistency that made "git show A..B C" vs "git show C A..B"
> behave differently, which we had to fix recently).

I completely agree.

> Would anything break if we take your patch, but without two
> possibilities to revs->no_walk option (i.e. we never sort under
> no_walk)?  That is, the core of your change would become something
> like this:

I also thought the sorting was just a bug. From what I understand by
looking how the code has evolved, the sorting in the no-walk case was
not intentional, but more of a consequence of the implementation. That
patch you suggested was my first attempt and led me to find the broken
cherry-pick test cases that I then fixed in patch 2/4. But, it clearly
would break the test case in t4202 called 'git log --no-walk <commits>
sorts by commit time'. So I started digging from there and found e.g.

http://thread.gmane.org/gmane.comp.version-control.git/123205/focus=123216

For convenience, I have pasted the commit message of the commit
mentioned in that thread at the end of this email.  So we would be
breaking at least Johannes's use case if we changed it. I would think
almost everyone who doesn't already know would expect "git rev-list A
B" to list them in that order, so is a migration desired? Or just
change the default for --no-walk from "sorted" to "unsorted" in git
2.0?

By the way, git-log's documentation says "By default, the commits are
shown in reverse chronological order.", which to some degree is in
support of the current behavior.


commit 8e64006eee9c82eba513b98306c179c9e2385e4e
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Tue Jul 24 00:38:40 2007 +0100

    Teach revision machinery about --no-walk

    The flag "no_walk" is present in struct rev_info since a long time, but
    so far has been in use exclusively by "git show".

    With this flag, you can see all your refs, ordered by date of the last
    commit:

    $ git log --abbrev-commit --pretty=oneline --decorate --all --no-walk

    which is extremely helpful if you have to juggle with a lot topic
    branches, and do not remember in which one you introduced that uber
    debug option, or simply want to get an overview what is cooking.

    (Note that the "git log" invocation above does not output the same as

     $ git show --abbrev-commit --pretty=oneline --decorate --all --quiet

     since "git show" keeps the alphabetic order that "--all" returns the
     refs in, even if the option "--date-order" was passed.)

    For good measure, this also adds the "--do-walk" option which overrides
    "--no-walk".

    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
