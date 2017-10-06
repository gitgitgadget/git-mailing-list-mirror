Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E862E20372
	for <e@80x24.org>; Fri,  6 Oct 2017 22:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751850AbdJFWfM (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 18:35:12 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:46826 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdJFWfM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 18:35:12 -0400
Received: from [89.246.212.34] (helo=sandbox)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e0bD4-0006O3-LL; Sat, 07 Oct 2017 00:35:10 +0200
Date:   Sat, 7 Oct 2017 00:35:09 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com
Subject: [RFC PATCH v3 4/4] submodule: simplify decision tree whether to or
 not to fetch
Message-ID: <20171006223509.GE26642@sandbox>
References: <20171006222544.GA26642@sandbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171006222544.GA26642@sandbox>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make extending this logic later easier.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

This should also be the same as in the previous version.

 submodule.c | 74 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0c586a0..c7b32c6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1142,6 +1142,31 @@ struct submodule_parallel_fetch {
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
 
+static int get_fetch_recurse_config(const struct submodule *submodule,
+				    struct submodule_parallel_fetch *spf)
+{
+	if (spf->command_line_option != RECURSE_SUBMODULES_DEFAULT)
+		return spf->command_line_option;
+
+	if (submodule) {
+		char *key;
+		const char *value;
+
+		int fetch_recurse = submodule->fetch_recurse;
+		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
+		if (!repo_config_get_string_const(the_repository, key, &value)) {
+			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
+		}
+		free(key);
+
+		if (fetch_recurse != RECURSE_SUBMODULES_NONE)
+			/* local config overrules everything except commandline */
+			return fetch_recurse;
+	}
+
+	return spf->default_option;
+}
+
 static int get_next_submodule(struct child_process *cp,
 			      struct strbuf *err, void *data, void **task_cb)
 {
@@ -1161,46 +1186,21 @@ static int get_next_submodule(struct child_process *cp,
 
 		submodule = submodule_from_path(&null_oid, ce->name);
 
-		default_argv = "yes";
-		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-			int fetch_recurse = RECURSE_SUBMODULES_NONE;
-
-			if (submodule) {
-				char *key;
-				const char *value;
-
-				fetch_recurse = submodule->fetch_recurse;
-				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
-				if (!repo_config_get_string_const(the_repository, key, &value)) {
-					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
-				}
-				free(key);
-			}
-
-			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
-				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
-					continue;
-				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_names,
-									 submodule->name))
-						continue;
-					default_argv = "on-demand";
-				}
-			} else {
-				if (spf->default_option == RECURSE_SUBMODULES_OFF)
-					continue;
-				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_names,
-									  submodule->name))
-						continue;
-					default_argv = "on-demand";
-				}
-			}
-		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
-			if (!unsorted_string_list_lookup(&changed_submodule_names,
+		switch (get_fetch_recurse_config(submodule, spf))
+		{
+		default:
+		case RECURSE_SUBMODULES_DEFAULT:
+		case RECURSE_SUBMODULES_ON_DEMAND:
+			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
 							 submodule->name))
 				continue;
 			default_argv = "on-demand";
+			break;
+		case RECURSE_SUBMODULES_ON:
+			default_argv = "yes";
+			break;
+		case RECURSE_SUBMODULES_OFF:
+			continue;
 		}
 
 		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
-- 
2.10.0.129.g35f6318

