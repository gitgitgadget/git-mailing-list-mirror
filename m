From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/5] Remove an unnecessary parameter to make_patch_name
Date: Fri, 11 May 2007 03:40:16 +0200
Message-ID: <20070511014016.13161.33634.stgit@yoghurt>
References: <20070511013400.13161.9160.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 03:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKGI-0005c8-C3
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757795AbXEKBtd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 21:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758023AbXEKBtd
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:49:33 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:41972 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757795AbXEKBtc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 21:49:32 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38577 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HmKEc-00082E-9O; Fri, 11 May 2007 03:47:57 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HmK7E-0003TT-Ta; Fri, 11 May 2007 03:40:16 +0200
In-Reply-To: <20070511013400.13161.9160.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HmKEc-00082E-9O.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HmKEc-00082E-9O 210cf4e3713189b3c0745de24c5e5f78
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46928>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>

The "alternative" parameter was a boolean that indicated whether we
were interested in testing if the first generated name was acceptable,
or if we would just always accept it. But that can be accomplished by
giving an "unacceptable" function that always returns False, so
there's no need for an additional parameter.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/imprt.py |    8 +++++---
 stgit/utils.py          |    5 ++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 89af472..6fcdc62 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -242,9 +242,11 @@ def __create_patch(filename, message, author_name,=
 author_email,
         patch =3D __strip_patch_name(patch)
=20
     if not patch:
-        patch =3D make_patch_name(message, crt_series.patch_exists,
-                                alternative =3D not (options.ignore
-                                                   or options.replace)=
)
+        if options.ignore or options.replace:
+            unacceptable_name =3D lambda name: False
+        else:
+            unacceptable_name =3D crt_series.patch_exists
+        patch =3D make_patch_name(message, unacceptable_name)
     else:
         # fix possible invalid characters in the patch name
         patch =3D re.sub('[^\w.]+', '-', patch).strip('-')
diff --git a/stgit/utils.py b/stgit/utils.py
index 3612a4b..fbfe748 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -183,15 +183,14 @@ def patch_name_from_msg(msg):
     subject_line =3D msg.split('\n', 1)[0].lstrip().lower()
     return re.sub('[\W]+', '-', subject_line).strip('-')[:30]
=20
-def make_patch_name(msg, unacceptable, default_name =3D 'patch',
-                    alternative =3D True):
+def make_patch_name(msg, unacceptable, default_name =3D 'patch'):
     """Return a patch name generated from the given commit message,
     guaranteed to make unacceptable(name) be false. If the commit
     message is empty, base the name on default_name instead."""
     patchname =3D patch_name_from_msg(msg)
     if not patchname:
         patchname =3D default_name
-    if alternative and unacceptable(patchname):
+    if unacceptable(patchname):
         suffix =3D 0
         while unacceptable('%s-%d' % (patchname, suffix)):
             suffix +=3D 1
