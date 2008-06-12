From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 09/14] Don't write a log entry if there were no changes
Date: Thu, 12 Jun 2008 07:35:02 +0200
Message-ID: <20080612053502.23549.64988.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fTz-000594-7a
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbYFLFfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYFLFfS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:35:18 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2175 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYFLFfO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:35:14 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fSg-00015j-00; Thu, 12 Jun 2008 06:35:03 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84712>

Some commands end up calling log_entry() without verifying that they
did in fact change anything. (One example of this is a conflicting
push, which will log two entries, everything else and the conflicting
push, with the "everything else" part being empty if there was only
one patch to push.) So before appending to the log, make sure that the
entry we're appending isn't a no-op.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/log.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index 920c261..3aec6e7 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -164,6 +164,9 @@ def log_entry(stack, msg):
         out.warn(str(e), 'No log entry written.')
         return
     full_log_tree, short_log_tree =3D log_entry_trees(stack.repository=
, stack)
+    if len(last_log) =3D=3D 1 and full_log_tree =3D=3D last_log[0].ful=
l_log.data.tree:
+        # No changes, so there's no point writing a new log entry.
+        return
     stack_log =3D stack.repository.commit(
         git.CommitData(tree =3D short_log_tree, message =3D msg,
                        parents =3D [ll.stack_log for ll in last_log]))
