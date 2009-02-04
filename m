From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 3/3] builtin-mv.c: check for unversionned files before looking at the destination.
Date: Wed,  4 Feb 2009 10:32:08 +0100
Message-ID: <1233739928-19895-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1233739928-19895-1-git-send-email-Matthieu.Moy@imag.fr>
 <1233739928-19895-2-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 04 10:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUeCX-0001sn-Ia
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:37:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbZBDJgV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZBDJgT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:36:19 -0500
Received: from harmonie.imag.fr ([147.171.130.40]:37592 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbZBDJgS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:36:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n149WNV0025106;
	Wed, 4 Feb 2009 10:32:23 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LUe77-0006SZ-20; Wed, 04 Feb 2009 10:32:09 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LUe76-0005BZ-Vv; Wed, 04 Feb 2009 10:32:08 +0100
X-Mailer: git-send-email 1.6.1.2.321.g68da9
In-Reply-To: <1233739928-19895-2-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 04 Feb 2009 10:32:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108327>

The previous code was failing in the case where one moves an
unversionned file to an existing destination, with mv -f: the
"existing destination" was checked first, and the error was cancelled
by the force flag.

We now check the unrecoverable error first, which fixes the bug.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 builtin-mv.c  |    8 ++++----
 t/t7001-mv.sh |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index bce9959..01270fe 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -162,7 +162,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				}
 				argc += last - first;
 			}
-		} else if (lstat(dst, &st) == 0) {
+		} else if (cache_name_pos(src, length) < 0)
+			bad = "not under version control";
+		else if (lstat(dst, &st) == 0) {
 			bad = "destination exists";
 			if (force) {
 				/*
@@ -177,9 +179,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				} else
 					bad = "Cannot overwrite";
 			}
-		} else if (cache_name_pos(src, length) < 0)
-			bad = "not under version control";
-		else if (string_list_has_string(&src_for_dst, dst))
+		} else if (string_list_has_string(&src_for_dst, dst))
 			bad = "multiple sources for the same target";
 		else
 			string_list_insert(dst, &src_for_dst);
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 52a47b5..8fb3a56 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -58,7 +58,7 @@ test_expect_success \
      test ! -f path0/untracked1 &&
      test ! -f path0/untracked2'
 
-test_expect_failure \
+test_expect_success \
     'checking -f on untracked file with existing target' \
     'touch path0/untracked1 &&
      git mv -f untracked1 path0
-- 
1.6.1.2.321.g68da9
