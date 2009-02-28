From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/4] diffcore-pickaxe: further refactor count_match()
Date: Sat, 28 Feb 2009 14:10:16 +0100
Message-ID: <49A937B8.1030205@lsrfire.ath.cx>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com> <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 14:11:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdOyv-0007WG-7Q
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 14:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbZB1NK0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 08:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbZB1NKZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 08:10:25 -0500
Received: from india601.server4you.de ([85.25.151.105]:60031 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZB1NKY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 08:10:24 -0500
Received: from [10.0.1.101] (p57B7E62B.dip.t-dialin.net [87.183.230.43])
	by india601.server4you.de (Postfix) with ESMTPSA id 603A82F8080;
	Sat, 28 Feb 2009 14:10:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111766>

Junio C Hamano schrieb:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>> ...
>>> In any case, there is also memmem(), which uses the same fast algor=
ithm
>>> as strstr() in recent glibc versions.  Like this?
>> Thanks; it would be nice to bench this change.
>=20
> With memmem() patch applied on top of [1-4/4], the same test as descr=
ibed
> in the commit log message of [4/4] which was:
>=20
>     $ STRING=3D'Ensure that the real time constraints are schedulable=
=2E'
>     $ git log -S"$STRING" HEAD -- kernel/sched.c >/dev/null
>=20
>     (Before the patch, best of 5 runs)
>     5.59user 0.15system 0:05.74elapsed 99%CPU (0avgtext+0avgdata 0max=
resident)k
>     0inputs+0outputs (0major+39956minor)pagefaults 0swaps
>=20
>     (After the patch, best of 5 runs)
>     3.04user 0.17system 0:03.23elapsed 99%CPU (0avgtext+0avgdata 0max=
resident)k
>     0inputs+0outputs (0major+49697minor)pagefaults 0swaps
>=20
>     The file "kernel/sched.c" has roughly 900 changes applied to it, =
and over
>     its lifetime, it has grown from 5kB to 9kB in size.  I'd expect a=
 larger
>     file may see a bigger performance boost.
>=20
> (With memmem() patch, best of 5 runs)
> 2.46user 0.15system 0:02.62elapsed 99%CPU (0avgtext+0avgdata 0maxresi=
dent)k
> 0inputs+0outputs (0major+49698minor)pagefaults 0swaps

I get this (Ubuntu 8.10 x64, Fedora 10 x64 using the same Linux repo,
Windows Vista x64 using a different Linux repo with the same HEAD on
NTFS and msysgit, numbers are the elapsed time in seconds, best of five
runs):

                           Ubuntu  Fedora  Windows
   v1.6.2-rc2                8.14    8.16    9.236
   v1.6.2-rc2+[1-4]          2.43    2.45    2.995
   v1.6.2-rc2+[1-4]+memmem   1.31    1.25    2.917
   v1.6.2-rc2+[1-3]+memmem   1.51    1.16    8.455

Ubuntu has glibc 2.8, while Fedora 10 has glibc 2.9, with a new and mor=
e
efficient memmem() implementation.  On Windows, we use our own naive
memmem() implementation.

So using memmem() is worthwhile.  And providing a better fall-back
version in compat/ can speed up this particular case to the point where
the fourth patch becomes moot.

Hmm, gnulib (http://git.savannah.gnu.org/gitweb/?p=3Dgnulib.git;a=3Dsum=
mary)
contains all parts ready for copy & paste, licensed under the GPL 2 or
up.  That won't cause problems with the libgit2 relicensing effort, as
memmem()  won't end up in there, right?


=46or the record, here the raw timings used to make the table above (be=
st
of five):

=46edora 10:
8.10user 0.05system 0:08.16elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+31943minor)pagefaults 0swaps

2.38user 0.06system 0:02.45elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+41294minor)pagefaults 0swaps

1.19user 0.05system 0:01.25elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+39274minor)pagefaults 0swaps

1.10user 0.05system 0:01.16elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+31796minor)pagefaults 0swaps

Ubuntu 8.10:
8.08user 0.05system 0:08.14elapsed 100%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+29579minor)pagefaults 0swaps

2.35user 0.07system 0:02.43elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+40437minor)pagefaults 0swaps

1.23user 0.08system 0:01.31elapsed 100%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+41097minor)pagefaults 0swaps

1.46user 0.05system 0:01.51elapsed 99%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+30533minor)pagefaults 0swaps

Windows:
real    0m9.236s
user    0m0.000s
sys     0m0.000s

real    0m2.995s
user    0m0.000s
sys     0m0.000s

real    0m2.917s
user    0m0.000s
sys     0m0.015s

real    0m8.455s
user    0m0.000s
sys     0m0.000s
