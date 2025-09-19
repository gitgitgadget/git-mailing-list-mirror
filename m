Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D69E2D6E4A
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322131; cv=none; b=cQODYT86VJxspGy1gk5ipsk4TfcZm+BkkCYrLPK88LaKX5rnzRmo5lOj01JiEBgcf2j2pTFmfgHIZEjGtP6HwE+TD047nyc+FaSHa9/wdUKRj8ZIJ6RpyOZfjrfHsmqubKO1IjAcwpWoM9avrjcZqQtQa3gBdD+quUgnGL9VRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322131; c=relaxed/simple;
	bh=IlRMSOmz1LBEV5fRWSHbfy4RP0p1VEnhbdWpxSj4RO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oECnWpzf8PUGheXYc8saSD2DvbIkirBmNhYS99eAa3byP/DGoCaQBVfRcf7k8ed0tEy3G3RA2iJBZXU5Zu7qHCGUOBo56b6fqBoRTMbq8Q1uFA4V2uP9sSu81CSxkERxndZvPmm/RbRwIREyBGua4JjjbG2zY01mB/1JMTw+oMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=g435mGJg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="g435mGJg"
Received: (qmail 134782 invoked by uid 109); 19 Sep 2025 22:48:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IlRMSOmz1LBEV5fRWSHbfy4RP0p1VEnhbdWpxSj4RO4=; b=g435mGJgvT/oDlv0wAxK2SKRMAZcZZuE1F2Y1VGITxeIpP1F1L5z6ECxZlCMLWNh4Rmgxfc/pudCKRVfYwRvnThIiMeIDfQXxROytPGTUkLL0pORg4qo8ahz51GzTM7vvZz5nK99t3jmYNcRBWeYx9xCDykDwsOatyoMnWTEE/MxjYlj5LhbDeKR1wy+/hHXLm1irqo6B8jWKNKWGy6XFL3w0UP2ZY5K00n0L2kOhPqwpfzk3P7JA9WciB/tj9+b34pvZ9oQAOC/eQ7b7piQah/DXoJWhVWfMKoG44srRxtgj+z61OiWRZDOwk1yjQ/ORWmU5RpkmGzwMgQwHHwCHw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 22:48:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211400 invoked by uid 111); 19 Sep 2025 22:48:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 18:48:47 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 18:48:47 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3/6] revision: add wrapper to setup_revisions() from a strvec
Message-ID: <20250919224847.GC594545@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919223351.GA3906184@coredump.intra.peff.net>

The setup_revisions() function was designed to take the argc/argv pair
from the operating system. But we sometimes construct our own argv using
a strvec and pass that in. There are a few gotchas that callers need to
deal with here:

  1. You should always pass the free_removed_argv_elements option via
     setup_revision_opt. Otherwise, entries may be leaked if
     setup_revisions() re-shuffles options.

  2. After setup_revisions() returns, the strvec state is odd. We get a
     reduced argc from setup_revisions() telling us how many unknown
     options were left in place. Entries after that in argv may be
     retained, or may be NULL (depending on how the reshuffling
     happened). But the strvec's "nr" field still represents the
     original value, and some of the entries it thinks it is still
     storing may be NULL. Callers must be careful with how they access
     it.

Some callers deal with (1), but not all. In practice they are OK because
they do not pass any options that would cause setup_revisions() to
re-shuffle (namely unknown options which may be relayed from the user,
and the use of the "--" separator). But it's probably a good idea to
consistently pass this option anyway to future-proof ourselves against
the details of setup_revisions() changing.

No callers address (2), though I don't think there any visible bugs.
Most of them simply call strvec_clear() and never otherwise look at the
result. And in fact, if they naively set foo.nr to the argc returned by
setup_revisions(), that would cause leaks!  Because setup_revisions()
does not free consumed options[1], we have to leave the "nr" field of
the strvec at its original value to find and free them during
strvec_clear().

So I don't think there are any bugs to fix here, but we can make things
safer and simpler for callers. Let's introduce a helper function that
sets the free_removed_argv_elements automatically and shrinks the strvec
to represent the retained options afterwards (taking care to free the
now-obsolete entries).

We'll start by converting all of the call-sites which the
free_removed_argv_elements option. There should be no behavior change
for them, except that their "shrunken" entries are cleaned up
immediately, rather than waiting for a strvec_clear() call.

[1] Arguably setup_revisions() should be doing this step for us if we
    told it to free removed options, but there are many existing callers
    which will be broken if it did. Introducing this helper is a
    possible first step towards that.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c                    |  5 +----
 builtin/stash.c             |  5 ++---
 builtin/submodule--helper.c | 10 ++--------
 remote.c                    |  5 +----
 revision.c                  | 19 +++++++++++++++++++
 revision.h                  |  2 ++
 6 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/bisect.c b/bisect.c
index f24474542e..a6dc76b15c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -674,9 +674,6 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 			     const char *bad_format, const char *good_format,
 			     int read_paths)
 {
-	struct setup_revision_opt opt = {
-		.free_removed_argv_elements = 1,
-	};
 	int i;
 
 	repo_init_revisions(r, revs, prefix);
@@ -693,7 +690,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	if (read_paths)
 		read_bisect_paths(rev_argv);
 
-	setup_revisions(rev_argv->nr, rev_argv->v, revs, &opt);
+	setup_revisions_from_strvec(rev_argv, revs, NULL);
 }
 
 static void bisect_common(struct rev_info *revs)
diff --git a/builtin/stash.c b/builtin/stash.c
index e5ab3c4cf5..3b473c4489 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -957,7 +957,6 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 static int show_stash(int argc, const char **argv, const char *prefix,
 		      struct repository *repo UNUSED)
 {
-	struct setup_revision_opt opt = { .free_removed_argv_elements = 1 };
 	int i;
 	int ret = -1;
 	struct stash_info info = STASH_INFO_INIT;
@@ -1016,8 +1015,8 @@ static int show_stash(int argc, const char **argv, const char *prefix,
 		}
 	}
 
-	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, &opt);
-	if (argc > 1)
+	setup_revisions_from_strvec(&revision_args, &rev, NULL);
+	if (revision_args.nr > 1)
 		goto usage;
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..fcd73abe53 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -616,9 +616,6 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 	struct rev_info rev = REV_INFO_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	const char *git_dir;
-	struct setup_revision_opt opt = {
-		.free_removed_argv_elements = 1,
-	};
 
 	if (validate_submodule_path(path) < 0)
 		die(NULL);
@@ -655,7 +652,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
-	setup_revisions(diff_files_args.nr, diff_files_args.v, &rev, &opt);
+	setup_revisions_from_strvec(&diff_files_args, &rev, NULL);
 	run_diff_files(&rev, 0);
 
 	if (!diff_result_code(&rev)) {
@@ -1094,9 +1091,6 @@ static int compute_summary_module_list(struct object_id *head_oid,
 {
 	struct strvec diff_args = STRVEC_INIT;
 	struct rev_info rev;
-	struct setup_revision_opt opt = {
-		.free_removed_argv_elements = 1,
-	};
 	struct module_cb_list list = MODULE_CB_LIST_INIT;
 	int ret = 0;
 
@@ -1114,7 +1108,7 @@ static int compute_summary_module_list(struct object_id *head_oid,
 	repo_init_revisions(the_repository, &rev, info->prefix);
 	rev.abbrev = 0;
 	precompose_argv_prefix(diff_args.nr, diff_args.v, NULL);
-	setup_revisions(diff_args.nr, diff_args.v, &rev, &opt);
+	setup_revisions_from_strvec(&diff_args, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_NO_OUTPUT | DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = submodule_summary_callback;
 	rev.diffopt.format_callback_data = &list;
diff --git a/remote.c b/remote.c
index 81d8fc017e..df9675cd33 100644
--- a/remote.c
+++ b/remote.c
@@ -2143,9 +2143,6 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	struct object_id oid;
 	struct commit *ours, *theirs;
 	struct rev_info revs;
-	struct setup_revision_opt opt = {
-		.free_removed_argv_elements = 1,
-	};
 	struct strvec argv = STRVEC_INIT;
 
 	/* Cannot stat if what we used to build on no longer exists */
@@ -2180,7 +2177,7 @@ static int stat_branch_pair(const char *branch_name, const char *base,
 	strvec_push(&argv, "--");
 
 	repo_init_revisions(the_repository, &revs, NULL);
-	setup_revisions(argv.nr, argv.v, &revs, &opt);
+	setup_revisions_from_strvec(&argv, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
 
diff --git a/revision.c b/revision.c
index 6c140d969d..f50f5d8ea2 100644
--- a/revision.c
+++ b/revision.c
@@ -3195,6 +3195,25 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	return left;
 }
 
+void setup_revisions_from_strvec(struct strvec *argv, struct rev_info *revs,
+				 struct setup_revision_opt *opt)
+{
+	struct setup_revision_opt fallback_opt;
+	int ret;
+
+	if (!opt) {
+		memset(&fallback_opt, 0, sizeof(fallback_opt));
+		opt = &fallback_opt;
+	}
+	opt->free_removed_argv_elements = 1;
+
+	ret = setup_revisions(argv->nr, argv->v, revs, opt);
+
+	for (size_t i = ret; i < argv->nr; i++)
+		free((char *)argv->v[i]);
+	argv->nr = ret;
+}
+
 static void release_revisions_cmdline(struct rev_cmdline_info *cmdline)
 {
 	unsigned int i;
diff --git a/revision.h b/revision.h
index 21e288c5ba..a28e349044 100644
--- a/revision.h
+++ b/revision.h
@@ -441,6 +441,8 @@ struct setup_revision_opt {
 };
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
+void setup_revisions_from_strvec(struct strvec *argv, struct rev_info *revs,
+				 struct setup_revision_opt *);
 
 /**
  * Free data allocated in a "struct rev_info" after it's been
-- 
2.51.0.568.g6b54b97edf

