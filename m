From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH 4/4] Add sample pre-push hook script
Date: Fri, 28 Dec 2012 17:57:32 -0500
Message-ID: <1356735452-21667-5-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 23:58:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToisP-000114-4E
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 23:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab2L1W5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 17:57:48 -0500
Received: from pug.qqx.org ([50.116.43.67]:57405 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab2L1W5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 17:57:43 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 027981D2D5
	for <git@vger.kernel.org>; Fri, 28 Dec 2012 17:57:41 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 480af
	by zim.qqx.org (DragonFly Mail Agent);
	Fri, 28 Dec 2012 17:57:41 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212272>

Create a sample of a script for a pre-push hook.  The main purpose is to
illustrate how a script may parse the parameters which are supplied to
such a hook.  The script may also be useful to some people as-is for
avoiding to push commits which are marked as a work in progress.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 templates/hooks--pre-push.sample |   63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 templates/hooks--pre-push.sample

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
new file mode 100644
index 0000000..1d3b4a3
--- /dev/null
+++ b/templates/hooks--pre-push.sample
@@ -0,0 +1,63 @@
+#!/bin/sh
+
+# An example hook script to verify what is about to be pushed.
+# Called by "git push" after it has checked the remote status, but before
+# anything has been pushed.  If this script exits with a non-zero status
+# nothing will be pushed.
+#
+# This hook is called with the following parameters:
+#
+# $1 -- Name of the remote to which the push is being done
+# $2 -- URL to which the push is being done
+#
+#   If pushing without using a named remote those arguments will be equal.
+#
+# Further arguments provide information about the commits which are being
+# pushed in the form:
+#
+#   <local ref>:<local sha1>:<remote ref>:<remote sha1>
+#
+# This sample shows how to prevent push of commits where the log
+# message starts with "WIP" (work in progress).
+
+remote="$1"
+url="$2"
+shift 2
+
+z40=0000000000000000000000000000000000000000
+
+old_ifs="$IFS"
+for to_push in "$@"
+do
+	# Split the value into its parts
+	IFS=:
+	set -- $to_push
+	IFS="$old_ifs"
+
+	local_ref="$1"
+	local_sha="$2"
+	remote_ref="$3"
+	remote_sha="$4"
+
+	if [ "$local_sha" = $z40 ]
+	then
+		range=''
+		# Handle deletes
+	else
+		if [ "$remote_sha" = $z40 ]
+		then
+			range="$local_sha"
+		else
+			range="$remote_sha..$local_sha"
+		fi
+
+		commit=`git rev-list -n 1 --grep '^WIP' "$range"`
+		if [ -n "$commit" ]
+		then
+			echo "Found WIP commit in $local_ref, not pushing"
+			exit 1
+		fi
+	fi
+done
+
+exit 0
-- 
1.7.10.4
