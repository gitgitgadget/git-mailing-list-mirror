Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C122F389
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 20:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733429694; cv=none; b=DXKaDSzOBLswlQAOgGDIN24AG6Tk7M197vnQazvQL4nLuW/VLLGCgW1riE650ywyRpE9Ivue/00NHuXjd4HcL7gIWO+L9Hr9hKng+U1+Bek1VZozq5KkSpB+FzAIkP9wh1GX8YMFzWhimifqEpb0s7dpiXAegyIVPdsbB19Njps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733429694; c=relaxed/simple;
	bh=/D+SpOSGAi39RVXVtIEpu1FaGENbcx79NMopjFfQ1iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf84Q5S/is11kUbPk0oH8tcKOnMC9rBTMdniWXuo0V7viVJCKe7yjI++nXuVbVfURj0YONu9wRtzsFftf87UfZkuzMUB5r1X0Z8aKsmowS6fGSOdZpDcLvMf5owqers0jFstUqmvkLZbovlTcoFamwKoMN+8D8R21nGoXxzvyLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xgu2oadx; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xgu2oadx"
Received: (qmail 31918 invoked by uid 109); 5 Dec 2024 20:14:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/D+SpOSGAi39RVXVtIEpu1FaGENbcx79NMopjFfQ1iU=; b=Xgu2oadx0B3xDgmlzLFnHm7XYr5/2qyql891gjNesoEsTE1RJ0Yxu/MzKdQRsc9g2+OmYgVi2K0T+TO0IAPq+2u5ERh3QXTC89FJl7KOQEk8ASXyutHmAkMhGYdu8yegmkUMSGCSMsAt4hpM3KDhbp5UD5yBYhIkguJzOrCaMe1xxMkkzySos0q0H+UAJegcqrHDtfC6CZr8PEGhQjMqKBJPs5e/0Liuw1mQDE7fyzSjgDzMpcQLXlY+igyJ8CR5ekwNcbCfiDLr5S8Cu7TAVXwB+k9Ns2JEbyNB8NBzFARHviU+x7SLh6gWtHz8hsfqocgCMLETcSYcOZmcxFdz7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 20:14:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9521 invoked by uid 111); 5 Dec 2024 20:14:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 15:14:50 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 15:14:49 -0500
From: Jeff King <peff@peff.net>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, benno.martin.evers@gmail.com,
	benno@bmevers.de, ravi@prevas.dk, jpoimboe@kernel.org,
	masahiroy@kernel.org
Subject: [PATCH] describe: drop early return for max_candidates == 0
Message-ID: <20241205201449.GA2635755@coredump.intra.peff.net>
References: <20241106211717.GD956383@coredump.intra.peff.net>
 <00270315b83b585f7d62ad1204ca1df93a668791.1733354035.git.steadmon@google.com>
 <20241204232750.GA1460551@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204232750.GA1460551@coredump.intra.peff.net>

On Wed, Dec 04, 2024 at 06:27:50PM -0500, Jeff King wrote:

> > Subject: Re: [PATCH] fixup! describe: stop traversing when we run out of names
> 
> This commit is already in 'next', so it's too late to squash in a change
> (though I'd have done this separately anyway, as it's already an issue
> for a manual --candidates=0 setting, as unlikely as that is).
> 
> Can you re-send with a full commit message?

Actually, after thinking on this a bit more, I think the solution below
is a bit more elegant. This can go on top of jk/describe-perf.

-- >8 --
From: Josh Steadmon <steadmon@google.com>
Subject: [PATCH] describe: drop early return for max_candidates == 0

Before we even start the describe algorithm, we check to see if
max_candidates is 0 and bail immediately if we did not find an exact
match. This comes from 2c33f75754 (Teach git-describe --exact-match to
avoid expensive tag searches, 2008-02-24), since the the --exact-match
option just sets max_candidates to 0.

But this interacts badly with the --always option (ironically added only
a week later in da2478dbb0 (describe --always: fall back to showing an
abbreviated object name, 2008-03-02)). With --always, we'd still want to
show the hash rather than calling die().

So this:

  git describe --exact-match --always

and likewise:

  git describe --exact-match --candidates=0

has always been broken. But nobody ever noticed, because using those
options together is rather unlikely. However, this bug became a lot
easier to trigger with a30154187a (describe: stop traversing when we run
out of names, 2024-10-31). There we reduce max_candidates automatically
based on the number of tags available. So in a repo with no tags (or one
where --match finds no tags), max_candidates becomes 0, and --always
will never show anything.

So that early check for --exact-match's zero candidates needs to be
adjusted. One way to do so is to have it check the "always" flag and
handle it specially, producing the expected hash. But that would require
duplicating the output code for "always".

Instead, we'd prefer to just fall through to the normal algorithm, which
should notice that we are not allowed to find any more candidates, stop
looking, and then hit the regular "always" output code. Back when
2c33f75754 was first done, this was a bad idea, since the normal
algorithm kept looking for the max+1 candidate. But since 082a4d90af
(describe: stop digging for max_candidates+1, 2024-10-31), we don't do
that anymore, and the algorithm is essentially a noop.

So we can drop the early return entirely, and the fact that
max_candidates is 0 will let us quit early without any special casing.

Reported-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Jeff King <peff@peff.net>
---
There is some small bit of setup work in the algorithm, like creating
the reverse index of commits->names in a slab. I don't think that's
worth worrying about. But if we did care, we could lazily initialize
that index, which would also benefit any other cases that bail before
needing it.

 builtin/describe.c  | 2 --
 t/t6120-describe.sh | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 8ec3be87df..21e1c87c65 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -336,8 +336,6 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		return;
 	}
 
-	if (!max_candidates)
-		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
 		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 5633b11d01..009d84ff17 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -715,4 +715,10 @@ test_expect_success 'describe --broken --dirty with a file with changed stat' '
 	)
 '
 
+test_expect_success '--always with no refs falls back to commit hash' '
+	git rev-parse HEAD >expect &&
+	git describe --no-abbrev --always --match=no-such-tag >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.47.1.734.g721956425b

