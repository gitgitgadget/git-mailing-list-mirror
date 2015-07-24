From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 08:04:21 -0700
Message-ID: <xmqqd1zhoave.fsf@gitster.dls.corp.google.com>
References: <20150723012343.GA21000@peff.net>
	<xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
	<CA+P7+xoOkTfair3M7HH_TPs9qxBAUR5GodHGDuw8Ux_HaUvvyQ@mail.gmail.com>
	<20150724073415.GD2111@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 17:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIeWU-0006k5-0f
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 17:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbbGXPE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 11:04:26 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34747 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbbGXPEY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 11:04:24 -0400
Received: by pacan13 with SMTP id an13so16014250pac.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 08:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UAQD+29zxlEyBJk1NB6DjX5ipIoht8JlJAZhEBaWmyY=;
        b=agpJ217vyCzJQG5mPvotol1Sa4JG6Fn73JCGmoEqSR/8jA9GqIvxgejORcljaZG9fM
         YojKFbMmrmyQ+1g7DwUjbofr563vC2UT643c7k0/R/9G57ptpev2AOum9xbiPvdPIyxb
         v0EasektD+B4KNFD9FBmx4ChVAacd1mh8nod8bQZYNz7ba3GHJrcj8iBod0JG6Qh+g1f
         s74NLV/jLKznhIb7V9dc/EAzM+qViVw054/P1nkiVMQXfbYMaXoSDmWItD/VZeB7Nla5
         NXVJLTnzvz/ZtWGjXLa52Ci+ScDgbrHF1hbB6WayhmlHTuDmdVyP8D9hUtUJrwE+MIeX
         ZHtw==
X-Received: by 10.67.1.226 with SMTP id bj2mr32043274pad.34.1437750264365;
        Fri, 24 Jul 2015 08:04:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id si3sm15203548pac.5.2015.07.24.08.04.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 Jul 2015 08:04:22 -0700 (PDT)
In-Reply-To: <20150724073415.GD2111@peff.net> (Jeff King's message of "Fri, 24
	Jul 2015 00:34:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274571>

Jeff King <peff@peff.net> writes:

> I think a really simple example is something like:
>
>   1. somebody implements as feature. It needs to handle cases a, b, and
>      c, but it only handles case a. Therefore it is buggy.
>
>   2. During review, somebody notices case b, and a new commit is made to
>      fix it. Nobody notices case c.
>
>   3. The topic is merged.
>
>   4. Much later, somebody notices the system is buggy and hunts in the
>      history.
>
> In a "clean" history, the patches from steps 1 and 2 are squashed. While
> reading the history, you see only "implement feature X", and no mention
> of the bug and its fix. But even if the person writes a terrible commit
> message for step (2), even seeing it pulled out into its own diff shows
> the exact nature of the already-seen bug, and may make it more obvious
> to realize that case (c) is a problem.
>
> I realize that's kind of vague. Another way to think about it is: in a
> squashing workflow like git.git, any time you have to turn to the
> mailing list to read the original sequence of re-rolls, you would have
> been better off if that information were in git. That's a minority case,
> but I certainly have turned to it (in some cases, the "fix" from our
> step 2 above actually introduces the new bug, and it's nice to see the
> reasoning that went into it :) ).
>
> Not that I am advocating for git.git to move to such a workflow. 

I actually do not think the above is quite true.  In our kind of
"clean history, we do not squash 1 & 2.  See Paul's "rewrite am in
C" series, for example, that starts from a "buggy" (in the sense
that it does almost nothing in the beginning and then gradually
builds on).

Instead, even somebody did not have foresight to realize 'b' when
she adds code to handle 'a', we would make sure the solution for 'a'
is sufficiently clearly described in commit #1.

In other words, without #1 and #2 squashed together, the history you
presented in your example _could_ be already "clean".  It just boils
down to the quality of individual commit.
