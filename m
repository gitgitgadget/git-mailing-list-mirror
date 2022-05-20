Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE56C433FE
	for <git@archiver.kernel.org>; Fri, 20 May 2022 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349534AbiETMuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 08:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349377AbiETMty (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 08:49:54 -0400
Received: from hrbata.com (hrbata.com [109.123.216.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79D651668B6
        for <git@vger.kernel.org>; Fri, 20 May 2022 05:49:53 -0700 (PDT)
Received: from fedora.redhat.com (ip-89-102-24-184.net.upcbroadband.cz [89.102.24.184])
        by hrbata.com (Postfix) with ESMTPSA id BCFBF44CEA;
        Fri, 20 May 2022 14:49:52 +0200 (CEST)
From:   Frantisek Hrbata <frantisek@hrbata.com>
To:     git@vger.kernel.org
Cc:     Frantisek Hrbata <frantisek@hrbata.com>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] transport: remove unnecessary indenting in transport_push()
Date:   Fri, 20 May 2022 14:49:50 +0200
Message-Id: <20220520124952.2393299-2-frantisek@hrbata.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520124952.2393299-1-frantisek@hrbata.com>
References: <20220520081723.1031830-1-frantisek@hrbata.com>
 <20220520124952.2393299-1-frantisek@hrbata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the big indented block for transport_push() check in transport vtable
and let's just return error immediately. Hopefully this makes the code
more readable.

Signed-off-by: Frantisek Hrbata <frantisek@hrbata.com>
---
 transport.c | 234 ++++++++++++++++++++++++++--------------------------
 1 file changed, 118 insertions(+), 116 deletions(-)

diff --git a/transport.c b/transport.c
index 3d64a43ab3..0b9c5a427d 100644
--- a/transport.c
+++ b/transport.c
@@ -1276,146 +1276,148 @@ int transport_push(struct repository *r,
 		   struct refspec *rs, int flags,
 		   unsigned int *reject_reasons)
 {
+	struct ref *remote_refs;
+	struct ref *local_refs;
+	int match_flags = MATCH_REFS_NONE;
+	int verbose = (transport->verbose > 0);
+	int quiet = (transport->verbose < 0);
+	int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
+	int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
+	int push_ret, ret, err;
+	struct transport_ls_refs_options transport_options =
+		TRANSPORT_LS_REFS_OPTIONS_INIT;
+
 	*reject_reasons = 0;
 
 	if (transport_color_config() < 0)
 		return -1;
 
-	if (transport->vtable->push_refs) {
-		struct ref *remote_refs;
-		struct ref *local_refs = get_local_heads();
-		int match_flags = MATCH_REFS_NONE;
-		int verbose = (transport->verbose > 0);
-		int quiet = (transport->verbose < 0);
-		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
-		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
-		int push_ret, ret, err;
-		struct transport_ls_refs_options transport_options =
-			TRANSPORT_LS_REFS_OPTIONS_INIT;
-
-		if (check_push_refs(local_refs, rs) < 0)
-			return -1;
+	if (!transport->vtable->push_refs)
+		return 1;
 
-		refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
+	local_refs = get_local_heads();
 
-		trace2_region_enter("transport_push", "get_refs_list", r);
-		remote_refs = transport->vtable->get_refs_list(transport, 1,
-							       &transport_options);
-		trace2_region_leave("transport_push", "get_refs_list", r);
+	if (check_push_refs(local_refs, rs) < 0)
+		return -1;
 
-		transport_ls_refs_options_release(&transport_options);
+	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
 
-		if (flags & TRANSPORT_PUSH_ALL)
-			match_flags |= MATCH_REFS_ALL;
-		if (flags & TRANSPORT_PUSH_MIRROR)
-			match_flags |= MATCH_REFS_MIRROR;
-		if (flags & TRANSPORT_PUSH_PRUNE)
-			match_flags |= MATCH_REFS_PRUNE;
-		if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
-			match_flags |= MATCH_REFS_FOLLOW_TAGS;
+	trace2_region_enter("transport_push", "get_refs_list", r);
+	remote_refs = transport->vtable->get_refs_list(transport, 1,
+						       &transport_options);
+	trace2_region_leave("transport_push", "get_refs_list", r);
 
-		if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
-			return -1;
+	transport_ls_refs_options_release(&transport_options);
 
-		if (transport->smart_options &&
-		    transport->smart_options->cas &&
-		    !is_empty_cas(transport->smart_options->cas))
-			apply_push_cas(transport->smart_options->cas,
-				       transport->remote, remote_refs);
+	if (flags & TRANSPORT_PUSH_ALL)
+		match_flags |= MATCH_REFS_ALL;
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		match_flags |= MATCH_REFS_MIRROR;
+	if (flags & TRANSPORT_PUSH_PRUNE)
+		match_flags |= MATCH_REFS_PRUNE;
+	if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
+		match_flags |= MATCH_REFS_FOLLOW_TAGS;
 
-		set_ref_status_for_push(remote_refs,
-			flags & TRANSPORT_PUSH_MIRROR,
-			flags & TRANSPORT_PUSH_FORCE);
+	if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
+		return -1;
 
-		if (!(flags & TRANSPORT_PUSH_NO_HOOK))
-			if (run_pre_push_hook(transport, remote_refs))
-				return -1;
+	if (transport->smart_options &&
+	    transport->smart_options->cas &&
+	    !is_empty_cas(transport->smart_options->cas))
+		apply_push_cas(transport->smart_options->cas,
+			       transport->remote, remote_refs);
 
-		if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
-			      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-		    !is_bare_repository()) {
-			struct ref *ref = remote_refs;
-			struct oid_array commits = OID_ARRAY_INIT;
-
-			trace2_region_enter("transport_push", "push_submodules", r);
-			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid))
-					oid_array_append(&commits,
-							  &ref->new_oid);
-
-			if (!push_unpushed_submodules(r,
-						      &commits,
-						      transport->remote,
-						      rs,
-						      transport->push_options,
-						      pretend)) {
-				oid_array_clear(&commits);
-				trace2_region_leave("transport_push", "push_submodules", r);
-				die(_("failed to push all needed submodules"));
-			}
+	set_ref_status_for_push(remote_refs,
+		flags & TRANSPORT_PUSH_MIRROR,
+		flags & TRANSPORT_PUSH_FORCE);
+
+	if (!(flags & TRANSPORT_PUSH_NO_HOOK))
+		if (run_pre_push_hook(transport, remote_refs))
+			return -1;
+
+	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
+		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
+	    !is_bare_repository()) {
+		struct ref *ref = remote_refs;
+		struct oid_array commits = OID_ARRAY_INIT;
+
+		trace2_region_enter("transport_push", "push_submodules", r);
+		for (; ref; ref = ref->next)
+			if (!is_null_oid(&ref->new_oid))
+				oid_array_append(&commits,
+						  &ref->new_oid);
+
+		if (!push_unpushed_submodules(r,
+					      &commits,
+					      transport->remote,
+					      rs,
+					      transport->push_options,
+					      pretend)) {
 			oid_array_clear(&commits);
 			trace2_region_leave("transport_push", "push_submodules", r);
+			die(_("failed to push all needed submodules"));
 		}
+		oid_array_clear(&commits);
+		trace2_region_leave("transport_push", "push_submodules", r);
+	}
 
-		if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
-		     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
-				TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
-		      !pretend)) && !is_bare_repository()) {
-			struct ref *ref = remote_refs;
-			struct string_list needs_pushing = STRING_LIST_INIT_DUP;
-			struct oid_array commits = OID_ARRAY_INIT;
-
-			trace2_region_enter("transport_push", "check_submodules", r);
-			for (; ref; ref = ref->next)
-				if (!is_null_oid(&ref->new_oid))
-					oid_array_append(&commits,
-							  &ref->new_oid);
-
-			if (find_unpushed_submodules(r,
-						     &commits,
-						     transport->remote->name,
-						     &needs_pushing)) {
-				oid_array_clear(&commits);
-				trace2_region_leave("transport_push", "check_submodules", r);
-				die_with_unpushed_submodules(&needs_pushing);
-			}
-			string_list_clear(&needs_pushing, 0);
+	if (((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) ||
+	     ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
+			TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
+	      !pretend)) && !is_bare_repository()) {
+		struct ref *ref = remote_refs;
+		struct string_list needs_pushing = STRING_LIST_INIT_DUP;
+		struct oid_array commits = OID_ARRAY_INIT;
+
+		trace2_region_enter("transport_push", "check_submodules", r);
+		for (; ref; ref = ref->next)
+			if (!is_null_oid(&ref->new_oid))
+				oid_array_append(&commits,
+						  &ref->new_oid);
+
+		if (find_unpushed_submodules(r,
+					     &commits,
+					     transport->remote->name,
+					     &needs_pushing)) {
 			oid_array_clear(&commits);
 			trace2_region_leave("transport_push", "check_submodules", r);
+			die_with_unpushed_submodules(&needs_pushing);
 		}
+		string_list_clear(&needs_pushing, 0);
+		oid_array_clear(&commits);
+		trace2_region_leave("transport_push", "check_submodules", r);
+	}
 
-		if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY)) {
-			trace2_region_enter("transport_push", "push_refs", r);
-			push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
-			trace2_region_leave("transport_push", "push_refs", r);
-		} else
-			push_ret = 0;
-		err = push_had_errors(remote_refs);
-		ret = push_ret | err;
-
-		if (!quiet || err)
-			transport_print_push_status(transport->url, remote_refs,
-					verbose | porcelain, porcelain,
-					reject_reasons);
-
-		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
-			set_upstreams(transport, remote_refs, pretend);
-
-		if (!(flags & (TRANSPORT_PUSH_DRY_RUN |
-			       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
-			struct ref *ref;
-			for (ref = remote_refs; ref; ref = ref->next)
-				transport_update_tracking_ref(transport->remote, ref, verbose);
-		}
+	if (!(flags & TRANSPORT_RECURSE_SUBMODULES_ONLY)) {
+		trace2_region_enter("transport_push", "push_refs", r);
+		push_ret = transport->vtable->push_refs(transport, remote_refs, flags);
+		trace2_region_leave("transport_push", "push_refs", r);
+	} else
+		push_ret = 0;
+	err = push_had_errors(remote_refs);
+	ret = push_ret | err;
+
+	if (!quiet || err)
+		transport_print_push_status(transport->url, remote_refs,
+				verbose | porcelain, porcelain,
+				reject_reasons);
+
+	if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
+		set_upstreams(transport, remote_refs, pretend);
+
+	if (!(flags & (TRANSPORT_PUSH_DRY_RUN |
+		       TRANSPORT_RECURSE_SUBMODULES_ONLY))) {
+		struct ref *ref;
+		for (ref = remote_refs; ref; ref = ref->next)
+			transport_update_tracking_ref(transport->remote, ref, verbose);
+	}
 
-		if (porcelain && !push_ret)
-			puts("Done");
-		else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
-			fprintf(stderr, "Everything up-to-date\n");
+	if (porcelain && !push_ret)
+		puts("Done");
+	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
+		fprintf(stderr, "Everything up-to-date\n");
 
-		return ret;
-	}
-	return 1;
+	return ret;
 }
 
 const struct ref *transport_get_remote_refs(struct transport *transport,
-- 
2.35.1

