From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] builtin/apply.c: use iswspace() to detect
 line-ending-like chars
Date: Fri, 21 Mar 2014 19:07:34 -0400
Message-ID: <CAPig+cRcW8jv7LNZmLfrSGLaqE7yHycbmfvtNETPo51QoM7N2g@mail.gmail.com>
References: <1395344384-7975-1-git-send-email-g3orge.app@gmail.com>
	<CAPig+cTw8pyRVOHToGRPBdxv+TX8Vcj5OrX-CmLWRCigZRS4MA@mail.gmail.com>
	<CAByyCQBmCTfW0HBL04MMqwm+bDe4Rb6n+MfWdYUQ6M6yW_u=yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: George Papanikolaou <g3orge.app@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 22 00:08:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR8Xp-000145-Ae
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 00:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbaCUXHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 19:07:36 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:37046 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaCUXHf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 19:07:35 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so3118612yho.4
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=057oDnAk5YyP0oPrtCO2R22cmepW48+xDn5iMLl88Uc=;
        b=IUe6/z8UbPq5lI2jpR9gXNt6guCvS43axoo3SkBtU3G2p8S1Cr1MOXUhCYR3JtQkFT
         hDAIGnt4E/NMCsli2NVzcV3aSAuv2PXkNs/LI8YWRuMeaoC9Kwz9lXA+sCCuEyv69fMH
         bCrTVC3xz4dpF6blxuvon5MLATA4UmndnpSAt2I/hVaisuD3uGGd2QuPnKLCLPIeYUka
         OSviRStbx6n2dcn9dVYopnT/kbFIhKecLPxOX3zYojEcII6HC5biIaKF/9r4WabOHj+A
         UaqVfGDw1R7OaBnlmqKiBvLU9iZCw+ViRslAvQb2PciLI7/84IPWXyATl0sWTr+PuGbL
         y2BA==
X-Received: by 10.236.97.102 with SMTP id s66mr45611704yhf.45.1395443254740;
 Fri, 21 Mar 2014 16:07:34 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 21 Mar 2014 16:07:34 -0700 (PDT)
In-Reply-To: <CAByyCQBmCTfW0HBL04MMqwm+bDe4Rb6n+MfWdYUQ6M6yW_u=yw@mail.gmail.com>
X-Google-Sender-Auth: d3nMRPS88DgF40Ondm5lHOiA43w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244760>

[Please reply on-list to review comments. Other people may learn from
the discussion or have comments of their own.]

On Fri, Mar 21, 2014 at 6:00 PM, George Papanikolaou
<g3orge.app@gmail.com> wrote:
> On Fri, Mar 21, 2014 at 4:48 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> Did you verify that it is safe to strip all whitespace characters
>> rather than only line-endings? Perhaps say so in the commit message.
>>
>> Why the choice of iswspace()? These are normal-width character
>> strings, so why apply a wide-character function?
>>
> why not?

Because it's unnecessary and invites confusion from people reading
code since they now have to wonder if there is something unusual and
non-obvious going on. Worse, the two loops immediately below the ones
you changed, as well as the rest of the function, use plain isspace(),
which really ramps up the "huh?"-factor from the reader.

The original code has the asset of being clear and obvious. Changing
these two loops to use a wide-character function makes it less so.

> since at this point it is checking for any non-readable
> characters at the end of the buffer, I figured we should check for the
> "wide-character" function that covers these.

Neither the function comment nor the existing code implies that it is
checking for "any non-readable characters". (I'm not even sure what
that means.) The only thing the existing code says at that point is
that it is ignoring line-endings.

> It is true that the
> comment should change in that matter.
>
> Also why wouldn't it be safe? And how can I check?

You're changing the behavior of the function (assuming I'm reading
correctly), which is why I asked if you verified that doing so was
safe. The existing code considers "foo bar" and "foo bar " to be
different. With your change, they are considered equal, which is
actually more in line with what the function comment says.
Nevertheless, callers may be relying upon the existing behavior.

At the very least, the unit tests should be run as a quick check of
whether this behavior change introduces problems. Manual inspection of
callers also wouldn't hurt.

There's also the issue that Michael raised when he asked what would
happen if either string was composed of whitespace only. The existing
code is not robust and can crash, but your change may increase the
likelihood of the crash.

> Thanks
>
> --
> papanikge's surrogate email.
> I may reply back.
> http://www.5slingshots.com/
