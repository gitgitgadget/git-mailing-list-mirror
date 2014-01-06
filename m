From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 7 Jan 2014 04:17:00 +0530
Message-ID: <CALkWK0=Km+a7NBm9ki5MN=R28HkzUZRqnBKcpuPZDrQKdsBesg@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com> <CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
 <xmqqha9ghhrw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 23:47:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0IxW-0003t7-2r
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 23:47:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933614AbaAFWrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 17:47:42 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:52889 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933442AbaAFWrl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 17:47:41 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so19556114iec.30
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 14:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H11uMP8P7H9dbYEtGqI/Oj+3ZbRKS2jtKHFJMy/Y2z0=;
        b=XyYkl5qoI+G2wykRgufTtc26Kp68n5Q0hztmalCrRY2GerGVfI8FywD3RpXjqf3oUm
         rzlKySsPQzrQfDcVt30E0hGalQsgwvgQ1sSOuOGBI3xg9XIc2qrTWkl366aAG4nTGJhh
         SoE43KmMy2vFqvUT2IOxH8X/Accucq4c3t963yBuevJPPgTyriCmtA2QzuM/BF0vu0Fn
         HbQ6TwGvBEXAJLjMkLDKH8M8aWr0fguKr2a4gDt8k/Y8eTq2OrTHhlcGMGSbfIedNR1V
         FOCdxFrWqsn3pr32cKw6VvChEo+IuQvLpoxRlUn9FjmezTzCYFaE8ZXP3B233mrZYK1F
         D8og==
X-Received: by 10.50.128.137 with SMTP id no9mr22567937igb.36.1389048460702;
 Mon, 06 Jan 2014 14:47:40 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Mon, 6 Jan 2014 14:47:00 -0800 (PST)
In-Reply-To: <xmqqha9ghhrw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240077>

Junio C Hamano wrote:.
> As I said in the different subthread, I am not convinced that you
> would need the complexity of branch.*.forkedFrom.  If you set your
> "upstream" to the true upstream (not your publishing point), and
> have "remote.pushdefault"set to 'publish', you can expect
>
>         git push
>
> to do the right thing, and then always say
>
>         git show-branch publish/topic topic

I think it's highly sub-optimal to have a local-branch @{u} for
several reasons; the prompt is almost useless in this case, and it
will always show your forked-branch ahead of 'master' (assuming that
'master' doesn't update itself in the duration of your development).
While doing respins, the prompt doesn't aid you in any way. Besides,
on several occasions, I found myself working on the same forked-branch
from two different machines; then the publish-point isn't necessarily
always a publish-point: it's just another "upstream" for the branch.
The point of a special branch.*.forkedFrom is that you can always show
the "master..@" information in the prompt ignoring divergences; after
all, a divergence simply means that you need to rebase onto the latest
'master' ('master' is never going to get a non-ff update anyway).

So, instead of crippling the functionality around the publish-point,
let's build minimal required functionality around branch.*.forkedFrom.
I'd love a prompt like:

  branch-forkedfrom<>5*:~/src/git$

Clearly, branch-forkedfrom has diverged from my publish-point (I'm
probably doing a respin), and has 5 commits (it's 5 commits ahead of
'master' ignoring divergences).

> to see where your last published branch is relative to what you
> have, no?  Mapping "topic@{publish}" to "refs/remotes/publish/topic"
> (or when you have 'topic' checked out, mapping "@{publish}" to it)
> is a trivial but is a separate usefulness, I would guess.

I think a @{publish} is needed for when branch.*.remote is different
from remote.pushDefault. Like I said earlier, it's probably too much
information to give to the user: divergences with respect to two
remotes. So, we'll hold it off until someone finds a usecase for it.
