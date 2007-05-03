From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: Segmentation fault in git-svn
Date: Thu, 3 May 2007 14:35:12 +0200
Message-ID: <20070503123512.GA6500@xp.machine.xx>
References: <4623F613.5010108@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 03 14:35:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjaWs-00045u-8r
	for gcvg-git@gmane.org; Thu, 03 May 2007 14:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031210AbXECMfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 3 May 2007 08:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031219AbXECMfW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 08:35:22 -0400
Received: from magnum.hofmann.stw.uni-erlangen.de ([131.188.23.34]:55675 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1031210AbXECMfV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2007 08:35:21 -0400
Received: (qmail 22932 invoked by uid 0); 3 May 2007 12:35:13 -0000
Received: from p54aaa661.dip0.t-ipconnect.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@84.170.166.97)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 3 May 2007 12:35:13 -0000
Mail-Followup-To: Eric Wong <normalperson@yhbt.net>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4623F613.5010108@midwinter.com>
User-Agent: Mutt/1.5.14+cvs20070403 (2007-04-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46082>

On Mon, Apr 16, 2007 at 03:17:55PM -0700, Steven Grimm wrote:
>  I expect this is really a libsvn bug, but git-svn triggers it, so I'=
m hoping=20
>  someone else has run into and solved it, or at least that someone ca=
n=20
>  reproduce it.
>=20
>  If I try to clone the "memcached" public repository with the command=
 line
>=20
>   git-svn clone --branches=3Dbranches --trunk=3Dtrunk=20
>  http://code.sixapart.com/svn/memcached
>=20
>  it cranks along fine until revision 299, then dies with SIGSEGV. If =
I run it=20
>  again, it appears to pick up where it left off, then dies again at r=
evision=20
>  399, then again at revision 499. (There are fewer than 600 revisions=
 in that=20
>  repo so it's anyone's guess if it'd die at 599 given the chance.)
>=20
>  This happens on both a Linux box (amd64, FC4, svn version 1.4.3) and=
 my Mac=20
>  (Intel OS 10.4, svn version 1.2.3 from Fink), so at the very least i=
t's not=20
>  platform-specific. It also happens periodically on the private svn=20
>  repository at my company, though not as predictably. On my Mac, I'm =
using=20
>  the very latest git code from "master".
>=20

I'm getting segfaults in git-svn, too.

This command segfaults reproducably in r55 while running

	git svn clone svn://svn.berlios.de/vermont vermont \
		-T trunk -b branches -t tags

I recompiled the debian subversion 1.4.3dfsg1-1 with debug support, to =
get a better
idea what went wrong.

Relevant output from running this beast under valgrind:
(full valgrind output available at [1])

[...]
r54 =3D f80e8d0ad785cae5a4abfb1fdd04b31167553ab0 (trunk)
	D	collector/src/testCollector.h
	M	collector/src/rcvIpfix.h
	M	collector/src/rcvMessage.c
	M	collector/src/common.c
	M	collector/src/rcvIpfix.c
	M	collector/src/common.h
r55 =3D 3fddc1de138e9457385ff43111bcaf6f82884525 (trunk)
=3D=3D10403=3D=3D=20
=3D=3D10403=3D=3D Invalid read of size 1
=3D=3D10403=3D=3D    at 0x59F90A6: readbuf_getchar (marshal.c:285)
=3D=3D10403=3D=3D    by 0x59F90E6: readbuf_getchar_skip_whitespace (mar=
shal.c:294)
=3D=3D10403=3D=3D    by 0x59FA0F3: svn_ra_svn_read_item (marshal.c:621)
=3D=3D10403=3D=3D    by 0x59FA628: svn_ra_svn_read_tuple (marshal.c:741=
)
=3D=3D10403=3D=3D    by 0x59FA906: svn_ra_svn_read_cmd_response (marsha=
l.c:799)
=3D=3D10403=3D=3D    by 0x59ED81D: handle_auth_request (client.c:346)
=3D=3D10403=3D=3D    by 0x59F02B1: ra_svn_check_path (client.c:1284)
=3D=3D10403=3D=3D    by 0x59B7FD7: svn_ra_check_path (ra_loader.c:564)
=3D=3D10403=3D=3D    by 0x599DC93: _wrap_svn_ra_check_path (svn_ra.c:60=
19)
=3D=3D10403=3D=3D    by 0x80BDAD0: Perl_pp_entersub (in /usr/bin/perl)
=3D=3D10403=3D=3D    by 0x80BC3A8: Perl_runops_standard (in /usr/bin/pe=
rl)
=3D=3D10403=3D=3D    by 0x8063A1A: perl_run (in /usr/bin/perl)
=3D=3D10403=3D=3D  Address 0x6F6C6720 is not stack'd, malloc'd or (rece=
ntly) free'd
=3D=3D10403=3D=3D=20
=3D=3D10403=3D=3D Process terminating with default action of signal 11 =
(SIGSEGV)
=3D=3D10403=3D=3D  Access not within mapped region at address 0x6F6C672=
0
=3D=3D10403=3D=3D    at 0x59F90A6: readbuf_getchar (marshal.c:285)
=3D=3D10403=3D=3D    by 0x59F90E6: readbuf_getchar_skip_whitespace (mar=
shal.c:294)
=3D=3D10403=3D=3D    by 0x59FA0F3: svn_ra_svn_read_item (marshal.c:621)
=3D=3D10403=3D=3D    by 0x59FA628: svn_ra_svn_read_tuple (marshal.c:741=
)
=3D=3D10403=3D=3D    by 0x59FA906: svn_ra_svn_read_cmd_response (marsha=
l.c:799)
=3D=3D10403=3D=3D    by 0x59ED81D: handle_auth_request (client.c:346)
=3D=3D10403=3D=3D    by 0x59F02B1: ra_svn_check_path (client.c:1284)
=3D=3D10403=3D=3D    by 0x59B7FD7: svn_ra_check_path (ra_loader.c:564)
=3D=3D10403=3D=3D    by 0x599DC93: _wrap_svn_ra_check_path (svn_ra.c:60=
19)
=3D=3D10403=3D=3D    by 0x80BDAD0: Perl_pp_entersub (in /usr/bin/perl)
=3D=3D10403=3D=3D    by 0x80BC3A8: Perl_runops_standard (in /usr/bin/pe=
rl)
=3D=3D10403=3D=3D    by 0x8063A1A: perl_run (in /usr/bin/perl)
=3D=3D10403=3D=3D=20
=3D=3D10403=3D=3D ERROR SUMMARY: 199 errors from 26 contexts (suppresse=
d: 19 from 1)
=3D=3D10403=3D=3D malloc/free: in use at exit: 7,028,898 bytes in 129,4=
40 blocks.
=3D=3D10403=3D=3D malloc/free: 325,184 allocs, 195,744 frees, 21,303,51=
4 bytes allocated.
=3D=3D10403=3D=3D For counts of detected errors, rerun with: -v
=3D=3D10403=3D=3D searching for pointers to 129,440 not-freed blocks.
=3D=3D10403=3D=3D checked 7,214,984 bytes.
=3D=3D10403=3D=3D=20
=3D=3D10403=3D=3D LEAK SUMMARY:
=3D=3D10403=3D=3D    definitely lost: 4,657 bytes in 118 blocks.
=3D=3D10403=3D=3D      possibly lost: 216 bytes in 13 blocks.
=3D=3D10403=3D=3D    still reachable: 7,024,025 bytes in 129,309 blocks=
=2E
=3D=3D10403=3D=3D         suppressed: 0 bytes in 0 blocks.
=3D=3D10403=3D=3D Use --leak-check=3Dfull to see details of leaked memo=
ry.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

subversion/libsvn_ra_svn/marshal.c:
[...]
280 static svn_error_t *readbuf_getchar(svn_ra_svn_conn_t *conn,
apr_pool_t *pool,
281                                     char *result)
282 {
283   if (conn->read_ptr =3D=3D conn->read_end)
284     SVN_ERR(readbuf_fill(conn, pool));
285   *result =3D *conn->read_ptr++;	<-------- SEGFAULT happens here
286   return SVN_NO_ERROR;
287 }

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

gdb backtrace:

r54 =3D f80e8d0ad785cae5a4abfb1fdd04b31167553ab0 (trunk)
        D       collector/src/testCollector.h
        M       collector/src/rcvIpfix.h
        M       collector/src/rcvMessage.c
        M       collector/src/common.c
        M       collector/src/rcvIpfix.c
        M       collector/src/common.h
r55 =3D 3fddc1de138e9457385ff43111bcaf6f82884525 (trunk)

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1210452288 (LWP 17426)]
0xb745f0a6 in readbuf_getchar (conn=3D0x877bf78, pool=3D0x88a6178,=20
    result=3D0xbfea011f "\bL:F=EF=BF=BDL:F=EF=BF=BDX\001=EF=BF=BD\006F=EF=
=BF=BDx=EF=BF=BDw\bxa\212\bD\001=EF=BF=BD230=EF=BF=BD=EF=BF=BDx=EF=BF=BD=
w\b=EF=BF=BD\212\b=EF=BF=BDF=EF=BF=BD\002")
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/marsh=
al.c:285
285       *result =3D *conn->read_ptr++;
(gdb) bt
#0  0xb745f0a6 in readbuf_getchar (conn=3D0x877bf78, pool=3D0x88a6178,=20
    result=3D0xbfea011f "\bL:F=EF=BF=BDL:F=EF=BF=BDX\001=EF=BF=BD\006F=EF=
=BF=BDx=EF=BF=BDw\bxa\212\bD\001=EF=BF=BD230=EF=BF=BD=EF=BF=BDx=EF=BF=BD=
w\b=EF=BF=BD\212\b=EF=BF=BDF=EF=BF=BD\002")
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/marsh=
al.c:285
#1  0xb745f0e7 in readbuf_getchar_skip_whitespace (conn=3D0x877bf78, po=
ol=3D0x88a6178,=20
    result=3D0xbfea011f "\bL:F=EF=BF=BDL:F=EF=BF=BDX\001=EF=BF=BD\006F=EF=
=BF=BDx=EF=BF=BDw\bxa\212\bD\001=EF=BF=BD230=EF=BF=BD=EF=BF=BDx=EF=BF=BD=
w\b=EF=BF=BD\212\b=EF=BF=BDF=EF=BF=BD\002")
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/marsh=
al.c:294
#2  0xb74600f4 in svn_ra_svn_read_item (conn=3D0x877bf78, pool=3D0x88a6=
178, item=3D0xbfea0144)
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/marsh=
al.c:621
#3  0xb7460629 in svn_ra_svn_read_tuple (conn=3D0x877bf78, pool=3D0x88a=
6178, fmt=3D0xb7462607 "wl")
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/marsh=
al.c:741
#4  0xb7460907 in svn_ra_svn_read_cmd_response (conn=3D0x877bf78, pool=3D=
0x88a6178, fmt=3D0xb7461372 "lc")
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/marsh=
al.c:799
#5  0xb745381e in handle_auth_request (sess=3D0x877e1e8, pool=3D0x88a61=
78)
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/clien=
t.c:346
#6  0xb74562b2 in ra_svn_check_path (session=3D0x8778090, path=3D0x8899=
d48 "tags/collector-orig", rev=3D56, kind=3D0xbfea02c8, pool=3D0x88a617=
8)
    at /tmp/buildd/subversion-1.4.3dfsg1/subversion/libsvn_ra_svn/clien=
t.c:1284
#7  0xb7495fd8 in svn_ra_check_path (session=3D0x8778090, path=3D0x8899=
d48 "tags/collector-orig", revision=3D56, kind=3D0xbfea02c8,=20
    pool=3D0x88a6178) at /tmp/buildd/subversion-1.4.3dfsg1/subversion/l=
ibsvn_ra/ra_loader.c:564
#8  0xb74c2c94 in _wrap_svn_ra_check_path (my_perl=3D0x814e008, cv=3D0x=
85e1a94) at svn_ra.c:6019
#9  0x080bdad1 in Perl_pp_entersub ()
#10 0x080bc3a9 in Perl_runops_standard ()
#11 0x08063a1b in perl_run ()
#12 0x0805ffd1 in main ()
(gdb)

I'm a little lost in debuging this any further. So if anyone could give
me some advice ... feel free to contact me by mail or in #git
(nickname siprbaum)

-Peter

My system is debian etch with backported subversion + patch in [2] and =
git from
debian unstable/experimental
ii  git-core                        1.5.1.3-1
ii  git-svn                         1.5.1.3-1
ii  libsvn-perl                     1.4.3dfsg1-1
ii  libsvn1                         1.4.3dfsg1-1
ii  subversion                      1.4.3dfsg1-1

[1]: http://wwwcip.informatik.uni-erlangen.de/~siprbaum/git-svn-segfaul=
t.txt
[2]: http://svn.haxx.se/dev/archive-2007-01/0936.shtml
