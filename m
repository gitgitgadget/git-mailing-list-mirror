From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Tue, 19 Mar 2013 20:49:58 +0100
Message-ID: <201303192049.58755.tboegi@web.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org,
	j6t@kdbg.org, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 20:50:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI2YO-0004nW-4n
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 20:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828Ab3CSTuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Mar 2013 15:50:06 -0400
Received: from mout.web.de ([212.227.17.12]:52486 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739Ab3CSTuF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Mar 2013 15:50:05 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MZDga-1TzHjr23oq-00LDS9; Tue, 19 Mar 2013 20:50:03 +0100
X-Provags-ID: V02:K0:I0so1Y6z7XHMP/eKiA1kGQxUsOH/fBOkBwj/fz8PW3Y
 aWel7LX/JRB1Gnm/MCux6d3+T5NO3BjSBzWQ+KEohqaA9xLD52
 1styneqIS+t32UZPNCwKDNXywv3vSsti24xTlZ0LaqoguABirM
 F/xvBsObSoQmgWfwRrH5v2/copTG5Plffars2xFCgeJS2tg+y7
 PCvjWkDAFzHV70mA5kPiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218552>

On Friday 08 February 2013 07:08:14 Torsten B=C3=B6gershausen wrote:
> On 07.02.13 20:35, Junio C Hamano wrote:
> > Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> >
> >> Torsten B=C3=B6gershausen wrote:
> >>> t0070 and t1301 fail when running the test suite under cygwin.
> >>> Skip the failing tests by unsetting POSIXPERM.
> >> t1301 does not fail for me. (WIN XP (SP3) on NTFS)
> > Others run Cygwin with vfat or some other filesystem, and some of
> > them do not cope will with POSIXPERM, perhaps?
> >
> > Not having POSIXPERM by default for Cygwin may be a saner default
> > than having one, if we have to pick one.
> >
> > It may be debatable to have this default as platform attribute,
> > though.
> >
> Yes, 1301 passes on cygwin 1.5, but not on 1.7.
> And it breaks on VFAT, for all kind of OS.
>=20
> Thanks for comments, I'll put more investigations on my todo stack.
> /Torsten

It turns out that cygwin 1.7 handles the read only attribute different =
then
cygwin 1.5.
Under cygwin 1.5 the "read only" attribute is synchronized with the
"user write" bit from the permissions.

tb@PC /cygdrive/c/temp/pt
$ echo x >x
$ chmod 444 x
$ attrib x
A    R     C:\temp\pt\x
Cygwin 1.7 does not do the synchronization, which means that some files
seem to be writable when do_stat() is used, but the permissions are r--=
r--r--

We can improve Git to work for cygwin 1.7, a suggestion for a patch
may look like this:

-- >8 --
Subject: [PATCH] Make core.sharedRepository work under cygwin 1.7

When core.sharedRepository is used, set_shared_perm() in path.c
needs lstat() to return the correct POSIX permissions.

The default for cygwin is core.ignoreCygwinFSTricks =3D false, which
means that a simplified and fast implementation of lstat() is used.

Especially the file permission bits are wrong in cygwin_lstat_fn():
The read-only attribute of a file is used to calculate
the permissions, resulting in either rw-r--r-- or r--r--r--

Use a compile switch IGNORECYGWINFSTRICKS to disable the usage
of cygwin_lstat_fn() only in path.c

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 compat/cygwin.h | 2 ++
 path.c          | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/compat/cygwin.h b/compat/cygwin.h
index a3229f5..984efbe 100644
--- a/compat/cygwin.h
+++ b/compat/cygwin.h
@@ -5,5 +5,7 @@ typedef int (*stat_fn_t)(const char*, struct stat*);
 extern stat_fn_t cygwin_stat_fn;
 extern stat_fn_t cygwin_lstat_fn;
=20
+#ifndef IGNORECYGWINFSTRICKS
 #define stat(path, buf) (*cygwin_stat_fn)(path, buf)
 #define lstat(path, buf) (*cygwin_lstat_fn)(path, buf)
+#endif
diff --git a/path.c b/path.c
index d3d3f8b..0acfabf 100644
--- a/path.c
+++ b/path.c
@@ -10,6 +10,8 @@
  *
  * which is what it's designed for.
  */
+#define IGNORECYGWINFSTRICKS
+
 #include "cache.h"
 #include "strbuf.h"
 #include "string-list.h"
--=20
1.8.2.341.g543621f
