From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-unbundle - unbundle objects and references for
 disconnected transfer.
Date: Wed, 14 Feb 2007 09:10:27 -0500
Message-ID: <11714622293142-git-send-email-mdl123@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 15:10:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHKqN-0002j3-0o
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:10:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbXBNOKh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbXBNOKh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:10:37 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:29195 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbXBNOKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:10:34 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDG00D3NI1CCRV2@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 08:10:25 -0600 (CST)
In-reply-to: <11714622292295-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39646>

Some workflows require coordinated development between repositories on
machines that can never be connected. This utility unpacks a bundle
containing objects and associated references (heads or tags) into the
current repository, effectively supporting git-push like operations
between disconnected systems.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 git-unbundle |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100755 git-unbundle

diff --git a/git-unbundle b/git-unbundle
new file mode 100755
index 0000000..5ea4ae6
--- /dev/null
+++ b/git-unbundle
@@ -0,0 +1,75 @@
+#!/bin/sh
+# unpack a git-bundle file into current repository
+#
+# See git-bundle.
+
+die() {
+	echo >&2 "$@"
+	exit 1
+}
+
+bfile=bundle.zip
+force=
+shallow=
+while case "$#" in 0) break ;; esac
+do
+	case "$1" in
+	--bare)
+		export GIT_DIR=.;;
+	-f|--f|--fo|--for|--forc|--force)
+		force=1;;
+	-h|--h|--he|--hel|--help)
+		echo "usage: git-unbundle [--bare] [-f|--force] [--shallow] [bundle (default is bundle.zip)]"
+		exit;;
+	-s|--s|--sh|--sha|--shal|--shall|--shallo|--shallow)
+		shallow=1;;
+	-*)
+		die "unknown option: $1";;
+	*)
+		bfile="$1";;
+	esac
+	shift
+done
+
+[ -e "$bfile" ] || die "cannot find $bfile"
+GIT_DIR=$(git-rev-parse --git-dir) || die "Not in a git directory"
+
+# get the objects
+unzip -p "$bfile" .gitBundlePack | git-unpack-objects
+
+# check each reference, assure that the result would be valid before updating local ref
+unzip -p "$bfile" .gitBundleReferences | while read sha1 ref ; do
+	if [ -z "$shallow" ] ; then
+		result=$(git fsck $sha1)
+		havemissing=$(echo "$result" | grep '^missing')
+	else
+		# accept a shallow transfer
+		havemissing=
+	fi
+	ok=
+	if [ ! -z "$havemissing" ] ; then
+		echo "Not updating: $ref to $sha1"
+		echo "Bundle does not contain all required objects. (possibly partial) errors:"
+		echo "$result" | head
+	elif [ -z "$force" ] ; then
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
1.5.0.rc3.24.g0c5e
