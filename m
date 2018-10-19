Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA591F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbeJTA1L (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:27:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:46456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727219AbeJTA1L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:27:11 -0400
Received: (qmail 23958 invoked by uid 109); 19 Oct 2018 16:20:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 16:20:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12521 invoked by uid 111); 19 Oct 2018 16:19:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 12:19:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 12:20:22 -0400
Date:   Fri, 19 Oct 2018 12:20:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 19/24] submodule.c: remove implicit dependency on
 the_index
Message-ID: <20181019162021.GA14778@sigill.intra.peff.net>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-20-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180903180932.32260-20-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 03, 2018 at 08:09:27PM +0200, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/submodule.c b/submodule.c
> index 50cbf5f13e..c0c1224760 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -766,7 +766,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
>   * have a corresponding 'struct oid_array' (in the 'util' field) which lists
>   * what the submodule pointers were updated to during the change.
>   */
> -static void collect_changed_submodules(struct string_list *changed,
> +static void collect_changed_submodules(struct index_state *istate,
> +				       struct string_list *changed,
>  				       struct argv_array *argv)
>  {
>  	struct rev_info rev;

This function doesn't actually make use of the newly added "istate" (nor
does it use the_index, so there's not a spot that forgot to get
converted). Is this in preparation for more refactoring, or is it just a
mistake and can be dropped?

I don't see anything in the "Kill the_index, final part" series that
would need it.

If this can be dropped, then most of the other changes here can, too,
because they're just pushing the unused parameter down the stack. I.e.:

diff --git a/builtin/pull.c b/builtin/pull.c
index 798ecf7faf..49e6f87b31 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -945,7 +945,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		int ret = 0;
 		if ((recurse_submodules == RECURSE_SUBMODULES_ON ||
 		     recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND) &&
-		    submodule_touches_in_range(&the_index, &rebase_fork_point, &curr_head))
+		    submodule_touches_in_range(&rebase_fork_point, &curr_head))
 			die(_("cannot rebase with locally recorded submodule modifications"));
 		if (!autostash) {
 			struct commit_list *list = NULL;
diff --git a/submodule.c b/submodule.c
index 5635dbda13..55298a4dab 100644
--- a/submodule.c
+++ b/submodule.c
@@ -767,8 +767,7 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
  * have a corresponding 'struct oid_array' (in the 'util' field) which lists
  * what the submodule pointers were updated to during the change.
  */
-static void collect_changed_submodules(struct index_state *UNUSED(istate),
-				       struct string_list *changed,
+static void collect_changed_submodules(struct string_list *changed,
 				       struct argv_array *argv)
 {
 	struct rev_info rev;
@@ -933,8 +932,7 @@ static int submodule_needs_pushing(const char *path, struct oid_array *commits)
 	return 0;
 }
 
-int find_unpushed_submodules(struct index_state *istate,
-			     struct oid_array *commits,
+int find_unpushed_submodules(struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing)
 {
@@ -948,7 +946,7 @@ int find_unpushed_submodules(struct index_state *istate,
 	argv_array_push(&argv, "--not");
 	argv_array_pushf(&argv, "--remotes=%s", remotes_name);
 
-	collect_changed_submodules(istate, &submodules, &argv);
+	collect_changed_submodules(&submodules, &argv);
 
 	for_each_string_list_item(name, &submodules) {
 		struct oid_array *commits = name->util;
@@ -1049,8 +1047,7 @@ static void submodule_push_check(const char *path, const char *head,
 		die("process for submodule '%s' failed", path);
 }
 
-int push_unpushed_submodules(struct index_state *istate,
-			     struct oid_array *commits,
+int push_unpushed_submodules(struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
@@ -1059,7 +1056,7 @@ int push_unpushed_submodules(struct index_state *istate,
 	int i, ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
-	if (!find_unpushed_submodules(istate, commits,
+	if (!find_unpushed_submodules(commits,
 				      remote->name, &needs_pushing))
 		return 1;
 
@@ -1118,7 +1115,7 @@ void check_for_new_submodule_commits(struct object_id *oid)
 	oid_array_append(&ref_tips_after_fetch, oid);
 }
 
-static void calculate_changed_submodule_paths(struct index_state *istate)
+static void calculate_changed_submodule_paths(void)
 {
 	struct argv_array argv = ARGV_ARRAY_INIT;
 	struct string_list changed_submodules = STRING_LIST_INIT_DUP;
@@ -1139,7 +1136,7 @@ static void calculate_changed_submodule_paths(struct index_state *istate)
 	 * Collect all submodules (whether checked out or not) for which new
 	 * commits have been recorded upstream in "changed_submodule_names".
 	 */
-	collect_changed_submodules(istate, &changed_submodules, &argv);
+	collect_changed_submodules(&changed_submodules, &argv);
 
 	for_each_string_list_item(name, &changed_submodules) {
 		struct oid_array *commits = name->util;
@@ -1166,8 +1163,7 @@ static void calculate_changed_submodule_paths(struct index_state *istate)
 	initialized_fetch_ref_tips = 0;
 }
 
-int submodule_touches_in_range(struct index_state *istate,
-			       struct object_id *excl_oid,
+int submodule_touches_in_range(struct object_id *excl_oid,
 			       struct object_id *incl_oid)
 {
 	struct string_list subs = STRING_LIST_INIT_DUP;
@@ -1185,7 +1181,7 @@ int submodule_touches_in_range(struct index_state *istate,
 		argv_array_push(&args, oid_to_hex(excl_oid));
 	}
 
-	collect_changed_submodules(istate, &subs, &args);
+	collect_changed_submodules(&subs, &args);
 	ret = subs.nr;
 
 	argv_array_clear(&args);
@@ -1356,7 +1352,7 @@ int fetch_populated_submodules(struct repository *r,
 	argv_array_push(&spf.args, "--recurse-submodules-default");
 	/* default value, "--submodule-prefix" and its value are added later */
 
-	calculate_changed_submodule_paths(r->index);
+	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
 			       get_next_submodule,
 			       fetch_start_failure,
diff --git a/submodule.h b/submodule.h
index ca861abe5a..8ab04e2327 100644
--- a/submodule.h
+++ b/submodule.h
@@ -102,16 +102,13 @@ int add_submodule_odb(const char *path);
  * Checks if there are submodule changes in a..b. If a is the null OID,
  * checks b and all its ancestors instead.
  */
-int submodule_touches_in_range(struct index_state *istate,
-			       struct object_id *a,
+int submodule_touches_in_range(struct object_id *a,
 			       struct object_id *b);
-int find_unpushed_submodules(struct index_state *istate,
-			     struct oid_array *commits,
+int find_unpushed_submodules(struct oid_array *commits,
 			     const char *remotes_name,
 			     struct string_list *needs_pushing);
 struct refspec;
-int push_unpushed_submodules(struct index_state *istate,
-			     struct oid_array *commits,
+int push_unpushed_submodules(struct oid_array *commits,
 			     const struct remote *remote,
 			     const struct refspec *rs,
 			     const struct string_list *push_options,
diff --git a/transport.c b/transport.c
index d0764fee19..4bf7fa5365 100644
--- a/transport.c
+++ b/transport.c
@@ -1172,8 +1172,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (!push_unpushed_submodules(&the_index,
-						      &commits,
+			if (!push_unpushed_submodules(&commits,
 						      transport->remote,
 						      rs,
 						      transport->push_options,
@@ -1197,8 +1196,7 @@ int transport_push(struct transport *transport,
 					oid_array_append(&commits,
 							  &ref->new_oid);
 
-			if (find_unpushed_submodules(&the_index,
-						     &commits,
+			if (find_unpushed_submodules(&commits,
 						     transport->remote->name,
 						     &needs_pushing)) {
 				oid_array_clear(&commits);
