Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA84E8E1E
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368802; cv=none; b=DsAWgLol7KdZlsNNcxEcqRmWogoR26QWiBbUTbk2qxWEHVKOYyqprjHZc1VmP2Fa48Xj5Bd1qV9eHw2t6clTGdM41vbP97eRGOsR+OY4wEkW6Ie5+MCR7skKQ5JjQf3eCNKbNxaNz25Ds+zlziL8IIDw94cV2hOhkS2xlvyKI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368802; c=relaxed/simple;
	bh=rLyjsvxIxvex5aMVTLqFo2UQJ3Ks8Q0CKww+ki643oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enLysLz6GQJl+Owiz7tMGvmCnVo2k1VPGCFG2DrNFGFM6MxL/I3tyct/8PCGNnsNS7u3fAWao7+awkG6zzOxSjpGmNn9JIGv9ITN129JkLbt4LIdk9rzo69IQmkXd36tsgkJoW9rUTE4/53wPIl0dgyHl7gsEzFOs6DTQV3uxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c/MduDl2; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c/MduDl2"
Received: (qmail 53018 invoked by uid 106); 25 Sep 2026 20:39:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rLyjsvxIxvex5aMVTLqFo2UQJ3Ks8Q0CKww+ki643oQ=; b=c/MduDl2H7V6E4qSAG+XSrfg7WsH99KlzM/hCjFFX9JHxzH0Atrz8BMfhIKD7VuCebdgxnw3ha+Om5hE8C0zBJ3o1jheXNfvW6nq0VBtt/+i8hT87uSB0VHAKcoOiDg3DJ0A/VraX65p9qztMAHodzsyzYJG6WkP+U+mhyqAqv4eXeaSbM/qwwQTGgFoR1lXohd0Ls8kp15Kx5ZRDdb7M4Uc0zzE7PfXn2+M4nOyAXVMOkOhosN5d5MRzzIt4RO2t0F2+0xrXjypDhfTDAU2lujDvsIRrg/KkLj8pJmFsj9zUn2wTSatTy26E0h9ooiF5X2zcOt0W7MUV60p9PUo+g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2026 20:39:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 210208 invoked by uid 111); 25 Sep 2026 20:39:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2026 16:39:58 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Sep 2026 16:39:58 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/2] revision: handle argv movement in parse_revision_opt()
Message-ID: <20260925203958.GB1544493@coredump.intra.peff.net>
References: <20260925203359.GA1506705@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925203359.GA1506705@coredump.intra.peff.net>

The argument parser used by setup_revisions() modifies the argv array
that is passed to it, consolidating non-options and unknown options at
the start of the array. This led to problems with memory leaks when argv
pointed to allocated strings. We addressed that in cd43948798 (revision:
manage memory ownership of argv in setup_revisions(), 2025-09-19). Now
instead of copying strings to the earlier part of argv, we actually move
them, setting the original location to NULL (so that we know we have
exactly one pointer to the string).

This works fine for setup_revisions() itself, but the underlying
handle_revision_opt() has another entry point: parse_revision_opt().
This lets a parse-options user parse a single revision option, but the
movement introduced by cd43948798 confuses its error code path. If we
see an unknown option, then handle_revision_opt() will move it out of
the way (to the "unknown options" section) and return an error. But
parse_revision_opt() then tries to access the original argv location,
which has now been set to NULL, and you get:

  $ git shortlog -n --no-such-option
  error: unknown option `(null)'

Whereas prior to cd43948798, it would have been a leftover copy of the
pointer (that may or may not eventually get written over, but was valid
for this immediate message). And you get what you'd expect:

  $ git shortlog -n --no-such-option
  error: unknown option `--no-such-option'

Making things even more confusing, it only happens if there's another
option before the unknown one! That's because with just:

  $ git shortlog --no-such-option

we "consolidate" to the exact same spot, and no movement occurs at all.

Note that we use shortlog in these examples because it is one of only
two commands that use the parse_revision_opt() interface (the other is
blame).

There are a few options for fixing this. One is that we can observe that
the "move" semantics introduced by cd43948798 only matter when the argv
strings are allocated on the heap, in which case the caller passes in
the free_removed_argv_elements flag to tell us. But we never use that
flag with parse_revision_opt(). So we could do something like this:

  diff --git a/revision.c b/revision.c
  index ee1df92d1d..7b858d54c1 100644
  --- a/revision.c
  +++ b/revision.c
  @@ -2340,7 +2340,8 @@ static void overwrite_argv(int *argc, const char **argv,
   	if (*value != argv[*argc]) {
   		mark_argv_for_free(opt, revs, argv[*argc]);
   		argv[*argc] = *value;
  -		*value = NULL;
  +		if (opt && opt->free_removed_argv_elements)
  +			*value = NULL;
   	}
   	(*argc)++;
   }

to restore the pre-cd43948798 semantics when heap-allocated strings are
not in use. We'd just keep the extra pointer in the original location,
but nobody cares because they're not going to free anything anyway.
That's enough to fix this case, and could fix any other theoretical
cases we haven't noticed. The downside is that it's an accident waiting
to happen if we ever do teach parse_revision_opt() to handle allocated
argv strings.

But are there other theoretical cases? I don't think so. The code paths
touched by cd43948798 are either in setup_revisions() itself (which also
learned how to handle this movement) or in handle_revision_opt(), the
low-level static helper. It has only two callers: setup_revisions()
itself, and parse_revision_opt() in which we see the current breakage.
So fixing parse_revision_opt() should cover all of our bases, and keep
the code ready for a potential future change to handle allocated
strings.

The fix is just to tell parse_revision_opt() to look for the unknown
option in the consolidated destination rather than the original
location.  We might write to that consolidated location for other
reasons (like moving pseudo-revision options like "--all"), but there is
only one code path that returns the 0 for an unknown option, and it
always moves the option before doing so. So the "end" of that
consolidated area will always have our unknown option.

This patch implements that solution and demonstrates the breakage and
fix using shortlog.

Reported-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Obviously another possible fix is for parse_revision_opt() to record the
string before passing it along, and use that for its error message. That
seemed clunkier to me.

 revision.c          | 2 +-
 t/t4201-shortlog.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index f958d8c301..a83e499047 100644
--- a/revision.c
+++ b/revision.c
@@ -2775,7 +2775,7 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 		/* handle_revision_opt() has already reported the error. */
 		usage_with_options(usagestr, options);
 	} else if (!n) {
-		error("unknown option `%s'", ctx->argv[0]);
+		error("unknown option `%s'", ctx->out[ctx->cpidx - 1]);
 		usage_with_options(usagestr, options);
 	}
 	ctx->argv += n;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 4ba7f5aec6..10c43e6e75 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -442,4 +442,9 @@ test_expect_success 'invalid revision options are not reported as unknown' '
 	test_grep ! "unknown option" err
 '
 
+test_expect_success 'unknown revision options are reported correctly' '
+	test_must_fail git shortlog -n --no-such-option 2>err &&
+	test_grep "unknown option .*--no-such-option" err
+'
+
 test_done
-- 
2.56.0.rc2.289.g137cf50cac
