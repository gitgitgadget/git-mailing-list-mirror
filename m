From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] More permissive "git-rm --cached" behavior without -f.
Date: Fri, 13 Jul 2007 19:41:38 +0200
Message-ID: <11843484982037-git-send-email-Matthieu.Moy@imag.fr>
References: <vpq8x9k9peu.fsf@bauges.imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 13 19:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9P9R-0002LP-Vp
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 19:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755117AbXGMRly (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 13:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbXGMRly
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 13:41:54 -0400
Received: from imag.imag.fr ([129.88.30.1]:37634 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512AbXGMRlx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 13:41:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6DHfcbl023441
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 13 Jul 2007 19:41:38 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I9P98-0004yr-Lw; Fri, 13 Jul 2007 19:41:38 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I9P98-0006kh-Hd; Fri, 13 Jul 2007 19:41:38 +0200
X-Mailer: git-send-email 1.5.3.rc1.4.gaf83-dirty
In-Reply-To: <vpq8x9k9peu.fsf@bauges.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 13 Jul 2007 19:41:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52405>

In the previous behavior, "git-rm --cached" (without -f) had the same
restriction as "git-rm". This forced the user to use the -f flag in
situations which weren't actually dangerous, like:

$ git add foo           # oops, I didn't want this
$ git rm --cached foo   # back to initial situation

Previously, the index had to match the file *and* the HEAD. With
--cached, the index must now match the file *or* the HEAD. The behavior
without --cached is unchanged, but provides better error messages.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-rm.txt |    3 ++-
 builtin-rm.c             |   32 ++++++++++++++++++++++++++------
 t/t3600-rm.sh            |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 78f45dc..be61a82 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -14,7 +14,8 @@ DESCRIPTION
 Remove files from the working tree and from the index.  The
 files have to be identical to the tip of the branch, and no
 updates to its contents must have been placed in the staging
-area (aka index).
+area (aka index).  When --cached is given, the staged content has to
+match either the tip of the branch *or* the file on disk.
 
 
 OPTIONS
diff --git a/builtin-rm.c b/builtin-rm.c
index 4a0bd93..9a808c1 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -46,7 +46,7 @@ static int remove_file(const char *name)
 	return ret;
 }
 
-static int check_local_mod(unsigned char *head)
+static int check_local_mod(unsigned char *head, int index_only)
 {
 	/* items in list are already sorted in the cache order,
 	 * so we could do this a lot more efficiently by using
@@ -65,6 +65,8 @@ static int check_local_mod(unsigned char *head)
 		const char *name = list.name[i];
 		unsigned char sha1[20];
 		unsigned mode;
+		int local_changes = 0;
+		int staged_changes = 0;
 
 		pos = cache_name_pos(name, strlen(name));
 		if (pos < 0)
@@ -87,14 +89,32 @@ static int check_local_mod(unsigned char *head)
 			continue;
 		}
 		if (ce_match_stat(ce, &st, 0))
-			errs = error("'%s' has local modifications "
-				     "(hint: try -f)", ce->name);
+			local_changes = 1;
 		if (no_head
 		     || get_tree_entry(head, name, sha1, &mode)
 		     || ce->ce_mode != create_ce_mode(mode)
 		     || hashcmp(ce->sha1, sha1))
-			errs = error("'%s' has changes staged in the index "
-				     "(hint: try -f)", name);
+			staged_changes = 1;
+
+		if (local_changes && staged_changes)
+			errs = error("'%s' has staged content different "
+				     "from both the file and the HEAD\n"
+				     "(use -f to force removal)", name);
+		else if (!index_only) {
+			/* It's not dangerous to git-rm --cached a
+			 * file if the index matches the file or the
+			 * HEAD, since it means the deleted content is
+			 * still available somewhere.
+			 */
+			if (staged_changes)
+				errs = error("'%s' has changes staged in the index\n"
+					     "(use --cached to keep the file, "
+					     "or -f to force removal)", name);
+			if (local_changes)
+				errs = error("'%s' has local modifications\n"
+					     "(use --cached to keep the file, "
+					     "or -f to force removal)", name);
+		}
 	}
 	return errs;
 }
@@ -192,7 +212,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		unsigned char sha1[20];
 		if (get_sha1("HEAD", sha1))
 			hashclr(sha1);
-		if (check_local_mod(sha1))
+		if (check_local_mod(sha1, index_only))
 			exit(1);
 	}
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 13a461f..5c001aa 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -46,6 +46,40 @@ test_expect_success \
     'git rm --cached foo'
 
 test_expect_success \
+    'Test that git rm --cached foo succeeds if the index matches the file' \
+    'echo content > foo
+     git add foo
+     git rm --cached foo'
+
+test_expect_success \
+    'Test that git rm --cached foo succeeds if the index matches the file' \
+    'echo content > foo
+     git add foo
+     git commit -m foo
+     echo "other content" > foo
+     git rm --cached foo'
+
+test_expect_failure \
+    'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' \
+    'echo content > foo
+     git add foo
+     git commit -m foo
+     echo "other content" > foo
+     git add foo
+     echo "yet another content" > foo
+     git rm --cached foo'
+
+test_expect_success \
+    'Test that git rm --cached -f foo works in case where --cached only did not' \
+    'echo content > foo
+     git add foo
+     git commit -m foo
+     echo "other content" > foo
+     git add foo
+     echo "yet another content" > foo
+     git rm --cached -f foo'
+
+test_expect_success \
     'Post-check that foo exists but is not in index after git rm foo' \
     '[ -f foo ] && ! git ls-files --error-unmatch foo'
 
-- 
1.5.3.rc1.4.gaf83-dirty
