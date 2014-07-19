From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v7 5/9] contrib: add convert-grafts-to-replace-refs.sh
Date: Sat, 19 Jul 2014 17:01:11 +0200
Message-ID: <20140719150116.9564.16002.chriscool@tuxfamily.org>
References: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 17:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Wlz-00087f-GJ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jul 2014 17:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755429AbaGSPlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2014 11:41:51 -0400
Received: from [194.158.98.45] ([194.158.98.45]:40951 "EHLO mail-3y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754928AbaGSPlr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2014 11:41:47 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id D353677;
	Sat, 19 Jul 2014 17:41:25 +0200 (CEST)
X-git-sha1: 6710de7a28286a63a1abe71134b0da2a6d790d44 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140719145951.9564.61331.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253884>

This patch adds into contrib/ an example script to convert
grafts from an existing grafts file into replace refs using
the new --graft option of "git replace".

While at it let's mention this new script in the
"git replace" documentation for the --graft option.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-replace.txt             |  4 +++-
 contrib/convert-grafts-to-replace-refs.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
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
index 0000000..0cbc917
--- /dev/null
+++ b/contrib/convert-grafts-to-replace-refs.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+# You should execute this script in the repository where you
+# want to convert grafts to replace refs.
+
+GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
+
+. $(git --exec-path)/git-sh-setup
+
+test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
+
+grep '^[^# ]' "$GRAFTS_FILE" |
+while read definition
+do
+	if test -n "$definition"
+	then
+		echo "Converting: $definition"
+		git replace --graft $definition ||
+			die "Conversion failed for: $definition"
+	fi
+done
+
+mv "$GRAFTS_FILE" "$GRAFTS_FILE.bak" ||
+	die "Could not rename '$GRAFTS_FILE' to '$GRAFTS_FILE.bak'"
+
+echo "Success!"
+echo "All the grafts in '$GRAFTS_FILE' have been converted to replace refs!"
+echo "The grafts file '$GRAFTS_FILE' has been renamed: '$GRAFTS_FILE.bak'"
-- 
2.0.0.421.g786a89d.dirty
