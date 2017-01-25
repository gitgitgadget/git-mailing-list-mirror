Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A67841F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbdAYV1a (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:27:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:44809 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752552AbdAYV13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:27:29 -0500
Received: (qmail 4205 invoked by uid 109); 25 Jan 2017 21:27:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 21:27:23 +0000
Received: (qmail 16235 invoked by uid 111); 25 Jan 2017 21:27:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 16:27:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 16:27:21 -0500
Date:   Wed, 25 Jan 2017 16:27:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 4/5] revision.c: refactor ref selection handler after
 --exclude
Message-ID: <20170125212721.7tbxkqsdtsv2n5mx@sigill.intra.peff.net>
References: <20170121140806.tjs6wad3x4srdv3q@sigill.intra.peff.net>
 <20170125125054.7422-1-pclouds@gmail.com>
 <20170125125054.7422-5-pclouds@gmail.com>
 <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170125205718.ksqstdnazmgbkehy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 03:57:18PM -0500, Jeff King wrote:

> IOW, the ref-selector options build up until a group option is given,
> which acts on the built-up options (over that group) and then resets the
> built-up options. Doing "--unrelated" as above is orthogonal (though I
> think in practice nobody would do that, because it's hard to read).

So here's what I would have expected your series to look more like (with
probably one patch adding clear_ref_selection_options, and the other
adding the decorate stuff):

diff --git a/revision.c b/revision.c
index b37dbec37..2f67707c7 100644
--- a/revision.c
+++ b/revision.c
@@ -1156,6 +1156,11 @@ static int handle_one_ref(const char *path, const struct object_id *oid,
 
 	if (ref_excluded(cb->all_revs->ref_excludes, path))
 	    return 0;
+	if (cb->all_revs->decorate_reflog) {
+		/* TODO actually do it for real */
+		warning("would decorate %s", path);
+		return 0; /* do not add it as a tip */
+	}
 
 	object = get_reference(cb->all_revs, path, oid->hash, cb->all_flags);
 	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
@@ -1188,6 +1193,12 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 	string_list_append(*ref_excludes_p, exclude);
 }
 
+static void clear_ref_selection_options(struct rev_info *revs)
+{
+	clear_ref_exclusion(&revs->ref_excludes);
+	revs->decorate_reflog = 0;
+}
+
 static void handle_refs(const char *submodule, struct rev_info *revs, unsigned flags,
 		int (*for_each)(const char *, each_ref_fn, void *))
 {
@@ -2080,10 +2091,10 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (!strcmp(arg, "--all")) {
 		handle_refs(submodule, revs, *flags, for_each_ref_submodule);
 		handle_refs(submodule, revs, *flags, head_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
 	} else if (!strcmp(arg, "--branches")) {
 		handle_refs(submodule, revs, *flags, for_each_branch_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
 	} else if (!strcmp(arg, "--bisect")) {
 		read_bisect_terms(&term_bad, &term_good);
 		handle_refs(submodule, revs, *flags, for_each_bad_bisect_ref);
@@ -2091,15 +2102,15 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		revs->bisect = 1;
 	} else if (!strcmp(arg, "--tags")) {
 		handle_refs(submodule, revs, *flags, for_each_tag_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
 	} else if (!strcmp(arg, "--remotes")) {
 		handle_refs(submodule, revs, *flags, for_each_remote_ref_submodule);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
 	} else if ((argcount = parse_long_opt("glob", argv, &optarg))) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref(handle_one_ref, optarg, &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
 		return argcount;
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
@@ -2108,17 +2119,19 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
 	} else if (starts_with(arg, "--tags=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
 	} else if (starts_with(arg, "--remotes=")) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
 		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
-		clear_ref_exclusion(&revs->ref_excludes);
+		clear_ref_selection_options(revs);
+	} else if (!strcmp(arg, "--decorate-reflog")) {
+		revs->decorate_reflog = 1;
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
 	} else if (!strcmp(arg, "--indexed-objects")) {
diff --git a/revision.h b/revision.h
index 9fac1a607..c74879829 100644
--- a/revision.h
+++ b/revision.h
@@ -66,6 +66,8 @@ struct rev_info {
 	/* excluding from --branches, --refs, etc. expansion */
 	struct string_list *ref_excludes;
 
+	int decorate_reflog;
+
 	/* Basic information */
 	const char *prefix;
 	const char *def;
