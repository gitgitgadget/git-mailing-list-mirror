From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2 (v2)] reset: make the output more user-friendly.
Date: Fri,  7 Aug 2009 22:24:36 +0200
Message-ID: <1249676676-5051-2-git-send-email-Matthieu.Moy@imag.fr>
References: <7vvdl0kau4.fsf@alter.siamese.dyndns.org>
 <1249676676-5051-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 07 22:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZVzw-0005Bg-0b
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933712AbZHGUY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933688AbZHGUY4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:24:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58244 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933687AbZHGUYz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:24:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n77KMcDc025218
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Aug 2009 22:22:38 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZVze-0007Pp-CX; Fri, 07 Aug 2009 22:24:50 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZVze-0004lI-BH; Fri, 07 Aug 2009 22:24:50 +0200
X-Mailer: git-send-email 1.6.4.62.g39c83.dirty
In-Reply-To: <1249676676-5051-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Aug 2009 22:22:38 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n77KMcDc025218
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250281358.56092@rNDe7CrcW5DjTeZTXqAfKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125217>

git reset without argument displays a summary of the remaining
unstaged changes. The problem with these is that they look like an
error message, and the format is inconsistant with the format used in
other places like "git diff --name-status".

This patch mimics the output of "git diff --name-status", and adds a
header to make it clear the output is informative, and not an error.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---

As noted by Junio, my previous version did actually display the header
unconditionnaly. This version displays it as the first change is found.

 read-cache.c     |   22 +++++++++++++++++-----
 t/t7102-reset.sh |    3 ++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index f1aff81..4a4f4a5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1065,6 +1065,15 @@ static struct cache_entry *refresh_cache_ent(struct index_state *istate,
 	return updated;
 }
 
+static void show_file(const char * fmt, const char * name, int in_porcelain, int * first)
+{
+	if (in_porcelain && *first) {
+		printf("Unstaged changes after reset:\n");
+		*first=0;
+	}
+	printf(fmt, name);
+}
+
 int refresh_index(struct index_state *istate, unsigned int flags, const char **pathspec, char *seen)
 {
 	int i;
@@ -1074,11 +1083,14 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	int quiet = (flags & REFRESH_QUIET) != 0;
 	int not_new = (flags & REFRESH_IGNORE_MISSING) != 0;
 	int ignore_submodules = (flags & REFRESH_IGNORE_SUBMODULES) != 0;
+	int first = 1;
+	int in_porcelain = (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options = really ? CE_MATCH_IGNORE_VALID : 0;
-	const char *needs_update_message;
+	const char *needs_update_fmt;
+	const char *needs_merge_fmt;
 
-	needs_update_message = ((flags & REFRESH_IN_PORCELAIN)
-				? "locally modified" : "needs update");
+	needs_update_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
+	needs_merge_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
@@ -1094,7 +1106,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			i--;
 			if (allow_unmerged)
 				continue;
-			printf("%s: needs merge\n", ce->name);
+			show_file(needs_merge_fmt, ce->name, in_porcelain, &first);
 			has_errors = 1;
 			continue;
 		}
@@ -1117,7 +1129,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			printf("%s: %s\n", ce->name, needs_update_message);
+			show_file(needs_update_fmt, ce->name, in_porcelain, &first);
 			has_errors = 1;
 			continue;
 		}
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index e637c7d..e85ff02 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -419,7 +419,8 @@ test_expect_success 'resetting an unmodified path is a no-op' '
 '
 
 cat > expect << EOF
-file2: locally modified
+Unstaged changes after reset:
+M	file2
 EOF
 
 test_expect_success '--mixed refreshes the index' '
-- 
1.6.4.62.g39c83.dirty
