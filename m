From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 22:56:23 +0530
Message-ID: <CALkWK0nJM2wUE9qzp38qjFFqCdwX9w0Jckxi1G=1=7adMxg2rw@mail.gmail.com>
References: <20120111173101.GQ30469@goldbirke> <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke> <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com> <20120112171536.GA18102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 18:26:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlOQM-00061D-U0
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 18:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab2ALR0q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 12:26:46 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:42742 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab2ALR0p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 12:26:45 -0500
Received: by wibhm14 with SMTP id hm14so1383571wib.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=K/73D8KVymFPQcnuSvRqV0MY9PVoTqIk66B4kMT67eU=;
        b=nQtJbK41sZKfTaG4F0/2/4rE5a94ES/VVZiSFS+IMc4IJtpDvsgz9nUSO46Pa9t8An
         C2SC4s2atIN8IsawdGcLV7nCztez+frkYeDyo+JxfM7BkUjQJWFgcuxEnvUAui5I1mzb
         2wEnnWGHJxtZLvJ8nn8VUdvDsohelAwyeiPbA=
Received: by 10.180.107.134 with SMTP id hc6mr7695151wib.21.1326389204292;
 Thu, 12 Jan 2012 09:26:44 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Thu, 12 Jan 2012 09:26:23 -0800 (PST)
In-Reply-To: <20120112171536.GA18102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188459>

Hi Peff,

Jeff King wrote:
> It may even be possible to use
> heuristics to identify when --literal-order is needed, and eventually=
 it
> could go away.

Yeah, that would be really nice.

> My only concern is that there are other parts of the revision machine=
ry
> that depend on the date-ordering of the commit list.

Agreed.  Looking at it another way, it's an opportunity to read
revision.c, learn, and modernize some older parts :)

> What would happen,
> for example, with:
>
> =C2=A0git rev-list --literal-order --do-walk foo
>
> It probably doesn't make sense to allow literal-order without no-walk=
,
> anyway (which of course is the default in cherry-pick anyway, so it's
> not a big deal here).

I don't know if that particular case is a problem: there are some
mutually exclusive options in revision.c already like:

  cannot combine --reverse with --graph

This'll just be another one of them.

> I'm also not sure what:
>
> =C2=A0git rev-list --literal-order foo..bar
>
> would or should do.

Instead of classifying it as an "ordering" option (as defined in
Documentation/rev-list-options.txt), I think we should give it some
sort of special status for now -- it can be combined with ordering
options (of which date ordering is default anyway).  For this specific
question, I suspect that revision.c does a topo-ordering for commit
ranges (I haven't read the code), so we have to make sure that
whatever extra logic we add doesn't disrupt the existing logic in
revision.c.

-- Ram
