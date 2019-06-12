Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D291F462
	for <e@80x24.org>; Wed, 12 Jun 2019 14:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437985AbfFLOz5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 10:55:57 -0400
Received: from resqmta-po-11v.sys.comcast.net ([96.114.154.170]:52622 "EHLO
        resqmta-po-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408884AbfFLOz5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 Jun 2019 10:55:57 -0400
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
        by resqmta-po-11v.sys.comcast.net with ESMTP
        id b2tEh38PdEDICb4fKhwhjR; Wed, 12 Jun 2019 14:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1560351354;
        bh=F88bSA2W7yjaZhCLD5C30oCcvfQNsRK9b937q3nAHY8=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=k4gj5n009Ov0g0AmlR3QUtcxV78JL3xsQ8aK32ZvoTswS9CwRcP3LXtAEeDbm3jQK
         +No4wFCGbVH6FotISKz1Xf7Dfbm8wqa2OQhEprU25qf6LeSTMufv3iJDm9Uk4Ycl0w
         cVN+WuzVo9XDFvKr6Eqz4+z7n9B8MirAb24D0GaQ4VBF4bXBzgdk+rBLclss/gNNGo
         RV+QO1/1IwP8Exc/mXsSpGL/1/96TtvBzZENeRW7jBUE20gauxY6wZOl2TNZAw3DkE
         K2qA4jr7Roadfc+PUBIsG1xhQ3QCS9xvfwourFIc/L9TX7ub2ZotFwKAoviUzPPZs7
         5pQublNC/RtJw==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:8dc5:35e2:73b6:2c5e])
        by resomta-po-02v.sys.comcast.net with ESMTPSA
        id b4eqhsX8wBBgub4evhVXnC; Wed, 12 Jun 2019 14:55:52 +0000
X-Xfinity-VMeta: sc=0;st=legit
Date:   Wed, 12 Jun 2019 07:55:24 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matthew DeVore <matvore@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, jrn@google.com, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v2 6/9] list-objects-filter-options: make filter_spec a
 strbuf
Message-ID: <20190612145524.GE58112@comcast.net>
References: <20190601003603.90794-1-matvore@google.com>
 <20190601003603.90794-7-matvore@google.com>
 <xmqqimtdmc59.fsf@gitster-ct.c.googlers.com>
 <20190611003456.GB10396@comcast.net>
 <xmqqtvcwkowx.fsf@gitster-ct.c.googlers.com>
 <20190611184426.GB58112@comcast.net>
 <xmqqmuinkd30.fsf@gitster-ct.c.googlers.com>
 <20190612003716.GD58112@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612003716.GD58112@comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 11, 2019 at 05:37:16PM -0700, Matthew DeVore wrote:
> On Tue, Jun 11, 2019 at 02:48:51PM -0700, Junio C Hamano wrote:
> > Matthew DeVore <matvore@comcast.net> writes:
> > 
> > >> It is brittle because callers are bound to forget doing "if
> > >> (!x->buf.buf) lazy_init(&x->buf)" at some point, and blindly use an
> > >> uninitialized x->buf.  Making sure x->buf is always initialized
> > >
> > > A corallary proposition would be to make this particular strbuf a "struct
> > > strbuf *" rather than an inline strbuf. It should then be rather clear to users
> > > that it may be null.
> > 
> > Would make it less likely for uses of an uninitialized strbuf to be
> > left undetected as errors?  I guess so, and if that is the case it
> > would definitely be an improvement.
> > 
> > But initializing the strbuf at the point where the enclosing
> > structure is initialized (or calloc()'ed) is also a vaiable option,
> > and between the two, I think that would be even more robust.
> > 
> > There may be reasons why it is cumbersome to arrange it that way,
> > though (e.g. if the code does not introduce a "new_stuff()"
> > allocator that also initializes, and instead uses xcalloc() from
> > many places, initializing the enclosing structure properly might
> > take a preliminary clean-up step before the main part of the patch
> > series can begin).

Here is an alternate interdiff where I use a string_list rather than a strbuf
for the filter_spec. This is actually slightly shorter code than the earlier
interdiff using a struct filter_spec type. (not by much, maybe half-dozen lines)
I think this is my favorite approach so far.

diff --git a/builtin/clone.c b/builtin/clone.c
index 85b0d3155d..81e6010779 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1135,27 +1135,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
 	if (option_upload_pack)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
 	if (server_options.nr)
 		transport->server_options = &server_options;
 
 	if (filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&filter_options,
-						&expanded_filter_spec);
+		const char *spec =
+			expand_list_objects_filter_spec(&filter_options);
 		transport_set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
-				     expanded_filter_spec.buf);
+				     spec);
 		transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-		strbuf_release(&expanded_filter_spec);
 	}
 
 	if (transport->smart_options && !deepen && !filter_options.choice)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 
 	argv_array_push(&ref_prefixes, "HEAD");
 	refspec_ref_prefixes(&remote->fetch, &ref_prefixes);
 	if (option_branch)
 		expand_ref_prefix(&ref_prefixes, option_branch);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ba63d5ac6..dee89e1a19 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1181,27 +1181,24 @@ static struct transport *prepare_transport(struct remote *remote, int deepen)
 	if (deepen && deepen_since)
 		set_option(transport, TRANS_OPT_DEEPEN_SINCE, deepen_since);
 	if (deepen && deepen_not.nr)
 		set_option(transport, TRANS_OPT_DEEPEN_NOT,
 			   (const char *)&deepen_not);
 	if (deepen_relative)
 		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	if (filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&filter_options,
-						&expanded_filter_spec);
-		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER,
-			   expanded_filter_spec.buf);
+		const char *spec =
+			expand_list_objects_filter_spec(&filter_options);
+		set_option(transport, TRANS_OPT_LIST_OBJECTS_FILTER, spec);
 		set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
-		strbuf_release(&expanded_filter_spec);
 	}
 	if (negotiation_tip.nr) {
 		if (transport->smart_options)
 			add_negotiation_tips(transport->smart_options);
 		else
 			warning("Ignoring --negotiation-tip because the protocol does not support it.");
 	}
 	return transport;
 }
 
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 7137f13a74..823e87c1c9 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -459,22 +459,24 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			show_progress = arg;
 			continue;
 		}
 
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&filter_options, arg);
 			if (filter_options.choice && !revs.blob_objects)
 				die(_("object filtering requires --objects"));
 			if (filter_options.choice == LOFC_SPARSE_OID &&
 			    !filter_options.sparse_oid_value)
-				die(_("invalid sparse value '%s'"),
-				    filter_options.filter_spec.buf);
+				die(
+					_("invalid sparse value '%s'"),
+					list_objects_filter_spec(
+						&filter_options));
 			continue;
 		}
 		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
 			list_objects_filter_set_no_filter(&filter_options);
 			continue;
 		}
 		if (!strcmp(arg, "--filter-print-omitted")) {
 			arg_print_omitted = 1;
 			continue;
 		}
diff --git a/fetch-pack.c b/fetch-pack.c
index 1c10f54e78..72e13b0a1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -332,26 +332,23 @@ static int find_common(struct fetch_negotiator *negotiator,
 		packet_buf_write(&req_buf, "deepen-since %"PRItime, max_age);
 	}
 	if (args->deepen_not) {
 		int i;
 		for (i = 0; i < args->deepen_not->nr; i++) {
 			struct string_list_item *s = args->deepen_not->items + i;
 			packet_buf_write(&req_buf, "deepen-not %s", s->string);
 		}
 	}
 	if (server_supports_filtering && args->filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&args->filter_options,
-						&expanded_filter_spec);
-		packet_buf_write(&req_buf, "filter %s",
-				 expanded_filter_spec.buf);
-		strbuf_release(&expanded_filter_spec);
+		const char *spec =
+			expand_list_objects_filter_spec(&args->filter_options);
+		packet_buf_write(&req_buf, "filter %s", spec);
 	}
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;
 
 	if (args->deepen) {
 		const char *arg;
 		struct object_id oid;
 
 		send_request(args, fd[1], &req_buf);
 		while (packet_reader_read(&reader) == PACKET_READ_NORMAL) {
@@ -1092,21 +1089,21 @@ static int add_haves(struct fetch_negotiator *negotiator,
 		ret = 1;
 	}
 
 	/* Increase haves to send on next round */
 	*haves_to_send = next_flush(1, *haves_to_send);
 
 	return ret;
 }
 
 static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
-			      const struct fetch_pack_args *args,
+			      struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain,
 			      int sideband_all)
 {
 	int ret = 0;
 	struct strbuf req_buf = STRBUF_INIT;
 
 	if (server_supports_v2("fetch", 1))
 		packet_buf_write(&req_buf, "command=fetch");
 	if (server_supports_v2("agent", 0))
@@ -1133,27 +1130,24 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 
 	/* Add shallow-info and deepen request */
 	if (server_supports_feature("fetch", "shallow", 0))
 		add_shallow_requests(&req_buf, args);
 	else if (is_repository_shallow(the_repository) || args->deepen)
 		die(_("Server does not support shallow requests"));
 
 	/* Add filter */
 	if (server_supports_feature("fetch", "filter", 0) &&
 	    args->filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
+		const char *spec =
+			expand_list_objects_filter_spec(&args->filter_options);
 		print_verbose(args, _("Server supports filter"));
-		expand_list_objects_filter_spec(&args->filter_options,
-						&expanded_filter_spec);
-		packet_buf_write(&req_buf, "filter %s",
-				 expanded_filter_spec.buf);
-		strbuf_release(&expanded_filter_spec);
+		packet_buf_write(&req_buf, "filter %s", spec);
 	} else if (args->filter_options.choice) {
 		warning("filtering not recognized by server, ignoring");
 	}
 
 	/* add wants */
 	add_wants(args->no_dependents, wants, &req_buf);
 
 	if (args->no_dependents) {
 		packet_buf_write(&req_buf, "done");
 		ret = 1;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 9a5677c2c8..38729a7238 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -174,20 +174,29 @@ static int parse_combine_filter(
 	return result;
 }
 
 static int allow_unencoded(char ch)
 {
 	if (ch <= ' ' || ch == '%' || ch == '+')
 		return 0;
 	return !strchr(RESERVED_NON_WS, ch);
 }
 
+static void filter_spec_append_urlencode(
+	struct list_objects_filter_options *filter, const char *raw)
+{
+	struct strbuf buf = STRBUF_INIT;
+	strbuf_addstr_urlencode(&buf, raw, allow_unencoded);
+	trace_printf("Added to composite filter-spec: %s\n", buf.buf);
+	string_list_append(&filter->filter_spec, strbuf_detach(&buf, NULL));
+}
+
 /*
  * Changes filter_options into an equivalent LOFC_COMBINE filter options
  * instance. Does not do anything if filter_options is already LOFC_COMBINE.
  */
 static void transform_to_combine_type(
 	struct list_objects_filter_options *filter_options)
 {
 	assert(filter_options->choice);
 	if (filter_options->choice == LOFC_COMBINE)
 		return;
@@ -195,64 +204,59 @@ static void transform_to_combine_type(
 		const int initial_sub_alloc = 2;
 		struct list_objects_filter_options *sub_array =
 			xcalloc(initial_sub_alloc, sizeof(*sub_array));
 		sub_array[0] = *filter_options;
 		memset(filter_options, 0, sizeof(*filter_options));
 		filter_options->sub = sub_array;
 		filter_options->sub_alloc = initial_sub_alloc;
 	}
 	filter_options->sub_nr = 1;
 	filter_options->choice = LOFC_COMBINE;
-	strbuf_init(&filter_options->filter_spec, 0);
-	strbuf_addstr(&filter_options->filter_spec, "combine:");
-	strbuf_addstr_urlencode(&filter_options->filter_spec,
-				filter_options->sub[0].filter_spec.buf,
-				allow_unencoded);
+	string_list_append(&filter_options->filter_spec, xstrdup("combine:"));
+	filter_spec_append_urlencode(
+		filter_options,
+		list_objects_filter_spec(&filter_options->sub[0]));
 	/*
 	 * We don't need the filter_spec strings for subfilter specs, only the
 	 * top level.
 	 */
-	strbuf_release(&filter_options->sub[0].filter_spec);
+	string_list_clear(&filter_options->sub[0].filter_spec, /*free_util=*/0);
 }
 
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options)
 {
 	if (filter_options->choice)
 		die(_("multiple filter-specs cannot be combined"));
 }
 
 void parse_list_objects_filter(
 	struct list_objects_filter_options *filter_options,
 	const char *arg)
 {
 	struct strbuf errbuf = STRBUF_INIT;
 	int parse_error;
 
 	if (!filter_options->choice) {
-		strbuf_init(&filter_options->filter_spec, 0);
-		strbuf_addstr(&filter_options->filter_spec, arg);
+		string_list_append(&filter_options->filter_spec, xstrdup(arg));
 
 		parse_error = gently_parse_list_objects_filter(
 			filter_options, arg, &errbuf);
 	} else {
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
 		 */
 		transform_to_combine_type(filter_options);
 
-		strbuf_addstr(&filter_options->filter_spec, "+");
-		strbuf_addstr_urlencode(&filter_options->filter_spec, arg,
-					allow_unencoded);
-		trace_printf("Generated composite filter-spec: %s\n",
-			     filter_options->filter_spec.buf);
+		string_list_append(&filter_options->filter_spec, xstrdup("+"));
+		filter_spec_append_urlencode(filter_options, arg);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
 
 		parse_error = gently_parse_list_objects_filter(
 			&filter_options->sub[filter_options->sub_nr - 1], arg,
 			&errbuf);
 	}
 	if (parse_error)
 		die("%s", errbuf.buf);
 }
@@ -262,54 +266,71 @@ int opt_parse_list_objects_filter(const struct option *opt,
 {
 	struct list_objects_filter_options *filter_options = opt->value;
 
 	if (unset || !arg)
 		list_objects_filter_set_no_filter(filter_options);
 	else
 		parse_list_objects_filter(filter_options, arg);
 	return 0;
 }
 
-void expand_list_objects_filter_spec(
-	const struct list_objects_filter_options *filter,
-	struct strbuf *expanded_spec)
+const char *list_objects_filter_spec(struct list_objects_filter_options *filter)
+{
+	if (!filter->filter_spec.nr)
+		BUG("no filter_spec available for this filter");
+	if (filter->filter_spec.nr != 1) {
+		struct strbuf concatted = STRBUF_INIT;
+		strbuf_add_separated_string_list(
+			&concatted, "", &filter->filter_spec);
+		string_list_clear(&filter->filter_spec, /*free_util=*/0);
+		string_list_append(
+			&filter->filter_spec, strbuf_detach(&concatted, NULL));
+	}
+
+	return filter->filter_spec.items[0].string;
+}
+
+const char *expand_list_objects_filter_spec(
+	struct list_objects_filter_options *filter)
 {
-	strbuf_init(expanded_spec, 0);
-	if (filter->choice == LOFC_BLOB_LIMIT)
-		strbuf_addf(expanded_spec, "blob:limit=%lu",
+	if (filter->choice == LOFC_BLOB_LIMIT) {
+		struct strbuf expanded_spec;
+		strbuf_addf(&expanded_spec, "blob:limit=%lu",
 			    filter->blob_limit_value);
-	else if (filter->choice == LOFC_TREE_DEPTH)
-		strbuf_addf(expanded_spec, "tree:%lu",
-			    filter->tree_exclude_depth);
-	else
-		strbuf_addstr(expanded_spec, filter->filter_spec.buf);
+		string_list_clear(&filter->filter_spec, /*free_util=*/0);
+		string_list_append(
+			&filter->filter_spec,
+			strbuf_detach(&expanded_spec, NULL));
+	}
+
+	return list_objects_filter_spec(filter);
 }
 
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options)
 {
 	size_t sub;
 
 	if (!filter_options)
 		return;
-	strbuf_release(&filter_options->filter_spec);
+	string_list_clear(&filter_options->filter_spec, /*free_util=*/0);
 	free(filter_options->sparse_oid_value);
 	free(filter_options->sparse_path_value);
 	for (sub = 0; sub < filter_options->sub_nr; sub++)
 		list_objects_filter_release(&filter_options->sub[sub]);
 	free(filter_options->sub);
 	memset(filter_options, 0, sizeof(*filter_options));
 }
 
 void partial_clone_register(
 	const char *remote,
-	const struct list_objects_filter_options *filter_options)
+	struct list_objects_filter_options *filter_options)
 {
 	/*
 	 * Record the name of the partial clone remote in the
 	 * config and in the global variable -- the latter is
 	 * used throughout to indicate that partial clone is
 	 * enabled and to expect missing objects.
 	 */
 	if (repository_format_partial_clone &&
 	    *repository_format_partial_clone &&
 	    strcmp(remote, repository_format_partial_clone))
@@ -318,35 +339,33 @@ void partial_clone_register(
 	git_config_set("core.repositoryformatversion", "1");
 	git_config_set("extensions.partialclone", remote);
 
 	repository_format_partial_clone = xstrdup(remote);
 
 	/*
 	 * Record the initial filter-spec in the config as
 	 * the default for subsequent fetches from this remote.
 	 */
 	core_partial_clone_filter_default =
-		xstrdup(filter_options->filter_spec.buf);
+		xstrdup(expand_list_objects_filter_spec(filter_options));
 	git_config_set("core.partialclonefilter",
 		       core_partial_clone_filter_default);
 }
 
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options)
 {
 	struct strbuf errbuf = STRBUF_INIT;
 
 	/*
 	 * Parse default value, but silently ignore it if it is invalid.
 	 */
 	if (!core_partial_clone_filter_default)
 		return;
 
-	if (!filter_options->filter_spec.buf)
-		strbuf_init(&filter_options->filter_spec, 0);
-	strbuf_addstr(&filter_options->filter_spec,
-		      core_partial_clone_filter_default);
+	string_list_append(&filter_options->filter_spec,
+			   core_partial_clone_filter_default);
 	gently_parse_list_objects_filter(filter_options,
 					 core_partial_clone_filter_default,
 					 &errbuf);
 	strbuf_release(&errbuf);
 }
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 2c0ce6383a..9b31048ada 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -1,15 +1,15 @@
 #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
 #define LIST_OBJECTS_FILTER_OPTIONS_H
 
 #include "parse-options.h"
-#include "strbuf.h"
+#include "string-list.h"
 
 /*
  * The list of defined filters for list-objects.
  */
 enum list_objects_filter_choice {
 	LOFC_DISABLED = 0,
 	LOFC_BLOB_NONE,
 	LOFC_BLOB_LIMIT,
 	LOFC_TREE_DEPTH,
 	LOFC_SPARSE_OID,
@@ -18,22 +18,24 @@ enum list_objects_filter_choice {
 	LOFC__COUNT /* must be last */
 };
 
 struct list_objects_filter_options {
 	/*
 	 * 'filter_spec' is the raw argument value given on the command line
 	 * or protocol request.  (The part after the "--keyword=".)  For
 	 * commands that launch filtering sub-processes, or for communication
 	 * over the network, don't use this value; use the result of
 	 * expand_list_objects_filter_spec() instead.
+	 * To get the raw filter spec given by the user, use the result of
+	 * list_objects_filter_spec().
 	 */
-	struct strbuf filter_spec;
+	struct string_list filter_spec;
 
 	/*
 	 * 'choice' is determined by parsing the filter-spec.  This indicates
 	 * the filtering algorithm to use.
 	 */
 	enum list_objects_filter_choice choice;
 
 	/*
 	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
 	 */
@@ -86,31 +88,33 @@ int opt_parse_list_objects_filter(const struct option *opt,
 	  N_("object filtering"), 0, \
 	  opt_parse_list_objects_filter }
 
 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
  * fully-expanded forms (e.g., "limit:blob=1k" becomes "limit:blob=1024").
  *
  * This form should be used instead of the raw filter_spec field when
  * communicating with a remote process or subprocess.
  */
-void expand_list_objects_filter_spec(
-	const struct list_objects_filter_options *filter,
-	struct strbuf *expanded_spec);
+const char *expand_list_objects_filter_spec(
+	struct list_objects_filter_options *filter);
+
+const char *list_objects_filter_spec(
+	struct list_objects_filter_options *filter);
 
 void list_objects_filter_release(
 	struct list_objects_filter_options *filter_options);
 
 static inline void list_objects_filter_set_no_filter(
 	struct list_objects_filter_options *filter_options)
 {
 	list_objects_filter_release(filter_options);
 	filter_options->no_filter = 1;
 }
 
 void partial_clone_register(
 	const char *remote,
-	const struct list_objects_filter_options *filter_options);
+	struct list_objects_filter_options *filter_options);
 void partial_clone_get_default_filter_spec(
 	struct list_objects_filter_options *filter_options);
 
 #endif /* LIST_OBJECTS_FILTER_OPTIONS_H */
diff --git a/transport-helper.c b/transport-helper.c
index cec83bd663..d6313ef9f5 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -675,27 +675,23 @@ static int fetch(struct transport *transport,
 	    data->transport_options.check_self_contained_and_connected)
 		set_helper_option(transport, "check-connectivity", "true");
 
 	if (transport->cloning)
 		set_helper_option(transport, "cloning", "true");
 
 	if (data->transport_options.update_shallow)
 		set_helper_option(transport, "update-shallow", "true");
 
 	if (data->transport_options.filter_options.choice) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(
-			&data->transport_options.filter_options,
-			&expanded_filter_spec);
-		set_helper_option(transport, "filter",
-				  expanded_filter_spec.buf);
-		strbuf_release(&expanded_filter_spec);
+		const char *spec = expand_list_objects_filter_spec(
+			&data->transport_options.filter_options);
+		set_helper_option(transport, "filter", spec);
 	}
 
 	if (data->transport_options.negotiation_tips)
 		warning("Ignoring --negotiation-tip because the protocol does not support it.");
 
 	if (data->fetch)
 		return fetch_with_fetch(transport, nr_heads, to_fetch);
 
 	if (data->import)
 		return fetch_with_import(transport, nr_heads, to_fetch);
diff --git a/upload-pack.c b/upload-pack.c
index ba8c3a1f8e..dda2ac6f44 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -133,32 +133,31 @@ static void create_pack_file(const struct object_array *have_obj,
 
 	argv_array_push(&pack_objects.args, "--stdout");
 	if (shallow_nr)
 		argv_array_push(&pack_objects.args, "--shallow");
 	if (!no_progress)
 		argv_array_push(&pack_objects.args, "--progress");
 	if (use_ofs_delta)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
-	if (filter_options.filter_spec.len) {
-		struct strbuf expanded_filter_spec = STRBUF_INIT;
-		expand_list_objects_filter_spec(&filter_options,
-						&expanded_filter_spec);
+	if (filter_options.choice) {
+		const char *spec =
+			expand_list_objects_filter_spec(&filter_options);
 		if (pack_objects.use_shell) {
 			struct strbuf buf = STRBUF_INIT;
-			sq_quote_buf(&buf, expanded_filter_spec.buf);
+			sq_quote_buf(&buf, spec);
 			argv_array_pushf(&pack_objects.args, "--filter=%s", buf.buf);
 			strbuf_release(&buf);
 		} else {
 			argv_array_pushf(&pack_objects.args, "--filter=%s",
-					 expanded_filter_spec.buf);
+					 spec);
 		}
 	}
 
 	pack_objects.in = -1;
 	pack_objects.out = -1;
 	pack_objects.err = -1;
 
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
 
