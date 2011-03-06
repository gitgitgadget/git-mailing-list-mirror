From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] unpack-trees.c: check return value of lstat()
Date: Sun, 6 Mar 2011 20:13:52 +0100
Message-ID: <201103062013.52793.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: drizzd@aon.a, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 20:14:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwJP2-0003Ne-FH
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 20:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab1CFTN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 14:13:59 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:55668 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab1CFTN5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Mar 2011 14:13:57 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 75D7A18A8A7ED;
	Sun,  6 Mar 2011 20:13:56 +0100 (CET)
Received: from [213.64.3.195] (helo=maxi.localnet)
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PwJOu-0001ug-00; Sun, 06 Mar 2011 20:13:56 +0100
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX18mTyXWNplMzslyLtp+jXKWAy6mBYmTDsYb/10N
	uzbZawTY+UuNgPLbSW/aAljBsjaJEtHa/hK5k2vrKVOoJyRlH+
	s9ROFS9tQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168524>

Since commit f66caa "do not overwrite files in leading path"
at one place lstat() was called but the result was not checked.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
(While I was experimenting with something different,=20
this was found by valgrind)
Please review the patch, comments wellcome.

 unpack-trees.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 1ca41b1..42f7aad 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1374,10 +1374,9 @@ static int verify_absent_1(struct cache_entry *c=
e,
 		char path[PATH_MAX + 1];
 		memcpy(path, ce->name, len);
 		path[len] =3D 0;
-		lstat(path, &st);
-
-		return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
-				error_type, o);
+		if (!lstat(path, &st))
+			return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
+			                          error_type, o);
 	} else if (!lstat(ce->name, &st))
 		return check_ok_to_remove(ce->name, ce_namelen(ce),
 				ce_to_dtype(ce), ce, &st,
--=20
1.7.4
