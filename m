From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 10/10] Don't write a log entry if there were no changes
Date: Mon, 21 Apr 2008 00:11:18 +0200
Message-ID: <20080420221118.5837.38770.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:13:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnhmY-0008OC-Rk
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbYDTWM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbYDTWMZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:12:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3392 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbYDTWMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:12:25 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jnhki-00084U-00; Sun, 20 Apr 2008 23:11:16 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79999>

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
index 9904941..a18c80e 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -49,6 +49,9 @@ def log_entry(stack, msg):
         out.warn(str(e), 'No log entry written.')
         return
     log_tree =3D log_entry_tree(stack.repository, stack)
+    if len(last_log) =3D=3D 1 and log_tree =3D=3D last_log[0].full_log=
=2Edata.tree:
+        # No changes, so there's no point writing a new log entry.
+        return
     stack_log =3D stack.repository.commit(
         git.Commitdata(tree =3D log_tree, message =3D msg,
                        parents =3D [ll.stack_log for ll in last_log]))
