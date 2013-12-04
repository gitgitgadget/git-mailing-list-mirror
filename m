From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 02/11] remote.c: add infrastructure for parsing --prune options
Date: Wed,  4 Dec 2013 06:44:41 +0100
Message-ID: <1386135890-13954-3-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:45:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5H8-0003Lk-Se
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab3LDFp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:45:27 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47386 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751044Ab3LDFp0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:45:26 -0500
X-AuditID: 1207440e-b7fbc6d000004ad9-96-529ec175f80a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 51.20.19161.571CE925; Wed,  4 Dec 2013 00:45:25 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCA7016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:24 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsUixO6iqFt6cF6QwfZjEhZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3x6O1kloKJChVX2ntYGxgf
	S3YxcnJICJhITPl+lhnCFpO4cG89WxcjF4eQwGVGif89fUwQznkmieOTprKBVLEJ6Eos6mlm
	ArFFBMQl3h6fyd7FyMHBLBAhcehtCYgpLOArcX6iPEgFi4CqxKWvmxhBbF4BF4lVM7ezQexS
	kOhc8x8szingKtHRu4QZpFUIqObeWacJjLwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka
	6+VmluilppRuYoSECd8Oxvb1MocYBTgYlXh4EzjnBQmxJpYVV+YeYpTkYFIS5a3fDhTiS8pP
	qcxILM6ILyrNSS0+xCjBwawkwmtTBpTjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1I
	LYLJynBwKEnwWh0AahQsSk1PrUjLzClBSDNxcIIILpANPEAbTEEKeYsLEnOLM9Mhik4xKkqJ
	84aBJARAEhmleXADYBH9ilEc6B9hXl6QKh5gMoDrfgU0mAlosPmrWSCDSxIRUlINjJvOf6ma
	47m5/nn2efZd/5aunMlQsXdS7pFvcy0YOktm7rY9eOrXm3UX+GYr3pk+pUbp4/SDbyOrLNWn
	1eSlHZN8lG3DmJS6OOD4372XbL4+bH6xy6GZy+3qrteT3Q7vcShszHh6YdOilVUv5xqf5Poa
	kSb3aJ5MCmfEhIjgXTf5mw+kZnzeFOegxFKckWioxVxUnAgAaZTiCMMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238752>

For now, only handle --prune/--no-prune.  But handle the option via a
callback so that in the future --prune=PATTERN can be implemented.

The new functions are not yet used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 remote.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/remote.c b/remote.c
index 075ed71..297e52f 100644
--- a/remote.c
+++ b/remote.c
@@ -7,6 +7,7 @@
 #include "dir.h"
 #include "tag.h"
 #include "string-list.h"
+#include "argv-array.h"
 #include "mergesort.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
@@ -58,6 +59,67 @@ static struct rewrites rewrites_push;
 #define BUF_SIZE (2048)
 static char buffer[BUF_SIZE];
 
+int prune_option_parse(const struct option *opt, const char *arg, int unset)
+{
+	struct prune_option *target = opt->value;
+
+	if (unset) {
+		target->prune = 0;
+	} else {
+		target->prune = 1;
+	}
+	return 0;
+}
+
+static int git_fetch_config(const char *k, const char *v, void *cb)
+{
+	int *fetch_prune_config = cb;
+
+	if (!strcmp(k, "fetch.prune")) {
+		*fetch_prune_config = git_config_bool(k, v);
+		return 0;
+	}
+	return 0;
+}
+
+void prune_option_fill(struct remote *remote,
+		       struct prune_option *prune_option, int default_prune)
+{
+	if (prune_option->prune < 0) {
+		/*
+		 * The user specified neither --prune nor --no-prune;
+		 * use the configured value of remote.<name>.prune or
+		 * fetch.prune:
+		 */
+		if (remote->prune >= 0) {
+			prune_option->prune = remote->prune;
+		} else {
+			int fetch_prune_config = -1;
+
+			git_config(git_fetch_config, &fetch_prune_config);
+
+			if (fetch_prune_config >= 0)
+				prune_option->prune = fetch_prune_config;
+			else
+				prune_option->prune = default_prune;
+		}
+	}
+}
+
+void argv_push_prune_option(struct argv_array *argv,
+			    struct prune_option *prune_option)
+{
+	if (prune_option->prune != -1)
+		argv_array_pushf(argv,
+				 prune_option->prune
+				 ? "--prune"
+				 : "--no-prune");
+}
+
+void prune_option_clear(struct prune_option *prune_option)
+{
+}
+
 static int valid_remote(const struct remote *remote)
 {
 	return (!!remote->url) || (!!remote->foreign_vcs);
diff --git a/remote.h b/remote.h
index afa3792..21ff4cb 100644
--- a/remote.h
+++ b/remote.h
@@ -53,6 +53,40 @@ struct remote {
 	char *http_proxy;
 };
 
+/* Structure to hold parsed --prune/--no-prune options */
+struct prune_option {
+	/* Should we prune at all?  -1 is indeterminate. */
+	int prune;
+};
+
+#define PRUNE_OPTION_INIT { -1 }
+
+/* parse_opts() callback for --prune/--no-prune options */
+int prune_option_parse(const struct option *opt, const char *arg, int unset);
+
+/*
+ * Fill in prune_option for the specified remote, given the
+ * prune_option values parsed from the command-line.  default_prune
+ * specifies whether pruning should default to true or false if it has
+ * not been configured explicitly.
+ */
+void prune_option_fill(struct remote *remote,
+		       struct prune_option *prune_option, int default_prune);
+
+/*
+ * Add --prune/--prune=<pattern>/--no-prune options to the argv_array
+ * to represent the options in prune_options.
+ */
+struct argv_array;
+void argv_push_prune_option(struct argv_array *argv,
+			    struct prune_option *prune_option);
+
+/*
+ * Free any resources used by *prune_option (but not *prune_option
+ * itself).
+ */
+void prune_option_clear(struct prune_option *prune_option);
+
 struct remote *remote_get(const char *name);
 struct remote *pushremote_get(const char *name);
 int remote_is_configured(const char *name);
@@ -238,6 +272,7 @@ struct ref *guess_remote_head(const struct ref *head,
  * Return refs that no longer exist on remote and that match one of
  * the patterns.
  */
+struct string_list;
 struct ref *get_stale_heads(struct refspec *refs, int ref_count,
 			    struct ref *fetch_map,
 			    struct string_list *patterns);
-- 
1.8.4.3
