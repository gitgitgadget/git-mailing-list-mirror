From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 4/7] contrib: add convert-grafts-to-replace-refs.sh
Date: Sat, 28 Jun 2014 20:11:13 +0200
Message-ID: <20140628181117.5687.16837.chriscool@tuxfamily.org>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 20:20:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0xEW-0007lL-HT
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jun 2014 20:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbaF1STu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2014 14:19:50 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:52623 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756035AbaF1STr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2014 14:19:47 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 868EAD3;
	Sat, 28 Jun 2014 20:19:46 +0200 (CEST)
X-git-sha1: 7b1bbefe6f8c7b8fe3ef60bce2a3060d1fc95874 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140628171731.5687.30308.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252615>

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
