From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/5] If any uncommit would fail, don't uncommit anything
Date: Fri, 11 May 2007 03:40:22 +0200
Message-ID: <20070511014021.13161.60939.stgit@yoghurt>
References: <20070511013400.13161.9160.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 03:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKFf-0005Wy-Gn
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758039AbXEKBs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 21:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757654AbXEKBs4
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:48:56 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:41909 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758023AbXEKBsz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 21:48:55 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38577 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HmKEU-00082E-8L; Fri, 11 May 2007 03:47:49 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HmK7K-0003Tc-7J; Fri, 11 May 2007 03:40:22 +0200
In-Reply-To: <20070511013400.13161.9160.stgit@yoghurt>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HmKEU-00082E-8L.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HmKEU-00082E-8L 19b0e07ff1c6f055bb61e9e31dd9f7ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46926>

=46rom: Karl Hasselstr=C3=B6m <kha@treskal.com>



Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/uncommit.py |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 04c7e52..f86af57 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -80,23 +80,26 @@ def func(parser, options, args):
     print 'Uncommitting %d patches...' % patch_nr,
     sys.stdout.flush()
=20
-    for n in xrange(0, patch_nr):
-        # retrieve the commit (only commits with a single parent are a=
llowed)
-        commit_id =3D crt_series.get_base()
+    def get_commit(commit_id):
         commit =3D git.Commit(commit_id)
         try:
             parent, =3D commit.get_parents()
         except ValueError:
-            raise CmdException, 'Commit %s does not have exactly one p=
arent' \
-                  % commit_id
+            raise CmdException('Commit %s does not have exactly one pa=
rent'
+                               % commit_id)
+        return (commit, commit_id, parent)
+
+    commits =3D []
+    next_commit =3D crt_series.get_base()
+    for i in xrange(patch_nr):
+        commit, commit_id, parent =3D get_commit(next_commit)
+        commits.append((commit, commit_id, parent))
+        next_commit =3D parent
+
+    for (commit, commit_id, parent), patchname in \
+        zip(commits, patchnames or (None for i in xrange(len(commits))=
)):
         author_name, author_email, author_date =3D \
                      name_email_date(commit.get_author())
-
-        if patchnames:
-            patchname =3D patchnames[n]
-        else:
-            patchname =3D None
-
         crt_series.new_patch(patchname,
                              can_edit =3D False, before_existing =3D T=
rue,
                              top =3D commit_id, bottom =3D parent,
@@ -105,4 +108,5 @@ def func(parser, options, args):
                              author_email =3D author_email,
                              author_date =3D author_date)
=20
+
     print 'done'
