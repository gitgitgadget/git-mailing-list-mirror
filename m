From: Matthias Lederhofer <matled@gmx.net>
Subject: git repack -a -d is not safe
Date: Thu, 1 Feb 2007 12:25:45 +0100
Message-ID: <20070201112545.GA19855@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 01 12:26:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCa4i-0000k9-4u
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 12:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbXBALZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 1 Feb 2007 06:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbXBALZu
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 06:25:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:44632 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751714AbXBALZu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 06:25:50 -0500
Received: (qmail invoked by alias); 01 Feb 2007 11:25:48 -0000
Received: from pD9EB9AC1.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.154.193]
  by mail.gmx.net (mp033) with SMTP; 01 Feb 2007 12:25:48 +0100
X-Authenticated: #5358227
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38344>

=46irst the object is unpacked, start something using read_sha1_file.
read_sha1_file: try packed object (fails)
run git repack -a -d
read_sha1_file: try to read the loose object (fails)
read_sha1_file: reread list of packs
run git repack -a -d so it will create a new pack
read_sha1_file: tries to open the old packs, not the new one, and
                fails

Anyway this is quite improbable because normally a read_sha1_file is
much faster than git repack -a -d.

gdb commands to do that:
shell git init
shell seq 1 10 > a
shell git add a
shell git commit -m first
file git-cat-file
break read_sha1_file
run -p HEAD:a
next
next
shell git repack -a -d
next
next
next
shell seq 11 20 >> a
shell git add a
shell git commit -m second
shell git repack -a -d
continue

gdb session running the commands:
GNU gdb 6.4.90-debian
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and yo=
u are
welcome to change it and/or distribute copies of it under certain condi=
tions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for deta=
ils.
This GDB was configured as "i486-linux-gnu".
$ shell git init
Initialized empty Git repository in .git/
$ shell seq 1 10 > a
$ shell git add a
$ shell git commit -m first
Created initial commit c520a6d82591b2c6654abe65418a2223302f927b
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 a
$ file git-cat-file
Reading symbols from /home/matled/local/bin/git-cat-file...done.
Using host libthread_db library "/lib/tls/i686/cmov/libthread_db.so.1".
$ break read_sha1_file
Breakpoint 1 at 0x8098959: file sha1_file.c, line 1483.
$ run -p HEAD:a
Starting program: /home/matled/local/bin/git-cat-file -p HEAD:a
warning: Lowest section in system-supplied DSO at 0xffffe000 is .hash a=
t ffffe0b4

Breakpoint 1, read_sha1_file (sha1=3D0xffcc0db8 "=C5 =A6=D8%\221=B2=C6e=
J=BEeA\212\"#0/\222{", type=3D0xffcc0dd0 "=FF=FF=FF=FF", size=3D0xffcc0=
dcc)
    at sha1_file.c:1483
1483            buf =3D read_packed_sha1(sha1, type, size);
$ next
1484            if (buf)
$ next
1486            map =3D map_sha1_file(sha1, &mapsize);
$ shell git repack -a -d
Generating pack...
Done counting 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
Pack pack-fcbc60879b35995a9b532543a3b072b83a50b510 created.
Removing unused objects 100%...
Done.
$ next
1487            if (map) {
$ next
1492            reprepare_packed_git();
$ next
1493            return read_packed_sha1(sha1, type, size);
$ shell seq 11 20 >> a
$ shell git add a
$ shell git commit -m second
Created commit 0bc9af2dfb8538abf9247ae282d0a2bd0cfc7b0d
 1 files changed, 10 insertions(+), 0 deletions(-)
$ shell git repack -a -d
Generating pack...
Done counting 6 objects.
Deltifying 6 objects.
 100% (6/6) done
Writing 6 objects.
 100% (6/6) done
Total 6 (delta 0), reused 3 (delta 0)
Pack pack-ad55ad59fa078c3261550ebd9adf0035cf89fa63 created.
Removing unused objects 100%...
Done.
$ continue=20
Continuing.
fatal: packfile .git/objects/pack/pack-fcbc60879b35995a9b532543a3b072b8=
3a50b510.pack cannot be opened

Program exited with code 0200.
$=20
