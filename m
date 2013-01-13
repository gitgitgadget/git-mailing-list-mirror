From: Aaron Schrab <aaron@schrab.com>
Subject: [PATCH v2 3/3] Add sample pre-push hook script
Date: Sun, 13 Jan 2013 00:17:04 -0500
Message-ID: <1358054224-7710-4-git-send-email-aaron@schrab.com>
References: <1358054224-7710-1-git-send-email-aaron@schrab.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 06:19:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuFyR-0003uZ-P9
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 06:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab3AMFSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 00:18:52 -0500
Received: from pug.qqx.org ([50.116.43.67]:36696 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab3AMFSv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 00:18:51 -0500
Received: from zim.qqx.org (cpe-107-015-024-243.nc.res.rr.com [107.15.24.243])
	by pug.qqx.org (Postfix) with ESMTPSA id 29BC81D0C0
	for <git@vger.kernel.org>; Sun, 13 Jan 2013 00:18:51 -0500 (EST)
Received: from ats (uid 1000)
	(envelope-from aaron@schrab.com)
	id 401f0
	by zim.qqx.org (DragonFly Mail Agent);
	Sun, 13 Jan 2013 00:18:50 -0500
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358054224-7710-1-git-send-email-aaron@schrab.com>
In-Reply-To: <1356735452-21667-1-git-send-email-aaron@schrab.com>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213334>

Create a sample of a script for a pre-push hook.  The main purpose is to
illustrate how a script may parse the information which is supplied to
such a hook.  The script may also be useful to some people as-is for
avoiding to push commits which are marked as a work in progress.

Signed-off-by: Aaron Schrab <aaron@schrab.com>
---
 templates/hooks--pre-push.sample | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 templates/hooks--pre-push.sample

diff --git a/templates/hooks--pre-push.sample b/templates/hooks--pre-push.sample
new file mode 100644
index 0000000..15ab6d8
--- /dev/null
+++ b/templates/hooks--pre-push.sample
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+# An example hook script to verify what is about to be pushed.  Called by "git
+# push" after it has checked the remote status, but before anything has been
+# pushed.  If this script exits with a non-zero status nothing will be pushed.
+#
+# This hook is called with the following parameters:
+#
+# $1 -- Name of the remote to which the push is being done
+# $2 -- URL to which the push is being done
+#
+# If pushing without using a named remote those arguments will be equal.
+#
+# Information about the commits which are being pushed is supplied as lines to
+# the standard input in the form:
+#
+#   <local ref> <local sha1> <remote ref> <remote sha1>
+#
+# This sample shows how to prevent push of commits where the log message starts
+# with "WIP" (work in progress).
+
+remote="$1"
+url="$2"
+
+z40=0000000000000000000000000000000000000000
+
+IFS=' '
+while read local_ref local_sha remote_ref remote_sha
+do
+	if [ "$local_sha" = $z40 ]
+	then
+		# Handle delete
+	else
+		if [ "$remote_sha" = $z40 ]
+		then
+			# New branch, examine all commits
+			range="$local_sha"
+		else
+			# Update to existing branch, examine new commits
+			range="$remote_sha..$local_sha"
+		fi
+
+		# Check for WIP commit
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
1.8.1.340.g425b78d
