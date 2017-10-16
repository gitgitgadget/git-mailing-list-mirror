Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A174E20437
	for <e@80x24.org>; Mon, 16 Oct 2017 13:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbdJPN7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 09:59:15 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:19485 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbdJPN7O (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 09:59:14 -0400
Received: from [193.96.224.22] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1e45vA-0002Mj-I1; Mon, 16 Oct 2017 15:59:10 +0200
Date:   Mon, 16 Oct 2017 15:59:05 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com, git@vger.kernel.org
Subject: [PATCH v4 3/3] submodule: simplify decision tree whether to or not
 to fetch
Message-ID: <20171016135905.GD12756@book.hvoigt.net>
References: <20171016135623.GA12756@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016135623.GA12756@book.hvoigt.net>
User-Agent: Mutt/1.9.0 (2017-09-02)
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
index 71d1773e2e..82d206eb65 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1187,6 +1187,31 @@ struct submodule_parallel_fetch {
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
@@ -1214,46 +1239,21 @@ static int get_next_submodule(struct child_process *cp,
 			}
 		}
 
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

