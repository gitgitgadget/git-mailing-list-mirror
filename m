From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-bzr: fix utf-8 support for fetching
Date: Mon,  8 Apr 2013 13:36:38 -0500
Message-ID: <1365446199-11382-2-git-send-email-felipe.contreras@gmail.com>
References: <1365446199-11382-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 20:37:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGwu-0007Fn-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935365Ab3DHShp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Apr 2013 14:37:45 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:33756 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934738Ab3DHShn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:37:43 -0400
Received: by mail-oa0-f50.google.com with SMTP id n1so6421457oag.23
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=7/Thyer567n9upc3Tfgf2rVmPICxhhZC5Po+wAyaTjQ=;
        b=FHjkufaeCzBZWsfXu4uwtBWRrIs+fYvz2vsTsPP3xxRZ33ezUBXKeKR+pc2cMyW5Jc
         Yunv09frzEAYhPW8+YM+UmQistaKPMUZgHuOevGDNbqY/05zoUHWyQ2833mVG57jTpNt
         OGKhv/p/ewUqeA2P9uNPLkB8D55Z5U07+VY7ITUB7qlf7gfDrI7D63RQUe1rmkPtPICp
         LjwAqAfKLkoMONVikb4VXhBrcgi1lEg+hb0UhagOVIjAhRNsSAgA9Hy+FlaVDUJi5Wge
         tlADEZz76vf6HNUCIEH1VTbXcp+qKxsEqyHiBX0KNhAljvGo+8bPsum+O+XH9MUPWffT
         YLmw==
X-Received: by 10.182.134.230 with SMTP id pn6mr16418860obb.19.1365446263442;
        Mon, 08 Apr 2013 11:37:43 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id s8sm5215620obf.2.2013.04.08.11.37.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 11:37:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365446199-11382-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220487>

=46rom: Christophe Simonis <christophe@kn.gl>

The previous patches didn't deal with all the scenarios.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 19 +++++++++++--------
 contrib/remote-helpers/test-bzr.sh    |  9 ++++++++-
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-hel=
pers/git-remote-bzr
index fad4a48..55ebf19 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -183,21 +183,24 @@ def get_filechanges(cur, prev):
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
@@ -223,7 +226,7 @@ def export_files(tree, files):
             # is the blog already exported?
             if h in filenodes:
                 mark =3D filenodes[h]
-                final.append((mode, mark, path.encode('utf-8')))
+                final.append((mode, mark, path))
                 continue
=20
             d =3D tree.get_file_text(fid)
@@ -240,7 +243,7 @@ def export_files(tree, files):
         print "data %d" % len(d)
         print d
=20
-        final.append((mode, mark, path.encode('utf-8')))
+        final.append((mode, mark, path))
=20
     return final
=20
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index f4c7768..e800c97 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -177,6 +177,13 @@ test_expect_success 'fetch utf-8 filenames' '
=20
   echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
   bzr add "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  echo test >> "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
+  bzr add "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
+  bzr commit -m utf-8 &&
+  echo test >> "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" &&
+  bzr commit -m utf-8 &&
+  bzr rm "=C3=AE=C3=B8=E2=88=AB=E2=88=86" &&
+  bzr mv "=C3=A1=C3=A9=C3=AD=C3=B3=C3=BA" "=C3=A5=C3=9F=E2=88=82" &&
   bzr commit -m utf-8
   ) &&
=20
@@ -186,7 +193,7 @@ test_expect_success 'fetch utf-8 filenames' '
   git ls-files > ../actual
   ) &&
=20
-  echo "\"\\303\\241\\303\\251\\303\\255\\303\\263\\303\\272\"" > expe=
cted &&
+  echo "\"\\303\\245\\303\\237\\342\\210\\202\"" > expected &&
   test_cmp expected actual
 '
=20
--=20
1.8.2
