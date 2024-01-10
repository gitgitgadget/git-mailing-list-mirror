Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD73FB18
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18122 invoked by uid 109); 10 Jan 2024 12:05:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jan 2024 12:05:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26668 invoked by uid 111); 10 Jan 2024 12:05:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jan 2024 07:05:31 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jan 2024 07:05:31 -0500
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: Limited operations in unsafe repositories
Message-ID: <20240110120531.GA25541@coredump.intra.peff.net>
References: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZZr-JLxubCvWe0EU@tapette.crustytoothpaste.net>

On Sun, Jan 07, 2024 at 07:40:20PM +0000, brian m. carlson wrote:

> I had looked at sending a patch to make `git rev-parse` operate in a
> special mode where it's impossible to invoke any binaries at all, but
> unfortunately, `get_superproject_working_tree` invokes binaries, so
> that's not possible.  (If anyone is interested in picking this up, there
> is a start on it, failing many tests, in the `rev-parse-safe-directory`
> on my GitHub remote.)
> 
> I guess I'm looking for us to provide some basic functionality that is
> guaranteed to work in this case, including `git rev-parse` and `git
> config -l`.  I don't think it's useful for every program that wants to
> work with Git to need to implement its own repository discovery and
> config parsing, and those are essential needs for tooling that needs to
> work with untrusted repositories.

If I understand correctly, you want to have some very limited code paths
that we know are OK to run even in an untrusted repo. My concern there
would be that it's easy for "basic functionality" to accidentally call
into less-limited code, which suddenly becomes a vulnerability.

My thinking is to flip that around: run all code, but put protection in
the spots that do unsafe things, like loading config or examining
hooks. I.e., a patch like this:

diff --git a/config.c b/config.c
index 9ff6ae1cb9..c7bbd6bdda 100644
--- a/config.c
+++ b/config.c
@@ -2026,7 +2026,7 @@ static int do_git_config_sequence(const struct config_options *opts,
 	if (!opts->git_dir != !opts->commondir)
 		BUG("only one of commondir and git_dir is non-NULL");
 
-	if (opts->commondir) {
+	if (opts->commondir && is_safe_repository())
 		repo_config = mkpathdup("%s/config", opts->commondir);
 		worktree_config = mkpathdup("%s/config.worktree", opts->git_dir);
 	} else {
diff --git a/hook.c b/hook.c
index f6306d72b3..4fcfd82dc5 100644
--- a/hook.c
+++ b/hook.c
@@ -12,6 +12,9 @@ const char *find_hook(const char *name)
 {
 	static struct strbuf path = STRBUF_INIT;
 
+	if (!is_safe_repository())
+		return NULL;
+
 	strbuf_reset(&path);
 	strbuf_git_path(&path, "hooks/%s", name);
 	if (access(path.buf, X_OK) < 0) {

where is_safe_repository() is something like:

  - if git_env_bool("GIT_ASSUME_SAFE", 1) is true, return true
    immediately

  - otherwise, see if we are matched by safe.directory

And then running:

  git --assume-unsafe rev-parse ...

would set that variable to "0".

And then most functionality would just work, modulo trusting repo hooks
and config. I mentioned "loading config" earlier, but of course that
patch is just touching the usual "load all config sources" code. We'd
still allow parsing .git/config for repo discovery, and something like:

  git --assume-unsafe config -l --local

would still work if the caller knew they would be careful with the
output.

The downside, of course, is that we might fail to include other
dangerous spots. Those two are the big ones, I think, but would we want
to prevent people from pointing to /dev/mem in info/alternates? I dunno.
It certainly is more protection than we offer today, but maybe saying
"this is safe" would produce a false sense of security.

I do think something like git-prompt.sh could benefit here (it could use
--assume-unsafe for all invocations so you don't get surprised just by
chdir-ing into a downloaded tarball).

-Peff
