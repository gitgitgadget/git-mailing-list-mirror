Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B899C7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 03:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjFLDqo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jun 2023 23:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjFLDqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2023 23:46:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A4BC
        for <git@vger.kernel.org>; Sun, 11 Jun 2023 20:46:40 -0700 (PDT)
Received: (qmail 23693 invoked by uid 109); 12 Jun 2023 03:46:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jun 2023 03:46:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11750 invoked by uid 111); 12 Jun 2023 03:46:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 11 Jun 2023 23:46:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 11 Jun 2023 23:46:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 06/11] branch: fix a leak in cmd_branch
Message-ID: <20230612034639.GF306352@coredump.intra.peff.net>
References: <9eb931e7-dd18-8ce8-4d4a-cf3d85066189@gmail.com>
 <6cbdf9b9-227a-4665-5725-6a863676e95d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6cbdf9b9-227a-4665-5725-6a863676e95d@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 11, 2023 at 08:50:05PM +0200, Rubén Justo wrote:

> We don't have a common clean-up section in cmd_branch().  To avoid
> refactoring and keep the fix simple, and while we find a better
> solution, let's silence the leak-hunter making the list static.

Gross. :)

If we are just going to annotate here, I'd prefer to use UNLEAK(). It
makes it more obvious this is about leak-checking, and doesn't imply
that we otherwise care about the lifetime of this field. Like:

diff --git a/builtin/branch.c b/builtin/branch.c
index e6c2655af6..075e580d22 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -832,6 +832,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
+	UNLEAK(sorting_options);
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));

> diff --git a/builtin/branch.c b/builtin/branch.c
> index e6c2655af6..759480fe8d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -709,7 +709,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  	enum branch_track track;
>  	struct ref_filter filter;
>  	static struct ref_sorting *sorting;
> -	struct string_list sorting_options = STRING_LIST_INIT_DUP;
> +	static struct string_list sorting_options = STRING_LIST_INIT_DUP;

It's interesting that the ref_sorting pointer is also static. This goes
back to aedcb7dc75 (branch.c: use 'ref-filter' APIs, 2015-09-23). I
wonder if it was trying to accomplish the same thing (back then we added
directly to the list), though back then we did not have any real
leak-detection tools set up.

It should probably move into the "if (list)" block, but that is
orthogonal to your patch.

As for the more complete fix, I think we'd perhaps want something like
this, which would also detect when --sort is used in a non-list mode (as
your example shows, it's a little complicated because we stuff
configured entries into the same list):

diff --git a/builtin/branch.c b/builtin/branch.c
index e6c2655af6..bcd2d9e1d9 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -708,8 +708,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    recurse_submodules_explicit = 0;
 	enum branch_track track;
 	struct ref_filter filter;
-	static struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
+	size_t nr_configured_sorting_options;
 	struct ref_format format = REF_FORMAT_INIT;
 
 	struct option options[] = {
@@ -773,6 +773,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_branch_usage, options);
 
 	git_config(git_branch_config, &sorting_options);
+	nr_configured_sorting_options = sorting_options.nr;
 
 	track = git_branch_track;
 
@@ -832,6 +833,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (list)
 		setup_auto_pager("branch", 1);
 
+	if (!list) {
+		if (sorting_options.nr != nr_configured_sorting_options)
+			die(_("--sort does not make sense when not listing"));
+		string_list_clear(&sorting_options, 0);
+	}
+
 	if (delete) {
 		if (!argc)
 			die(_("branch name required"));
@@ -840,6 +847,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		print_current_branch_name();
 		return 0;
 	} else if (list) {
+		struct ref_sorting *sorting;
 		/*  git branch --list also shows HEAD when it is detached */
 		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
 			filter.kind |= FILTER_REFS_DETACHED_HEAD;

-Peff
