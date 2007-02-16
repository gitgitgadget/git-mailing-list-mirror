From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Fri, 16 Feb 2007 01:38:41 -0500
Message-ID: <11716079211954-git-send-email-mdl123@verizon.net>
References: <Pine.LNX.4.64.0702151838250.20368@woody.linux-foundation.org>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 07:39:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHwkI-0002hm-Qs
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 07:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbXBPGiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 01:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932972AbXBPGiv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 01:38:51 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:43897 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932964AbXBPGiu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 01:38:50 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms040.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ0045UMGH47G4@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 00:38:42 -0600 (CST)
In-reply-to: <Pine.LNX.4.64.0702151838250.20368@woody.linux-foundation.org>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39890>

Some workflows require coordinated development between repositories on
machines that can never be connected. This utility unpacks a bundle
containing objects and associated references (heads or tags) into the
current repository, effectively supporting git-push like operations
between disconnected systems.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 git-unbundle.sh |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100755 git-unbundle.sh

diff --git a/git-unbundle.sh b/git-unbundle.sh
new file mode 100755
index 0000000..c947f15
--- /dev/null
+++ b/git-unbundle.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+# unpack a git-bundle file into current repository
+#
+# See git-bundle.
+
+USAGE="usage: git-unbundle [-f|--force] [file]"
+SUBDIRECTORY_OK=1
+. git-sh-setup
+
+bfile=bundle.tar
+force=
+while case "$#" in 0) break ;; esac
+do
+    case "$1" in
+    -f|--f|--fo|--for|--forc|--force)
+        force=1;;
+    -h|--h|--he|--hel|--help)
+        usage;;
+    -*)
+        die "unknown option: $1";;
+    *)
+        bfile="$1";;
+    esac
+    shift
+done
+
+test -e "$bfile" || die "cannot find $bfile"
+
+# Get prereqs and refs in one go to avoid a third tar invocation.
+# Have a header line with version, prereqs, then references.
+references=$(tar -xf "$bfile" --to-stdout references)
+refdata=${references##v1*prerequisites}
+test "$references" = "$refdata" && die "This doesn't look like a v1 bundle file."
+prereqs="${refdata%%references*}"
+refs="${refdata#*references}"
+
+# make sure prerequisites are available
+test -n "$prereqs" && printf "%s\n" $prereqs | \
+    git-rev-list --stdin --not --all || exit 1
+
+# get the pack file
+tar -xf "$bfile" --to-stdout pack | git-index-pack --stdin || exit 1
+
+# check each reference, avoid non-fast forward update unless forced
+printf "%s %s\n" $refs | while read sha1 ref ; do
+    ok=
+    if test -z "$force" ; then
+        # update only if non-fastforward
+        local=$(git-rev-parse --verify "$ref^0" 2>/dev/null)
+        if test -n "$local"  ; then
+            mb=$(git-merge-base $local $sha1)
+            if test "$mb" != "$local" ; then
+                echo "Not applying non-fast forward update: $ref"
+            else
+                ok=1
+            fi
+        else
+            ok=1
+        fi
+    else
+        #forced, accept non-fast forward update
+        ok=1
+    fi
+    if test -n "$ok" ; then
+        echo "updating: $ref to $sha1"
+        git-update-ref -m "git-unbundle update" $ref $sha1
+    fi
+done
-- 
1.5.0.rc4.375.gd0938-dirty
