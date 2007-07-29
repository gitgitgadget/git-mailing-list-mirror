From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 3/4] guilt-select: Select guards to apply when pushing patches
Date: Sun, 29 Jul 2007 00:50:17 -0700
Message-ID: <11856954182318-git-send-email-eclesh@ucla.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Sun Jul 29 09:50:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF3Xy-000795-HF
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760078AbXG2Huh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760079AbXG2Hug
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:50:36 -0400
Received: from smtp-1.smtp.ucla.edu ([169.232.46.136]:60934 "EHLO
	smtp-1.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760063AbXG2Hub (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:50:31 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.46.157])
	by smtp-1.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oNSe004762;
	Sun, 29 Jul 2007 00:50:23 -0700
Received: from localhost (adsl-75-26-192-134.dsl.scrm01.sbcglobal.net [75.26.192.134])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6T7oMTR019049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 00:50:23 -0700
Received: by localhost (Postfix, from userid 1000)
	id A9A711E80AA; Sun, 29 Jul 2007 00:50:18 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <118569541814-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.136
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54092>

guilt-select chooses guards that alter which patches will be applied
with a guilt-push.  The selected guards are stored in
.git/patches/$branch/guards.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 Documentation/guilt-select.txt |   42 ++++++++++++++++++++++++++++++++++++++++
 guilt                          |    1 +
 guilt-select                   |   36 ++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/guilt-select.txt
 create mode 100755 guilt-select

diff --git a/Documentation/guilt-select.txt b/Documentation/guilt-select.txt
new file mode 100644
index 0000000..8e18f26
--- /dev/null
+++ b/Documentation/guilt-select.txt
@@ -0,0 +1,42 @@
+guilt-select(1)
+===============
+
+NAME
+----
+guilt-select - Select guards to apply when pushing patches
+
+SYNOPSIS
+--------
+include::usage-guilt-select.txt[]
+
+DESCRIPTION
+-----------
+Select guards to apply when pushing patches.
+
+Guards are selected without the + or - prefix.  Patches are applied in
+the following way:
+
+An unguarded patch is always applied.
+
+A patch with a positive guard is applied *only* if the guard is
+selected with guilt-select.
+
+A patch with a negative guard is applied *unless* the guard is
+selected with guilt-select.
+
+OPTIONS
+-------
+-n|--none::
+        Remove all selected guards
+-s|--series::
+        List all guards listed in the series file
+
+Author
+------
+Written by Eric Lesh <eclesh@ucla.edu>
+
+Documentation
+-------------
+Documentation by Eric Lesh <eclesh@ucla.edu>
+
+include::footer.txt[]
diff --git a/guilt b/guilt
index b2767ea..3882962 100755
--- a/guilt
+++ b/guilt
@@ -641,6 +641,7 @@ fi
 # very useful files
 series="$GUILT_DIR/$branch/series"
 applied="$GUILT_DIR/$branch/status"
+guards_file="$GUILT_DIR/$branch/guards"
 
 # determine an editor to use for anything interactive (fall back to vi)
 editor="vi"
diff --git a/guilt-select b/guilt-select
new file mode 100755
index 0000000..f237ef0
--- /dev/null
+++ b/guilt-select
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# Copyright (c) Eric Lesh, 2007
+#
+
+USAGE="[-n|--none] [-s|--series] [<guard>]"
+ . `dirname $0`/guilt
+
+if [ $# == 0 ]; then
+	if [ -s "$guards_file" ]; then
+		cat "$guards_file"
+	else
+		echo "No guards applied"
+	fi
+	exit 0
+fi
+
+case $1 in
+	-n|--none)
+		rm -f "$guards_file"
+		touch "$guards_file"
+		;;
+	-s|--series)
+		(get_series | while read patch; do
+			get_guards "$patch"
+		done) | sed -e 's/ /\n/g' | sort | uniq
+		;;
+	*)
+		for x in "$@"; do
+			if [ $(echo $x | grep -e "^[+-]") ]; then
+				die "'$x' is not a valid guard name"
+			fi
+		done
+		echo "$@" | sed -e 's/ /\n/g' | sort | uniq > "$guards_file"
+		;;
+esac
-- 
1.5.2
