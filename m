From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/5] range-set and line-log bug fixes
Date: Thu, 25 Jul 2013 04:03:35 -0400
Message-ID: <CAPig+cRWaKv6UN5pZLwonXBpHnFE7+4ELXTnE+2nLr8h83bX6Q@mail.gmail.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 25 10:03:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2GWc-0006hf-T3
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 10:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755245Ab3GYIDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 04:03:46 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:37116 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab3GYIDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 04:03:37 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so712335lbc.13
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=5GW+Q/usm+CvABbD3Aa2E7FjPiY2GqQoS0bZPvOvVkw=;
        b=K/Zy8WY6WPaJtZByWzofbGfKjjTIRhAP0vQy+mppRR1/1s00aN7wmcSOh3tLKr+qWd
         4bIH/9euCDY+JsPLKTdnb6ge72KtbnLJo5SKg/udZlgMwltSmYmibXJNCR3OaRNyoj8q
         dzVD8SSuDBfufCXoMDRcDFG3oUVlqHsNFKm5rP3NHSwR8+fu+Z0MUaOx1Q319EDrtgRX
         nRqpvDOK1pXAQU+dsCMctmvhM4L9chFytiriXxiDXCWO3oLgje/iouITfLiEwcDA8Ebj
         ezLNG4Mgi8X2sYZzP1bYlfuHYO6HPZPBTcBXoN/XGxkhuEmpZYCI+4z93IjlJqWyj/OG
         PnQg==
X-Received: by 10.152.5.227 with SMTP id v3mr18760401lav.31.1374739415457;
 Thu, 25 Jul 2013 01:03:35 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 25 Jul 2013 01:03:35 -0700 (PDT)
In-Reply-To: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: b9BYr7IsyMm6kwaqzTFeaYkijS8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231126>

On Tue, Jul 23, 2013 at 10:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> While implementing multiple -L support for git-blame, I encountered
> several bugs in range-set and line-log resulting in crashes. This
> series fixes those bugs.
>
> Eric Sunshine (5):
>   range-set: fix sort_and_merge_range_set() corner case bug
>   t4211: demonstrate empty -L range crash
>   range-set: satisfy non-empty ranges invariant
>   t4211: demonstrate crash when first -L encountered is empty range
>   line-log: fix "log -LN" crash when N is last line of file

I've run into a bit of a conundrum relating to the tests added by this
series, for which I could use some input.

The tests in this series identify real bugs in dealing with empty
ranges, which the subsequent patches fix. The test are possible
because one can specify an empty range via blame/log -L, however, I
now realize that the ability for -L to create empty ranges was never
intended or part of the design, but is in fact itself a bug. An
example manifestation of this bug, given a 5-line file:

  % git blame -L5 foo  # OK, blames line 5
  % git blame -L6 foo  # accepted, no error, no output, huh?
  % git blame -L7 foo  # error: "fatal: file foo has only 5 lines"

I believe that it is correct to fix this bug (and already have a fix
locally). The example -L6 should error out just like -L7 rather than
creating an empty range.

Fixing this bug closes the empty-range-creation loophole which is used
by the t4211 tests added in this series and, unfortunately, there is
no other way to create an empty range, hence no way to keep these
tests operational. What to do?

* Should we drop these new t4211 tests which guard against real potential bugs?

* Should we add custom C code to the test suite to make the
empty-range testing possible?

* Should we introduce another (undocumented) loophole just for the
sake of the tests?

For the last point, I was considering -Lfoo,+0. It is currently
undocumented and its behavior undefined. In fact, -Lfoo,+0 and
-Lfoo,-0 presently are interpreted as -Lfoo,+2 (definitely undefined
behavior). It would be possible to make -Lfoo,+0 mean empty-range and
keep it undocumented, which would create the loophole these tests
require.

I personally dislike this idea for several reasons: (1) we should be
closing loopholes rather than creating them intentionally; (2)
generally, an empty range has no useful meaning in conjunction with
-L; (3) if not an empty range, then -Lfoo,+0 conveys nothing and
should be reported as an error.

The only possible minor advantage I can see to interpreting -Lfoo,+0
as an empty range is that it could provide an anchor for relative
-L/RE/ searches once blame accepts multiple -L options. For example,
"blame -L42,+0 -L/^struct/,/^}/ foo.c" would blame the first struct
starting at line 42, without also showing blame for line 42. I don't
really consider this a good argument in favor of -Lfoo,+0 representing
an empty range, and it's a very poor substitute for Michael Haggerty's
more expressive proposal [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/229755/focus=230967
