From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/6] revert: don't let revert continue a cherry-pick
Date: Mon, 9 Jan 2012 01:58:07 +0530
Message-ID: <CALkWK0kwbzXRyFf=JjfAW9yD7M_FTB80+q1UPOCv-Em4qO2RKQ@mail.gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-4-git-send-email-artagnon@gmail.com> <20120108193749.GH1942@burratino>
 <CALkWK0=-AWy7HnVASB1rt8njavTYOhV7Zxsdq4TE+VShVZmEzQ@mail.gmail.com> <20120108202216.GL1942@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:28:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjzM9-0002AQ-J6
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272Ab2AHU2a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jan 2012 15:28:30 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52057 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2AHU23 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2012 15:28:29 -0500
Received: by wgbdr10 with SMTP id dr10so1063208wgb.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=PJ+B9j15rZMQSwXJINLBAn4kRjM5MulKJHVgmtAkxds=;
        b=GAplF56LTGmoQMLeXHjiJCZUpEO0vNI1KNr8iy/dU8zSMfm1jLAL6znsZfD+XnQpuq
         5nUbvqITAyRlBb7Ntea9NaEAMZjqnDQGuKOcTSBz3RtyUA5BZK7rx95SQn3xV1FrSKmW
         MHBN3CPlnTzPBYr4i9SXZuA575QxfQ4jkoI0A=
Received: by 10.180.106.165 with SMTP id gv5mr23089769wib.18.1326054508216;
 Sun, 08 Jan 2012 12:28:28 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Sun, 8 Jan 2012 12:28:07 -0800 (PST)
In-Reply-To: <20120108202216.GL1942@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188129>

Hi again,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder wrote:
> [...]
>> Junio explained this to me in [1]. =C2=A0It's very unnatural for a u=
ser to
>> want to execute "git cherry-pick --continue" when the previous comma=
nd
>> was a "git revert": it probably means that she forgot about the
>> in-progress "git revert".
> [...]
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/185355
>
> I don't think that's what Junio said.
>
> Did this actually happen, or is it a theoretical worry? =C2=A0I think=
 I would
> be more likely to run "git cherry-pick <foo>..<bar>" than "git
> cherry-pick --continue" if I had forgotten about an in-progress
> revert. =C2=A0The former already errors out with a sensible message.
>
> Or is the problem that I might run:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git revert foo..bar
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --merge; # conflict --- let's cl=
ean this up
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# ah, I remember reverting the patch that =
conflicted before;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# let's reuse the resolution.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick baz
> =C2=A0 =C2=A0 =C2=A0 =C2=A0edit file.c; # another conflict, sigh
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add file.c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git cherry-pick --continue; # oops!
>
> ? =C2=A0That seems like a real worry, but the same problem could happ=
en
> with cherry-pick used both for the multipick and single-pick, so I
> don't think your patch fundamentally addresses it.

Good catch.  I didn't replay this scenario in my head earlier.

> In other words, this is a problem caused by the overloading of the
> same cherry-pick command for single-pick and multi-pick. =C2=A0I thin=
k it
> should be preventable by remembering which action failed when stoppin=
g
> a sequence and doing only a single-pick resume if
> CHERRY_PICK_HEAD/REVERT_HEAD/whatever doesn't match that.

I was attempting to fix this to simplify the life of the user, not
complicate it further- the user might have no idea what the next
command in the sequence is, and I don't see the point in
inconveniencing her.  In retrospect, I think we should simply drop
this patch.

> What
> happens when there is a mixture of picks and reverts?

Permitted.

-- Ram
