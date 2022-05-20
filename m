Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB41C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 08:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbiETI1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 04:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239123AbiETI0v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 04:26:51 -0400
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 May 2022 01:26:44 PDT
Received: from hrbata.com (hrbata.com [109.123.216.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 34A8B2EA01
        for <git@vger.kernel.org>; Fri, 20 May 2022 01:26:42 -0700 (PDT)
Received: from fedora.redhat.com (ip-89-102-24-184.net.upcbroadband.cz [89.102.24.184])
        by hrbata.com (Postfix) with ESMTPSA id 38BA544C18;
        Fri, 20 May 2022 10:17:23 +0200 (CEST)
From:   Frantisek Hrbata <frantisek@hrbata.com>
To:     git@vger.kernel.org
Cc:     Frantisek Hrbata <frantisek@hrbata.com>,
        Josh Steadmon <steadmon@google.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] transport: free local and remote refs in transport_push()
Date:   Fri, 20 May 2022 10:17:22 +0200
Message-Id: <20220520081723.1031830-1-frantisek@hrbata.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in transport_push(), where remote_refs and local_refs
are never freed. While at it, remove the unnecessary indenting and make
the code hopefully more readable.

116 bytes in 1 blocks are definitely lost in loss record 56 of 103
   at 0x484486F: malloc (vg_replace_malloc.c:381)
   by 0x4938D7E: strdup (strdup.c:42)
   by 0x628418: xstrdup (wrapper.c:39)
   by 0x4FD454: process_capabilities (connect.c:232)
   by 0x4FD454: get_remote_heads (connect.c:354)
   by 0x610A38: handshake (transport.c:333)
   by 0x612B02: transport_push (transport.c:1302)
   by 0x4803D6: push_with_options (push.c:357)
   by 0x4811D6: do_push (push.c:414)
   by 0x4811D6: cmd_push (push.c:650)
   by 0x405210: run_builtin (git.c:465)
   by 0x405210: handle_builtin (git.c:719)
   by 0x406363: run_argv (git.c:786)
   by 0x406363: cmd_main (git.c:917)
   by 0x404F17: main (common-main.c:56)

5,912 (388 direct, 5,524 indirect) bytes in 2 blocks are definitely lost in loss record 98 of 103
   at 0x4849464: calloc (vg_replace_malloc.c:1328)
   by 0x628705: xcalloc (wrapper.c:150)
   by 0x5C216D: alloc_ref_with_prefix (remote.c:975)
   by 0x5C232A: alloc_ref (remote.c:983)
   by 0x5C232A: one_local_ref (remote.c:2299)
   by 0x5C232A: one_local_ref (remote.c:2289)
   by 0x5BDB03: do_for_each_repo_ref_iterator (iterator.c:418)
   by 0x5B4C4F: do_for_each_ref (refs.c:1486)
   by 0x5B4C4F: refs_for_each_ref (refs.c:1492)
   by 0x5B4C4F: for_each_ref (refs.c:1497)
   by 0x5C6ADF: get_local_heads (remote.c:2310)
   by 0x612A85: transport_push (transport.c:1286)
   by 0x4803D6: push_with_options (push.c:357)
   by 0x4811D6: do_push (push.c:414)
   by 0x4811D6: cmd_push (push.c:650)
   by 0x405210: run_builtin (git.c:465)
   by 0x405210: handle_builtin (git.c:719)
   by 0x406363: run_argv (git.c:786)
   by 0x406363: cmd_main (git.c:917)

Signed-off-by: Frantisek Hrbata <frantisek@hrbata.com>
---
For remote_refs it might be worth to leave the freeing to
transport_disconnect() and introduce helper similar to
transport_get_remote_refs().

 transport.c | 254 +++++++++++++++++++++++++++-------------------------
 1 file changed, 130 insertions(+), 124 deletions(-)

diff --git a/transport.c b/transport.c
index 3d64a43ab3..4c5d9db7f2 100644
--- a/transport.c
+++ b/transport.c
@@ -1276,146 +1276,152 @@ int transport_push(struct repository *r,
 		   struct refspec *rs, int flags,
 		   unsigned int *reject_reasons)
 {
+	struct ref *remote_refs = NULL;
+	struct ref *local_refs = NULL;
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
-
-		refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
-
-		trace2_region_enter("transport_push", "get_refs_list", r);
-		remote_refs = transport->vtable->get_refs_list(transport, 1,
-							       &transport_options);
-		trace2_region_leave("transport_push", "get_refs_list", r);
-
-		transport_ls_refs_options_release(&transport_options);
-
-		if (flags & TRANSPORT_PUSH_ALL)
-			match_flags |= MATCH_REFS_ALL;
-		if (flags & TRANSPORT_PUSH_MIRROR)
-			match_flags |= MATCH_REFS_MIRROR;
-		if (flags & TRANSPORT_PUSH_PRUNE)
-			match_flags |= MATCH_REFS_PRUNE;
-		if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
-			match_flags |= MATCH_REFS_FOLLOW_TAGS;
-
-		if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
-			return -1;
-
-		if (transport->smart_options &&
-		    transport->smart_options->cas &&
-		    !is_empty_cas(transport->smart_options->cas))
-			apply_push_cas(transport->smart_options->cas,
-				       transport->remote, remote_refs);
-
-		set_ref_status_for_push(remote_refs,
-			flags & TRANSPORT_PUSH_MIRROR,
-			flags & TRANSPORT_PUSH_FORCE);
-
-		if (!(flags & TRANSPORT_PUSH_NO_HOOK))
-			if (run_pre_push_hook(transport, remote_refs))
-				return -1;
+	if (!transport->vtable->push_refs)
+		return 1;
 
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
+	ret = -1;
+	local_refs = get_local_heads();
+
+	if (check_push_refs(local_refs, rs) < 0)
+		goto done;
+
+	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
+
+	trace2_region_enter("transport_push", "get_refs_list", r);
+	remote_refs = transport->vtable->get_refs_list(transport, 1,
+						       &transport_options);
+	trace2_region_leave("transport_push", "get_refs_list", r);
+
+	transport_ls_refs_options_release(&transport_options);
+
+	if (flags & TRANSPORT_PUSH_ALL)
+		match_flags |= MATCH_REFS_ALL;
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		match_flags |= MATCH_REFS_MIRROR;
+	if (flags & TRANSPORT_PUSH_PRUNE)
+		match_flags |= MATCH_REFS_PRUNE;
+	if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
+		match_flags |= MATCH_REFS_FOLLOW_TAGS;
+
+	if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
+		goto done;
+
+	if (transport->smart_options &&
+	    transport->smart_options->cas &&
+	    !is_empty_cas(transport->smart_options->cas))
+		apply_push_cas(transport->smart_options->cas,
+			       transport->remote, remote_refs);
+
+	set_ref_status_for_push(remote_refs,
+		flags & TRANSPORT_PUSH_MIRROR,
+		flags & TRANSPORT_PUSH_FORCE);
+
+	if (!(flags & TRANSPORT_PUSH_NO_HOOK))
+		if (run_pre_push_hook(transport, remote_refs))
+			goto done;
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
+done:
+	free_refs(local_refs);
+	free_refs(remote_refs);
+	return ret;
 }
 
 const struct ref *transport_get_remote_refs(struct transport *transport,

base-commit: e54793a95afeea1e10de1e5ad7eab914e7416250
-- 
2.35.1

