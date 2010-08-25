From: "Neal Kreitzinger" <neal@rsss.com>
Subject: Re: repo permissions repair: restore --shared=group permissions
Date: Tue, 24 Aug 2010 22:42:54 -0500
Message-ID: <i523if$86m$5@dough.gmane.org>
References: <i3vbho$f5j$5@dough.gmane.org> <AANLkTik7w6rDa=dLp=cvU8JeuCn1ZjM9ateHU8m_UQkO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 05:44:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo6uf-0002jX-CZ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 05:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab0HYDo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 23:44:26 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from lo.gmane.org ([80.91.229.12]:56409 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755090Ab0HYDoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 23:44:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oo6uV-0002c8-SA
	for git@vger.kernel.org; Wed, 25 Aug 2010 05:44:23 +0200
Received: from 67.63.162.200 ([67.63.162.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 05:44:23 +0200
Received: from neal by 67.63.162.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 05:44:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 67.63.162.200
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-RFC2646: Format=Flowed; Original
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5931
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154407>


"=C6var Arnfj=F6r=F0 Bjarmason" <avarab@gmail.com> wrote in message=20
news:AANLkTik7w6rDa=3DdLp=3DcvU8JeuCn1ZjM9ateHU8m_UQkO@mail.gmail.com..=
=2E
On Wed, Aug 11, 2010 at 23:24, Neal Kreitzinger <neal@rsss.com> wrote:
> chmod -R 755 was inadvertantly run on all of our git repos (bare and
> non-bare). These repos were originally created as --shared=3Dgroup. W=
hen I
> run git init --shared=3Dgroup it does not complain, but it also does =
not
> correct the permissions. Please advise on the best way restore the
> permissions to --shared=3Dgroup. Thanks!

chmod -R g+rw ?

I followed your suggestion, but because I wasn't sure that would replic=
ate=20
what git would have done, I ended up restoring from tape after realizin=
g=20
that the rsync backups were corrupted due to the git repos being in use=
=20
during the rsync.

I then had a similar situation where I needed to lock down a central gi=
t=20
repository so that only the integration manager had write access.  Sinc=
e git=20
init --shared=3D0644 would not do it for me, this is the method I used =
to=20
ensure that git set the permissions according to its rules:

(Search Keywords: "How to change the permissions of a Git Repo")

Change Permissions on an Existing Git Repo:

Check System for Users who may be using the Repo:
# w  (see who's logged in)
# ps -A |grep git-menu-scriptname  (where scriptname is some unique str=
ing=20
in the name of the main script your users use to access that repo, if=20
applicable)
# skill -KILL pts/99  (where 99 =3D the pts/# from w command, log the u=
ser=20
off)

Change Shared=3Dgroup to Shared=3D0644  (change group read+write to gro=
up read=20
only):
Create Template for permissions:
login as fsngit0
$ cd /path/to/template
$ cat config
[core]
        sharedRepository =3D 0644

Clone repo to set permissions via git:
$ cd /path/to/repo-parent-dir
$ git clone --bare --template=3D/path/to/template REPO.git REPOMOD.git

Compare old and new versions:
$ diff -r REPO.git REPOMOD.git
Only in REPO.git: branches  (empty, keep the old version)
diff -r REPO.git/config REPOMOD.git/config  (merge the old and new toge=
ther)
1a2
>       sharedrepository =3D 0644
6,7c7
<         denyDeletes =3D true
<         denyNonFastForwards =3D true
---
>       denyNonFastforwards =3D true
Only in REPO.git: description  (keep the old version)
Only in REPO.git: gitk.cache  (gitk will recreate this)
Only in REPO.git: hooks  (contains sample scripts only or whatever scri=
pts=20
your using, keep the old version)
Only in REPO.git: info  (keep the old version: contains attributes, exc=
lude,=20
or whatever you've setup)
diff -r REPO.git/packed-refs REPOMOD.git/packed-refs  (keep the new ver=
sion=20
because fresh clone has been optimized)
2c2
< Xa8b7b8c8fd3920b89770f2e8356f4ecb71a58cX refs/heads/master
---
> Ya69744e46276a37932d5f0755a53f76cdf83e0dY refs/heads/master
Only in REPO.git/refs/heads: master  (old version not needed because fr=
esh=20
clone has been optimized)

Copy over REPO.git files that the clone didn't replicate, but that you =
need=20
in order to retain all settings:
$ cd /path/to/REPOMOD.git
$ cp -rv /path/to/REPO.git/info .
repeat as needed...

change permissions to g-w or whatever your core.sharedRepository new va=
lue=20
is supposed to be:
$ chmod -R g-w info
repeat as needed...

Validate your changes:
$ diff -r REPO.git REPOMOD.git
diff -r REPO.git/config REPOMOD.git/config
1a2
>       sharedrepository =3D 0644
7c8
<         denyNonFastForwards =3D true
---
>       denyNonFastforwards =3D true
Only in REPO.git: gitk.cache
diff -r REPO.git/packed-refs REPOMOD.git/packed-refs
2c2
< Xa8b7b8c8fd3920b89770f2e8356f4ecb71a58cX refs/heads/master
---
> Y69744e46276a37932d5f0755a53f76cdf83e0dY refs/heads/master
Only in REPO.git/refs/heads: master

Backup REPO.git and rename REPOMOD.git to REPO.git:
$ cp -rvp REPO.git REPO.git-old
$ diff -r REPO.git REPO.git-old
$ rm -rf REPO.git
$ cp -rvp REPOMOD.git REPO.git
$ diff -r REPO.git REPOMOD.git
$ diff -r REPO.git REPO.git-old
