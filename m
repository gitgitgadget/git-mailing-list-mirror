From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull & git gc
Date: Wed, 18 Mar 2015 19:27:46 -0700
Message-ID: <CAPc5daWmppS_PrvMurEUfvZ2c_bhMnLb-zmck0wzFpgJ4maxZw@mail.gmail.com>
References: <5509836D.2020304@aegee.org> <CACsJy8ChKgwr5OBRDG1p5nxwPC0vei7J=Lr3NefLYoReTMuhPA@mail.gmail.com>
 <55098A49.1020003@aegee.org> <CACsJy8AtoeSv7uZc3P2xXN0A15gpj-OUTRyNhMe__=HqtTkD2Q@mail.gmail.com>
 <CACsJy8DCdF1YmfFF1aCuhMJ0v4+FW7EkDiwBnBF2OFhE=kcbFg@mail.gmail.com>
 <20150318145815.GN1369@serenity.lan> <20150318210458.GA3376@peff.net>
 <CACsJy8AJfx8id+oHmhsLODBJeNLgRqD+5B295TtS+c-hrC5raQ@mail.gmail.com> <20150319012722.GA26867@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, John Keeping <john@keeping.me.uk>,
	=?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 03:28:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYQBw-0007ZV-PI
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 03:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbbCSC2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 22:28:09 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35210 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbbCSC2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 22:28:07 -0400
Received: by oiag65 with SMTP id g65so54138682oia.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 19:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=smVY7iGW3D0NB3Hp8+oQR2ngg/wMZW4OxVtldgXmDB8=;
        b=08FQoAQbuSE4/HGoWlGPMBNJH1GvxmZJxYx8Hp9S+e6hMf0QqxDLgp2gEvC8k0xKhO
         vZfwtqlMnO7ikw2Fb4I03eEcg+ab7kZBuRDw39oAiqT8jW0rIa7Kvkik8KjYn/0kafc5
         tVXlwnh9Xd1Ipk1H3l1zpeFrsjs8TxOAQBxrvbB9qs2hPeh/Z09HMfK26qZYAbrRCkxb
         VLpX43lLrOTMZfp6k4AHwIRfnlrlXKsrEESUkrX/qsL0YAfJy+QDIM3v6O8GYM5U4g7z
         f86aUDFFDGUMXoWldyL7sjHeG36RSXFcsMWAvxAU5IOExZxT0Pcr0iC0MAVU0YmvwU3G
         4moQ==
X-Received: by 10.182.75.194 with SMTP id e2mr58474705obw.17.1426732086257;
 Wed, 18 Mar 2015 19:28:06 -0700 (PDT)
Received: by 10.202.87.85 with HTTP; Wed, 18 Mar 2015 19:27:46 -0700 (PDT)
In-Reply-To: <20150319012722.GA26867@peff.net>
X-Google-Sender-Auth: AQRL8uhZxvSKzM4PjAXiU9rt3yE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265777>

On Wed, Mar 18, 2015 at 6:27 PM, Jeff King <peff@peff.net> wrote:
>
> Keeping a file that says "I ran gc at time T, and there were still N
> objects left over" is probably the best bet. When the next "gc --auto"
> runs, if T is recent enough, subtract N from the estimated number of
> objects. I'm not sure of the right value for "recent enough" there,
> though. If it is too far back, you will not gc when you could. If it is
> too close, then you will end up running gc repeatedly, waiting for those
> objects to leave the expiration window.
>
> I guess leaving a bunch of loose objects around longer than necessary
> isn't the end of the world. It wastes space, but it does not actively
> make the rest of git slower (whereas having a large number of packs does
> impact performance). So you could probably make "recent enough" be "T <
> now - gc.pruneExpire / 4" or something. At most we would try to gc 4
> times before dropping unreachable objects, and for the default period,
> that's only once every couple days.

We could simply prune unreachables more aggressively, and it would
solve this issue at the root cause, no?

We do keep things reachable from reflogs, so the only thing you are
getting by leaving the unreachables around is for an expert to perform
some forensic analysis---especially if there are so many loose objects
that are all unreachable, nobody sane can go through them one by one
and guess correctly if each of them is what they wished they kept if
their ancient reflog entry extended a few weeks more.

That is, unless there is some tool to analyse the unreachable loose
objects, collect them into meaningful islands, and present them in
some way that the end user can make sense of, which I do not think
exists (yet).
