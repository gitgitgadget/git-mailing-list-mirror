Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1361FFC59
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739475782; cv=none; b=e4KNDUMYRFHmM9UgRlODq0+hHNE7fx5aTX2eyqtOSwghoYPNbw+A0WPvvkiqXNQv2iBVzYGcGs+x5WOFU5Y1KcdXL7ZQPAQBfpVpmfSVuwpkApiOcJfxA7dBEjGIs7tNCvaoC4bLxTky5yQTtTotPvyJpHaPXjjsA8qIBkadftQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739475782; c=relaxed/simple;
	bh=7NJ/FwfR6bYObkYs4kKrh0ghKy/K3usHxfsIK+nSmPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/mnA14L6q9U//3QH6YQkdmuxWwCO7/A/3q+FV/zxfgHdxPgJ7/CN6yVaEvgKhYnFgAoEapzDvqXXjvCOo5/C00e/luoaqRVW9puPRJJxm7RgixduhgdyzzlQqekOAWOjGHWNEWhLLy6zyT7yT3VAK4qArqwgowwXkDwv5+0l4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dwrBIH+Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dwrBIH+Z"
Received: (qmail 1230 invoked by uid 109); 13 Feb 2025 19:42:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7NJ/FwfR6bYObkYs4kKrh0ghKy/K3usHxfsIK+nSmPA=; b=dwrBIH+ZJI0IrfxmYjyW9ip7rW5yx2ovilpTgEqhk2wTE/r3TQ+C0H8bc/YEenoOoxGJSdiLvdilDJxYApdOxBozziYYoDR3QBtW64OnF7liQALprfaj1RgMoFpq7/Pf0SyZxJe+So2GxfqOJo+a7YJBoq6wQj1I1WgMvFiPkXgTqd1xT45yNvdOZthWd5+Jh+KQD0syBTgN9ZtejH77nqXzXfUhCh0R/KAJTxkOpvIhG/N5aaCZRQMs1Z+94J4LHRybA20eny3UQ4WZQv3Jrm7y9S/JmCdV5pvKkfXV4tQOeu6BJOqhmvamH75nL66aj/kQLWrBeU8fsc2lP63cqA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Feb 2025 19:42:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 422 invoked by uid 111); 13 Feb 2025 19:42:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2025 14:42:57 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Feb 2025 14:42:56 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <20250213194256.GA934256@coredump.intra.peff.net>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
 <Z62booOOXODOl_sZ@pks.im>
 <20250213082221.GA916028@coredump.intra.peff.net>
 <Z63VY_wa7Z6lrUfY@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z63VY_wa7Z6lrUfY@pks.im>

On Thu, Feb 13, 2025 at 12:20:03PM +0100, Patrick Steinhardt wrote:

> Yes, `refs_verify_refname_available()` is exactly the problem. We spend
> ~80% of the time in that function after the optimization I have pointed
> out for `repo_get_oid()`. I assume that we'd see similar performance for
> the "files" backend if we had 360k refs and inserted 360k other refs,
> but haven't verified this claim.

Yeah. I didn't test it, but reading your analysis, I similarly thought
that having non-deleted refs might cause the same problem.

> > Try:
> > 
> >   git -c core.warnAmbiguousRefs=false update-ref --stdin
> > 
> > to disable that. Internally there's a warn_on_object_refname_ambiguity
> > flag that some code (like cat-file) sets when it knows it may be asked
> > to do a resolve a lot of entries that are likely to be oids.
> > 
> > I kind of wonder if we should ditch that warning. But if we wanted to
> > keep it, maybe adding a flag to get_oid_with_context() would be a less
> > hacky way of disabling that warning on a per-call basis.
> 
> Ah, that makes a lot of sense. I don't really think the warning makes
> sense for git-update-ref(1), so introducing a flag is probably the best
> way to go about this.

So I think the core of my suggestion is to just turn off the existing
flag, like:

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4d35bdc4b4..00e340a53b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -618,6 +618,8 @@ static void update_refs_stdin(void)
 	if (!transaction)
 		die("%s", err.buf);
 
+	warn_on_object_refname_ambiguity = 0; /* XXX should also restore after */
+
 	/* Read each line dispatch its command */
 	while (!strbuf_getwholeline(&input, stdin, line_termination)) {
 		const struct parse_cmd *cmd = NULL;

which would solve the immediate problem, and is what we do elsewhere for
stdin modes.

But I'm not sure if my suggestion to do a per-call flag makes sense. A
patch for that is below, but it gets weird for commands like rev-list.
There we turn off the warning for --stdin, but leave it on for arguments
on the command line. But they both end up in handle_revision(), so if we
convert that global into a per-call flag, they'll both be affected. You
could mitigate that by passing the flags down to handle_revision(), but
it gets even weirder with stuff like collect_changed_submodules(), which
puts a potentially large number of entries into a fake argv to call
setup_revisions().

So the patch below, which illustrates the idea, probably weakens the
warning to the point of being useless, as commands that use revision.c
would never warn at all. So probably we're better off with the hacky
global, or just getting rid of the warning entirely. I have trouble
imagining it helping much beyond something like:

  git branch $some_oid

which creates refs/heads/$some_oid. But we probably would be better off
warning about that at the time of writing rather than checking for
ambiguity on each read.

-Peff

---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b13561cf73..ad7a0a6407 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -526,7 +526,7 @@ static void batch_one_object(const char *obj_name,
 {
 	struct object_context ctx = {0};
 	int flags =
-		GET_OID_HASH_ANY |
+		GET_OID_HASH_ANY | GET_OID_SKIP_OBJREF |
 		(opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0);
 	enum get_oid_result result;
 
@@ -781,7 +781,6 @@ static int batch_objects(struct batch_options *opt)
 	struct strbuf input = STRBUF_INIT;
 	struct strbuf output = STRBUF_INIT;
 	struct expand_data data;
-	int save_warning;
 	int retval = 0;
 
 	/*
@@ -850,16 +849,6 @@ static int batch_objects(struct batch_options *opt)
 		return 0;
 	}
 
-	/*
-	 * We are going to call get_sha1 on a potentially very large number of
-	 * objects. In most large cases, these will be actual object sha1s. The
-	 * cost to double-check that each one is not also a ref (just so we can
-	 * warn) ends up dwarfing the actual cost of the object lookups
-	 * themselves. We can work around it by just turning off the warning.
-	 */
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
-
 	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
 		batch_objects_command(opt, &output, &data);
 		goto cleanup;
@@ -886,7 +875,6 @@ static int batch_objects(struct batch_options *opt)
  cleanup:
 	strbuf_release(&input);
 	strbuf_release(&output);
-	warn_on_object_refname_ambiguity = save_warning;
 	return retval;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 58a9b16126..128cc39860 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4190,17 +4190,13 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 	};
 	char line[1000];
 	int flags = 0;
-	int save_warning;
 
 	save_commit_buffer = 0;
 	setup_revisions(ac, av, revs, &s_r_opt);
 
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
-
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
 		if (len && line[len - 1] == '\n')
@@ -4227,8 +4223,6 @@ static void get_object_list(struct rev_info *revs, int ac, const char **av)
 			die(_("bad revision '%s'"), line);
 	}
 
-	warn_on_object_refname_ambiguity = save_warning;
-
 	if (use_bitmap_index && !get_object_list_from_bitmap(revs))
 		return;
 
diff --git a/environment.c b/environment.c
index e5b361bb5d..b619d0c2b8 100644
--- a/environment.c
+++ b/environment.c
@@ -36,7 +36,6 @@ int minimum_abbrev = 4, default_abbrev = -1;
 int ignore_case;
 int assume_unchanged;
 int is_bare_repository_cfg = -1; /* unspecified */
-int warn_on_object_refname_ambiguity = 1;
 int repository_format_precious_objects;
 char *git_commit_encoding;
 char *git_log_output_encoding;
diff --git a/environment.h b/environment.h
index 2f43340f0b..87f71807b7 100644
--- a/environment.h
+++ b/environment.h
@@ -156,7 +156,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
 extern char *apply_default_ignorewhitespace;
 extern char *git_attributes_file;
diff --git a/hash.h b/hash.h
index 4367acfec5..e9d881c06e 100644
--- a/hash.h
+++ b/hash.h
@@ -204,6 +204,7 @@ struct object_id {
 #define GET_OID_ONLY_TO_DIE    04000
 #define GET_OID_REQUIRE_PATH  010000
 #define GET_OID_HASH_ANY      020000
+#define GET_OID_SKIP_OBJREF   040000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 945d5bdef2..516f214562 100644
--- a/object-name.c
+++ b/object-name.c
@@ -961,7 +961,8 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
-		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
+		if (repo_settings_get_warn_ambiguous_refs(r) &&
+		    !(flags & GET_OID_SKIP_OBJREF)) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);
diff --git a/revision.c b/revision.c
index 474fa1e767..5c8e80a0c2 100644
--- a/revision.c
+++ b/revision.c
@@ -2184,7 +2184,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 	int local_flags;
 	const char *arg = arg_;
 	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
-	unsigned get_sha1_flags = GET_OID_RECORD_PATH;
+	unsigned get_sha1_flags = GET_OID_RECORD_PATH | GET_OID_SKIP_OBJREF;
 	int ret;
 
 	flags = flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
@@ -2914,12 +2914,8 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 	struct strbuf sb;
 	int seen_dashdash = 0;
 	int seen_end_of_options = 0;
-	int save_warning;
 	int flags = 0;
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
-
 	strbuf_init(&sb, 1000);
 	while (strbuf_getline(&sb, stdin) != EOF) {
 		if (!sb.len)
@@ -2952,7 +2948,6 @@ static void read_revisions_from_stdin(struct rev_info *revs,
 		read_pathspec_from_stdin(&sb, prune);
 
 	strbuf_release(&sb);
-	warn_on_object_refname_ambiguity = save_warning;
 }
 
 static void NORETURN diagnose_missing_default(const char *def)
diff --git a/submodule.c b/submodule.c
index b361076c5b..e63019a6f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -916,16 +916,12 @@ static void collect_changed_submodules(struct repository *r,
 {
 	struct rev_info rev;
 	const struct commit *commit;
-	int save_warning;
 	struct setup_revision_opt s_r_opt = {
 		.assume_dashdash = 1,
 	};
 
-	save_warning = warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity = 0;
 	repo_init_revisions(r, &rev, NULL);
 	setup_revisions(argv->nr, argv->v, &rev, &s_r_opt);
-	warn_on_object_refname_ambiguity = save_warning;
 	if (prepare_revision_walk(&rev))
 		die(_("revision walk setup failed"));
 
