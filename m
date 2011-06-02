From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC PATCH] revert: Implement --abort processing
Date: Thu, 2 Jun 2011 18:33:42 +0530
Message-ID: <BANLkTikgY_Kc6gu_iTtpiiayo9e=DPxOLw@mail.gmail.com>
References: <1306944446-11031-1-git-send-email-artagnon@gmail.com> <20110601190006.GB9730@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 15:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS7ZM-0004ZV-8e
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 15:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab1FBNEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 09:04:05 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59866 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab1FBNED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2011 09:04:03 -0400
Received: by wya21 with SMTP id 21so580401wya.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=wAtcuHrJlNa7f8m7DfgAx5sLRkEpIpQtWdjry/8scFU=;
        b=xr074atJIYNOVFAKnwfGFyHb1R6ecPKcNT/2Q9kDA3SSznIvNT7OJZFT/t+YI07+Vb
         yAbpRxO0hjVK+wKRXpFpZPLn2Dbnky5uLiUhLuWFoBp0B80QEuHjRMp05I78dR/U/J4W
         1UywXo62jS9pa5Mqrg/tVpKDPvKPgtmeiddXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fdBgJluDitJcussUBwd7WTJbS6/TFmo56d/SrH+RkV9YYcIB/Hao2lqSVxmD1Dcs9W
         sRNf322LLTo6Ym46nliN3SLD3qHZ2RRT6OUFoHT2JQ2Lm0XcimbTWHMYjt2Ol6/q1UDB
         Nya6RI+pgbymSdUch0MBaJFpDXZT1nLozRclw=
Received: by 10.216.234.80 with SMTP id r58mr664433weq.109.1307019842088; Thu,
 02 Jun 2011 06:04:02 -0700 (PDT)
Received: by 10.216.51.68 with HTTP; Thu, 2 Jun 2011 06:03:42 -0700 (PDT)
In-Reply-To: <20110601190006.GB9730@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174947>

Hi Sverre, Junio and Jonathan,

Sverre Rabbelier writes:
> Isn't this the kind of usecase we added 'git reset --merge' for?

Yes, I can see that now.

Junio Hamano writes:
> Even if you dropped the unconditional "rerere clear" from the patch, =
I am
> not sure what this new feature buys us. Some people would want the re=
rere
> cache cleared, some others don't. "revert --abort" will forever be to
> aborting revert and restoring some but not all the parts of the opera=
tion
> the user wants to be undone, as you cannot satisfy everybody. =C2=A0S=
o I am a
> bit puzzled why you thought this was even a good idea to begin with.

It's actually very specific to the way I work/ think -- I would have
expected an abort to go back in time, and make it look like the
operation wasn't performed in the first place. My normal workflow: I
make my changes, create a "fixup!" commit, abort, and cherry-pick that
commit from my reflog. Yes, I use "reset --hard" a lot, and yes, it's
a very powerful hammer.

I see now that this probably doesn't fit everyone's usecase. So the
changes I propose are:
1. Don't rerere clear. We can probably document this fact somewhere,
and hint the user about this during the time of abort.
2. Use reset --merge as Sverre suggested.

I'll think about this workflow and post a patch soon.

Jonathan Nieder writes:
> I have some changes to files that did not participate in the automati=
c
> cherry-pick:
>
> =C2=A01. for unrelated reasons, I bumped the version number in the Ma=
kefile
> =C2=A0as a reminder not to forget later, without commiting it or mark=
ing
> =C2=A0with "git add";
>
> =C2=A02. I (manually) moved a declaration to a different header file =
to
> =C2=A0reflect differences between the codebase at the time of foo^ an=
d HEAD,
> =C2=A0to get it to compile. =C2=A0Which works, so I mark it with "git=
 add" for
> =C2=A0incorporation into the corrected cherry-pick commit.
>
> With "git reset --merge", (1) is left alone, while (2) is backed out,
> unmerged entries are of course clobbered, and hazy cases in which I
> make some changes, "git add", and then make more changes without "git
> add" cause the operation to error out. =C2=A0It would be nicer if git=
 could
> read my mind, but at first glance this seems like an okay second-best=
=2E

Thanks for the excellent explanation. I'll think about this workflow
for a while before posting another iteration of this patch.

-- Ram
