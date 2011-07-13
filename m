From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/17] revert: Eliminate global "commit" variable
Date: Wed, 13 Jul 2011 14:03:22 +0530
Message-ID: <CALkWK0mUbEXCjUYVPi8Kvctkh0+bnnk0VoAHjUjT_8M5druzqQ@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-7-git-send-email-artagnon@gmail.com> <20110712174518.GB14120@elie>
 <CALkWK0k3muAi_h7GRqgJ9vY8SwHK40-AwMdjA=uCDO8Ng4utCA@mail.gmail.com> <20110713071029.GA31285@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 10:34:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgutV-0003ps-MV
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:34:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084Ab1GMIeE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 04:34:04 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:46295 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965080Ab1GMIeD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 04:34:03 -0400
Received: by wwg11 with SMTP id 11so261981wwg.1
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VgmUm+2ot/l+XNb/vQyueT2QMECrfZMJ15RNOF9+bzc=;
        b=LxCcojHHU5iPtVoRy4rQvDJzeGis74VjcItIFMh7ps1kdMkvwEmsbjWyinC78bj0qj
         6RlhOG8fekJ744F4xaPzsG/KRBy1nCWm3CQNPglxd4kxbfkwYNcqRS1e1yK+EzK2izLJ
         YFI+BPlWnH4ZAyLhFVIc+46NvQOJgGEMAKT/0=
Received: by 10.216.50.2 with SMTP id y2mr694844web.77.1310546041510; Wed, 13
 Jul 2011 01:34:01 -0700 (PDT)
Received: by 10.216.175.198 with HTTP; Wed, 13 Jul 2011 01:33:22 -0700 (PDT)
In-Reply-To: <20110713071029.GA31285@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177014>

Hi again,

Jonathan Nieder writes:
> Sounds fine to me. =C2=A0I could nitpick by saying that "Functions wh=
ich
> act on commits" is a little vague (I think the actual story is
> something like "The global 'commit' variable used to represent one of
> the arguments passed to 'git cherry-pick' or 'git revert' and thus wa=
s
> static along with the options. =C2=A0When cherry-pick learned to repl=
ay
> multiple commits in sequence, that wasn't changed, resulting in a
> somewhat unnatural calling sequence that uses a global to pass in a
> parameters:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for each commit c {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0commit =3D c;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D do_pic=
k_commit();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (res)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return res;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> Teach do_pick_commit and the functions it calls to accept the commit
> to act on as an argument, like we always should have. =C2=A0Part of a
> campaign to clean up cherry-pick/revert's internal APIs before
> exposing them.")

Yes.  Thanks.  How about this?

revert: Eliminate global "commit" variable

Prior to v1.7.2-rc1~4^2~7 (revert: allow cherry-picking more than one
commit, 2010-06-02), the file-scope static "commit" variable used to
represent one of the arguments passed to the "git cherry-pick" or "git
revert".  This was not changed after cherry-pick learnt to replay
multiple commits in a sequence, resulting in ugly and unclear
callsites which rely on setting the global variable before calling a
function to act on it:

for each c in commits {
    commit =3D c;
    act_on_commit();
}


Remove the global variable and modify the API of various functions to
pass "commit" around as an argument, so that the callsites become
clearer:

for each c in commits {
    act_on_commit(c);
}

The change is also in line with our long-term goal of exposing the
cherry-picking machinery through a public API.

-- Ram
