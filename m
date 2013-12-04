From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 05/11] remote.c: add infrastructure to handle --prune=<pattern>
Date: Wed,  4 Dec 2013 06:44:44 +0100
Message-ID: <1386135890-13954-6-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:53:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5OX-0008BE-5z
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754415Ab3LDFxC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:53:02 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53414 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754321Ab3LDFw7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:52:59 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Dec 2013 00:52:59 EST
X-AuditID: 12074412-b7fc96d0000023d5-3f-529ec178ce48
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id FA.80.09173.871CE925; Wed,  4 Dec 2013 00:45:28 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCAA016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:27 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsUixO6iqFtxcF6QwfunlhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3xqWEJY8EymYr1C3kaGA+K
	dTFyckgImEgsmTyBCcIWk7hwbz1bFyMXh5DAZUaJw99vM0M455kkXi5qAKtiE9CVWNTTDGaL
	CIhLvD0+k72LkYODWSBC4tDbEhBTWMBXYukVVpAKFgFViXd71oPZvAIuEl/2/2aB2KUg0bnm
	PyOIzSngKtHRu4QZpFUIqObeWacJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6eVm
	luilppRuYoQEidAOxvUn5Q4xCnAwKvHwJnDOCxJiTSwrrsw9xCjJwaQkylu/HSjEl5SfUpmR
	WJwRX1Sak1p8iFGCg1lJhNemDCjHm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgm
	K8PBoSTBa3UAqFGwKDU9tSItM6cEIc3EwQkiuEA28ABtMAUp5C0uSMwtzkyHKDrFqCglzhsG
	khAASWSU5sENgMXzK0ZxoH+EeT1BqniAqQCu+xXQYCagweavZoEMLklESEk1MCpcDMhYbf3y
	RWhL+eW7vdcy99UlX1c1UprFPz+1Tppv/e/gHR9VpCdnyvoIeG09dEQuO3BKkMgq+yX1G04+
	O/r652nXndv21nLmub9ReLjCcXJv2POtt2wfxS6UbYxqWL9k7rLT7YeTTGY2Gj9VW7SXkeM3
	h8f1+Os1Mexvc9lr0z/+cz4uFa3EUpyRaKjFXFScCADkZAfVwgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238762>

This will soon be used to allow the user to tell what reference
namespaces should be subjected to pruning.  But since the callers of
these functions still use PARSE_OPT_NOARG, the new functionality is
not yet visible.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 35 +++++++++++++++++++++++++++++------
 remote.h | 11 +++++++----
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index 297e52f..89c9eaa 100644
--- a/remote.c
+++ b/remote.c
@@ -6,7 +6,6 @@
 #include "revision.h"
 #include "dir.h"
 #include "tag.h"
-#include "string-list.h"
 #include "argv-array.h"
 #include "mergesort.h"
 
@@ -64,9 +63,16 @@ int prune_option_parse(const struct option *opt, const char *arg, int unset)
 	struct prune_option *target = opt->value;
 
 	if (unset) {
+		if (arg) {
+			error("--no-prune must not be used with an argument");
+			return 1;
+		}
 		target->prune = 0;
+		string_list_clear(&target->prune_patterns, 0);
 	} else {
 		target->prune = 1;
+		if (arg)
+			string_list_append(&target->prune_patterns, arg);
 	}
 	return 0;
 }
@@ -104,20 +110,37 @@ void prune_option_fill(struct remote *remote,
 				prune_option->prune = default_prune;
 		}
 	}
+
+	if (prune_option->prune && !prune_option->prune_patterns.nr) {
+		/*
+		 * We want to prune, but no pruning patterns were
+		 * specified on the command line.  Default to "*".
+		 */
+		string_list_append(&prune_option->prune_patterns, "*");
+	}
 }
 
 void argv_push_prune_option(struct argv_array *argv,
 			    struct prune_option *prune_option)
 {
-	if (prune_option->prune != -1)
-		argv_array_pushf(argv,
-				 prune_option->prune
-				 ? "--prune"
-				 : "--no-prune");
+	if (prune_option->prune != -1) {
+		if (prune_option->prune && prune_option->prune_patterns.nr) {
+			struct string_list_item *item;
+
+			for_each_string_list_item(item, &prune_option->prune_patterns)
+				argv_array_pushf(argv, "--prune=%s", item->string);
+		} else {
+			argv_array_pushf(argv,
+					 prune_option->prune
+					 ? "--prune"
+					 : "--no-prune");
+		}
+	}
 }
 
 void prune_option_clear(struct prune_option *prune_option)
 {
+	string_list_clear(&prune_option->prune_patterns, 0);
 }
 
 static int valid_remote(const struct remote *remote)
diff --git a/remote.h b/remote.h
index 21ff4cb..a484290 100644
--- a/remote.h
+++ b/remote.h
@@ -2,6 +2,7 @@
 #define REMOTE_H
 
 #include "parse-options.h"
+#include "string-list.h"
 
 enum {
 	REMOTE_CONFIG,
@@ -53,15 +54,18 @@ struct remote {
 	char *http_proxy;
 };
 
-/* Structure to hold parsed --prune/--no-prune options */
+/* Structure to hold parsed --prune/--prune=<pattern>/--no-prune options */
 struct prune_option {
 	/* Should we prune at all?  -1 is indeterminate. */
 	int prune;
+
+	/* Arguments passed to --prune=<pattern> */
+	struct string_list prune_patterns;
 };
 
-#define PRUNE_OPTION_INIT { -1 }
+#define PRUNE_OPTION_INIT { -1, STRING_LIST_INIT_DUP }
 
-/* parse_opts() callback for --prune/--no-prune options */
+/* parse_opts() callback for --prune/--prune=<pattern>/--no-prune options */
 int prune_option_parse(const struct option *opt, const char *arg, int unset);
 
 /*
@@ -272,7 +276,6 @@ struct ref *guess_remote_head(const struct ref *head,
  * Return refs that no longer exist on remote and that match one of
  * the patterns.
  */
-struct string_list;
 struct ref *get_stale_heads(struct refspec *refs, int ref_count,
 			    struct ref *fetch_map,
 			    struct string_list *patterns);
-- 
1.8.4.3
