From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] builtins: utilize startup_info->help where possible
Date: Wed, 20 Oct 2010 08:13:06 +0700
Message-ID: <AANLkTinvSKAyXkzjUgxvrDWvuHWpa+46XVxTu=tWck53@mail.gmail.com>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-2-git-send-email-pclouds@gmail.com> <20101019172953.GC25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 03:13:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8NFF-000250-4t
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 03:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365Ab0JTBN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 21:13:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57653 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab0JTBN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 21:13:27 -0400
Received: by wyb28 with SMTP id 28so3150396wyb.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 18:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gPCSL8up/otaW5V6K+gBARrr/6O+yyjJnC5Bq8plVTw=;
        b=p5Sv68iuIZBP9KksFmIrjidnq4IOMjNZjmj7mpbkfsfZf3snpDr7ORbnAGTS7K6uBM
         9/fSr4MFOU/LZxeBoYH+IMYgKzrASTXkrzbdsVn8/8g9Mv15nTGMx9nuHabI/E2MjW5A
         PqIpdOcIel4jHNsaOIiNQVKKxilX5S5WRnTdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=R6ISebZVMpCer10uoKJerJOjMGqQ+hgdjPrlw3PXEQbSsFgJ8FZz/1lPNq2t+unXb8
         uSUTxWrdeUoRpw6TBd4aSLkKqsi5IzQwarcQ7XjbsB/qm9F9Sb/B7gpvpu8OAHoWFn5r
         0HCKtEl5MXjqFL47byj2FGBssxIWjbtjZndTg=
Received: by 10.216.157.72 with SMTP id n50mr7548335wek.4.1287537206309; Tue,
 19 Oct 2010 18:13:26 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Tue, 19 Oct 2010 18:13:06 -0700 (PDT)
In-Reply-To: <20101019172953.GC25139@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159382>

2010/10/20 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> It helps reduce false alarms while I'm looking for "git foo -h" code
>> path that accesses repository.
>
> Not sure I understand. =C2=A0Is the idea that use of startup_info->he=
lp
> is a marker for "I've checked this code path"?
>
> If that were the only reason, I don't think I'd like the idea.

That. And simpler check. I mean "if (startup_info->help)" takes a tiny
bit less energy for me to understand than "if (argc =3D=3D 2 && argv[1]=
 =3D=3D
"-h")". It's also good for grepping.

> As it is, I'm a bit conflicted: what if we decide to short-circuit
> "git foo --help-all" in the future just like we short-circuit
> "git foo -h" now? =C2=A0Would that require a separate flag?

As long as it's help related, startup_info->help can be turned to a
bit set. Although I'm not sure if --help-all or any other option will
be implemented anytime soon. Remember it has to be implemented for
_all_ builtin commands, or we need to introduce NO_DASH_H in
run_builtin() to skip the shortcut for commands that do not support
it.

> In other words, I'm not sure startup_info->help is a good abstraction=
=2E
> Maybe (modulo names) it would be better to do
>
> struct startup_info {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *short_circuit; =C2=A0 =C2=A0 =C2=
=A0/* "-h", "--help-all", "--no-index", or NULL */
> };
>
> and use
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(startup_info->short_circuit, "=
-h"))
>
> to allow relaxing the argc =3D=3D 2 check later?

Can it be relaxed later when someone comes up with "--help-all" or some=
thing?
--=20
Duy
