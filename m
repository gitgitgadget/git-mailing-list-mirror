Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C07621F453
	for <e@80x24.org>; Fri, 21 Sep 2018 19:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391184AbeIVAur (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 20:50:47 -0400
Received: from [192.252.130.194] ([192.252.130.194]:44043 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390867AbeIVAur (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 20:50:47 -0400
X-Greylist: delayed 526 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2018 20:50:46 EDT
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 074A5A1BE3;
        Fri, 21 Sep 2018 14:51:49 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Subject: [PATCH] fetch: Ensure that fetch.recurseSubmodules overrides submodule.recurse.
Date:   Fri, 21 Sep 2018 14:51:49 -0400
Message-Id: <20180921185149.8670-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.19.0.1.g5109f9487a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also document this fact.

Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
---

I ran into this bug when I had both fetch.recurseSubmodules=on-demand and
submodule.recurse=true, and submodule.recurse was set *after*
fetch.recurseSubmodules in my config.

The fix ensures that fetch.recurseSubmodules always overrides
submodule.recurse.  If neither is set then fetch still behaves as if
fetch.recurseSubmodules=on-demand (the documented default).

I'm not sure if this is the most elegant implementation, but it gets the job
done.

		M.


 Documentation/config.txt | 6 ++++--
 builtin/fetch.c          | 5 ++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index eb66a11975..67b0adc1d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1514,7 +1514,8 @@ fetch.recurseSubmodules::
 	recurse at all when set to false. When set to 'on-demand' (the default
 	value), fetch and pull will only recurse into a populated submodule
 	when its superproject retrieves a commit that updates the submodule's
-	reference.
+	reference.  This option overrides the more general submodule.recurse
+	option, for the `fetch` command.
 
 fetch.fsckObjects::
 	If it is set to true, git-fetch-pack will check all fetched
@@ -3465,7 +3466,8 @@ submodule.active::
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
 	applies to all commands that have a `--recurse-submodules` option,
-	except `clone`.
+	except `clone`.  Also, the `fetch` command's behaviour can be specified
+	independently with the fetch.recurseSubmodules option.
 	Defaults to false.
 
 submodule.fetchJobs::
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213..08b8bf2741 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -60,6 +60,7 @@ static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
+static int recurse_submodules_set_explicitly = 0;
 static int shown_url = 0;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
@@ -78,7 +79,8 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(k, "submodule.recurse")) {
+	if (!strcmp(k, "submodule.recurse") &&
+	    !recurse_submodules_set_explicitly) {
 		int r = git_config_bool(k, v) ?
 			RECURSE_SUBMODULES_ON : RECURSE_SUBMODULES_OFF;
 		recurse_submodules = r;
@@ -88,6 +90,7 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
 		max_children = parse_submodule_fetchjobs(k, v);
 		return 0;
 	} else if (!strcmp(k, "fetch.recursesubmodules")) {
+		recurse_submodules_set_explicitly = 1;
 		recurse_submodules = parse_fetch_recurse_submodules_arg(k, v);
 		return 0;
 	}
-- 
2.19.0.1.g5109f9487a

