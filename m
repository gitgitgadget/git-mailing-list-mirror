From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 4/4] Find uninteresting commits faster for special cases
Date: Mon, 13 Aug 2007 23:01:42 +0200
Message-ID: <20070813210142.25929.66904.stgit@yoghurt>
References: <20070813205801.25929.34925.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:02:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKh3B-000626-2s
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 23:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S945797AbXHMVBx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 17:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030770AbXHMVBt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 17:01:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3342 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030449AbXHMVBp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 17:01:45 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IKh2l-0008QN-00; Mon, 13 Aug 2007 22:01:43 +0100
In-Reply-To: <20070813205801.25929.34925.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55783>

=46or the special cases of zero or one patch, the set of uninteresting
commits is very cheap to find.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index dbb27eb..b00a024 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -449,15 +449,27 @@ class UninterestingCache:
         self.__compute_uninteresting()
         self.__write_file()
     def __compute_uninteresting(self):
-        """Compute a reasonable set of uninteresting commits from
-        scratch. This is expensive."""
-        out.start('Finding uninteresting commits')
+        """Compute the set of uninteresting commits from scratch. This
+        is expensive in the general case; therefore, we print a
+        message to the user."""
         ref2hash =3D read_refs(self.__series.get_name())
         patches =3D Set([sha1 for ref, sha1 in ref2hash.iteritems() if=
 ref])
-        interesting, uninteresting =3D Set(), Set()
+
+        # Optimize some important special cases.
+        if len(patches) =3D=3D 0:
+            self.__uninteresting =3D Set()
+            return
+        elif len(patches) =3D=3D 1:
+            patch =3D iter(patches).next()
+            commit, parent =3D git._output_one_line(
+                'git-rev-list --parents %s' % patch).split()
+            self.__uninteresting =3D Set([parent])
+            return
=20
         # Iterate over all commits. We are guaranteed to see each
         # commit before any of its children.
+        out.start('Finding uninteresting commits')
+        interesting, uninteresting =3D Set(), Set()
         for line in git._output_lines(
             'git-rev-list --topo-order --reverse --parents --stdin',
             ['%s\n' % p for p in patches]):
@@ -483,7 +495,6 @@ class UninterestingCache:
             # Commits with interesting parents are interesting.
             elif interesting.intersection(parents):
                 interesting.add(commit)
-
         self.__uninteresting =3D uninteresting
         out.done()
     def create_patch(self, name, top, bottom, new_commit):
@@ -496,6 +507,13 @@ class UninterestingCache:
         if not self.__cache_file():
             return # not cached
=20
+        # If there are no existing uninteresting commits, this is the
+        # first patch, so its bottom has to be uninteresting.
+        if not self.__uninteresting:
+            self.__uninteresting.add(bottom)
+            self.__write_file()
+            return
+
         # New patch inserted just below an existing bottommost patch:
         # need to move the uninteresting commit down one step.
         if top in self.__uninteresting:
