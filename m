Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AAFC35247
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697042087E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 22:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBDWNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:13:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:52582 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727494AbgBDWNg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 17:13:36 -0500
Received: (qmail 11758 invoked by uid 109); 4 Feb 2020 22:13:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 04 Feb 2020 22:13:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3175 invoked by uid 111); 4 Feb 2020 22:21:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Feb 2020 17:21:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Feb 2020 17:13:35 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200204221335.GA15220@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
 <20200128073100.GA563058@coredump.intra.peff.net>
 <CAFQ2z_MZcYEDkyKENE+eRLAQCXObqqaypHvL_coHrecoxp655g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_MZcYEDkyKENE+eRLAQCXObqqaypHvL_coHrecoxp655g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 04, 2020 at 09:22:36PM +0100, Han-Wen Nienhuys wrote:

> >   - init/clone should take a command-line option for the ref format of
> >     the new repository. Anybody choosing reftables would want to set
> >     core.repositoryformatversion to "1" and set the extensions.refFormat
> >     key.
> 
> I did this, but are you sure this works? Where would the
> repo->ref_storage_format get set? I tried adding it to repo_init(),
> but this doesn't get called in a normal startup sequence.
> 
> Breakpoint 3, ref_store_init (gitdir=0x555555884b70 ".git",
> be_name=0x5555557942ca "reftable", flags=15) at refs.c:1841
> warning: Source file is more recent than executable.
> 1841 {
> (gdb) up
> #1  0x00005555556de2c8 in get_main_ref_store (r=0x555555871d40
> <the_repo>) at refs.c:1862
> (gdb) p r->ref_storage_format
> $1 = 0x0
> }

Hmm. Looks like repo_init() is only used for submodules. Which is pretty
horrid, because that setup sequence is basically duplicated between
there and setup_git_directory(), which is the traditional mechanism.
That's something that ought to be cleaned up, but it's definitely
outside the scope of your series.

The patch below was enough to make something like this work:

  git init --reftable repo
  cd repo
  git commit --allow-empty -m foo
  git for-each-ref

I had to make some tweaks to the init code, too:

 - setting the_repository->ref_storage_format based on the --reftable
   flag

 - we can still recognize a reinit by the presence of a HEAD file
   (whether it's a real one or a dummy). And we should call
   create_symref() in either case, either to create HEAD or to create
   the HEAD symlink inside reftables

I also fixed a bug in your first patch, where the creation of refs/
moves into files_init_db(). The strbuf needs reset there, or we just
append to it, and end up with a doubled path (you could see it by
running the same commands above without --reftable, but of course not
with your patch series as-is because it will _always_ choose reftable).

diff --git a/builtin/init-db.c b/builtin/init-db.c
index dcea74610c..ea2a333c4a 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -213,6 +213,8 @@ static int create_default_files(const char *template_path,
 	is_bare_repository_cfg = init_is_bare_repository;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
+	if (flags & INIT_DB_REFTABLE)
+		the_repository->ref_storage_format = xstrdup("reftable");
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -222,6 +224,15 @@ static int create_default_files(const char *template_path,
 		adjust_shared_perm(get_git_dir());
 	}
 
+	/*
+	 * Check to see if .git/HEAD exists; this must happen before
+	 * initializing the ref db, because we want to see if there is an
+	 * existing HEAD.
+	 */
+	path = git_path_buf(&buf, "HEAD");
+	reinit = (!access(path, R_OK) ||
+		  readlink(path, junk, sizeof(junk) - 1) != -1);
+
 	/*
 	 * We need to create a "refs" dir in any case so that older
 	 * versions of git can tell that this is a repository.
@@ -234,18 +245,14 @@ static int create_default_files(const char *template_path,
 	 * Create the default symlink from ".git/HEAD" to the "master"
 	 * branch, if it does not exist yet.
 	 */
-	if (flags & INIT_DB_REFTABLE) {
-		reinit = 0; /* XXX - how do we recognize a reinit,
-			     * and what should we do? */
-	} else {
-		path = git_path_buf(&buf, "HEAD");
-		reinit = (!access(path, R_OK) ||
-			  readlink(path, junk, sizeof(junk) - 1) != -1);
-	}
-
 	if (!reinit) {
 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
 			exit(1);
+	} else {
+		/*
+		 * XXX should check whether our ref backend matches the
+		 * original one; if not, either die() or convert
+		 */
 	}
 
 	/* This forces creation of new config file */
diff --git a/refs.c b/refs.c
index 493d3fb673..d6ddbbcc67 100644
--- a/refs.c
+++ b/refs.c
@@ -1859,10 +1859,9 @@ struct ref_store *get_main_ref_store(struct repository *r)
 		BUG("attempting to get main_ref_store outside of repository");
 
 	r->refs = ref_store_init(r->gitdir,
-				 /* XXX r->ref_storage_format == NULL. Where
-				  * should the config file be parsed out? */
-				 r->ref_storage_format ? r->ref_storage_format :
-							 "reftable",
+				 r->ref_storage_format ?
+					r->ref_storage_format :
+					"files",
 				 REF_STORE_ALL_CAPS);
 	return r->refs;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0c53b246e8..6f9efde9ca 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3166,6 +3166,7 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
+	strbuf_reset(&sb);
 	files_ref_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 
diff --git a/repository.c b/repository.c
index aff47302c9..ff0988dac8 100644
--- a/repository.c
+++ b/repository.c
@@ -174,9 +174,7 @@ int repo_init(struct repository *repo,
 	if (worktree)
 		repo_set_worktree(repo, worktree);
 
-	repo->ref_storage_format = format.ref_storage != NULL ?
-					   xstrdup(format.ref_storage) :
-					   "files"; /* XXX */
+	repo->ref_storage_format = xstrdup_or_null(format.ref_storage);
 
 	clear_repository_format(&format);
 	return 0;
diff --git a/setup.c b/setup.c
index a339186d83..58c5cd3bf0 100644
--- a/setup.c
+++ b/setup.c
@@ -450,7 +450,7 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			data->partial_clone = xstrdup(value);
 		} else if (!strcmp(ext, "worktreeconfig")) {
 			data->worktree_config = git_config_bool(var, value);
-		} else if (!strcmp(ext, "refStorage")) {
+		} else if (!strcmp(ext, "refstorage")) {
 			data->ref_storage = xstrdup(value);
 		} else
 			string_list_append(&data->unknown_extensions, ext);
@@ -1184,8 +1184,11 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
 			setup_git_env(gitdir);
 		}
-		if (startup_info->have_repository)
+		if (startup_info->have_repository) {
 			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
+			the_repository->ref_storage_format =
+				xstrdup_or_null(repo_fmt.ref_storage);
+		}
 	}
 
 	strbuf_release(&dir);
