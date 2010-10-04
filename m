From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] send-email: Don't leak To: headers between patches
Date: Mon, 4 Oct 2010 07:15:13 +0000
Message-ID: <AANLkTimuP8Myj-PAU76hjtWdOkbzg2WrZwaFNOxRqfsM@mail.gmail.com>
References: <a9b17bd454e57abb75f6cd2a7da63ec7738f5e7b.1286170305.git.viresh.kumar@st.com>
	<1286175924-15761-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Viresh Kumar <viresh.kumar@st.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Joe Perches <joe@perches.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:15:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fGp-0001wb-JH
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab0JDHPa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 03:15:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64013 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab0JDHPa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 03:15:30 -0400
Received: by iwn5 with SMTP id 5so6556649iwn.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 00:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sT7RB/kfnNIsiiSTuj67x0Qkkw75aOeMr1Ld9uKVMAc=;
        b=FHridw/sowgCbe+fG8cPuzZQUg16MlNGBuN4c7W6o7SUv0HSegHGmwAbxz9PAcjc2a
         DiqzuY3nMjYULdgHnI0mhg/5zdy1ISsEocjEqaI6QzbcItx4iJzlafMEaQWph8YoKUaj
         E/QzF1CARY6RVSQXbMWSvKAlisjx8yMoMjX+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QxAtrkccmcZwGLiG/4ZUIa7yd0l0GnbBs2bnNsd6Ba2mO+eZH8x5YU7ljoyTjdfeKm
         RH+JNgm6yojTy0DarK+AP1hbWjuyy5MGiJ+2N+WFZQ2cwUh/KJ3LErMDnx254c6SCTjn
         LEIh/w66F/Mj6Jj+134gtT7CIjCUWG+rgsxV4=
Received: by 10.231.11.8 with SMTP id r8mr9213346ibr.135.1286176513266; Mon,
 04 Oct 2010 00:15:13 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Mon, 4 Oct 2010 00:15:13 -0700 (PDT)
In-Reply-To: <1286175924-15761-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157996>

On Mon, Oct 4, 2010 at 07:05, Stephen Boyd <bebarino@gmail.com> wrote:
> If the first patch in a series has a To: header in the file and the
> second patch in the series doesn't the address from the first patch w=
ill
> be part of the To: addresses in the second patch. Fix this by treatin=
g the
> to list like the cc list. Have an initial to list come from the comma=
nd
> line, user input and config options. Then build up a to list from eac=
h
> patch and concatenate the two together before sending the patch. Fina=
lly,
> reset the list after sending each patch so the To: headers from a pat=
ch
> don't get used for the next one.

Couldn't this whole thing be done by:

> =C2=A0# Variables we fill in automatically, or via prompting:
> -my (@to,$no_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
> +my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@=
xh,

Changing this to an "our" variable instead of a "my".

> =C2=A0 =C2=A0 =C2=A0 =C2=A0my $body_encoding;
> + =C2=A0 =C2=A0 =C2=A0 @to =3D ();

Then doing:

    local @to =3D @to;

> + =C2=A0 =C2=A0 =C2=A0 @to =3D (@initial_to, @to);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0@cc =3D (@initial_cc, @cc);

And keeping this as it is, and should the @cc addresses by accumulated
across patches, but not the @to addresses?

> +test_expect_success $PREREQ 'To headers from files reset each patch'=
 '
> + =C2=A0 =C2=A0 =C2=A0 patch1=3D`git format-patch -1 --to=3D"bodies@e=
xample.com"` &&
> + =C2=A0 =C2=A0 =C2=A0 patch2=3D`git format-patch -1 --to=3D"other@ex=
ample.com" HEAD~` &&
> + =C2=A0 =C2=A0 =C2=A0 test_when_finished "rm $patch1 && rm $patch2" =
&&
> + =C2=A0 =C2=A0 =C2=A0 git send-email \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --dry-run \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --from=3D"Example =
<nobody@example.com>" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --to=3D"nobody@exa=
mple.com" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --smtp-server rela=
y.example.com \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $patch1 $patch2 >s=
tdout &&
> + =C2=A0 =C2=A0 =C2=A0 test $(grep -c "RCPT TO:<bodies@example.com>" =
stdout) =3D 1 &&
> + =C2=A0 =C2=A0 =C2=A0 test $(grep -c "RCPT TO:<nobody@example.com>" =
stdout) =3D 2 &&
> + =C2=A0 =C2=A0 =C2=A0 test $(grep -c "RCPT TO:<other@example.com>" s=
tdout) =3D 1
> +'
> +
