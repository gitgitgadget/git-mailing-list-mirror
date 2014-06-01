From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/4] contrib: add convert-grafts-to-replace-refs.sh
Date: Sun, 01 Jun 2014 17:10:37 +0200
Message-ID: <20140601151038.15428.20661.chriscool@tuxfamily.org>
References: <20140601150409.15428.27017.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 17:11:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr7QK-0000O8-05
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 17:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbaFAPLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 11:11:39 -0400
Received: from [194.158.98.45] ([194.158.98.45]:33646 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752278AbaFAPLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 11:11:36 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id AE8236A;
	Sun,  1 Jun 2014 17:11:12 +0200 (CEST)
X-git-sha1: 11f8376673325afed9f18a194e795ac65d19c2bb 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140601150409.15428.27017.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250528>

This patch adds into contrib/ an example script to convert
grafts from an existing grafts file into replace refs using
the new --graft option of "git replace".

While at it let's mention this new script in the
"git replace" documentation for the --graft option.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt             |  4 +++-
 contrib/convert-grafts-to-replace-refs.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 contrib/convert-grafts-to-replace-refs.sh

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 491875e..e1be2e6 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -79,7 +79,9 @@ OPTIONS
 	content as <commit> except that its parents will be
 	[<parent>...] instead of <commit>'s parents. A replacement ref
 	is then created to replace <commit> with the newly created
-	commit.
+	commit. See contrib/convert-grafts-to-replace-refs.sh for an
+	example script based on this option that can convert grafts to
+	replace refs.
 
 -l <pattern>::
 --list <pattern>::
diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
new file mode 100755
index 0000000..7718a53
--- /dev/null
+++ b/contrib/convert-grafts-to-replace-refs.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+# You should execute this script in the repository where you
+# want to convert grafts to replace refs.
+
+die () {
+	echo >&2 "$@"
+	exit 1
+}
+
+GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
+
+test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
+
+grep '^[^# ]' "$GRAFTS_FILE" | while read definition
+do
+	test -n "$definition" && {
+		echo "Converting: $definition"
+		git replace --graft $definition ||
+			die "Convertion failed for: $definition"
+	}
+done
+
+mv "$GRAFTS_FILE" "$GRAFTS_FILE.bak" ||
+	die "Could not mv '$GRAFTS_FILE' to '$GRAFTS_FILE.bak'"
+
+echo "Success!"
+echo "All the grafts in '$GRAFTS_FILE' have been converted to replace refs!"
+echo "The grafts file '$GRAFTS_FILE' has been renamed: '$GRAFTS_FILE.bak'"
-- 
2.0.0.rc0.40.gd30ccc4
