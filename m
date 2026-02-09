Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11220125A0
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770622564; cv=none; b=OwGCHycuSxFXPKyeishoAaOG8F75R4QLCi/RENUrqhH1i/pTyAfzFCgGnvDpiQPjqQpybYRfjeGOBxm34dsYimnGFhrhQKvVKyMwyVQcGl0pDK5P4uTSjuaTFMVuMzA/4OlkabKClFxrMt7NQ7c/NiotHIBLzjCaBTSoH1IS7bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770622564; c=relaxed/simple;
	bh=xTt4RFLBgUyxEtSe9gnRjHTcpmN+zxUBm7pZMK21b+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgpYaTW9+UxWf5vOOLHZBcz1QaFRVGxropvPHS0lMvA9Nfa2oUcTamULRRfD7r39nD0W3zUjXHQvzKWbGAQVNW0wWNT/uU+RCgmOXaX3xq6yzc8Xf1i2HMHvvALRQ4i09DgA/CsoMTQn7NzJzpN/b6MD0S+A7xg0IKvu2UTS4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=euXVAZIO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="euXVAZIO"
Received: (qmail 339669 invoked by uid 109); 9 Feb 2026 07:36:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=xTt4RFLBgUyxEtSe9gnRjHTcpmN+zxUBm7pZMK21b+0=; b=euXVAZIOll5sfry1Xxbl/VLv4Yp3x7K/N18ooAN0BZEM1PmIOEanTAzWRKLoUV9ge6h/ARO+kpAAitz59HNytswyPRAF+cMAZKA30na/t/kL30T6kxdwDYF8Wfeho98tahBm3PNZqpjUnAHW3XIc75aLX2n9SJkA/yR5DG17H1Tnh+UYpBKFys53swsExZa0RKGWam3Q44SzSa3fOJgJWqrKA2flLOqjE6ClRnfg3o+IDTDX5xYMGKOve/+UAILVHUDmjguoFj3UiK5B7xQRVdeddz9bmzAyRS6E33BNjLyQ9rOaq+c6zHVeyHB5lOctCwIeKkZStRkHzxd7o8Dddg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Feb 2026 07:36:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 670328 invoked by uid 111); 9 Feb 2026 07:36:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Feb 2026 02:36:07 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 9 Feb 2026 02:36:02 -0500
From: Jeff King <peff@peff.net>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org
Subject: Re: [RFC] Support UTF-8 characters in Git alias names
Message-ID: <20260209073602.GC585828@coredump.intra.peff.net>
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>

On Sun, Feb 08, 2026 at 04:30:02PM +0100, Jonatan Holmgren wrote:

> I think the best approach is to support UTF-8 specifically for alias.*
> variables, which would mean modifying the git_config_parse_key() fn to allow
> UTF-8 bytes and make non-ascii aliases case-sensitive to avoid complex
> locale-dependent case folding.
> 
> The main pain point would be making sure all platforms handle this nicely,
> esp since mac uses NFD and not NFC Unicode.
> 
> Before implementing this, I'd like to hear:
> 
> 1. Is this a feature the project would like?
> 2. Is my implementation approach reasonable?
> 3. What concerns should be addressed in said design?
> 4. Any compat requirements I should be aware of?

I think supporting non-ascii aliases is a good goal.

However, I'm not sure that special-casing the parsing of alias config
keys is the best direction. Since it's a syntactic change, the special
case would have to be understand by all code that reads or writes
config, not just git_config_parse_key(). And then you'd potentially run
into problems with older versions of Git, or alternate implementations
(of which there are several).

Plus it doesn't solve all of the issues. E.g., should we allow new
characters like "_" (for a potential "git foo_bar")? That is doable, but
what about "." (for "git foo.bar")? I think that introduces new
ambiguities into the syntax.

Taking a step back, I think the root of the issue is that the schema for
alias keys is poorly designed. Git's config syntax allows for three
levels: section, subsection, and key. The section and key fields are
restricted to alnum and dash, but the subsection is designed to be
unrestricted (modulo NUL bytes).

And that's why we have:

  [branch "foo/bar"]
  remote = origin

for example, because branch names don't follow the same syntax rules as
config keys. And it's the same issue here: the alias.* schema is trying
to use one syntax (alnum config keys) to store another (command names).
They _usually_ overlap, but not always. The pager.* config has the same
problem.

We've discussed this before, e.g., in:

  https://lore.kernel.org/git/20150206124528.GA18859@inner.h.apk.li/

There the immediate problem was that "git foo_bar" caused an error
message. We hacked around it by suppressing the error, but it was still
impossible to add an alias or pager config. We knew that was a
limitation, but punted until somebody came along who actually cared
about making it work. Now you get to be that somebody. ;)

So what I'd propose instead is introducing a new schema like:

  - setting "alias.foo.command" to "bar" would alias "git foo" to "bar";
    this should work for any command name, as it is just a byte stream

  - a given command subsection is matched verbatim. So alias.foo.command
    matches "git foo" but not "git Foo". Likewise, we do not do any
    normalization. You put what you want into your config, and it should
    match the command you invoke. This is perhaps less friendly, but it
    punts on any normalization or case-folding that we have to do, and
    matches how the rest of Git works (paths are likewise streams of
    bytes, and it is mostly up to the user to use them consistently).

  - leave "alias.foo" as a historical synonym for "alias.foo.command",
    so that existing config continues working

  - optionally add new keys within alias.foo.* sections. For example, we
    could allow alias.foo.help to provide text shown during "git help
    foo". For the most part that could come later, so I'm just
    illustrating possible eventual directions that the new schema would
    allow. But it might be worth pondering a little now to avoid
    painting ourselves into a corner. E.g., you could imagine a schema
    where alias.foo.shell is set to "true" instead of sticking a "!" at
    the front of the value of alias.foo.command. I don't know if that's
    a good idea or not, but if we were going to do stuff like that, we'd
    want to decide now before setting the alias.foo.command behavior in
    stone.

  - likewise, optionally do the same for pager.*

I hacked together some illustrative code below. Note that we do use
strcasecmp() currently to match command names (which kind of makes
sense, since if you had "alias.Foo" in your config, the parser would
downcase it to "alias.foo"). So probably that historical code should
continue to behave like that, but the new "alias.Foo.command" should be
more verbatim (the patch below just feeds them both to strcasecmp).

-Peff

---
diff --git a/alias.c b/alias.c
index 1a1a141a0a..44bdde58af 100644
--- a/alias.c
+++ b/alias.c
@@ -17,19 +17,30 @@ static int config_alias_cb(const char *key, const char *value,
 			   const struct config_context *ctx UNUSED, void *d)
 {
 	struct config_alias_data *data = d;
-	const char *p;
+	const char *cmd, *p;
+	size_t cmd_len;
 
-	if (!skip_prefix(key, "alias.", &p))
+	if (parse_config_key(key, "alias", &cmd, &cmd_len, &p) < 0)
 		return 0;
 
+	if (cmd) {
+		/* The only 3-level key we understand is alias.*.command */
+		if (strcmp(p, "command"))
+			return 0;
+	} else {
+		/* alias.foo is the same as alias.foo.command */
+		cmd = p;
+		cmd_len = strlen(p);
+	}
+
 	if (data->alias) {
-		if (!strcasecmp(p, data->alias)) {
+		if (!strncasecmp(cmd, data->alias, cmd_len)) {
 			FREE_AND_NULL(data->v);
 			return git_config_string(&data->v,
 						 key, value);
 		}
 	} else if (data->list) {
-		string_list_append(data->list, p);
+		string_list_append_nodup(data->list, xmemdupz(cmd, cmd_len));
 	}
 
 	return 0;
