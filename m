From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 2/6] New contrib scripts: stg-dispatch and stg-show.
Date: Thu, 02 Aug 2007 22:18:21 +0200
Message-ID: <20070802201821.16614.87841.stgit@gandelf.nowhere.earth>
References: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 22:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGh9L-0007HH-K3
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 22:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759914AbXHBUT0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 16:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759407AbXHBUT0
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 16:19:26 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55063 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759901AbXHBUTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 16:19:25 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7B57F5A0B0;
	Thu,  2 Aug 2007 22:19:24 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 61A8359E3B;
	Thu,  2 Aug 2007 22:19:24 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 20AFC1F06F;
	Thu,  2 Aug 2007 22:18:21 +0200 (CEST)
In-Reply-To: <20070802200704.16614.57993.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54594>

From: Yann Dirson <yann.dirson@sagem.com>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 contrib/stg-dispatch |   34 ++++++++++++++++++++++++++++++++++
 contrib/stg-show     |   27 +++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/contrib/stg-dispatch b/contrib/stg-dispatch
new file mode 100755
index 0000000..8911946
--- /dev/null
+++ b/contrib/stg-dispatch
@@ -0,0 +1,34 @@
+#!/bin/sh
+set -e
+
+# stg-dispatch - percollates files matching a pattern down to another patch.
+# It does the same job as stg-fold-files-from (and makes use of it to
+# do so), but from the patch containing the changes to migrate,
+# instead of doing so from the target patch.
+
+# usage: stg-dispatch <topatch> [-#<n>[-<n>][,<n>]...] <file-pattern>
+
+# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+die()
+{
+    echo >&2 "$(basename $0) error: $*"
+    exit 1
+}
+
+TOPATCH="$1"
+shift
+
+stg applied | grep "^$TOPATCH\$" >/dev/null ||
+    die "cannot dispatch to unapplied patch '$TOPATCH'"
+
+CURRENTPATCH=$(stg top)
+
+[ "x$TOPATCH" != "x$CURRENTPATCH" ] ||
+    die "dispatching to current patch ($CURRENTPATCH) makes no sense"
+
+stg goto "$TOPATCH"
+stg-fold-files-from "$CURRENTPATCH" "$@"
+stg refresh
+stg goto "$CURRENTPATCH"
diff --git a/contrib/stg-show b/contrib/stg-show
new file mode 100755
index 0000000..8c61540
--- /dev/null
+++ b/contrib/stg-show
@@ -0,0 +1,27 @@
+#!/bin/bash
+set -e
+
+# stg-show - unlike "stg show", just "git show" with knowledge of stg refs
+
+# Ex:
+# stg-show --color-words -- files
+
+# Copyright (c) 2007 Yann Dirson <ydirson@altern.org>
+# Subject to the GNU GPL, version 2.
+
+command=(git show)
+
+# subsitute git id's for stg ones until --
+endofpatches=0
+while [ "$#" -gt 0 ]; do
+    case "$1" in
+	--) endofpatches=1; break ;;
+	-*) command+=("$1"); shift ;;
+	*) command+=( $(stg id "$1" 2>/dev/null || echo "$1") ); shift ;;
+    esac
+done
+
+# append remaining args
+command+=("$@")
+
+eval "${command[@]}"
