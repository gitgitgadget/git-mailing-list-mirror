From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 4/4] contrib: add convert-grafts-to-replace-refs.sh
Date: Fri, 06 Jun 2014 22:25:35 +0200
Message-ID: <20140606202536.3722.64861.chriscool@tuxfamily.org>
References: <20140606201741.3722.96819.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 08:44:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtAN6-0000bt-Pn
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 08:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbaFGGou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 02:44:50 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:59978 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbaFGGoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 02:44:46 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 2A66758;
	Sat,  7 Jun 2014 08:44:45 +0200 (CEST)
X-git-sha1: c4db80d64cf21c6cc381d792e78d2bbb705b7033 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140606201741.3722.96819.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251023>

This patch adds into contrib/ an example script to convert
grafts from an existing grafts file into replace refs using
the new --graft option of "git replace".

While at it let's mention this new script in the
"git replace" documentation for the --graft option.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
2.0.0.rc0.40.gd30ccc4
