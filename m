From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: git-http-fetch segfault backtrace
Date: Fri, 2 Jun 2006 10:47:48 -0500
Message-ID: <43D574AA-92CF-42E6-BB89-9F57533D1E91@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jun 02 17:46:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmBqa-0004dp-Jk
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 17:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWFBPpw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Jun 2006 11:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWFBPpw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 11:45:52 -0400
Received: from [192.88.158.103] ([192.88.158.103]:34499 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932424AbWFBPpv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 11:45:51 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k52G2JCh026814
	for <git@vger.kernel.org>; Fri, 2 Jun 2006 09:02:19 -0700 (MST)
Received: from [10.82.17.212] ([10.82.17.212])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k52Fjj6x028946
	for <git@vger.kernel.org>; Fri, 2 Jun 2006 10:45:45 -0500 (CDT)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.750)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21163>


I've been having problems with git-http-fetch segfaulting for several =20
git versions now.  I've been watching the list and have seen other =20
complaints about similar problems, but the issue I'm hitting seems to =20
be slightly different.  Any insight anyone has here is greatly =20
appreciated.  I've included what information I have, and if there's =20
any other information or experiments anyone would like me to try, =20
I'll be happy to give it a go.

Some information:
- the git version is top of tree as of 1pm 6/1.  I pulled it from =20
http://www.kernel.org/pub/scm/git/git.git
- I am running on an i686 Linux machine: uname -a returns
Linux machinename 2.4.21-32.EL #1 Fri Apr 15 21:29:19 EDT 2005 i686 =20
i686 i386 GNU/Linux
- my curl version is
curl 7.10.6 (i386-redhat-linux-gnu) libcurl/7.10.6 OpenSSL/0.9.7a =20
ipv6 zlib/1.1.4.  git with the same curl version appears to work fine =20
on x86_64 systems here.
- As far as I can tell, this problem seems to have appeared sometime =20
after git 1.2.4


I compiled git without optimizations and ran git-http-fetch via gdb =20
to see what's going on.  Here's the backtrace:

(gdb) run -v -a -w heads/html heads/html http://www.kernel.org/pub/=20
scm/git/git.git/
Starting program: /tmp/install/bin/git-http-fetch -v -a -w heads/html =20
heads/html http://www.kernel.org/pub/scm/git/git.git/
walk bb8fb05ed082c81af81f9eecf356f993e2ef83b7
walk f31d9f5bcd0a1c236d8277df39c74927917ffb8f
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/

Program received signal SIGSEGV, Segmentation fault.
0x00eed07c in memcpy () from /lib/tls/libc.so.6
(gdb) bt
#0  0x00eed07c in memcpy () from /lib/tls/libc.so.6
#1  0x0804a6db in fread_buffer (ptr=3D0x9323a01, eltsize=3D1, =20
nmemb=3D16384, buffer=3D0xbfffb830)
     at http.c:38
#2  0x0012c438 in Curl_getinfo () from /usr/lib/libcurl.so.2
#3  0x0012ce49 in Curl_readwrite () from /usr/lib/libcurl.so.2
#4  0x001314f2 in curl_multi_perform () from /usr/lib/libcurl.so.2
#5  0x0804afb9 in get_active_slot () at http.c:304
#6  0x0804d41d in fetch_indices (repo=3D0x9309498) at http-fetch.c:910
#7  0x0804d666 in fetch_pack (repo=3D0x9309498, sha1=3D0x9312390 "=D1=A4=
???r#=20
\032??&?\aC??:?+'[?\005\b")
     at http-fetch.c:977
#8  0x0804dd41 in fetch (sha1=3D0x9312390 "=D1=A4???r#\032??&?\aC??:?+'=
[?\005=20
\b") at http-fetch.c:1129
#9  0x0804a4a9 in loop () at fetch.c:166
#10 0x0804a64f in pull (target=3D0xbfffefe1 "heads/html") at fetch.c:21=
8
#11 0x0804e2c9 in main (argc=3D7, argv=3D0xbfffcae4) at http-fetch.c:12=
69

I also did some poking around, and it looks like the call to =20
fread_buffer that causes the problem (it's the 3rd call, in this =20
case) has a potentially bogus buffer->posn (at least, it seems a =20
little ridiculous to me).... Note that the previous call to fread =20
resulted in a 0 size.

Starting program: /tmp/install/bin/git-http-fetch -v -a -w heads/html =20
heads/html http://www.kernel.org/pub/scm/git/git.git/
[/_TOOLS_/plat/local-/ppc-/login]
Installing oss-/1.0.0
walk bb8fb05ed082c81af81f9eecf356f993e2ef83b7
walk f31d9f5bcd0a1c236d8277df39c74927917ffb8f
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/

Breakpoint 1, fread_buffer (ptr=3D0x914fa01, eltsize=3D1, nmemb=3D16384=
, =20
buffer=3D0xbfffb9a0)
     at http.c:35
35              size_t size =3D eltsize * nmemb;
(gdb) step
36              if (size > buffer->size - buffer->posn)
(gdb) step
37                      size =3D buffer->size - buffer->posn;
(gdb) p/x size
$1 =3D 0x4000
(gdb) p/x buffer->size
$2 =3D 0x5e
(gdb) p/x buffer->posn
$3 =3D 0x0
(gdb) c
Continuing.

Breakpoint 1, fread_buffer (ptr=3D0x914fa01, eltsize=3D1, nmemb=3D16384=
, =20
buffer=3D0xbfffb9a0)
     at http.c:35
35              size_t size =3D eltsize * nmemb;
(gdb) step
36              if (size > buffer->size - buffer->posn)
(gdb) p/x size
$4 =3D 0x4000
(gdb) p/x buffer->size
$5 =3D 0x5e
(gdb) p/x buffer->posn
$6 =3D 0x5e
(gdb) c
Continuing.

Breakpoint 1, fread_buffer (ptr=3D0x914fa01, eltsize=3D1, nmemb=3D16384=
, =20
buffer=3D0xbfffb9a0)
     at http.c:35
35              size_t size =3D eltsize * nmemb;
(gdb) step
36              if (size > buffer->size - buffer->posn)
(gdb) p/x size
$7 =3D 0x4000
(gdb) p/x buffer->size
$8 =3D 0x7
(gdb) p/x buffer->posn
$9 =3D 0xbfffcc54
(gdb)

We thought perhaps the problem was related to CURL MULTI, but we set =20
http.maxrequests to 1, we get the same behavior.  FYI - if you turn =20
off USE_CURL_MULTI, git no longer builds.  There is stuff that uses =20
the curlm variable that is not inside the ifdefs.

Thanks,
B
