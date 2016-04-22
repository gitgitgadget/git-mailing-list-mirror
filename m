From: Jeff King <peff@peff.net>
Subject: Re: git status core dump with bad sector!
Date: Fri, 22 Apr 2016 01:11:12 -0400
Message-ID: <20160422051111.GA32107@sigill.intra.peff.net>
References: <570FB06D.5060308@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Fri Apr 22 07:11:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atTNA-00024t-KC
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 07:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbcDVFLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 01:11:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:53956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753181AbcDVFLP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 01:11:15 -0400
Received: (qmail 7156 invoked by uid 102); 22 Apr 2016 05:11:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 01:11:14 -0400
Received: (qmail 3716 invoked by uid 107); 22 Apr 2016 05:11:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Apr 2016 01:11:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Apr 2016 01:11:12 -0400
Content-Disposition: inline
In-Reply-To: <570FB06D.5060308@giref.ulaval.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292167>

On Thu, Apr 14, 2016 at 10:59:57AM -0400, Eric Chamberland wrote:

> just cloned a repo and it checked-out wihtout any error (with git 2.2=
=2E0) but
> got come corrupted files (because I got some sdd failures).
>=20
> Then, I get a git core dump when trying to "git status" into the repo=
 which
> have a "bad sector" on sdd drive (crypted partition).
>=20
> I tried with git 2.2.0 AND git version 2.8.1.185.gdc0db2c.dirty (just
> modified the Makefile to remove STRIP part)
>=20
> In both cases, I have a  Bus error (core dumped)

Interesting. There was a known issue with reading corrupted pack .idx
files, but it was fixed in v2.8.0. So this could be a new thing.

SIGBUS is somewhat rare, though (usually just accessing unmapped memory
should get us a SIGSEGV). What platform are you on? I seem to recall
that hardware like ARM that cares about memory alignment is more likely
to get a SIGBUS.

> Program received signal SIGBUS, Bus error.
> 0x00007ffff7866d58 in ?? () from /lib64/libcrypto.so.1.0.0
> (gdb) bt
> #0  0x00007ffff7866d58 in ?? () from /lib64/libcrypto.so.1.0.0
> #1  0x3334d90d8c20f3f0 in ?? ()
> #2  0xe59b5a6cd844a601 in ?? ()
> #3  0xc587a53f67985ae7 in ?? ()
> #4  0x3ce81893e5541777 in ?? ()
> #5  0xdeb18349a4b042ea in ?? ()
> #6  0x8254de489067ec4b in ?? ()
> #7  0x6fbef2439704c81b in ?? ()
> #8  0xe0eee2bb385a96da in ?? ()
> #9  0x00007ffff6e19ab3 in ?? ()
> #10 0x00007fffffffc4d0 in ?? ()
> #11 0x000000000000001d in ?? ()
> #12 0x00007ffff7863f80 in SHA1_Update () from /lib64/libcrypto.so.1.0=
=2E0
> #13 0x00000000005102c0 in write_sha1_file_prepare
> (buf=3Dbuf@entry=3D0x7ffff6c81000, len=3D1673936, type=3D<optimized o=
ut>,
> sha1=3Dsha1@entry=3D0x7fffffffc750 "\340_~", hdr=3Dhdr@entry=3D0x7fff=
ffffc570 "blob
> 1673936",

So I'd assume here that the problem is in accessing the memory in "buf"=
=2E
to actually compute the sha1. That is mmap'd data, but the process is
fairly bland (mmap however many bytes stat() tells us the file has, and
then compute the sha1). You mentioned a bad sector; could it be that th=
e
filesystem is corrupted, and the OS is giving us SIGBUS when trying to
read unavailable bytes from an mmap'd file?

That would explain the SIGBUS versus SIGSEGV.

What happens if you "cat" the file in question:

> #15 0x00000000005159f8 in index_mem (sha1=3Dsha1@entry=3D0x7fffffffc7=
50
> "\340_~", buf=3Dbuf@entry=3D0x7ffff6c81000, size=3D1673936,
> type=3Dtype@entry=3DOBJ_BLOB,
>     path=3Dpath@entry=3D0x80a818 "Ressources/dev/Test.ExportationVTK/=
Ressources.Avion/Avion.Quadratique.cont.vtu.etalon",
> flags=3Dflags@entry=3D0) at sha1_file.c:3305

Can it show all of the bytes? I guess from the "size" field it's too bi=
g
to manually verify, but "cat >/dev/null" should be enough to see if we
can read the whole thing.

> Ii would have expected git to first gave me an error when checking ou=
t the
> files!!! Here is the log:
>=20
> Checking out files:  99% (28645/28934)
> Checking out files: 100% (28934/28934)
> Checking out files: 100% (28934/28934), done.
> Already on 'master'
> Your branch is up-to-date with 'origin/master'.
>     On valide le d=C3=A9p=C3=B4t TestValidation avec la r=C3=A9f=C3=A9=
rence:
> 9b4a485202b2b52922377842c15bfd605d240667
> HEAD is now at 9b4a485 BUG: On sp=C3=A9cifie bash comme shell...
>=20
> But at least 1 file is corrupted!
>=20
> I keep preciously this faulty repo to further investigation with some=
one who
> can help dig into the coredump and correct it...

So _if_ my guess is right that you have filesystem corruption, git may
not even know about it. It wrote the file, and the OS said "OK,
success", not knowing it had been partially corrupted.

And if that guess is right, it also means there's no git bug to fix.
SIGBUS is the natural way for the OS to tell the process that mmap'd
data isn't available.

-Peff
