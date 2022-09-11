Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E331ECAAA1
	for <git@archiver.kernel.org>; Sun, 11 Sep 2022 05:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiIKFDL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Sep 2022 01:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIKFDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2022 01:03:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B8B303D9
        for <git@vger.kernel.org>; Sat, 10 Sep 2022 22:03:08 -0700 (PDT)
Received: (qmail 18257 invoked by uid 109); 11 Sep 2022 05:03:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 11 Sep 2022 05:03:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31554 invoked by uid 111); 11 Sep 2022 05:03:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Sep 2022 01:03:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Sep 2022 01:03:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 3/4] list-objects-filter: add and use initializers
Message-ID: <Yx1sC6w2yDZRXFdE@coredump.intra.peff.net>
References: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yx1qwlpNbxGEiUgc@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 7e2619d8ff (list_objects_filter_options: plug leak of filter_spec
strings, 2022-09-08), we noted that the filter_spec string_list was
inconsistent in how it handled memory ownership of strings stored in the
list. The fix there was a bit of a band-aid to set the "strdup_strings"
variable right before adding anything.

That works OK, and it lets the users of the API continue to
zero-initialize the struct. But it makes the code a bit hard to follow
and accident-prone, as any other spots appending the filter_spec need to
think about whether to set the strdup_strings value, too (there's one
such spot in partial_clone_get_default_filter_spec(), which is probably
a possible memory leak).

So let's do that full cleanup now. We'll introduce a
LIST_OBJECTS_FILTER_INIT macro and matching function, and use them as
appropriate (though it is for the "_options" struct, this matches the
corresponding list_objects_filter_release() function).

This is harder than it seems! Many other structs, like
git_transport_data, embed the filter struct. So they need to initialize
it themselves even if the rest of the enclosing struct is OK with
zero-initialization. I found all of the relevant spots by grepping
manually for declarations of list_objects_filter_options. And then doing
so recursively for structs which embed it, and ones which embed those,
and so on.

I'm pretty sure I got everything, but there's no change that would alert
the compiler if any topics in flight added new declarations. To catch
this case, we now double-check in the parsing function that things were
initialized as expected and BUG() if appropriate.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c               |  2 +-
 builtin/fetch-pack.c          |  1 +
 builtin/fetch.c               |  2 +-
 builtin/submodule--helper.c   |  8 ++++----
 bundle.h                      |  1 +
 list-objects-filter-options.c | 20 +++++++++++---------
 list-objects-filter-options.h |  3 +++
 revision.c                    |  1 +
 transport-helper.c            |  2 ++
 transport.c                   |  1 +
 upload-pack.c                 |  1 +
 11 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index e21d42dfee..d269d6fec6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -73,7 +73,7 @@ static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
-static struct list_objects_filter_options filter_options;
+static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index f045bbbe94..afe679368d 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -62,6 +62,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("fetch-pack");
 
 	memset(&args, 0, sizeof(args));
+	list_objects_filter_init(&args.filter_options);
 	args.uploadpack = "git-upload-pack";
 
 	for (i = 1; i < argc && *argv[i] == '-'; i++) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 368a0f5329..d2c0c65de4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -80,7 +80,7 @@ static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
-static struct list_objects_filter_options filter_options;
+static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 static int fetch_write_commit_graph = -1;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b63f420ece..4b958e3cf8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1747,7 +1747,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options =
+		LIST_OBJECTS_FILTER_INIT;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
@@ -1789,7 +1790,6 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -2566,7 +2566,8 @@ static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec;
 	struct update_data opt = UPDATE_DATA_INIT;
-	struct list_objects_filter_options filter_options;
+	struct list_objects_filter_options filter_options =
+		LIST_OBJECTS_FILTER_INIT;
 	int ret;
 
 	struct option module_update_options[] = {
@@ -2626,7 +2627,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	update_clone_config_from_gitmodules(&opt.max_jobs);
 	git_config(git_update_clone_config, &opt.max_jobs);
 
-	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
diff --git a/bundle.h b/bundle.h
index 0c052f5496..68ff39a0a7 100644
--- a/bundle.h
+++ b/bundle.h
@@ -18,6 +18,7 @@ struct bundle_header {
 { \
 	.prerequisites = STRING_LIST_INIT_DUP, \
 	.references = STRING_LIST_INIT_DUP, \
+	.filter = LIST_OBJECTS_FILTER_INIT, \
 }
 void bundle_header_init(struct bundle_header *header);
 void bundle_header_release(struct bundle_header *header);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 18c51001dc..56a1933a50 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -108,7 +108,7 @@ int gently_parse_list_objects_filter(
 
 	strbuf_addf(errbuf, _("invalid filter-spec '%s'"), arg);
 
-	memset(filter_options, 0, sizeof(*filter_options));
+	list_objects_filter_init(filter_options);
 	return 1;
 }
 
@@ -223,8 +223,7 @@ static void transform_to_combine_type(
 		struct list_objects_filter_options *sub_array =
 			xcalloc(initial_sub_alloc, sizeof(*sub_array));
 		sub_array[0] = *filter_options;
-		memset(filter_options, 0, sizeof(*filter_options));
-		string_list_init_dup(&filter_options->filter_spec);
+		list_objects_filter_init(filter_options);
 		filter_options->sub = sub_array;
 		filter_options->sub_alloc = initial_sub_alloc;
 	}
@@ -255,11 +254,8 @@ void parse_list_objects_filter(
 	struct strbuf errbuf = STRBUF_INIT;
 	int parse_error;
 
-	if (!filter_options->filter_spec.strdup_strings) {
-		if (filter_options->filter_spec.nr)
-			BUG("unexpected non-allocated string in filter_spec");
-		filter_options->filter_spec.strdup_strings = 1;
-	}
+	if (!filter_options->filter_spec.strdup_strings)
+		BUG("filter_options not properly initialized");
 
 	if (!filter_options->choice) {
 		string_list_append(&filter_options->filter_spec, arg);
@@ -346,7 +342,7 @@ void list_objects_filter_release(
 	for (sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
-	memset(filter_options, 0, sizeof(*filter_options));
+	list_objects_filter_init(filter_options);
 }
 
 void partial_clone_register(
@@ -429,3 +425,9 @@ void list_objects_filter_copy(
 	for (i = 0; i < src->sub_nr; i++)
 		list_objects_filter_copy(&dest->sub[i], &src->sub[i]);
 }
+
+void list_objects_filter_init(struct list_objects_filter_options *filter_options)
+{
+	struct list_objects_filter_options blank = LIST_OBJECTS_FILTER_INIT;
+	memcpy(filter_options, &blank, sizeof(*filter_options));
+}
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index ffc02d77e7..2720f7dba8 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -69,6 +69,9 @@ struct list_objects_filter_options {
 	 */
 };
 
+#define LIST_OBJECTS_FILTER_INIT { .filter_spec = STRING_LIST_INIT_DUP }
+void list_objects_filter_init(struct list_objects_filter_options *filter_options);
+
 /*
  * Parse value of the argument to the "filter" keyword.
  * On the command line this looks like:
diff --git a/revision.c b/revision.c
index a04ebd6139..7fc0e16bdf 100644
--- a/revision.c
+++ b/revision.c
@@ -1903,6 +1903,7 @@ void repo_init_revisions(struct repository *r,
 	}
 
 	init_display_notes(&revs->notes_opt);
+	list_objects_filter_init(&revs->filter);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
diff --git a/transport-helper.c b/transport-helper.c
index 322c722478..e95267a4ab 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1286,6 +1286,8 @@ int transport_helper_init(struct transport *transport, const char *name)
 	if (getenv("GIT_TRANSPORT_HELPER_DEBUG"))
 		debug = 1;
 
+	list_objects_filter_init(&data->transport_options.filter_options);
+
 	transport->data = data;
 	transport->vtable = &vtable;
 	transport->smart_options = &(data->transport_options);
diff --git a/transport.c b/transport.c
index 6ec6130852..a14179684b 100644
--- a/transport.c
+++ b/transport.c
@@ -1113,6 +1113,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		 * will be checked individually in git_connect.
 		 */
 		struct git_transport_data *data = xcalloc(1, sizeof(*data));
+		list_objects_filter_init(&data->options.filter_options);
 		ret->data = data;
 		ret->vtable = &builtin_smart_vtable;
 		ret->smart_options = &(data->options);
diff --git a/upload-pack.c b/upload-pack.c
index 35fe1a3dbb..54583b71c6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -141,6 +141,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->allow_filter_fallback = 1;
 	data->tree_filter_max_depth = ULONG_MAX;
 	packet_writer_init(&data->writer, 1);
+	list_objects_filter_init(&data->filter_options);
 
 	data->keepalive = 5;
 	data->advertise_sid = 0;
-- 
2.37.3.1242.g835d375f85

