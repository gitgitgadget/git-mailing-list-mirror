From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] More regressions fixes.
Date: Thu, 14 Jun 2007 17:50:54 +0200
Message-ID: <11818362542177-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 17:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyrbX-0007UR-B3
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 17:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbXFNPu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 11:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbXFNPu4
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 11:50:56 -0400
Received: from pan.madism.org ([88.191.52.104]:37449 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbXFNPuz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 11:50:55 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B0D0BDB16;
	Thu, 14 Jun 2007 17:50:54 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4CA301048; Thu, 14 Jun 2007 17:50:54 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50210>

  + use awk again to parse git-cat-file properly
  + fixes .new -> .tmp (always use the same suffix to avoid problems)
  + write in foo.tmp and move it, and not the reverse :)

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/guilt b/guilt
index 58df606..7c78cc7 100755
--- a/guilt
+++ b/guilt
@@ -177,16 +177,22 @@ do_make_header()
 		exit 2
 	fi
 
-	git-cat-file -p "$1" | sed -e \
-		'1,/^$/ {
-			/^author/ {
-				s/^author /From: /
-				s/ [0-9]* [+-]*[0-9][0-9]*$//
-				p
+	git-cat-file -p "$1" | awk '
+		BEGIN{headers=1; firstline=1}
+		/^author / && headers {
+			sub(/^author +/, "");
+			sub(/ [0-9]* [+-]*[0-9][0-9]*$/, "");
+			author=$0
+		}
+		!headers {
+			print
+			if (firstline) {
+				firstline = 0;
+				print "\nFrom: " author;
 			}
-			/^$/p
-			d
-		}'
+		}
+		/^$/ && headers { headers = 0 }
+	'
 }
 
 # usage: do_get_header patchfile
@@ -267,7 +273,7 @@ series_rename_patch()
 {
 	awk -v old="$1" -v new="$2" \
 		'{ if ($0 == old) print new; else print $0 }' \
-		"$series.tmp" > "$series"
+		"$series" > "$series.tmp"
 
 	mv "$series.tmp" "$series"
 }
@@ -284,7 +290,7 @@ applied_rename_patch()
 				print substr($0, 0, 41) new;
 			else
 				print;
-			}' "$applied" > "$applied.new"
+			}' "$applied" > "$applied.tmp"
 
 	mv "$applied.tmp" "$applied"
 }
-- 
1.5.2.1
