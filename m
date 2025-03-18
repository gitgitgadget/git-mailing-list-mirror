Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5D1DB951
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742276421; cv=none; b=T6meOBI1teAFl7f+AFVAgjjby5alEsJqBw49UcJrreIzUlKlJjWa5iIH3eerqoC3iF6h3vvarAqBgFPn8AAL3AGNvAhSGzqpdMY0AZDixwaCjYZ1DaFa2SkfNeKgOGmEX39Te36aTjlTs/N60EztNutndrRYxD1+iMH8WmZkauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742276421; c=relaxed/simple;
	bh=Mg5ELlh/D1NLG4Y4N97xXD3QJ+SnG2ZVR8QbucECC+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoQhZIDsqbEvx1idZRdKwdvKVv5mTWb0dW01D14rgd7SFUvrPF+nuh3YsigeEWMnYFeTWm5E8OP3QWfeh/53OtAxTHu2NgFg4GqpHTuZFD6GFZAIhllIuKwz6ikyjLIhG/nvOqnCdgxSiHyJeOfgLiU2vdWq4RDG991woQDv02Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IHR17s/Y; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IHR17s/Y"
Received: (qmail 28327 invoked by uid 109); 18 Mar 2025 05:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Mg5ELlh/D1NLG4Y4N97xXD3QJ+SnG2ZVR8QbucECC+A=; b=IHR17s/YBlTmjw2g9Kv0eDaNCUsTP4arbU+/9U9qApYsBseMR6Zvqp0GqTznbfRkDA9uE8QlFJAkXI7RZEk/geCSO1Coef8rviPWYEOEeyaCDHTpSO0kB7hhoxgDxLZk9OGmvcBYIucgAI3/tqudyiWCaUNq+bdgA2+oUatFD0nWsXmOHkDFlpA+E//xidcmZZQZs3lGNrz1I3hYtSe7N7MPhmJRYY/YYcbUWjiYnlgm0EAbeWb5UI3A+Xy3bI43qrPeSNkPcjRlHIu4ZVj+zU7cknAxW+o9+2j5Sm0m9NUjFoQ/xOE4OF0ECtYIxrbCc6BXGT96dYKDzYdoKLv8pQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 05:40:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6182 invoked by uid 111); 18 Mar 2025 05:40:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Mar 2025 01:40:17 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Mar 2025 01:40:17 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 1/2] fetch: only respect followRemoteHEAD with configured
 refspecs
Message-ID: <20250318054017.GA2051617@coredump.intra.peff.net>
References: <20250318053905.GA2051217@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318053905.GA2051217@coredump.intra.peff.net>

The new followRemoteHEAD feature is triggered for almost every fetch,
causing us to ask the server about the remote "HEAD" and to consider
updating our local tracking HEAD symref. This patch limits the feature
only to the case when we are fetching a remote using its configured
refspecs (typically into its refs/remotes/ hierarchy). There are two
reasons for this.

One is efficiency. E.g., the fixes in 6c915c3f85 (fetch: do not ask for
HEAD unnecessarily, 2024-12-06) and 20010b8c20 (fetch: avoid ls-refs
only to ask for HEAD symref update, 2025-03-08) were aimed at reducing
the work we do when we would not be able to update HEAD anyway. But they
do not quite cover all cases. The remaining one is:

  git fetch origin refs/heads/foo:refs/remotes/origin/foo

which _sometimes_ can update HEAD, but usually not. And that leads us to
the second point, which is being simple and explainable.

The code for updating the tracking HEAD symref requires both that we
learned which ref the remote HEAD points at, and that the server
advertised that ref to us. But because the v2 protocol narrows the
server's advertisement, the command above would not typically update
HEAD at all, unless it happened to point to the "foo" branch. Or even
weirder, it probably _would_ update if the server is very old and
supports only the v0 protocol, which always gives a full advertisement.

This creates confusing behavior for the user: sometimes we may try to
update HEAD and sometimes not, depending on vague rules.

One option here would be to loosen the update code to accept the remote
HEAD even if the server did not advertise that ref. I think that could
work, but it may also lead to interesting corner cases (e.g., creating a
dangling symref locally, even though the branch is not unborn on the
server, if we happen not to have fetched it).

So let's instead simplify the rules: we'll only consider updating the
tracking HEAD symref when we're doing a full fetch of the remote's
configured refs. This is easy to implement; we can just set a flag at
the moment we realize we're using the configured refspecs.  And we can
drop the special case code added by 6c915c3f85 and 20010b8c20, since
this covers those cases. The existing tests from those commits still
pass.

In t5505, an incidental call to "git fetch <remote> <refspec>" updated
HEAD, which caused us to adjust the test in 3f763ddf28 (fetch: set
remote/HEAD if it does not exist, 2024-11-22). We can now adjust that
back to how it was before the feature was added.

Even though t5505 is incidentally testing our new desired behavior,
we'll add an explicit test in t5510 to make sure it is covered.

Signed-off-by: Jeff King <peff@peff.net>
---
The test is weird with the way it calls "cd", but it matches the nearby
ones. I think that could all be simplified, but I'll leave that for
another day (or never).

 Documentation/config/remote.adoc |  3 ++-
 builtin/fetch.c                  | 25 ++++++-------------------
 t/t5505-remote.sh                |  2 +-
 t/t5510-fetch.sh                 | 14 ++++++++++++++
 4 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/Documentation/config/remote.adoc b/Documentation/config/remote.adoc
index 25fe219d10..91e46f66f5 100644
--- a/Documentation/config/remote.adoc
+++ b/Documentation/config/remote.adoc
@@ -108,7 +108,8 @@ the values inherited from a lower priority configuration files (e.g.
 `$HOME/.gitconfig`).
 
 remote.<name>.followRemoteHEAD::
-	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`.
+	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`
+	when fetching using the configured refspecs of a remote.
 	The default value is "create", which will create `remotes/<name>/HEAD`
 	if it exists on the remote, but not locally; this will not touch an
 	already existing local reference. Setting it to "warn" will print
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 02af505469..66f5ae31b6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1691,21 +1691,6 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
 	return result;
 }
 
-static int uses_remote_tracking(struct transport *transport, struct refspec *rs)
-{
-	if (!remote_is_configured(transport->remote, 0))
-		return 0;
-
-	if (!rs->nr)
-		rs = &transport->remote->fetch;
-
-	for (int i = 0; i < rs->nr; i++)
-		if (rs->items[i].dst)
-			return 1;
-
-	return 0;
-}
-
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs,
 		    const struct fetch_config *config)
@@ -1720,6 +1705,7 @@ static int do_fetch(struct transport *transport,
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	struct fetch_head fetch_head = { 0 };
 	struct strbuf err = STRBUF_INIT;
+	int do_set_head = 0;
 
 	if (tags == TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags == 2)
@@ -1740,9 +1726,11 @@ static int do_fetch(struct transport *transport,
 	} else {
 		struct branch *branch = branch_get(NULL);
 
-		if (transport->remote->fetch.nr)
+		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
 					     &transport_ls_refs_options.ref_prefixes);
+			do_set_head = 1;
+		}
 		if (branch_has_merge_config(branch) &&
 		    !strcmp(branch->remote_name, transport->remote->name)) {
 			int i;
@@ -1765,8 +1753,7 @@ static int do_fetch(struct transport *transport,
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "refs/tags/");
 
-	if (transport_ls_refs_options.ref_prefixes.nr &&
-	    uses_remote_tracking(transport, rs))
+	if (do_set_head)
 		strvec_push(&transport_ls_refs_options.ref_prefixes,
 			    "HEAD");
 
@@ -1918,7 +1905,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (set_head(remote_refs, transport->remote))
+	if (do_set_head && set_head(remote_refs, transport->remote))
 		;
 		/*
 		 * Way too many cases where this can go wrong
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index bb7e0c6879..fed5823e85 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -499,7 +499,7 @@ test_expect_success 'set-head --auto has no problem w/multiple HEADs' '
 		cd test &&
 		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		git remote set-head --auto two >output 2>&1 &&
-		echo "${SQ}two/HEAD${SQ} is unchanged and points to ${SQ}main${SQ}" >expect &&
+		echo "${SQ}two/HEAD${SQ} is now created and points to ${SQ}main${SQ}" >expect &&
 		test_cmp expect output
 	)
 '
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5f350facf5..ad23dd11ef 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -250,6 +250,20 @@ test_expect_success "fetch test followRemoteHEAD always" '
 	)
 '
 
+test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git remote set-head origin other &&
+		git config set remote.origin.followRemoteHEAD always &&
+		git fetch origin refs/heads/main:refs/remotes/origin/main &&
+		echo refs/remotes/origin/other >expect &&
+		git symbolic-ref refs/remotes/origin/HEAD >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'fetch --prune on its own works as expected' '
 	cd "$D" &&
 	git clone . prune &&
-- 
2.49.0.390.gc9996a6a6c

