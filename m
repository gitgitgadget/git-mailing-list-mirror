From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Store branch description in the config file
Date: Mon, 14 May 2007 21:28:10 +0200
Message-ID: <20070514192528.26543.75736.stgit@yoghurt>
References: <7vy7jtyh8q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Yann Dirson <ydirson@altern.org>,
	Carl Worth <cworth@cworth.org>, Petr Baudis <pasky@suse.cz>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 21:30:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HngFZ-0007lB-F9
	for gcvg-git@gmane.org; Mon, 14 May 2007 21:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbXENTaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 14 May 2007 15:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbXENTaX
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 15:30:23 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:56226 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751153AbXENTaW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 15:30:22 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:59341 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HngFO-0004Wd-3e; Mon, 14 May 2007 21:30:20 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HngDK-0006w1-PE; Mon, 14 May 2007 21:28:10 +0200
In-Reply-To: <7vy7jtyh8q.fsf@assigned-by-dhcp.cox.net>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HngFO-0004Wd-3e.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HngFO-0004Wd-3e 266390b099e1035d273a281001caf0a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47287>

Instead of storing the branch description in an StGIT-specific file,
store it in the git config file, where tools other than StGIT can read
and write it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

On 2007-05-12 12:27:49 -0700, Junio C Hamano wrote:

> Will it be something like
>
>       [branch "master"]
>               description =3D "My primary development line"

This was easier to do than I'd thought. I don't get quotes around the
description, though; do I have to insert them manually? And what
purpose do they serve?

 stgit/stack.py |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index c105b21..7048af7 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -451,7 +451,6 @@ class Series(StgitObject):
                                        self.__name)
=20
         self.__hidden_file =3D os.path.join(self._dir(), 'hidden')
-        self.__descr_file =3D os.path.join(self._dir(), 'description')
=20
         # where this series keeps its patches
         self.__patch_dir =3D os.path.join(self._dir(), 'patches')
@@ -550,11 +549,23 @@ class Series(StgitObject):
         if os.path.isfile(protect_file):
             os.remove(protect_file)
=20
+    def __branch_descr(self):
+        return 'branch.%s.description' % self.get_branch()
+
     def get_description(self):
-        return self._get_field('description') or ''
+        # Fall back to the .git/patches/<branch>/description file if
+        # the config variable is unset.
+        return (config.get(self.__branch_descr())
+                or self._get_field('description') or '')
=20
     def set_description(self, line):
-        self._set_field('description', line)
+        if line:
+            config.set(self.__branch_descr(), line)
+        else:
+            config.unset(self.__branch_descr())
+        # Delete the old .git/patches/<branch>/description file if it
+        # exists.
+        self._set_field('description', None)
=20
     def get_parent_remote(self):
         value =3D config.get('branch.%s.remote' % self.__name)
@@ -787,8 +798,6 @@ class Series(StgitObject):
             # (move functionality to StgitObject ?)
             if os.path.exists(self.__hidden_file):
                 os.remove(self.__hidden_file)
-            if os.path.exists(self.__descr_file):
-                os.remove(self.__descr_file)
             if os.path.exists(self._dir()+'/orig-base'):
                 os.remove(self._dir()+'/orig-base')
=20
