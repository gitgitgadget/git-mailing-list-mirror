From: Roman Kagan <rkagan@mail.ru>
Subject: Re: [PATCH 1/3] git-svn: use POSIX::sigprocmask to block signals
Date: Tue, 24 Apr 2012 01:07:23 +0400
Message-ID: <CANiYKX68AJyE3+3BT7QSjziGS=HGKuk95rxS_04c0sGz9pywXw@mail.gmail.com>
References: <cover.1335198921.git.rkagan@mail.ru>
	<d21d7433574e8ea7628320dbe1a5fc0dc9d94e64.1335198921.git.rkagan@mail.ru>
	<xmqqipgqjqtk.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 23:07:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMQTr-0003A4-ID
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 23:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147Ab2DWVHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 17:07:25 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:41489 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab2DWVHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 17:07:24 -0400
Received: by obbta14 with SMTP id ta14so13215691obb.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 14:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NmEgyspugtScuN8dtzjSss7C5ZK49jEFgEpokwunAKE=;
        b=ElftJGNq+DtzbiyB6kPamVGwQtbJROKdCXSkCeIS7FmQWpXYFI7Q+2SOeJywZ7r5nx
         p7lqBmh083Ftd+FLEYUVVPyAzqc4T49vGqxDvqiIKNi4sgqZSy8USQTEXFlwzaIroLsx
         Lk3aWNS4urBkHBdU0F+ELqwreYizGFQ3tNuo8MzAMKjjcK2tqIOpMaqw5Vz/ldpE8bZy
         E1vZAuLb0BL33vQxMT2drIW7VyNsgzHprNxTkfe0a7f8SxGfEqXkl0Sh1Z8qBQWeX+M7
         XXaPnccxC795ea6fy7CWHHCyRL8FQuf8vzJ2dKqXvcYhOq9xHe/w4RS6TEv2iATpuWqG
         Ps6A==
Received: by 10.182.13.99 with SMTP id g3mr24951923obc.22.1335215243822; Mon,
 23 Apr 2012 14:07:23 -0700 (PDT)
Received: by 10.182.46.129 with HTTP; Mon, 23 Apr 2012 14:07:23 -0700 (PDT)
In-Reply-To: <xmqqipgqjqtk.fsf@junio.mtv.corp.google.com>
X-Google-Sender-Auth: IZXd1hdLjH78SBdtaNQfwTC_9wg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196166>

23 =C1=D0=D2=C5=CC=D1 2012=9A=C7. 21:33 =D0=CF=CC=D8=DA=CF=D7=C1=D4=C5=CC=
=D8 Junio C Hamano <junio@pobox.com> =CE=C1=D0=C9=D3=C1=CC:
> Roman Kagan <rkagan@mail.ru> writes:
>
>> rev_map_set() tries to avoid being interrupted by signals.
>
> The wording "tries to avoid" was unclear and I had to read the code
> twice. =9AThe code defers the signal processing but still wants to ge=
t the
> signal after it is done what it is doing, which is different from sim=
ply
> "ignoring", which is another way to "try to avoid".

Sorry.  I'll try to avoid misunderstanding next time ;)

>> This is implemented by this patch. =9AOne important consequence of i=
t is
>> that the signal handlers won't be unconditionally set to SIG_DFL any=
more
>> upon the first invocation of rev_map_set() as they used to.
>
> That may be the first degree consequence (another is what happens whe=
n
> you received signals of different kinds while in the blocked section)=
,
> but how would that difference affect the overall program execution?

Unless the parent of this script decides to ignore those signals,
nothing will change: the signals will be delivered at the end of the
section and script will die.

>> [That said, I'm not convinced that messing with signals is necessary
>> (and sufficient) here at all, but my perl-foo is too weak for a more
>> intrusive change.]
>
> Everything you discussed above in the log message before "That said"
> part made sense. =9AInstead of catching and setting a single $sig and
> replaying that later, potentially losing accumulated signals that are=
 of
> different kinds, blocking before entering the part you do not want to
> get interrupted and unblocking after you are done is better done usin=
g
> sigprocmask.
>
> If the problem to solve is to implement deferral and delayed signal
> processing correctly, I think your patch did the right thing, but you=
r
> "necessary/sufficient" comment implies that the problem you were tryi=
ng
> to address is _different_ from that. =9ABut it is not clear what it i=
s.
>
> Could you elaborate on it a bit more here, or if it will become clear=
 in
> the later patch, then please drop that parenthesized part out of the =
log
> message.

If read the code correctly (and I'm not a "native perl speaker"), all
this is about maintaining consistency in the ad-hoc database for
mapping svn revision numbers git commits.

However, blocking some signals is obviously not a good enough
protection measure: the program may die on SIGKILL or the power may go
off.  Even worse, due to the unfortunate record size of 24 bytes
there's essentially no way to ensure atomicity of appends.

So if the consistency of this database is critical for git-svn, then
it needs a stronger protection mechanism; if it isn't then it's
probably not worth the hassle at all.

However, as I said I'm not strong enough in perl to understand which
of the above applies and how to do it right.  (Yes, ~7kloc perl script
using multi-level callback-based svn binding scares me off).

So I just made a fairly simple change that basically preserved the
existing behavior but allowed me to set SIGPIPE to SIG_IGN for the
duration of the script run in the second patch of the series.

Do you think I should merge this into the commit log, or just drop
that appendix from my original log and be done with it?

Roman.
