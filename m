From: Josiah Boning <jboning@gmail.com>
Subject: Re: git log with ordering option and --first-parent is unnecessarily slow
Date: Fri, 8 Apr 2016 22:42:15 -0700
Message-ID: <CAKdicq_uNFcy0_SPephHX9KhEouYdk0ddj4g0y4nAiD90+eH3A@mail.gmail.com>
References: <CAKdicq8MnZMBV97K5O8Oa1T=PT9DsutmBS+P-bFYitATHH3s+Q@mail.gmail.com>
	<20160409050116.GB25151@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 07:42:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aolfB-0000pS-Jf
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 07:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbcDIFmR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 01:42:17 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35355 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbcDIFmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 01:42:16 -0400
Received: by mail-oi0-f50.google.com with SMTP id p188so157809875oih.2
        for <git@vger.kernel.org>; Fri, 08 Apr 2016 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=OrjHD1Bu0pi+OvDvSKnr1oDR7eawC/Na4RZ3eJ091wQ=;
        b=QGdsxQpF/pRVuJSrfxRxqUtUJC3TERQTbLkRaPKENXizbD23CtTapGfSlR8XYhLaA5
         azs9SBrx20S+JfrQcDDhu2s21ANI5ErZA2DIsK1Fa539csqoJIOAi2v2k/XXlxVH/EoM
         3UFdExLegpBSvmDANJ75i+0jn4qe0qC64p3Kf6pMAjCYgQocnzTCaNieqWxsC+wnsA5B
         JOBtrgDn0JL/t1nhIAqL5pLLTSZq6MecgpMpK4AscOBX8Ft/KfDJ+fE9jxfbOFJomeja
         lry2xtEVpZt/2wQFLeel8bDndZ0j3RLF6F9pwiT4IDWt+GHC0R6KzKrBbSUfl1fmgctP
         T8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=OrjHD1Bu0pi+OvDvSKnr1oDR7eawC/Na4RZ3eJ091wQ=;
        b=Ny4qGBWH9phiVGDObtT97jP58STdfuRUrq1MT1h4RPRGjAVy3lQbMjyKa4BDmDnY4i
         KYosul1IZzWRcwaI/7IXxqB2J/9vF/806zH5wD1DsfblZ7m4wXczGo4mZjEVNn1L7aNZ
         qtOdOK39Dm2XvmPrEE47XhYJru2YilKcBe4w1gGoz2twSTCLdXDveFpPjCgKqrO93ycv
         Y5Xi6UzNp9OGBIb/zzvvKOrPLflAT0IPO4r60lpfCajsPJia5w1gAK2ptAkgC8NMeFwO
         q46C97quy1NnRBSRGiYeIpCeKd856hEGG2jA292JYjH+PzvZCt2wVdG3b/IsIFFRQR4H
         0wCQ==
X-Gm-Message-State: AD7BkJK7jPsWw2TWIKx/XVO1/XYgh+y3zPoupLPhnPmTFz85OSB08c2WjeC2xske+9XN+UMigbRBligJD8b/Mw==
X-Received: by 10.157.24.103 with SMTP id t36mr5654616ott.101.1460180535581;
 Fri, 08 Apr 2016 22:42:15 -0700 (PDT)
Received: by 10.182.177.10 with HTTP; Fri, 8 Apr 2016 22:42:15 -0700 (PDT)
In-Reply-To: <20160409050116.GB25151@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291082>

On Fri, Apr 8, 2016 at 10:01 PM, Jeff King wrote:
> I do agree that --date-order on a linear parent walk cannot change the
> ordering (which guarantees child-before-parent), and is a noop.  But
> note that not all first-parent invocations are strictly linear. For
> example:
>
>   git log --first-parent --date-order master next
>
> which starts from two tips. We'd still want to order commits from the
> two lists according to --date-order.

Ah, indeed; multiple tips certainly count as a nonlinearity.

> I suppose we could catch the single-tip, first-parent case and ignore
> any ordering options which imply child-before-parent (which is currently
> all of them). But I did not think too hard if there are any other corner
> cases. This sounds like a case of "doctor, it hurts when I do this". Why
> do you want to add --date-order in such a case, when it is a noop?

It hurt when I did that, so I stopped. In my case, the git log command
was written when the repositories involved were much smaller, so the
delay was not so noticeable. Today I found and fixed the
invocation--but it still seems nice to fix at the git level, if that's
possible without adding much complexity.

> It's not the cost of sorting. It's the cost of accessing the commits (if
> you profile, you should see most time spent in zlib). So figuring out
> that the case is linear will require roughly the same expense.

I'm imagining that while traversing the commit graph, one could keep
an is_linear flag, which is set initially if starting from a single
tip, and becomes unset when a merge commit is encountered. If
is_linear is still true when the entire requested range or the desired
number of commit sare accumulated, then there's no need to sort.

This is, as a disclaimer, the guesswork of someone not familiar with
the codebase. I'll go read the source before imagining further :)

Josiah
