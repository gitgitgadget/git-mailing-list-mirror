Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C30320C41
	for <e@80x24.org>; Tue,  5 Dec 2017 16:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbdLEQuf (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:50:35 -0500
Received: from siwi.pair.com ([209.68.5.199]:50620 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752548AbdLEQue (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:50:34 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EC801844E8;
        Tue,  5 Dec 2017 11:50:33 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5F728844E4;
        Tue,  5 Dec 2017 11:50:33 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 2/3] list-objects-filter-options: support --no-filter
Date:   Tue,  5 Dec 2017 16:50:13 +0000
Message-Id: <20171205165014.64488-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165014.64488-1-git@jeffhostetler.com>
References: <20171205165014.64488-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach opt_parse_list_objects_filter() to take --no-filter
option and to free the contents of struct filter_options.
This command line argument will be automatically inherited
by commands using OPT_PARSE_LIST_OBJECTS_FILTER(); this
includes pack-objects.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Documentation/git-pack-objects.txt |  3 +++
 list-objects-filter-options.c      | 15 +++++++++++++--
 list-objects-filter-options.h      |  5 ++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index b924c6c..aa403d0 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -242,6 +242,9 @@ So does `git bundle` (see linkgit:git-bundle[1]) when it creates a bundle.
 	the resulting packfile.  See linkgit:git-rev-list[1] for valid
 	`<filter-spec>` forms.
 
+--no-filter::
+	Turns off any previous `--filter=` argument.
+
 --missing=<missing-action>::
 	A debug option to help with future "partial clone" development.
 	This option specifies how missing objects are handled.
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 52bdec7..4c5b34e 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -74,8 +74,19 @@ int opt_parse_list_objects_filter(const struct option *opt,
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
-	assert(arg);
-	assert(!unset);
+	if (unset || !arg) {
+		list_objects_filter_release(filter_options);
+		return 0;
+	}
 
 	return parse_list_objects_filter(filter_options, arg);
 }
+
+void list_objects_filter_release(
+	struct list_objects_filter_options *filter_options)
+{
+	free(filter_options->filter_spec);
+	free(filter_options->sparse_oid_value);
+	free(filter_options->sparse_path_value);
+	memset(filter_options, 0, sizeof(*filter_options));
+}
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index dd7e5db..eea44a1 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -52,7 +52,10 @@ int opt_parse_list_objects_filter(const struct option *opt,
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
 	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
-	  N_("object filtering"), PARSE_OPT_NONEG, \
+	  N_("object filtering"), 0, \
 	  opt_parse_list_objects_filter }
 
+void list_objects_filter_release(
+	struct list_objects_filter_options *filter_options);
+
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
-- 
2.9.3

