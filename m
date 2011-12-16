From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: Any tips for improving the performance of cloning large repositories?
Date: Fri, 16 Dec 2011 15:28:07 +0000
Message-ID: <CAJ-05NPbRmyx=a+U7BK4rNShBgaXj+g-Bwc1aBDDb3N0VPBW=A@mail.gmail.com>
References: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com>
	<hbf.20111216yufz@bombur.uio.no>
	<hbf.20111216zcin@bombur.uio.no>
	<201112161414.pBGEExLJ006769@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 16:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbZhn-0002Kb-UI
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 16:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759949Ab1LPP2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 10:28:12 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:39300 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759683Ab1LPP2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 10:28:08 -0500
Received: by ggdk6 with SMTP id k6so2809880ggd.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 07:28:08 -0800 (PST)
Received: by 10.50.181.136 with SMTP id dw8mr9025301igc.71.1324049287793; Fri,
 16 Dec 2011 07:28:07 -0800 (PST)
Received: by 10.42.174.136 with HTTP; Fri, 16 Dec 2011 07:28:07 -0800 (PST)
In-Reply-To: <201112161414.pBGEExLJ006769@no.baka.org>
X-Google-Sender-Auth: Y33or097UnzmROqfu9dxlGhoQGs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187281>

On 16 December 2011 14:14, Seth Robertson <in-gitvger@baka.org> wrote:
>
> In message <hbf.20111216zcin@bombur.uio.no>, Hallvard Breien Furuseth=
 writes:
>
> =C2=A0 =C2=A0I wrote:
> =C2=A0 =C2=A0> Do you often need to clone from a remote? =C2=A0Instea=
d of cloning from a
> =C2=A0 =C2=A0> local (git clone --mirror) which gets auto-updated fro=
m the remote.
>
> =C2=A0 =C2=A0Er, obviously not, since you tried that with rsync. =C2=A0=
Create the mirror
> =C2=A0 =C2=A0with 'git clone --mirror', then update it with 'git fetc=
h' rather than
> =C2=A0 =C2=A0rsync.
>
> If you really need to perform a full clone from the buildbot with or
> without a different working directory (for instance if you have
> buildbots/checkout users running in parallel where multiple users nee=
d
> a consistent HEAD for multiple sequential operations) then instead
> consider cloning with --reference or --shared.

Well that's counter intuitive....

 - reverting the original repo to one big pack speeds up the clone
 - adding a --local --reference mirror slows it down

Timings:

14:41 ajb@vsbldhost/i686 [ajb] >time git clone git://engbot/repo.git
test-clone-bigpack.git
Initialized empty Git repository in /scratch/ajb/test-clone-bigpack.git=
/.git/
remote: Counting objects: 371220, done.
remote: Compressing objects: 100% (88900/88900), done.
remote: Total 371220 (delta 274586), reused 371220 (delta 274586)
Receiving objects: 100% (371220/371220), 1.78 GiB | 20.10 MiB/s, done.
Resolving deltas: 100% (274586/274586), done.
Checking out files: 100% (42909/42909), done.

real    8m53.008s
user    2m53.151s
sys     7m16.339s

14:53 ajb@vsbldhost/i686 [ajb] >time git clone --local --reference
/var/cache/repos/repo.git git://engbot/repo.git te
st-clone-local.git
Initialized empty Git repository in /scratch/ajb/test-clone-local.git/.=
git/
Checking out files: 100% (42909/42909), done.

real    14m6.333s
user    1m6.844s
sys     12m44.676s

Two things are odd. The first is the clone "hung" at around 22%
checking out the files for ~ 10 minutes before finishing the remaining
70% in a few seconds. Secondly is seems in both cases the systime is
quite high.

--=20
Alex, homepage: http://www.bennee.com/~alex/
http://www.half-llama.co.uk
