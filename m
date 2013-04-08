From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 6/7] remote-bzr: add utf-8 support for fetching
Date: Mon,  8 Apr 2013 12:27:15 -0500
Message-ID: <1365442036-25732-7-git-send-email-felipe.contreras@gmail.com>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:28:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFs7-0001ex-AU
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934779Ab3DHR2h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 13:28:37 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:38189 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934770Ab3DHR2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:28:36 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so6486575oag.17
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dvVe9A0I4rxP0PBWczQV3wEcbtwNS3TNGA/6eTUcJP4=;
        b=O9LjUyD46ESiWVi8gbXcu/XBHR5CnrMvy6LSaEK3GwEqDAtmWkwic1dGYA5/TzvFLz
         b57jg9D/d57uYp7s26En4mX/r3x6wI9mSIB2GBL1t9oV1ZF+HuhfZBbQnl9aBOzixd0y
         nwUpJHOfr3Hs5PYarxPg4rYpiVD8/kLLzpdDpUHLhxFIdhOPWERYzqFbfxl4Z7qhOvsQ
         /59DnYJ1WJMAqDdXT95bPnP0Zaf6gR9jNx9Ijl4mS0h1lyKuLc/jLizgARN8+g39IXVe
         5wAB+s0sa52RYnDiyz5A31yMEy0e0X72FZjIVE+/sU9Vk2sCjFhLfjzdDEzb/nCtrMfL
         DOiQ==
X-Received: by 10.182.107.66 with SMTP id ha2mr16478393obb.43.1365442115837;
        Mon, 08 Apr 2013 10:28:35 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id xz9sm26185220oeb.5.2013.04.08.10.28.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:28:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220471>

=46rom: Christophe Simonis <christophe@kn.gl>

Initial patch by Timotheus Pokorra.

[fc: added tests]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 15 +++++++++------
 contrib/remote-helpers/test-bzr.sh    | 32 +++++++++++++++++++++++++++=
+++++
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index dc0b757..64b35c7 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -184,21 +184,24 @@ def get_filechanges(cur, prev):
=20
     changes =3D cur.changes_from(prev)
=20
+    def u(s):
+        return s.encode('utf-8')
+
     for path, fid, kind in changes.added:
-        modified[path] =3D fid
+        modified[u(path)] =3D fid
     for path, fid, kind in changes.removed:
-        removed[path] =3D None
+        removed[u(path)] =3D None
     for path, fid, kind, mod, _ in changes.modified:
-        modified[path] =3D fid
+        modified[u(path)] =3D fid
     for oldpath, newpath, fid, kind, mod, _ in changes.renamed:
-        removed[oldpath] =3D None
+        removed[u(oldpath)] =3D None
         if kind =3D=3D 'directory':
             lst =3D cur.list_files(from_dir=3Dnewpath, recursive=3DTru=
e)
             for path, file_class, kind, fid, entry in lst:
                 if kind !=3D 'directory':
-                    modified[newpath + '/' + path] =3D fid
+                    modified[u(newpath + '/' + path)] =3D fid
         else:
-            modified[newpath] =3D fid
+            modified[u(newpath)] =3D fid
=20
     return modified, removed
=20
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index 68105fc..9a510a8 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -165,4 +165,36 @@ test_expect_success 'different authors' '
   test_cmp expected actual
 '
=20
+test_expect_success 'fetch utf-8 filenames' '
+  mkdir -p tmp && cd tmp &&
+  test_when_finished "cd .. && rm -rf tmp && LC_ALL=3DC" &&
+
+  export LC_ALL=3Den_US.UTF-8
+
+  (
+  bzr init bzrrepo &&
+  cd bzrrepo &&
+
+  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  bzr add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  echo test >> "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
+  bzr add "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
+  bzr commit -m utf-8 &&
+  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  bzr commit -m utf-8 &&
+  bzr rm "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
+  bzr mv "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" "=C3=A5=C3=9F=E2=88=82" &&
+  bzr commit -m utf-8
+  ) &&
+
+  (
+  git clone "bzr::$PWD/bzrrepo" gitrepo &&
+  cd gitrepo &&
+  git ls-files > ../actual
+  ) &&
+
+  echo "\"\\303\\245\\303\\237\\342\\210\\202\"" > expected &&
+  test_cmp expected actual
+'
+
 test_done
--=20
1.8.2
