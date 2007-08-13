From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/4] Speed up the discovery of uninteresting commits
Date: Mon, 13 Aug 2007 23:01:25 +0200
Message-ID: <20070813210125.25929.80371.stgit@yoghurt>
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
	id 1IKh3A-000626-7K
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 23:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbXHMVBo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 17:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S971161AbXHMVBm
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 17:01:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3333 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967578AbXHMVB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 17:01:28 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IKh2T-0008PV-00; Mon, 13 Aug 2007 22:01:25 +0100
In-Reply-To: <20070813205801.25929.34925.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55782>

The operation of discovering uninteresting commits (that is, all the
commits that immediately precede a patch but don't have any patch
among their ancestors) is expensive. Make it less so, by using the
fact that we're done as soon as we've seen all patch commits.

This is probably less of a win than might be naively expected, since
we give the --topo-order flag to git-rev-list, which causes it to have
to read the full DAG to even start producing the output; but at least
we skip quite a bit of looping and set manipulation in Python, which
ought to be worth _something_.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 1b6808e..d3756d0 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -472,11 +472,17 @@ class UninterestingCache:
                 for p in parents:
                     if not p in interesting:
                         uninteresting.add(p)
-                continue
+
+                # If this is the last patch commit, there is no way we
+                # can encounter any more uninteresting commits.
+                patches.remove(commit)
+                if not patches:
+                    break
=20
             # Commits with interesting parents are interesting.
-            if interesting.intersection(parents):
+            elif interesting.intersection(parents):
                 interesting.add(commit)
+
         self.__uninteresting =3D uninteresting
         out.done()
     def create_patch(self, name, top, bottom):
