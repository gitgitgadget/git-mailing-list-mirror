From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/5] grep: remove global variable builtin_grep
Date: Thu, 07 May 2009 21:46:17 +0200
Message-ID: <1241725577.4772.10.camel@ubuntu.ubuntu-domain>
References: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 07 21:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29Yr-0003a2-4x
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755236AbZEGTqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758051AbZEGTqT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:46:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:37377 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbZEGTqS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:46:18 -0400
Received: from [10.0.1.101] (p57B7C554.dip.t-dialin.net [87.183.197.84])
	by india601.server4you.de (Postfix) with ESMTPSA id 8A1DC2F8003;
	Thu,  7 May 2009 21:46:18 +0200 (CEST)
In-Reply-To: <1241725380.4772.6.camel@ubuntu.ubuntu-domain>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118515>

Replace the only global variable in builtin-grep.c, builtin_grep, by a
local one and a function parameter with reversed meaning.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-grep.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index f88a912..620399f 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -20,8 +20,6 @@
 #endif
 #endif
 
-static int builtin_grep;
-
 static int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
@@ -432,7 +430,8 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 }
 #endif
 
-static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
+static int grep_cache(struct grep_opt *opt, const char **paths, int cached,
+		      int external_grep_allowed)
 {
 	int hit = 0;
 	int nr;
@@ -444,7 +443,7 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 	 * we grep through the checked-out files. It tends to
 	 * be a lot more optimized
 	 */
-	if (!cached && !builtin_grep) {
+	if (!cached && external_grep_allowed) {
 		hit = external_grep(opt, paths, cached);
 		if (hit >= 0)
 			return hit;
@@ -574,6 +573,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
 	int cached = 0;
+	int external_grep_allowed = 1;
 	int seen_dashdash = 0;
 	struct grep_opt opt;
 	struct object_array list = { 0, 0, NULL };
@@ -612,7 +612,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("--no-ext-grep", arg)) {
-			builtin_grep = 1;
+			external_grep_allowed = 0;
 			continue;
 		}
 		if (!strcmp("-a", arg) ||
@@ -823,7 +823,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (opt.color && !opt.color_external)
-		builtin_grep = 1;
+		external_grep_allowed = 0;
 	if (!opt.pattern_list)
 		die("no pattern given.");
 	if ((opt.regflags != REG_NEWLINE) && opt.fixed)
@@ -874,7 +874,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
-		return !grep_cache(&opt, paths, cached);
+		return !grep_cache(&opt, paths, cached, external_grep_allowed);
 	}
 
 	if (cached)
-- 
1.6.3
