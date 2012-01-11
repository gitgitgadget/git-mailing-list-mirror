From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/8] revert: decouple sequencer actions from builtin commands
Date: Wed, 11 Jan 2012 10:44:28 +0530
Message-ID: <CALkWK0kJpEXvBMV=D7h91sz7U2sLvXdW1UzomW0kG2bbM+byYA@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com> <1326212039-13806-3-git-send-email-artagnon@gmail.com>
 <20120110183857.GC22184@burratino> <CALkWK0k=44znLr2oYSx61Mk=qdAurona0f0H4i4=YXNSAeQhHQ@mail.gmail.com>
 <CALkWK0=bEPPv4rtPrMrQnk3MK=JY4-wwAByWPmzg86NBm_56iQ@mail.gmail.com> <20120111050404.GA13507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 06:15:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkqWa-0005gK-53
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 06:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286Ab2AKFOv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 00:14:51 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:37545 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab2AKFOu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 00:14:50 -0500
Received: by werm1 with SMTP id m1so240034wer.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 21:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pKj5lE6aJ+OAorjMoFnf8EoRZvjhlFtEmUDGf3CKRqQ=;
        b=nxFdchNoUBvGllnKBZRu5f0UAlYLNAlC9xM4Q+mEB+7rDXc3s69ZVYEeZCAs3eESKp
         Jl2nPlNKm7mY+NQULfVp2YNyohRGyR9T/8bUhMC0ciny0uAjx8U2Obo/CJcsqRepTS3o
         7bm44vW8rqKcLWJthY/xROcGHsfPoMAYAcB4w=
Received: by 10.216.137.232 with SMTP id y82mr2148048wei.0.1326258889232; Tue,
 10 Jan 2012 21:14:49 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Tue, 10 Jan 2012 21:14:28 -0800 (PST)
In-Reply-To: <20120111050404.GA13507@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188331>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> I wrote that too quickly. =C2=A0I can't stand seeing so many strcmp(=
) calls
>> all over my codebase -- look at the number of instances of matching
>> opts->command to REPLAY_CMD_*.
>
> If the number of such in sequencer.c is greater than 0, it's probably
> a bug. =C2=A0Why would the sequencer change behavior based on its cal=
ler's
> name?

In the super-final version, yes-  I agree.  However, we're not there
yet -- this patch is more of a transition, to make the life of
"revert: allow mixing "pick" and "revert" actions" easier.  Once the
painful move to sequencer.c is completed, we can think about all these
things.  Right now, I'm only focusing on the move, and everything that
should logically precede it (in my opinion).

> Is this what you're talking about?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (opts->action =3D=3D CHERRY_PICK)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error(_("Your =
local changes would be overwritten by cherry-pick."));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error(_("Your =
local changes would be overwritten by revert."));

1. Yes, error messages like this.
2. Since I haven't modified function prototypes to include a
"replay_action" at the "revert: decouple sequencer actions from
builtin commands" stage, functions like do_pick_commit() have to rely
on opts->command!  That's the entire point: I want to show how this
"opts->command" is changing to "action" in most places in "revert:
allow mixing "pick" and "revert" actions".

I'd rationalize that taking care of (1) is not urgent- we can do it
after we move to sequencer.c.  As for (2), we have little choice at
this point- either make it a string like it's supposed to be in the
super-final version, and struggle with the ugliness of strcmp() now,
or make it an enum now; I choose the latter.

Thanks for making me explain this.

-- Ram
