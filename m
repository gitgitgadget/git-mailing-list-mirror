Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349DF20281
	for <e@80x24.org>; Fri, 15 Sep 2017 13:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdIONU0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 09:20:26 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.111]:36880 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdIONUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 09:20:25 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1dsqXf-00087c-1y; Fri, 15 Sep 2017 15:20:23 +0200
Date:   Fri, 15 Sep 2017 15:20:21 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        Brandon Williams <bmwill@google.com>
Subject: [RFC PATCH v2 2/2] submodule: simplify decision tree whether to or
 not to fetch
Message-ID: <20170915132021.GB99666@book.hvoigt.net>
References: <20170817105349.GC52233@book.hvoigt.net>
 <20170915131853.GA99666@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170915131853.GA99666@book.hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make extending this logic later easier.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c | 74 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/submodule.c b/submodule.c
index 38b9905e43..fa44fc59f2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1118,6 +1118,31 @@ struct submodule_parallel_fetch {
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
@@ -1137,46 +1162,21 @@ static int get_next_submodule(struct child_process *cp,
 
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
2.14.1.145.gb3622a4

