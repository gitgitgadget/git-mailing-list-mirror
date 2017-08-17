Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94B64208CD
	for <e@80x24.org>; Thu, 17 Aug 2017 11:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751626AbdHQLAT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 07:00:19 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.100]:5118 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbdHQLAS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 07:00:18 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay05.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1diIX9-00078V-HK; Thu, 17 Aug 2017 13:00:15 +0200
Date:   Thu, 17 Aug 2017 13:00:13 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        Brandon Williams <bmwill@google.com>
Subject: [RFC PATCH 2/2] submodule: simplify decision tree whether to or not
 to fetch
Message-ID: <20170817110013.GD52233@book.hvoigt.net>
References: <20170817105349.GC52233@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817105349.GC52233@book.hvoigt.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make extending this logic later easier.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
I am quite sure I replicated the same logic but a few more eyes would be
appreciated.

Cheers Heiko

 submodule.c | 55 +++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/submodule.c b/submodule.c
index 3ed78ac..a1011f4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1171,6 +1171,21 @@ int submodule_touches_in_range(struct object_id *excl_oid,
 	return ret;
 }
 
+static int get_fetch_recurse_config(const struct submodule *submodule, int command_line_option)
+{
+	if (command_line_option != RECURSE_SUBMODULES_DEFAULT)
+		return command_line_option;
+
+	if (submodule && submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
+		/* local config overrules everything except commandline */
+		return submodule->fetch_recurse;
+
+	if (gitmodules_is_unmerged)
+		return RECURSE_SUBMODULES_OFF;
+
+	return config_fetch_recurse_submodules;
+}
+
 struct submodule_parallel_fetch {
 	int count;
 	struct argv_array args;
@@ -1203,37 +1218,21 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule)
 			submodule = submodule_from_name(&null_oid, ce->name);
 
-		default_argv = "yes";
-		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
-			if (submodule &&
-			    submodule->fetch_recurse !=
-						RECURSE_SUBMODULES_NONE) {
-				if (submodule->fetch_recurse ==
-						RECURSE_SUBMODULES_OFF)
-					continue;
-				if (submodule->fetch_recurse ==
-						RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_names,
-									 submodule->name))
-						continue;
-					default_argv = "on-demand";
-				}
-			} else {
-				if ((config_fetch_recurse_submodules == RECURSE_SUBMODULES_OFF) ||
-				    gitmodules_is_unmerged)
-					continue;
-				if (config_fetch_recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) {
-					if (!unsorted_string_list_lookup(&changed_submodule_names,
-									 submodule->name))
-						continue;
-					default_argv = "on-demand";
-				}
-			}
-		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
-			if (!unsorted_string_list_lookup(&changed_submodule_names,
+		switch (get_fetch_recurse_config(submodule, spf->command_line_option))
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
2.0.0.274.g6b2cd91

