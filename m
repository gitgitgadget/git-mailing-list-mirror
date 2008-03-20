From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/6] Make sure that we only uncommit commits with
	exactly one parent
Date: Thu, 20 Mar 2008 01:31:51 +0100
Message-ID: <20080320003151.13102.44813.stgit@yoghurt>
References: <20080320002604.13102.53757.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 01:32:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc8iC-0006sd-L9
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 01:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163274AbYCTAb7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 20:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763870AbYCTAb6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 20:31:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2858 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761904AbYCTAb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 20:31:56 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jc8hC-0004sb-00; Thu, 20 Mar 2008 00:31:50 +0000
In-Reply-To: <20080320002604.13102.53757.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77596>

If we encounter a commit with 0, or 2 or more parents, fail with a
nice error message instead of crashing.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/uncommit.py |   14 ++++++++++++--
 t/t1300-uncommit.sh        |    2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)


diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 933ec60..272c5db 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -85,13 +85,23 @@ def func(parser, options, args):
         patchnames =3D args
         patch_nr =3D len(patchnames)
=20
+    def get_parent(c):
+        next =3D c.data.parents
+        try:
+            [next] =3D next
+        except ValueError:
+            raise common.CmdException(
+                'Trying to uncommit %s, which does not have exactly on=
e parent'
+                % c.sha1)
+        return next
+
     commits =3D []
     next_commit =3D stack.base
     if patch_nr:
         out.start('Uncommitting %d patches' % patch_nr)
         for i in xrange(patch_nr):
             commits.append(next_commit)
-            next_commit =3D next_commit.data.parent
+            next_commit =3D get_parent(next_commit)
     else:
         if options.exclusive:
             out.start('Uncommitting to %s (exclusive)' % to_commit)
@@ -103,7 +113,7 @@ def func(parser, options, args):
                     commits.append(next_commit)
                 break
             commits.append(next_commit)
-            next_commit =3D next_commit.data.parent
+            next_commit =3D get_parent(next_commit)
         patch_nr =3D len(commits)
=20
     taken_names =3D set(stack.patchorder.applied + stack.patchorder.un=
applied)
diff --git a/t/t1300-uncommit.sh b/t/t1300-uncommit.sh
index 0d952a7..a906d13 100755
--- a/t/t1300-uncommit.sh
+++ b/t/t1300-uncommit.sh
@@ -78,7 +78,7 @@ test_expect_success \
     stg commit --all
 '
=20
-test_expect_failure 'Uncommit a commit with not precisely one parent' =
'
+test_expect_success 'Uncommit a commit with not precisely one parent' =
'
     stg uncommit -n 5 ; [ $? =3D 2 ] &&
     [ "$(echo $(stg series))" =3D "" ]
 '
