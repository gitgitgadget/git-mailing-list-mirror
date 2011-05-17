From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: git svn info --url lacks username
Date: Tue, 17 May 2011 18:51:56 +0200
Message-ID: <BANLkTik1n8SCVu1-EwVrhJ7rURtk16eA9A@mail.gmail.com>
References: <BANLkTinCx4pEycjGmWA=jZ8os7R3tZWXNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 18:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMNVB-0004sK-Mm
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 18:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab1EQQv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 May 2011 12:51:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43314 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327Ab1EQQv5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 12:51:57 -0400
Received: by bwz15 with SMTP id 15so664786bwz.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=8ME/4cUpIU21zUkqno2aS64u9fYrhHydqB3laVmfV2k=;
        b=rCZWnrN3gZoAX9xrE3S+os7Cp/BkPZlPzqF5JKsn0chFrtMI+H26NdlP5hmi1t80bH
         BhW8yaQypFY8V1pZmw4XGP628poxgoO1rM0eQKyOnP7F8ghKxyk0Tt6zaqwj2flWVEJF
         H6CmQvSlxGpCiM3oVZEzW6cj/tdRUcrLpU1Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ScyQqUP4deIN9V2MKxvb1UcrZABGyXU9VswYi2qRnUlh4L09d4HSd92CyaxO+w6mxr
         YXw2V3K/vM07o0YlzQlKSOaOpeGr7LPTdQyd+agY/UTaGiiHXsUK0+8lAlgPu/tKGn4w
         tmGrk/pmODj8eg8O4LsRiXwpk2UjkMh5CS+KQ=
Received: by 10.204.74.7 with SMTP id s7mr807363bkj.57.1305651116344; Tue, 17
 May 2011 09:51:56 -0700 (PDT)
Received: by 10.204.116.17 with HTTP; Tue, 17 May 2011 09:51:56 -0700 (PDT)
In-Reply-To: <BANLkTinCx4pEycjGmWA=jZ8os7R3tZWXNQ@mail.gmail.com>
X-Google-Sender-Auth: 17AcHBfzBB4PRRQzFXN3HnpUNW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173813>

On Thu, May 12, 2011 at 14:13, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> I'm using git-svn. Due to local policies and for compatibility with t=
he other
> developers using plain svn, I have to lock a file before committing a=
nything to
> the svn repository.
>
> Hence I wrote a small wrapper script around "git svn dcommit", which =
basically
> does:
>
> | SVNROOT=3D$( ( cd ./$(git rev-parse --show-cdup) && git svn info --=
url ) )
> | SVNLOCKFILE=3D$SVNROOT/lockfile
> |
> | svn lock $SVNLOCKFILE
> | git svn dcommit $*
> | svn unlock $SVNLOCKFILE

[...]

> My .git/config has
>
> | [svn-remote "svn"]
> | =C2=A0 =C2=A0 =C2=A0 =C2=A0 url =3D svn+ssh://user@server/project
>
> But "git svn info --url" only prints:
>
> | svn+ssh://server/project/sub/branches/branch
>
> i.e. the username part is missing.
> Obviously "git svn dcommit" does use the correct URL.

[...]

> I tried, "git config --get svn-remote.svn.url", but that only gives m=
e
> "svn+ssh://user@server/project", i.e. it lacks the "/sub/branches/bra=
nch" part.
>
> Do you have any idea what's going on, or how to fix it?
> Shouldn't "git svn info --url" include the username?

I ended up adding:

| SVNURL=3D$(git config --get svn-remote.svn.url)
| case $SVNURL in svn+ssh://*@*)
|         SVNROOT=3D${SVNURL%%@*}@${SVNROOT#svn+ssh://}
|         ;;
| esac

so it hacks in the username from the config file.
But I don't think that's the ideal solution?

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
