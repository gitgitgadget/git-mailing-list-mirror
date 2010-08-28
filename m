From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Odd encoding issue with UTF-8 + gettext yields ? on non-ASCII
Date: Sat, 28 Aug 2010 21:17:00 +0000
Message-ID: <AANLkTi=cb5zyKyogdunB6NzWDk99V2hSg-c0vQpwKM-Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marcin Cieslak <saper@saper.info>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 28 23:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpSmB-0006wR-6x
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 23:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab0H1VRB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 17:17:01 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33227 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab0H1VRA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 17:17:00 -0400
Received: by iwn5 with SMTP id 5so3649734iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 14:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=zi0xKDyHEhTQdjTbVuwsRzWbO20rD/zzOGd7GgWFx6o=;
        b=psB3gNSBU2cmw4MVIs4P5OOpf0s5NEtvhxtk9RYR8syDSNK1b/0tXkMOQfWGraL2U7
         LrhidjkovfCsc0mXpFSfg6FOQl7hr6tjTOFgcMORSPJnt5Yjh6lOUNSLpm7U4W8vWtU/
         esAKywKwiON1nN2KKAY0JsSYjEaW6pjQl7mBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=KsRtN5VLwyQNRwQKgzwmdG6br4/38BnRpIXJRYAhkXbpfGCMxjYYhruJeiyFkypB0V
         TGcsOKjRpYttvs5K4uYd2HEB7pjYcigARbJodQQRvsG4ThiZTvO4mzh7aYNX2YR/1FLz
         A4HsdKZ3pplC0Lv4ORYKaoYiuBfo2b/FWVdTw=
Received: by 10.231.35.77 with SMTP id o13mr2924398ibd.92.1283030220137; Sat,
 28 Aug 2010 14:17:00 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 28 Aug 2010 14:17:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154657>

I'm having an odd encoding issue with gettext on my
gettextize-git-mainporcelain branch that hadn't been turned up before
because none of the existing messages used non-ASCII translations.

With this in is.po (full version at [is.po]):

    "Content-Type: text/plain; charset=3DUTF-8\n"
    "Content-Transfer-Encoding: 8bit\n

I do:

    $ msgfmt -o /opt/git/next-gettext/share/locale/is/LC_MESSAGES/git.m=
o is.po

Which, under an Icelandic locale gives me:

    $ rm -rf /tmp/meh; LANGUAGE=3D LC_ALL=3D LANG=3Dis_IS.UTF-8 git ini=
t /tmp/meh
    Bj? til t?ma Git lind ? /tmp/meh/.git/

Those "?" characters are actual ASCII question marks.

But if I don't specify an encoding msgfmt will complain:

    $ msgfmt -o /opt/git/next-gettext/share/locale/is/LC_MESSAGES/git.m=
o is.po
    is.po: warning: Charset missing in header.
                    Message conversion to user's charset will not work.

But git will now emit the non-ASCII characters from its message
catalogue. Probably because some component now doesn't try to be smart
about encoding.

    $ rm -rf /tmp/meh; LANGUAGE=3D LC_ALL=3D LANG=3Dis_IS.UTF-8 git ini=
t /tmp/meh
    Bj=C3=B3 til t=C3=B3ma Git lind =C3=AD /tmp/meh/.git/

That'd probably break under a non-UTF-8 locale, like an ISO-8859-1 one
though.

A `hexdump -C` of the two `.mo` files is exactly the same, aside from
the charset header. I.e. both contain valid UTF-8 sequences, so the
issue is somewhere between the `*.mo` file being read and it being
emitted by `libintl` and the `gettext` function.

We're not doing anything odd in our [gettext.c] that I can see that
could explain this.

To reproduce it, do:

    git clone --reference ~/g/git git://github.com/avar/git.git next-ge=
ttext
    cd next-gettext
    git checkout -t origin/gettextize-git-mainporcelain
    make -j 4 prefix=3D/tmp/git all install
    rm -rf /tmp/meh; LANGUAGE=3D LANG=3Dis_IS.utf8 /tmp/git/bin/git ini=
t /tmp/meh

Which'll give (as mentioned above):

    Bj? til t?ma Git lind ? /tmp/meh/.git/

But editing out the Content-Type line gives:

    Bj=C3=B3 til t=C3=B3ma Git lind =C3=AD /tmp/meh/.git/

[gettextize-git-mainporcelain]:
http://github.com/avar/git/tree/gettextize-git-mainporcelain]
[is.po]: http://github.com/avar/git/blob/gettextize-git-mainporcelain/p=
o/is.po
[gettext.c]: http://github.com/avar/git/blob/gettextize-git-mainporcela=
in/gettext.c
