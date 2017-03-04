Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5611E2023D
	for <e@80x24.org>; Sat,  4 Mar 2017 19:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbdCDTgD (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 14:36:03 -0500
Received: from dalaran.tastycake.net ([212.13.201.165]:54495 "EHLO
        dalaran.tastycake.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbdCDTgB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 14:36:01 -0500
Received: from [176.27.107.90] (helo=localhost.localdomain)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <markbt@efaref.net>)
        id 1ckFCw-0001xc-2z; Sat, 04 Mar 2017 19:19:10 +0000
From:   Mark Thomas <markbt@efaref.net>
To:     git@vger.kernel.org
Cc:     Mark Thomas <markbt@efaref.net>
Subject: [RFC 4/4] clone: Request on-demand shallow clones
Date:   Sat,  4 Mar 2017 19:19:01 +0000
Message-Id: <20170304191901.9622-5-markbt@efaref.net>
X-Mailer: git-send-email 2.12.0.193.g9dc7f06
In-Reply-To: <20170304191901.9622-1-markbt@efaref.net>
References: <20170304191901.9622-1-markbt@efaref.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the --on-demand option to git-clone, which, when used in combination
with the existing shallow clone options, requests an on-demand shallow
clone.

An on-demand shallow clone contains all commits from all history, but
the commits that would normally be omitted in the shallow clone do not
have their trees or blobs in the repository.  Instead, they will be
fetched on-demand from the remote.

Signed-off-by: Mark Thomas <markbt@efaref.net>
---
 builtin/clone.c | 7 ++++++-
 cache-tree.c    | 2 +-
 fetch-pack.c    | 3 +++
 fetch-pack.h    | 1 +
 shallow.c       | 2 +-
 transport.c     | 3 +++
 transport.h     | 4 ++++
 7 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3f63edb..7541016 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,6 +40,7 @@ static const char * const builtin_clone_usage[] = {
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
+static int option_on_demand;
 static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
@@ -100,6 +101,8 @@ static struct option builtin_clone_options[] = {
 		    N_("create a shallow clone since a specific time")),
 	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
 			N_("deepen history of shallow clone, excluding rev")),
+	OPT_BOOL(0, "on-demand", &option_on_demand,
+		 N_("Make shallow clone an on-demand clone")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
@@ -1045,6 +1048,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_not.nr)
 		transport_set_option(transport, TRANS_OPT_DEEPEN_NOT,
 				     (const char *)&option_not);
+	if (option_on_demand)
+		transport_set_option(transport, TRANS_OPT_ON_DEMAND, "1");
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
@@ -1118,7 +1123,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_fetch_refs(transport, mapped_refs);
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
-			   branch_top.buf, reflog_msg.buf, transport, !is_local);
+			   branch_top.buf, reflog_msg.buf, transport, !is_local && !option_on_demand);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
diff --git a/cache-tree.c b/cache-tree.c
index 345ea35..10b14fe 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -356,7 +356,7 @@ static int update_one(struct cache_tree *it,
 		}
 		if (mode != S_IFGITLINK && !missing_ok && !has_sha1_file(sha1)) {
 			strbuf_release(&buffer);
-			if (expected_missing)
+			if (expected_missing || 1 /*** FIXME: markbt temp hack, to allow missing files ***/)
 				return -1;
 			return error("invalid object %06o %s for '%.*s'",
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
diff --git a/fetch-pack.c b/fetch-pack.c
index e0f5d5c..1dd4823 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -372,6 +372,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
 			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
 			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
+			if (args->on_demand)    strbuf_addf(&c, " on-demand");
 			if (agent_supported)    strbuf_addf(&c, " agent=%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -936,6 +937,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("Server does not support --shallow-exclude"));
 	if (!server_supports("deepen-relative") && args->deepen_relative)
 		die(_("Server does not support --deepen"));
+	if (!server_supports("on-demand") && args->on_demand)
+		die(_("Server does not support --on-demand"));
 
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index c912e3d..16ab8bd 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -29,6 +29,7 @@ struct fetch_pack_args {
 	unsigned cloning:1;
 	unsigned update_shallow:1;
 	unsigned deepen:1;
+	unsigned on_demand:1;
 };
 
 /*
diff --git a/shallow.c b/shallow.c
index 11f7dde..a24292b 100644
--- a/shallow.c
+++ b/shallow.c
@@ -45,7 +45,7 @@ int is_repository_shallow(void)
 	FILE *fp;
 	char buf[1024];
 	const char *path = alternate_shallow_file;
-
+	is_shallow = 0;  /*** FIXME: markbt temp hack to allow shallow repos with on-demand files ***/
 	if (is_shallow >= 0)
 		return is_shallow;
 
diff --git a/transport.c b/transport.c
index 5828e06..69f8d72 100644
--- a/transport.c
+++ b/transport.c
@@ -160,6 +160,8 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
 		opts->deepen_relative = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_ON_DEMAND)) {
+		opts->on_demand = !!value;
 	}
 	return 1;
 }
@@ -223,6 +225,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.deepen_since = data->options.deepen_since;
 	args.deepen_not = data->options.deepen_not;
 	args.deepen_relative = data->options.deepen_relative;
+	args.on_demand = data->options.on_demand;
 	args.check_self_contained_and_connected =
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
diff --git a/transport.h b/transport.h
index bc55715..d4f848b 100644
--- a/transport.h
+++ b/transport.h
@@ -15,6 +15,7 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned deepen_relative : 1;
+	unsigned on_demand : 1;
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -210,6 +211,9 @@ void transport_check_allowed(const char *type);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* On-demand clone */
+#define TRANS_OPT_ON_DEMAND "on-demand"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.7.4

