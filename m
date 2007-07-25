From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: index-pack died on pread
Date: Thu, 26 Jul 2007 01:15:12 +0200
Message-ID: <200707260115.13234.robin.rosenberg.lists@dewire.com>
References: <333e1ca10707230552i34c2a1cfq9fae94f20023e9d7@mail.gmail.com> <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Rokos <michal.rokos@gmail.com>, GIT <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 01:14:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDq3V-00083q-DD
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 01:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760002AbXGYXOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 25 Jul 2007 19:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759308AbXGYXOF
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 19:14:05 -0400
Received: from [83.140.172.130] ([83.140.172.130]:26088 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759614AbXGYXOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 19:14:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 0EDC18026F9;
	Thu, 26 Jul 2007 01:06:46 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13524-01; Thu, 26 Jul 2007 01:06:45 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 9A80180266C;
	Thu, 26 Jul 2007 01:06:45 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <alpine.LFD.0.999.0707230956390.3607@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53737>

m=E5ndag 23 juli 2007 skrev Linus Torvalds:
>=20
> On Mon, 23 Jul 2007, Michal Rokos wrote:
> >
> > fatal: cannot pread pack file: No such file or directory (n=3D0,
> > errno=3D2, fd=3D3, ptr=3D40452958, len=3D428, rdy=3D0, off=3D123601=
)
>=20
> Ok, that's bogus. When "n" is zero, the errno (and thus the error str=
ing)=20
> is not changed by pread, so that's a very misleading error report.
>=20
> So what seems to have happened is that the pack-file is too short, so=
 we=20
> got a return value of 0, and then reported it as if it had an errno.
>=20
> The reason for returning zero from pread would be:
>=20
>  - broken pread. I don't think HPUX should be a problem, so that's=20
>    probably not it.
>=20
>  - the pack-file got truncated
>=20
>  - the offset is corrupt, and points to beyond the size of the packfi=
le.
>=20
> In this case, since the offset is just 123601, I suspect it's a trunc=
ation=20
> issue, and your pack-file is simply corrupt. Either because of some=20
> problem with receiving it, or because of problems on the remote side.
>=20
> > fetch-pack from 'git://git.kernel.org/pub/scm/git/git' failed.
>=20
> One thing to look out for is that the "git.kernel.org" machines aren'=
t the=20
> "primary" ones, and the data gets mirrored from other machines. If th=
e=20
> mirroring is incomplete, I could imagine that the remote side simply =
ended=20
> up terminating the connection, and you ended up with a partial pack-f=
ile.
>=20
> Some of the kernel.org machines ran out of disk space the other day, =
so=20
> maybe you happened to hit it in an unlucky window. Does it still happ=
en?

Does cygwin have the same pread problem then.. ? after make NO_PREAD=3D=
1 with 1.5.2.4
clone works.

Here is my output with pread. Note that I'm cloning from or.cz, not ker=
nel.org .

$ git clone git://repo.or.cz/git.git GIT=20
Initialized empty Git repository in /roro/GIT/.git/=20
remote: Generating pack...=20
remote: Done counting 56038 objects.=20
remote: Deltifying 56038 objects...=20
remote:  100% (56038/56038) done=20
Indexing 56038 objects...=20
remote: Total 56038 (delta 39190), reused 52555 (delta 36164)=20
 100% (56038/56038) done=20
Resolving 39190 deltas...=20
fatal: cannot pread pack file: No such file or directory=20
fatal: index-pack died with error code 128=20
fetch-pack from 'git://repo.or.cz/git.git' failed.

-- robin
