From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/4] contrib: add convert-grafts-to-replace-refs.sh
Date: Wed, 04 Jun 2014 21:43:52 +0200
Message-ID: <20140604194353.23903.58934.chriscool@tuxfamily.org>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 07:29:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsQEx-0007M1-2m
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 07:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbaFEF3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 01:29:06 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:48261 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaFEF3E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 01:29:04 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id E09B451;
	Thu,  5 Jun 2014 07:29:00 +0200 (CEST)
X-git-sha1: 2ad64b44b9f0729fffd62b51b6a6a2d2fac0b193 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140604194118.23903.3019.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250810>

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
index 0000000..8472879
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
+			die "Conversion failed for: $definition"
+	}
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
