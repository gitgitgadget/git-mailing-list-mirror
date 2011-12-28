From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] gc --auto: warn garbage collection happens soon
Date: Thu, 29 Dec 2011 04:50:49 +0700
Message-ID: <CACsJy8BVWQHUfi3=fMiqFAfbFyTAV0LnY0yF0AbD_weT4bX6Hw@mail.gmail.com>
References: <1324993534-16307-1-git-send-email-pclouds@gmail.com> <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 22:51:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rg1PC-0004T3-Kw
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 22:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab1L1VvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Dec 2011 16:51:23 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43246 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab1L1VvV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2011 16:51:21 -0500
Received: by eaad14 with SMTP id d14so5607476eaa.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 13:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yzzs8+sw/gUe6Rg2SReO0vop5QRrEhEVmzTLHDgpF9Y=;
        b=W9BgIj1c5P6Jnj25phJ0w2UwuVX1BTuUu5jvwJvWF4HDBJzeuX8kyNi8dePljr2atA
         BWfsLnBjX2Au3fJ46e4I3PJJa33CowgJFLBGvQ6fFKCsvPSzGFEPWuzBrOc6G3B/kAor
         aWCi7eIgXXkMho+RV+2lMtFrPFqXaG4xDYaOs=
Received: by 10.204.48.148 with SMTP id r20mr3631354bkf.116.1325109080275;
 Wed, 28 Dec 2011 13:51:20 -0800 (PST)
Received: by 10.204.32.197 with HTTP; Wed, 28 Dec 2011 13:50:49 -0800 (PST)
In-Reply-To: <7vpqf94r8c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187762>

2011/12/28 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> This gives users a chance to run gc explicitly elsewhere if they do =
not
>> want gc to run suddenly in current terminal.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> As I am still in a cheerly holiday mood, let's be a bit philosophical=
,
> step back a bit and think.
>
> After this patch gets applied, will the users start feeling bothered =
by
> repeated "you will soon see auto-gc" messages and will want "you will=
 soon
> start seeing the you will soon see auto-gc messages" warnings?

They should not for most of the time, given the default settings is
warnings at 90% limits. If they do feel bothered, they could turn it
off or just run "gc".

> And if the answer to that tongue-in-cheek question is no, what is the
> reason why the users will not find the messages disturbing, while loa=
thing
> the auto-gc?
>
> I suspect that is because auto-gc takes long time, making the user wa=
it,
> compared to the new message that may be noisy but quick. =C2=A0Perhap=
s the real
> cure for the disease is not to add the message but to make an auto-gc=
 less
> painful, no?

It's something with expected run time of a command. When I'm about to
run "commit", I know the command is fast and I expect the shell prompt
soon. When I run "fetch", I know it may take a bit (or a lot) of time
and I will be ready to make myself a cup of coffee while it's running.

auto-gc is an unknown factor and may break my expectations. I would
not mind if auto-gc is extremely fast, e.g. a couple of seconds
maximum. But gc time seems to be proportional to repository size.

> What are the things we could do to make auto-gc less painful?
>
> Are we doing something that is not necessary in auto-gc that takes ti=
me
> but that we can live without doing?
>
> It may be a better cure for the disease to force a full gc after
> operations that we know the users already know to take long time (e.g=
=2E a
> clone, a large fetch), so that the next auto-gc do not have to do muc=
h
> work.

git works best when everything is in one pack. So while we may be able
to skip stuff and make auto-gc fast the first few times, eventually we
need to do something like "git repack -ad" as part of auto-gc. I don't
see any way to make that part complete in a few secs regardless repo
size (unless packv4 comes in time and speeds up revlist
significantly). So the pain will be there in the end, it's just
delayed.

There's another possibility (but not sure if it's feasible): to make
auto-gc use up to certain amount of time. If it runs out of allocated
time, it needs to save its state somewhere, somehow and resumes in
next auto-gc.
--=20
Duy
