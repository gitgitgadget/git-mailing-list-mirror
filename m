Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84C2202D7
	for <e@80x24.org>; Wed,  8 Mar 2017 20:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754483AbdCHUrb (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 15:47:31 -0500
Received: from siwi.pair.com ([209.68.5.199]:60672 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754296AbdCHUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 15:47:29 -0500
Received: from jeffhostetler.2jll4ugiwlvuzhh55dqabi0nia.bx.internal.cloudapp.net (unknown [40.76.14.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8E3638461D;
        Wed,  8 Mar 2017 13:51:02 -0500 (EST)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com, Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH 08/10] fetch: add partial-by-size and partial-special arguments
Date:   Wed,  8 Mar 2017 18:50:37 +0000
Message-Id: <1488999039-37631-9-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <git@jeffhostetler.com>

Teach fetch to accept --partial-by-size=n and --partial-special
arguments and pass them to fetch-patch to request that the
server certain blobs from the generated packfile.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/fetch.c | 26 +++++++++++++++++++++++++-
 connected.c     |  3 +++
 connected.h     |  3 +++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5ad09d..3d47107 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -52,6 +52,8 @@ static const char *recurse_submodules_default;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
+static const char *partial_by_size;
+static int partial_special;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -141,6 +143,11 @@ static struct option builtin_fetch_options[] = {
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
+	OPT_STRING(0, "partial-by-size", &partial_by_size,
+			   N_("size"),
+			   N_("only include blobs smaller than this")),
+	OPT_BOOL(0, "partial-special", &partial_special,
+			 N_("only include blobs for git special files")),
 	OPT_END()
 };
 
@@ -731,6 +738,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
+	struct check_connected_options opt = CHECK_CONNECTED_INIT;
+
+	if (partial_by_size || partial_special)
+		opt.allow_partial = 1;
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -742,7 +753,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 		url = xstrdup("foreign");
 
 	rm = ref_map;
-	if (check_connected(iterate_ref_map, &rm, NULL)) {
+	if (check_connected(iterate_ref_map, &rm, &opt)) {
 		rc = error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -882,6 +893,9 @@ static int quickfetch(struct ref *ref_map)
 	struct ref *rm = ref_map;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
+	if (partial_by_size || partial_special)
+		opt.allow_partial = 1;
+
 	/*
 	 * If we are deepening a shallow clone we already have these
 	 * objects reachable.  Running rev-list here will return with
@@ -1020,6 +1034,10 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (partial_by_size)
+		set_option(transport, TRANS_OPT_PARTIAL_BY_SIZE, partial_by_size);
+	if (partial_special)
+		set_option(transport, TRANS_OPT_PARTIAL_SPECIAL, "yes");
 	return transport;
 }
 
@@ -1314,6 +1332,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
+	if (partial_by_size) {
+		unsigned long s;
+		if (!git_parse_ulong(partial_by_size, &s))
+			die(_("invalid partial-by-size value"));
+	}
+
 	if (deepen_relative) {
 		if (deepen_relative < 0)
 			die(_("Negative depth in --deepen is not supported"));
diff --git a/connected.c b/connected.c
index 136c2ac..b07cbb5 100644
--- a/connected.c
+++ b/connected.c
@@ -62,6 +62,9 @@ int check_connected(sha1_iterate_fn fn, void *cb_data,
 		argv_array_pushf(&rev_list.args, "--progress=%s",
 				 _("Checking connectivity"));
 
+	if (opt->allow_partial)
+		argv_array_push(&rev_list.args, "--allow-partial");
+
 	rev_list.git_cmd = 1;
 	rev_list.env = opt->env;
 	rev_list.in = -1;
diff --git a/connected.h b/connected.h
index 4ca325f..756259e 100644
--- a/connected.h
+++ b/connected.h
@@ -34,6 +34,9 @@ struct check_connected_options {
 	/* If non-zero, show progress as we traverse the objects. */
 	int progress;
 
+	/* A previous partial clone/fetch may have omitted some blobs. */
+	int allow_partial;
+
 	/*
 	 * Insert these variables into the environment of the child process.
 	 */
-- 
2.7.4

