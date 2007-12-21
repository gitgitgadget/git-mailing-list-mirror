From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] git-describe: Add a --match option to limit considered tags.
Date: Fri, 21 Dec 2007 17:18:20 +0100
Message-ID: <1198253900-31502-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Dec 21 17:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5kaJ-0001jM-Qb
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 17:18:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbXLUQSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 11:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbXLUQSY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 11:18:24 -0500
Received: from pan.madism.org ([88.191.52.104]:44892 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbXLUQSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 11:18:23 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D271C1B5C2;
	Fri, 21 Dec 2007 17:18:21 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id E66984C14; Fri, 21 Dec 2007 17:18:20 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc1.1096.gde4c4-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69070>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/git-describe.txt |    4 ++++
 builtin-describe.c             |   11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index ac23e28..cb869e9 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -51,6 +51,10 @@ OPTIONS
 	being employed to standard error.  The tag name will still
 	be printed to standard out.
 
+--match <pattern>::
+        Only consider tags matching the given pattern (can be used to avoid
+        leaking private tags made from the repository).
+
 EXAMPLES
 --------
 
diff --git a/builtin-describe.c b/builtin-describe.c
index 7a148a2..982a355 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -19,6 +19,7 @@ static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
+const char *pattern = NULL;
 
 struct commit_name {
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
@@ -57,9 +58,11 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	 * Otherwise only annotated tags are used.
 	 */
 	if (!prefixcmp(path, "refs/tags/")) {
-		if (object->type == OBJ_TAG)
+		if (object->type == OBJ_TAG) {
 			prio = 2;
-		else
+			if (pattern && fnmatch(pattern, path + 10, 0))
+				prio = 0;
+		} else
 			prio = 1;
 	}
 	else
@@ -253,7 +256,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "tags",       &tags, "use any tag in .git/refs/tags"),
 		OPT__ABBREV(&abbrev),
 		OPT_INTEGER(0, "candidates", &max_candidates,
-					"consider <n> most recent tags (default: 10)"),
+		            "consider <n> most recent tags (default: 10)"),
+		OPT_STRING(0, "match",       &pattern, "pattern",
+		           "only consider tags matching <pattern>"),
 		OPT_END(),
 	};
 
-- 
1.5.4.rc1.1096.gde4c4-dirty
