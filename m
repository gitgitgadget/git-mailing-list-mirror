From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT RFC PATCH] Add contrib/stg-k script.
Date: Thu, 31 May 2007 20:54:29 +0200
Message-ID: <20070531184957.16258.55617.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 20:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtppS-0008Pp-56
	for gcvg-git@gmane.org; Thu, 31 May 2007 20:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998AbXEaS4t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 14:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757016AbXEaS4t
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 14:56:49 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:32999 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111AbXEaS4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 14:56:48 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BA8A95A2D2;
	Thu, 31 May 2007 20:56:41 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 9AF041F157;
	Thu, 31 May 2007 20:54:29 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48815>


Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This patch mainly adds a contrib script that allows to execute given
StGIT command while preserving local changes.  It is surely not
fool-proof in itself yet.

It relies on another small script which removes the current patch from
the stack, keeping its contents as uncommitted changes.  I named it
"stg-unnew" because under a very particular angle it may look like
reversing the "stg new" operation - but I'm highly dissatisfied with
that name, and would gladly accept any sensible suggestion to rename
it :)

 contrib/stg-k     |   32 ++++++++++++++++++++++++++++++++
 contrib/stg-unnew |   15 +++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-k b/contrib/stg-k
new file mode 100755
index 0000000..0134c25
--- /dev/null
+++ b/contrib/stg-k
@@ -0,0 +1,32 @@
+#!/bin/sh
+set -e
+
+# stg-k - execute given StGIT command while preserving local changes
+
+# Uses a temporary patch to save local changes, then execute the given
+# command, and restore local changes from the saved patch.  In
+# essence, "stg-k pop" is a "stg pop -k" that works better, hence its
+# name.
+
+# CAVEAT: this script relies on the operation to run ignoring hidden
+# patches, so in 0.12 (where "stg push" can push an hidden patch)
+# "stg-k push" will fail midway, albeit with no information loss -
+# you'll just have to finish manually.  Luckilly this appears to work
+# on master branch.
+
+# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+stg new __local -m " - local changes (internal patch)"
+stg refresh
+stg pop
+
+# avoid bad interactions like "stg-k push" not behaving as expected
+stg hide __local
+
+stg "$@"
+
+stg unhide __local
+
+stg push __local
+stg-unnew
diff --git a/contrib/stg-unnew b/contrib/stg-unnew
new file mode 100755
index 0000000..5ac8781
--- /dev/null
+++ b/contrib/stg-unnew
@@ -0,0 +1,15 @@
+#!/bin/sh
+set -e
+
+# stg-unnew - sort of "reverse an 'stg new'"
+
+# Remove the current patch from the stack, keeping its contents as
+# uncommitted changes.
+
+# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+patch=$(stg top)
+stg pop
+stg pick --fold $patch
+stg delete $patch
