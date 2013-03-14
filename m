From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] Make core.sharedRepository work under cygwin 1.7
Date: Thu, 14 Mar 2013 17:01:38 +0100
Message-ID: <201303141701.39215.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 17:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGAbc-00086R-VP
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 17:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933610Ab3CNQBq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Mar 2013 12:01:46 -0400
Received: from mout.web.de ([212.227.17.12]:53046 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932394Ab3CNQBq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 12:01:46 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MJCR8-1UIvkg0NqM-002P0P; Thu, 14 Mar 2013 17:01:44 +0100
X-Provags-ID: V02:K0:jRJG1qFsx3he4rqJmRA4ihflxgP+lGXsrQrRCOQ4Alw
 mzaLaAO9ORbwZPNJaWbAhnVRN1uaWTTzenhaPj4mi+v4YqIOsC
 JWAJlLWBuIshLl4vWmhDvWdYwoos6uu3iPoi2d3doxT5g31NHf
 D9PokzhSeR26+DBjJwu+JuRsSx5moMNfkNOLAEljMrmcvwnzYs
 V99NtdvjfMyPpfYIskqSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218150>

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
1.8.1.3
