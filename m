From: Pavel Roskin <proski@gnu.org>
Subject: Re: New release?
Date: Tue, 06 Jun 2006 14:38:17 -0400
Message-ID: <1149619097.25298.6.camel@dv>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	 <7vodx6zus2.fsf@assigned-by-dhcp.cox.net> <1149610759.27253.9.camel@dv>
	 <20060606164618.GC3938@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 20:38:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FngRy-0006v0-3B
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 20:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWFFSin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 6 Jun 2006 14:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWFFSin
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 14:38:43 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:65252 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750936AbWFFSim convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Jun 2006 14:38:42 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FngRi-0008OH-2R
	for git@vger.kernel.org; Tue, 06 Jun 2006 14:38:30 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FngRV-0006rz-Iq; Tue, 06 Jun 2006 14:38:17 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060606164618.GC3938@reactrix.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21394>

On Tue, 2006-06-06 at 09:46 -0700, Nick Hengeveld wrote:
> On Tue, Jun 06, 2006 at 12:19:19PM -0400, Pavel Roskin wrote:
>=20
> > On Mon, 2006-06-05 at 23:02 -0700, Junio C Hamano wrote:
> > >          - http-fetch fixes from Nick, which looked obviously cor=
rect.
> > >            I would appreciate test reports from people who saw br=
eakages
> > >            on this one.
> >=20
> > I'm still getting a segfault with the current git from the "next" b=
ranch:
> >=20
> > $ git-clone http://www.denx.de/git/linux-2.6-denx.git
> > ...
> > got 4160b8334c53e0881cdc12c1f7d3d54fff883772
> > got 5f57f29efee48d84e235a8ff75a35e7e354227a7
> > got 681a9c73a2a321850404d4856f4738be47e17d15
> > got 29b0ddaa324e417abf153460d7d94fb67823a6ef
> > got 23e7a5c7d2c13d98524b69f54378d887e1962fc8
> > /home/proski/bin/git-clone: line 29: 27271 Segmentation fault      =
git-http-fetch -v -a -w "$tname" "$name" "$1/"

It crashed again, in a different place:
got d82e6dae84070951f625622229154cb32d3f2333
got c3e1d3e888d7b25c20d90ae4a7ecb8f5be420b98
got 2ed07112d683fa7cd1c72b0a31a7e95c6645543d
got 2721e4c8184a9a64f505686ebf7bf6e1e80ecf59

This time I was better prepared (git was compiled with -g without
optimization, the trap was commented out in git-clone, "ulimit -c" set
to unlimited), and I attached gdb to git-http-fetch.

Program received signal SIGSEGV, Segmentation fault.
0x00000000004044dc in closedown_active_slot (slot=3D0x656854202a200a73)=
 at http.c:434
434             slot->in_use =3D 0;
(gdb) p slot
$1 =3D (struct active_request_slot *) 0x656854202a200a73
(gdb) p slot->in_use
Cannot access memory at address 0x656854202a200a83
(gdb) where
#0  0x00000000004044dc in closedown_active_slot (slot=3D0x656854202a200=
a73) at http.c:434
#1  0x00000000004044fa in release_active_slot (slot=3D0x656854202a200a7=
3) at http.c:439
#2  0x00000000004070fc in abort_object_request (obj_req=3D0xdaf2b0) at =
http-fetch.c:1060
#3  0x00000000004071cf in fetch_object (repo=3D0x548f50,=20
    sha1=3D0xcd4838 "=F1=BF=A5\025=D7=DB=FE=A5c'\210=E6=CB=A9\213=D6}=DB=
=F4=FC") at http-fetch.c:1078
#4  0x00000000004073ed in fetch (sha1=3D0xcd4838 "=F1=BF=A5\025=D7=DB=FE=
=A5c'\210=E6=CB=A9\213=D6}=DB=F4=FC")
    at http-fetch.c:1126
#5  0x0000000000403126 in loop () at fetch.c:180
#6  0x000000000040336a in pull (target=3D0x7fff0c2e38c2 "heads/master")=
 at fetch.c:248
#7  0x0000000000407a14 in main (argc=3D7, argv=3D0x7fff0c2e18a8) at htt=
p-fetch.c:1271
(gdb)

It's a different backtrace this time.  abort_object_request() has this =
code:

if (obj_req->slot) {
     release_active_slot(obj_req->slot);
     obj_req->slot =3D NULL;
}

Apparently just because obj_req->slot is not NULL doesn't mean it's a
valid pointer.  I'm going to use Valgrind now.

It's x86_64, FC5, Linux kernel from git.

> I just posted a fix for the compile errors.  As noted there, I've don=
e
> very little testing of the fetch/push binaries when built with
> USE_CURL_MULTI commented out.

Thank you.  I'll try it too.

--=20
Regards,
Pavel Roskin
