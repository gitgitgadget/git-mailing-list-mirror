From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: git svn info --url lacks username
Date: Thu, 12 May 2011 14:13:45 +0200
Message-ID: <BANLkTinCx4pEycjGmWA=jZ8os7R3tZWXNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 14:13:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKUmA-0008EO-0V
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 14:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831Ab1ELMNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2011 08:13:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41545 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756825Ab1ELMNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 08:13:47 -0400
Received: by bwz15 with SMTP id 15so1233448bwz.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 05:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=b55zjOR27w8KLVi5Ddvll9tdERKTsZtCN36Qd6VjH6E=;
        b=BPX3H1ZnzpXjM+dAr1ssamSvy58hBjIltlLED0HD7BeyHttXBt5zkgAIPko8c51zVe
         4k5zOHmHR6mqBLMdhbIlqkLUm4U0oq+PWbDb14Raul7mWWwmvesW/IIPNLOTXQIMZlr1
         Ui/kmeppOhqH3zR93szwkEnutGV5pdd9i6Ekk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=aiuGAATJztc7HoWu+AlB8SVC4X0dthx3wycj+stoLyEkqYSMesTEb+mvGuv5fQMJ+z
         lhNcSf1arKGD3NHTViO84c57bciaQ8bk1GHuRYLDRTygwubZJcF3M6sN/j9pmkn7Wht+
         y8r2eFYL7jJ+HzJ+8vVCa/vher7vMyFpgCokE=
Received: by 10.204.80.28 with SMTP id r28mr137471bkk.46.1305202425885; Thu,
 12 May 2011 05:13:45 -0700 (PDT)
Received: by 10.204.126.154 with HTTP; Thu, 12 May 2011 05:13:45 -0700 (PDT)
X-Google-Sender-Auth: H5H_D-dZ1QKAnlY5XIBMKPURvNs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173464>

        Hi all,

I'm using git-svn. Due to local policies and for compatibility with the=
 other
developers using plain svn, I have to lock a file before committing any=
thing to
the svn repository.

Hence I wrote a small wrapper script around "git svn dcommit", which ba=
sically
does:

| SVNROOT=3D$( ( cd ./$(git rev-parse --show-cdup) && git svn info --ur=
l ) )
| SVNLOCKFILE=3D$SVNROOT/lockfile
|
| svn lock $SVNLOCKFILE
| git svn dcommit $*
| svn unlock $SVNLOCKFILE

A while ago, I started seeing "svn: Network connection closed unexpecte=
dly"
messages being printed. Unfortunately, I didn't really look into them a=
t that
time, as everything seemed to continue working fine.

Recently, we noticed concurrent commits, and discovered I no longer loc=
k the
lockfile. It seems that both the lock and unlock fail with
"svn: Network connection closed unexpectedly", because $SVNROOT doesn't
contain the username I need to use for authentication.

My .git/config has

| [svn-remote "svn"]
|         url =3D svn+ssh://user@server/project

But "git svn info --url" only prints:

| svn+ssh://server/project/sub/branches/branch

i.e. the username part is missing.
Obviously "git svn dcommit" does use the correct URL.

I'm using git version 1.7.0.4, but I also tried version 1.7.5.1.217.g4e=
3aa
with the same results.

The funny thing is that I tested that locking did work when I wrote my =
script.
But when I look at the history for git-svn.perl, I don't see any change=
 that
caused it to break, or even work at all.
Nor do I have access to the same machine and software I originally used=
, as it
got upgraded in the mean time.

I tried, "git config --get svn-remote.svn.url", but that only gives me
"svn+ssh://user@server/project", i.e. it lacks the "/sub/branches/branc=
h" part.

Do you have any idea what's going on, or how to fix it?
Shouldn't "git svn info --url" include the username?

Thanks in advance!

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
