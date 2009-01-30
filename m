From: Geoffrey Thomas <geofft@MIT.EDU>
Subject: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Fri, 30 Jan 2009 04:41:29 -0500
Message-ID: <1233308489-2656-2-git-send-email-geofft@mit.edu>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu>
Cc: Geoffrey Thomas <geofft@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 10:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSptu-0006Oc-EF
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 10:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbZA3Jlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 04:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753119AbZA3Jlg
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 04:41:36 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44861 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464AbZA3Jle (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 04:41:34 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n0U9fUC4003016;
	Fri, 30 Jan 2009 04:41:30 -0500 (EST)
Received: from localhost (VINEGAR-POT.MIT.EDU [18.181.0.51])
	(authenticated bits=0)
        (User authenticated as geofft@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n0U9fUd7005564;
	Fri, 30 Jan 2009 04:41:30 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.255.g2979d
In-Reply-To: <1233308489-2656-1-git-send-email-geofft@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107784>

From: Geoffrey Thomas <geofft@mit.edu>
git blame misaligns output if a author's name has a differing display width and
strlen; for instance, an accented Latin letter that takes two bytes to encode
will cause the rest of the line to be shifted to the left by one. To fix this,
use utf8_strwidth instead of strlen (and compute the padding ourselves, since
printf doesn't know about UTF-8).

Signed-off-by: Geoffrey Thomas <geofft@mit.edu>
---
 builtin-blame.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index aae14ef..2941fc0 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -19,6 +19,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "parse-options.h"
+#include "utf8.h"
 
 static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
 
@@ -1619,9 +1620,9 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 				       ent->s_lno + 1 + cnt);
 
 			if (!(opt & OUTPUT_NO_AUTHOR))
-				printf(" (%-*.*s %10s",
-				       longest_author, longest_author,
+				printf(" (%s%*s %10s",
 				       ci.author,
+				       longest_author - utf8_strwidth(ci.author), "",
 				       format_time(ci.author_time,
 						   ci.author_tz,
 						   show_raw_time));
@@ -1755,7 +1756,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
-			num = strlen(ci.author);
+			num = utf8_strwidth(ci.author);
 			if (longest_author < num)
 				longest_author = num;
 		}
-- 
1.5.6.5
