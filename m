From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What should "git fetch origin +next" should do?
Date: Mon, 17 Oct 2011 21:40:56 +0530
Message-ID: <CALkWK0kXyovFrJO+5AD3gOs1YuutBZouH8aESXSKA-1nX3T6rw@mail.gmail.com>
References: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 18:11:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFpmd-0005A1-ET
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 18:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab1JQQLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 12:11:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54865 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab1JQQLS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 12:11:18 -0400
Received: by wyg36 with SMTP id 36so2372474wyg.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8jpZ0D55jByKF2b1itHGoyV0i+l9m9vBGYHmzPQmD1k=;
        b=hy8hFRoD491Vpm1BXtKwDg/LHxDg6HSRLpna/MMzXjKCVtN3SD7MAu0lB72KBK3Jrb
         zdo0KJIlBlzs77fcnbubPx9tGFLQVZIQN7BHO4T9auKeW7F/w0IaOUO2wcud59vb+pT5
         l+jg7obJu2JClfKLN3NYNgkGSqvl+Yz33Kf/U=
Received: by 10.216.165.136 with SMTP id e8mr6640977wel.60.1318867877081; Mon,
 17 Oct 2011 09:11:17 -0700 (PDT)
Received: by 10.216.51.75 with HTTP; Mon, 17 Oct 2011 09:10:56 -0700 (PDT)
In-Reply-To: <7v7h45s8rh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183795>

Hi Junio,

Junio C Hamano writes:
> I just tried to update one of them with "git pull --ff-only", and aft=
er
> seeing that the fetch phase failed with non-ff on 'next', ran
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git fetch origin +next
>
> which happily copied the tip of updated next to FETCH_HEAD and nowher=
e
> else. Of course, a colon-less refspec means do not store it anywhere,
> i.e. "<colon-less-refspec>" =3D=3D=3D "<colon-less refspec>:", so pre=
fixing it
> with '+' to force would logically be a no-op. =C2=A0But it neverthele=
ss was
> somewhat surprising and irritating.

Interesting: I wouldn't have expected this behavior either.  I'll see
if I can add something useful to this.

> As some might know, I use the traditional non-separate-remotes layout=
 in
> many of my working trees. I am old fashioned.

As an interesting aside, I recently stopped using the word 'origin' to
name a remote since I started using multiple remotes: your remote is
called 'junio', mine's called 'ram', Jonathan's is called 'jrn', and
so on.  I personally use a variation of `git fetch junio master:master
next:next +pu:pu`.  It "fails" when:
1. Some uncommitted work is left:  I'm a bit messy with multiple
worktrees (git-new-workdir).
2. I'm doing some work directly on top of `master` or some other
upstream branch, and haven't forked out yet (I only fork out and name
the branch if the volume of work justifies it).
3. Sometimes `next` is non-ff, and I'm curious about what happened.  I
inspect the changes before invariably using a `git reset --hard
junio/next` to throw away the useless commits.

> =C2=A0(2) Do notice '+' and understand that it is a request to force =
fetch into
> =C2=A0 =C2=A0 some ref locally, and from the lack of colon and RHS, a=
ssume that the
> =C2=A0 =C2=A0 user wants Git to infer the RHS using the configured re=
fspec (in my
> =C2=A0 =C2=A0 case, "refs/heads/next:refs/heads/next" is one of the c=
onfigured
> =C2=A0 =C2=A0 fetch refspec; "refs/heads/*:refs/remotes/origin/*" wou=
ld be the one
> =C2=A0 =C2=A0 that would match in the separate-remotes layout). In ot=
her words,
> =C2=A0 =C2=A0 treat it as if the user typed "+refs/heads/next:refs/he=
ads/next" (or
> =C2=A0 =C2=A0 "+refs/heads/next:refs/remotes/origin/next" in the sepa=
rate-remote
> =C2=A0 =C2=A0 layout) from the command line.

Ugh, no.  Such smartness is probably desirable at the `pull` level.

> =C2=A0(3) Do notice '+' is applied to 'next' but otherwise ignore the=
 fact that
> =C2=A0 =C2=A0 it is a command line pathspec, which would cause us to =
ignore
> =C2=A0 =C2=A0 configured refspecs. In other words, fetch normally as =
if there were
> =C2=A0 =C2=A0 no refspec on the command line, but when updating refs/=
heads/next (or
> =C2=A0 =C2=A0 refs/remotes/origin/next in the separate-remotes layout=
), allow non
> =C2=A0 =C2=A0 fast-forward updates.

This is unnecessarily complicated and ugly imho.  I think `git fetch`
is trying to be over-smart here: If I don't choose to update my local
refs by hand immediately after the fetch, I'll be surprised later.

> Perhaps we can/want to implement (1)?

Yeah, I think it's the right thing to do.  For the implementation,
should we update the condition in fetch.c:451 or try to implement it
at the refspec-parsing level?

Thanks.

-- Ram
