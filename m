From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 4/7] parse-options: let OPT__ABBREV ignore arguments.
Date: Mon, 17 Dec 2007 19:23:14 +0100
Message-ID: <1197915797-30679-5-git-send-email-madcoder@debian.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
 <1197915797-30679-2-git-send-email-madcoder@debian.org>
 <1197915797-30679-3-git-send-email-madcoder@debian.org>
 <1197915797-30679-4-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:25:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdQ-0003yo-Vg
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756410AbXLQSXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756652AbXLQSXW
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:22 -0500
Received: from pan.madism.org ([88.191.52.104]:54939 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756314AbXLQSXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:19 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 72CE230959;
	Mon, 17 Dec 2007 19:23:18 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2CB834BF5A5; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
In-Reply-To: <1197915797-30679-4-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68589>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index f3f0f2a..679a963 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -359,19 +359,21 @@ void usage_with_options(const char * const *usagestr,
 
 int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int flags)
 {
-	int v;
-
-	if (!arg) {
-		v = flags & PARSE_OPT_UNSET ? 0 : DEFAULT_ABBREV;
-	} else {
+	int v = flags & PARSE_OPT_UNSET ? 0 : DEFAULT_ABBREV;
+	if (arg) {
 		v = strtol(arg, (char **)&arg, 10);
-		if (*arg)
+		if (*arg) {
+			if (flags & PARSE_OPT_MAY_IGN) {
+				*(int *)opt->value = DEFAULT_ABBREV;
+				return PARSE_OPT_IGNORE;
+			}
 			return opterror(opt, "expects a numerical value", 0);
+		}
 		if (v && v < MINIMUM_ABBREV)
 			v = MINIMUM_ABBREV;
 		else if (v > 40)
 			v = 40;
 	}
-	*(int *)(opt->value) = v;
+	*(int *)opt->value = v;
 	return 0;
 }
-- 
1.5.4.rc0.1148.ga3ab1-dirty
