Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988F1CEAD6
	for <git@vger.kernel.org>; Sat,  5 Jul 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751741927; cv=none; b=k3MeIhKjiumWX3rXrvsTqvXZDkJKHe7MsICJqE0CBphGZn/BQ3d7V4wHhmHfEu9s3hi4Ut6cPLDfGcPMy7M+dnPLXOLTGOh2fYwCVHS8gjSzq+e+or26lMsUa1oNd/LUyG4nk3fDhHXKDCL9fRadhrmlvWGxBsdIW/vRyoDiIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751741927; c=relaxed/simple;
	bh=3FK9IlU/h5Eq7aoEOvnRFkBNc3n7JuN1u7u8uLWEJHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAn7plNlRJSsToaXvWcEfyxgbfAR7Y+QTF/gG1Z553/3n3SN1eEU2CCXeT3P4QItrqqwNFniuBj7QwNuy2DEj2dIrpdS1V6TG1EeV92xI2k29PZ+IrrVz55+hua2yJ85w7cPi8DWx97WxbJBqpPWMGrrYiusExdfxrbaZbsDPho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HZB48QvZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HZB48QvZ"
Received: (qmail 24281 invoked by uid 109); 5 Jul 2025 18:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3FK9IlU/h5Eq7aoEOvnRFkBNc3n7JuN1u7u8uLWEJHQ=; b=HZB48QvZXXAM0Wiinb8+qdmsv9OzP6DZop6Niw6zOKugT8Hc6U27QW6KZEUIsFDPirceuCk+V8Bu13P6O2I90gGnYt7x3XYzCLPS4of5gzadSLgDq00uOix7a+PY4foBDZdG6D9MaoxbxOPHgUuu4w67fSafYA23VxDjwgb7zuD2gImhJ2GMAqOV0BqFgDVDZf0fxhGdDAFGNhNuqm650dT9xcBkjK9GgvTCUn8deGYxL0nKNkeiEDXubBKKsHYlLI+esCXnHJUIz4HCU3Q7a2RHdwBwMw5tl/Ef1K9lrRJE8Y9KiVBU8eo/FDZyImY6d32knIGLn7f89m9y/eTQOw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 05 Jul 2025 18:58:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4597 invoked by uid 111); 5 Jul 2025 18:58:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 05 Jul 2025 14:58:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 5 Jul 2025 14:58:42 -0400
From: Jeff King <peff@peff.net>
To: Per Cederqvist <ceder@lysator.liu.se>
Cc: git@vger.kernel.org
Subject: [PATCH] remote: detect collisions in remote names
Message-ID: <20250705185842.GA2496172@coredump.intra.peff.net>
References: <CAHx6-Um1dq0xJ-RkW+qXe=sEa6JGViSJxjzNw56u55DHLYoT2Q@mail.gmail.com>
 <20250705165750.GA1951664@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250705165750.GA1951664@coredump.intra.peff.net>

On Sat, Jul 05, 2025 at 12:57:50PM -0400, Jeff King wrote:

> So I dunno. It feels like a configuration error in most cases, but not
> all. I'd probably say that people touching the config manually should be
> allowed to do what they want, but maybe "git remote" should be a bit
> more careful about names being proper subsets of existing remotes (it
> should already prevent the exact-match above, I'd think, because the ref
> namespace it uses will always match the configuration name).

So I'm not entirely convinced we should do anything here. The answer
might just be "if it hurts, don't do it". But if we wanted any
protections in the "git remote" porcelain, they might look like this:

-- >8 --
Subject: [PATCH] remote: detect collisions in remote names

When two remotes collide in the destinations of their fetch refspecs,
the results can be confusing. For example, in this silly example:

  git config remote.one.url [...]
  git config remote.one.fetch +refs/heads/*:refs/remotes/collide/*
  git config remote.two.url [...]
  git config remote.two.fetch +refs/heads/*:refs/remotes/collide/*
  git fetch --all

we may try to write to the same ref twice (once for each remote we're
fetching). There's also a more subtle version of this. If you have
remotes "outer/inner" and "outer", then the ref "inner/branch" on the
second remote will conflict with just "branch" on the former (they both
want to write to "refs/remotes/outer/inner/branch").

We probably don't want to forbid this kind of overlap completely. While
the results can be confusing, there are legitimate reasons to have
multiple refs write into the same namespace (e.g., if one is a "backup"
of the other that is rarely fetched from).

But it may be worth limiting the porcelain "git remote" command to avoid
this confusion. The example above cannot be done with "git remote",
because it always[1] matches the refspecs to the remote name, and you
can only have one instance of each remote name. But you can still
trigger the more subtle variant like this:

  git remote add outer [...]
  git remote add outer/inner [...]

So let's detect that kind of name collision (in both directions) and
forbid it. You can still do whatever you like by manipulating the config
directly, but this should prevent the most obvious foot-gun.

[1] Almost always. With the --mirror option, the resulting refspec will
    just write into "refs/*"; the remote name does not appear in the ref
    namespace at all.

    Our new "names must not overlap" rule is not necessary for that
    case, but it seems reasonable to enforce it consistently. We already
    require all remote names to be valid in the ref namespace, even
    though we won't ever use them in that context for --mirror remotes.

    Likewise, our new rule doesn't help with overlap here. Any two
    mirror remotes will always overlap (in fact, any mirror remote along
    with any other single one, since refs/remotes/ is a subset of the
    mirrored refs). I'm not sure this is worth worrying about, but if it
    is, we'd want an additional rule like "mirror remotes must be the
    only remote".

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c  | 17 +++++++++++++++++
 t/t5505-remote.sh | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0d6755bcb7..b18730ddb2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -157,6 +157,21 @@ static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 	return 0;
 }
 
+static int check_remote_collision(struct remote *remote, void *vname)
+{
+	const char *name = vname;
+	const char *p;
+
+	if (skip_prefix(name, remote->name, &p) && *p == '/')
+		die(_("remote name '%s' is a subset of existing remote '%s'"),
+		    name, remote->name);
+	if (skip_prefix(remote->name, name, &p) && *p == '/')
+		die(_("remote name '%s' is a superset of existing remote '%s'"),
+		    name, remote->name);
+
+	return 0;
+}
+
 static int add(int argc, const char **argv, const char *prefix,
 	       struct repository *repo UNUSED)
 {
@@ -208,6 +223,8 @@ static int add(int argc, const char **argv, const char *prefix,
 	if (!valid_remote_name(name))
 		die(_("'%s' is not a valid remote name"), name);
 
+	for_each_remote(check_remote_collision, (void *)name);
+
 	strbuf_addf(&buf, "remote.%s.url", name);
 	git_config_set(buf.buf, url);
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index bef0250e89..2701eef85e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1644,4 +1644,18 @@ test_expect_success 'empty config clears remote.*.pushurl list' '
 	test_cmp expect actual
 '
 
+test_expect_success 'forbid adding subset of existing remote' '
+	test_when_finished "git remote rm outer" &&
+	git remote add outer url &&
+	test_must_fail git remote add outer/inner url 2>err &&
+	test_grep ".outer/inner. is a subset of existing remote .outer." err
+'
+
+test_expect_success 'forbid adding superset of existing remote' '
+	test_when_finished "git remote rm outer/inner" &&
+	git remote add outer/inner url &&
+	test_must_fail git remote add outer url 2>err &&
+	test_grep ".outer. is a superset of existing remote .outer/inner." err
+'
+
 test_done
-- 
2.50.0.438.g3b3bebd3e8

