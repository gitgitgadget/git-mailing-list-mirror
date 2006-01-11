From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] git-describe: Show HEAD by default.
Date: Wed, 11 Jan 2006 21:33:12 +0100 (CET)
Message-ID: <20060111203312.5FEF25BEBD@nox.op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 11 21:33:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewmej-0004vI-NF
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 21:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWAKUdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 15:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWAKUdO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 15:33:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:40864 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964826AbWAKUdN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 15:33:13 -0500
Received: from nox.op5.se (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 8966D6BD07
	for <git@vger.kernel.org>; Wed, 11 Jan 2006 21:33:12 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 5FEF25BEBD; Wed, 11 Jan 2006 21:33:12 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14511>

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 describe.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

b3c6fee2b1dda213fe8439da2c14189abab9bdf7
diff --git a/describe.c b/describe.c
index a0180f5..fda4102 100644
--- a/describe.c
+++ b/describe.c
@@ -98,11 +98,20 @@ static int compare_names(const void *_a,
 	return (a_date > b_date) ? -1 : (a_date == b_date) ? 0 : 1;
 }
 
-static void describe(struct commit *cmit)
+static void describe(const char *ref)
 {
 	struct commit_list *list;
 	static int initialized = 0;
 	struct commit_name *n;
+	unsigned char sha1[20];
+	struct commit *cmit;
+
+	if (get_sha1(ref, sha1) < 0)
+		usage(describe_usage);
+
+	cmit = lookup_commit_reference(sha1);
+	if (!cmit)
+		usage(describe_usage);
 
 	if (!initialized) {
 		initialized = 1;
@@ -132,12 +141,10 @@ static void describe(struct commit *cmit
 
 int main(int argc, char **argv)
 {
-	int i;
+	int i, desc = 0;
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		unsigned char sha1[20];
-		struct commit *cmit;
 
 		if (!strcmp(arg, "--all")) {
 			all = 1;
@@ -153,12 +160,12 @@ int main(int argc, char **argv)
 				abbrev = DEFAULT_ABBREV;
 			continue;
 		}
-		if (get_sha1(arg, sha1) < 0)
-			usage(describe_usage);
-		cmit = lookup_commit_reference(sha1);
-		if (!cmit)
-			usage(describe_usage);
-		describe(cmit);
+		describe(arg);
+		desc++;
 	}
+
+	if (!desc)
+		describe("HEAD");
+
 	return 0;
 }
-- 
1.1.0
