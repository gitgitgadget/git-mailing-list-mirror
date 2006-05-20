From: Yann Dirson <ydirson@altern.org>
Subject: Re: [BUG] "stg pull" on qgit tree shows problems, including git-http-fetch segfault
Date: Sat, 20 May 2006 15:12:33 +0200
Message-ID: <20060520131232.GH6535@nowhere.earth>
References: <20060520125804.GG6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat May 20 15:00:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhR4Z-00031E-DI
	for gcvg-git@gmane.org; Sat, 20 May 2006 15:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWETNAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 20 May 2006 09:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWETNAm
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 09:00:42 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:30340 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S964827AbWETNAm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 09:00:42 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 0802B2252C
	for <git@vger.kernel.org>; Sat, 20 May 2006 15:00:41 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FhRFx-00055B-EJ
	for git@vger.kernel.org; Sat, 20 May 2006 15:12:33 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060520125804.GG6535@nowhere.earth>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20378>

Let's be more precise - the command that repedetly fails is the
following.  It is reponsible for both the "XML error" message and the
segfault.

git-http-fetch -v -a 79ac640b3129344d4e94573ddaea09ccda1b8e3b http://di=
gilander.libero.it/mcostalba/scm/qgit.git/


Output goes like:

walk 79ac640b3129344d4e94573ddaea09ccda1b8e3b
walk d8bc846d8d2709fa240887da512e8b125a669006
walk 5d0d2f1703976e04c6db1e55ea6a044981b9ed20
error: File f7dc43059ca42dec2ea7214a33d1ff3c35e0aca5 (http://digilander=
=2Elibero.it/mcostalba/scm/qgit.git/objects/f7/dc43059ca42dec2ea7214a33=
d1ff3c35e0aca5) corrupt
Getting pack list for http://digilander.libero.it/mcostalba/scm/qgit.gi=
t/
error: XML error: syntax error
Getting index for pack c47999034002469dddee39ba0069c1b1a84487a5
error: Unable to open local file .git/objects/pack/pack-c47999034002469=
dddee39ba0069c1b1a84487a5.idx for pack index
Getting alternates list for http://digilander.libero.it/mcostalba/scm/q=
git.git/
Also look at <meta http-equiv=3D"Refresh" content=3D"5;URL=3Dhttp://dig=
iland.libe
Also look at <BASE HREF=3D"http://digiland.liber
Segmentation fault (core dumped)


gdb backtrace is:

#0  0xb7caa5d0 in strncpy () from /lib/tls/libc.so.6
#1  0x0804c177 in process_alternates_response (callback_data=3D0xbfd428=
ec) at http-fetch.c:587
#2  0x0804a6c8 in process_curl_messages () at http.c:461
#3  0x0804a773 in step_active_slots () at http.c:379
#4  0x0804a7c7 in run_active_slot (slot=3D0x807f6a8) at http.c:400
#5  0x0804c565 in fetch_alternates (base=3D0xbfd45424 "http://digilande=
r.libero.it/mcostalba/scm/qgit.git/") at http-fetch.c:668
#6  0x0804d46c in fetch (sha1=3D0x807f448 "=F7=DCC\005\234=A4-=EC.=A7!J=
3=D1=FF<5=E0=AC=A5\225=B9\005\b") at http-fetch.c:1131
#7  0x0804a1ad in pull (target=3D0xbfd453fb "79ac640b3129344d4e94573dda=
ea09ccda1b8e3b") at fetch.c:168
#8  0x0804b590 in main (argc=3D5, argv=3D0xbfd43af4) at http-fetch.c:12=
69


The crash in process_alternates_response occurs on line:

587                                     strncpy(target + serverlen, dat=
a + i,
588                                             posn - i - 7);

(gdb) p target
$1 =3D 0x80800b8 "http://digilander.libero.it//-->\n</script>\n\n<scrip=
t language=3D\"Javascript\" src=3D\"/x/js/nu05.js\"></script>\n\n<scrip=
t>\n<!--\n\nfunction loaded() {\n\tcommon_boot();\n\t\n\t\t\n}\n\nfunct=
ion unloaded() {\n\tcommon_unload"...
(gdb) p target+serverlen
$2 =3D 0x80800d3 "//-->\n</script>\n\n<script language=3D\"Javascript\"=
 src=3D\"/x/js/nu05.js\"></script>\n\n<script>\n<!--\n\nfunction loaded=
() {\n\tcommon_boot();\n\t\n\t\t\n}\n\nfunction unloaded() {\n\tcommon_=
unload();\n\t}\n\nfunction eoc() {\n\tc"...
(gdb) p data
$3 =3D 0x809c840 ""
(gdb) p i
$4 =3D 134739640
(gdb) p posn
$5 =3D 1304


Looks like something is going very wrong, like wrong assumptions about =
received HTML.

--=20
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Grati=
s
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
