Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF31C3F26
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810366; cv=none; b=T+0mS7dSITNznbxV+iDqDzVSKhLez/m0oOYu/rk+pQcpr3e2/j+gKF52BzdpaM2BgVtly66pxxBBcQA938QydIpPIlH6lXYyKCrt0cvA9DfV7VitEmjBlx/s6lm/3T+bC0jpZdM4MH6MR7dBl75xrZbI/HUgyIrsuMJl0aidvtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810366; c=relaxed/simple;
	bh=kR2DGw2iAl5q904CHqzSNC+oudEX0Einn66GZxsRAXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drypxTSIHGE0yMz8K3CFC545T/skABmaIMtzvGzM14ISxtsioVvXewrs90XGY2AywoPNJBp0zPpa2mwf5SEm3+Pfve6CiOxs7KWlmd8wqNJVvGHo8I61Cb+TuXHP8NDf6453EFY43kcs18PNkoN6xT13e5luZFpYAoh0ZTqSnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=I3nq8Jyc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="I3nq8Jyc"
Received: (qmail 23153 invoked by uid 109); 28 Nov 2024 16:12:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kR2DGw2iAl5q904CHqzSNC+oudEX0Einn66GZxsRAXU=; b=I3nq8JycqWKLDX0EmtFbeea5WZUJR+tv1oRWc9yD17i2tnr8X6yhNVWN/hkBjulF4sUx3rK4/3vvKiBOpy17NUG4Z3I7mZ3O7PC5RWIMrQoWBeVQ4fu72FZ7/6NWnnShM+br1jIMoiJogXW5WhDn4xK6+hG1Vwg3KN76CCH8EfWaoXVHvQX0bfpOJRoBc+ogy41t7An+AgbaFCIzf5vanisua+3bYcOXTeFtb7dKGiwkhZLWJ0aaa/Rrowc1u9lYulocNdDgqSskRNgJ+LfF87/EjXCRmk7yjzwng1Y5nyDsQ0oS/noawjn6lDj3//vLsDTaC8T/UtAuHVVkRS3umQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Nov 2024 16:12:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13736 invoked by uid 111); 28 Nov 2024 16:12:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Nov 2024 11:12:33 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 28 Nov 2024 11:12:32 -0500
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Patrick Steinhardt <ps@pks.im>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] fast-import: disallow more path components
Message-ID: <20241128161232.GA11476@coredump.intra.peff.net>
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>

On Wed, Nov 27, 2024 at 08:47:44PM +0000, Elijah Newren via GitGitGadget wrote:

> Instead of just disallowing '.' and '..', make use of verify_path() to
> ensure that fast-import will disallow anything we wouldn't allow into
> the index, such as anything under .git/, .gitmodules as a symlink, or
> a dos drive prefix on Windows.
> 
> Since a few fast-export and fast-import tests that tried to stress-test
> the correct handling of quoting relied on filenames that fail
> is_valid_win32_path(), such as spaces or periods at the end of filenames
> or backslashes within the filename, turn off core.protectNTFS for those
> tests to ensure they keep passing.

Great, thanks for following up on this. I think it will work as
advertised, though...

> @@ -1413,6 +1414,8 @@ static int tree_content_set(
>  		die("Empty path component found in input");
>  	if (!*slash1 && !S_ISDIR(mode) && subtree)
>  		die("Non-directories cannot have subtrees");
> +	if (!verify_path(p, mode))
> +		die("invalid path '%s'", p);

This spot is over-verifying, I think, because it's recursive. Given the
path foo/bar/baz, it will see "foo/bar/baz", then "bar/baz", then "baz".
But just the first one should be sufficient to feed to verify_path().

I'd have expected the check when we parse the path in file_change_m().
That would also require touching other callers, too. One option would be
to put a non-recursive wrapper around tree_content_set(), and add the
check there.

But looking at those other callers, I think it's really just
file_change_cr() that maters. The other call in do_change_note_fanout()
is using a notes path that we've constructed ourselves (so it's not
wrong to check, but probably pointless).

The patch below passes your tests (though perhaps it would be worth
adding an explicit check of a copy/rename). Is it worth worrying about
the efficiency of the extra calls? I'm not sure, and I didn't measure.
But this just seems less surprising to me overall.

(Both your patch and what I've shown below do not verify deletions from
the tree, but I think that's fine; such a name would not exist in the
tree in the first place).

-Peff

---
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index bb4b769c7c..265d1b7d52 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1414,8 +1414,6 @@ static int tree_content_set(
 		die("Empty path component found in input");
 	if (!*slash1 && !S_ISDIR(mode) && subtree)
 		die("Non-directories cannot have subtrees");
-	if (!verify_path(p, mode))
-		die("invalid path '%s'", p);
 
 	if (!root->tree)
 		load_tree(root);
@@ -2417,6 +2415,9 @@ static void file_change_m(const char *p, struct branch *b)
 		tree_content_replace(&b->branch_tree, &oid, mode, NULL);
 		return;
 	}
+
+	if (!verify_path(path.buf, mode))
+		die("invalid path '%s'", path.buf);
 	tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
 }
 
@@ -2454,6 +2455,8 @@ static void file_change_cr(const char *p, struct branch *b, int rename)
 			leaf.tree);
 		return;
 	}
+	if (!verify_path(dest.buf, leaf.versions[1].mode))
+		die("invalid path '%s'", dest.buf);
 	tree_content_set(&b->branch_tree, dest.buf,
 		&leaf.versions[1].oid,
 		leaf.versions[1].mode,
