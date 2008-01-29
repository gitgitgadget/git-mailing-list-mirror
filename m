From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/4] Teach new infrastructure about the default author
	and committer
Date: Tue, 29 Jan 2008 04:15:31 +0100
Message-ID: <20080129031520.1177.8884.stgit@yoghurt>
References: <20080129031310.1177.83290.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:16:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgxC-0006bV-PM
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753846AbYA2DPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753681AbYA2DPe
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:15:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4647 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbYA2DPd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:15:33 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgwb-0000eO-00; Tue, 29 Jan 2008 03:15:30 +0000
In-Reply-To: <20080129031310.1177.83290.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71940>

As specified by the config options user.name and user.email, and the
environment variables GIT_{AUTHOR,COMMITTER}_{NAME,EMAIL,DATE} (the
latter overriding the former).

Nothing uses this yet, but "stg edit" will soon.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6cd7450..8678979 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -52,6 +52,30 @@ class Person(Repr):
         email =3D m.group(2)
         date =3D m.group(3)
         return cls(name, email, date)
+    @classmethod
+    def user(cls):
+        if not hasattr(cls, '__user'):
+            cls.__user =3D cls(name =3D config.get('user.name'),
+                             email =3D config.get('user.email'))
+        return cls.__user
+    @classmethod
+    def author(cls):
+        if not hasattr(cls, '__author'):
+            cls.__author =3D cls(
+                name =3D os.environ.get('GIT_AUTHOR_NAME', NoValue),
+                email =3D os.environ.get('GIT_AUTHOR_EMAIL', NoValue),
+                date =3D os.environ.get('GIT_AUTHOR_DATE', NoValue),
+                defaults =3D cls.user())
+        return cls.__author
+    @classmethod
+    def committer(cls):
+        if not hasattr(cls, '__committer'):
+            cls.__committer =3D cls(
+                name =3D os.environ.get('GIT_COMMITTER_NAME', NoValue)=
,
+                email =3D os.environ.get('GIT_COMMITTER_EMAIL', NoValu=
e),
+                date =3D os.environ.get('GIT_COMMITTER_DATE', NoValue)=
,
+                defaults =3D cls.user())
+        return cls.__committer
=20
 class Tree(Repr):
     """Immutable."""
