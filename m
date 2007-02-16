From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Add git-unbundle - unpack objects and references for
 disconnected transfer
Date: Thu, 15 Feb 2007 19:19:53 -0500
Message-ID: <11715851973802-git-send-email-mdl123@verizon.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
 <11715851972838-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 01:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqpj-0000rW-Ds
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbXBPAUE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbXBPAUE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:20:04 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:39631 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422769AbXBPAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:20:03 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00A094X94RQ1@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:19:58 -0600 (CST)
In-reply-to: <11715851972838-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39868>

Some workflows require coordinated development between repositories on
machines that can never be connected. This utility unpacks a bundle
containing objects and associated references (heads or tags) into the
current repository, effectively supporting git-push like operations
between disconnected systems.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 git-unbundle.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100755 git-unbundle.sh

diff --git a/git-unbundle.sh b/git-unbundle.sh
new file mode 100755
index 0000000..ca13305
--- /dev/null
+++ b/git-unbundle.sh
@@ -0,0 +1,67 @@
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
+	case "$1" in
+	-f|--f|--fo|--for|--forc|--force)
+		force=1;;
+	-h|--h|--he|--hel|--help)
+		usage;;
+	-*)
+		die "unknown option: $1";;
+	*)
+		bfile="$1";;
+	esac
+	shift
+done
+
+[ -e "$bfile" ] || die "cannot find $bfile"
+
+# Get prereqs and refs in one go to avoid a third tar invocation.
+# Prereqs come first, are separated by a single - from the actual refs.
+refdata=$(tar -f "$bfile" -x --to-stdout  .gitBundleReferences)
+prereqs="${refdata%%-*}"
+refs="${refdata#*-}"
+
+# check that the prerequisites exist before unbundling.
+for sha1 in $prereqs ; do
+	git-rev-parse --verify $sha1 >& /dev/null || die "Prerequisite commit $sha1 not found."
+done
+
+# get the objects, maybe repack
+tar -f "$bfile" -x --to-stdout .gitBundlePack | git-index-pack --stdin
+
+# check each reference, assure that the result would be valid before updating local ref
+printf "%s %s\n" $refs | while read sha1 ref ; do
+	ok=
+	if [ -z "$force" ] ; then
+		# update only if non-fastforward
+		local=$(git-rev-parse --verify "$ref^0" 2>/dev/null)
+		if [ ! -z "$local" ] ; then
+			mb=$(git-merge-base $local $sha1)
+			if [ "$mb" != "$local" ] ; then
+				echo "Not applying non-fast forward update: $ref"
+			else
+				ok=1
+			fi
+		else
+			ok=1
+		fi
+	else
+		#forced, accept non-fast forward update
+		ok=1
+	fi
+	if [ ! -z "$ok" ] ; then
+		echo "updating: $ref to $sha1"
+		git-update-ref -m "git-unbundle update" $ref $sha1
+	fi
+done
-- 
1.5.0.34.g6afaa
