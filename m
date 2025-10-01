Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F51DA0E1
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759340480; cv=none; b=QDbbhzs5SLPgncS4Yo/tC3YJNs8td/mIKhXXS2EbraWoSZ2rUBl3dSA6591/tuZoy0G0x2zGCBAEyt38cyAq0rGCUZJPUMEqFVsodqnhstvpAdFwtHb6/35hq0IwyUBkCeT6iFJqqAeoGDivODlJe9Psk9ZJ8rG3yTwbdH0sXD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759340480; c=relaxed/simple;
	bh=JSrOGHSiI/PQWIYm1Y321VlBtBCB/hOu/MJbrjlxhbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsHEnqpyR1gHzaVwFIwZQN5cGf6dgS1dDEP0cOfC90qAB9lLMqhFi5ASo53bEyzrI8nPK8HiNaxTd8lLHkTwIJiwlEqiwc7EaZ9f4L96IreirKG2rPHnZtTt2LSTtxxqSLnYs3B3ff1rQvwkMFIu1Q8ZMvTXrzngeIOshVHQqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DZsIZ36x; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DZsIZ36x"
Received: (qmail 97685 invoked by uid 109); 1 Oct 2025 17:41:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JSrOGHSiI/PQWIYm1Y321VlBtBCB/hOu/MJbrjlxhbs=; b=DZsIZ36xl91fpgP7eQZMxhoDDR48xQoEgv/2k+b8bR2MvRXyn+4/Tud7ZIBlsS3nm3jV7bXWqMTQ5iBE838FKvfFPKom7zCNYaRocJeC2LorVQ81wROk7xTsddPvL6GiqCrIAMTZq/HhLioYGag9ATn8zcuIaCApxHhyTMoCKDgpiczSw4pE+0rvwA0Kk2Y3dIchiXJuetLC4zRo0n8pzHYhPNiSnV4eYDd2uwscUS2oskiA2ADJ81jMrOTLC9n3XdndAenx4GkQ/ifOyPWDFIMR2CnIRySfPeX+13zoM2hmGmbQral3rq+kOBEtWJHVRuvaWag/2mo64fZu9p6Irg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Oct 2025 17:41:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 137848 invoked by uid 1000); 1 Oct 2025 17:41:10 -0000
Date: Wed, 1 Oct 2025 13:41:10 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] Define an extended tree format
Message-ID: <20251001174110.GA137600@peff.net>
References: <20251001005814.846992-1-sandals@crustytoothpaste.net>
 <20251001005814.846992-2-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001005814.846992-2-sandals@crustytoothpaste.net>

On Wed, Oct 01, 2025 at 12:58:14AM +0000, brian m. carlson wrote:

> There are some cases in which we want to encode additional information
> in a tree but there is currently no possible way to do so.  Define a
> format for extended trees that uses mode 130000 plus some additional
> nonzero bytes in the file name to encode additional data in a mostly
> backwards compatible way.

Thanks for writing this up. This was along the lines I was thinking, but
I have a few variant suggestions to consider.

Your proposal here covers a very general extension format which can be
used for solving several possible problems. But if we constrain
ourselves just to the gitlink question, it does open up some more
possibilities. Here you're using a custom mode to mark the entry, and
the downside is that the mode will be somewhat confusing to old versions
of Git. They won't recognize a gitlink as such, and their fsck will
complain about it. It also leaves the question of what goes into the
hash/object-id field of the entry. We can't represent the true hash
(that is the whole problem we are trying to solve). You could put in the
null sha1, but that is another fsck landmine. So probably we have some
dummy hash. But old versions, not knowing it's a submodule, will expect
that hash to be reachable and will complain that it's missing!

What if instead, we leave the mode as S_IFGITLINK, but use a dummy hash
to recognize the extended submodule? Let's say 0000...1. We risk
colliding with a real hash, but the chances are quite unlikely, and it's
a risk we already take with the null oid. With this scheme, the old
versions will still realize it's a submodule, and that we do not need to
have access to that hash. If an old version checks it out without
submodule recursion, we'll never even try to access that hash. And if it
does, it will try to clone the appropriate gitmodule and say "oops, we
don't have that hash". Which is probably the best outcome we can hope
for.

The obvious downside is that this does nothing to help the
stored-conflict case. _If_ we are going to come up with a solution for
that, I agree it might make sense to piggy-back on it for submodules.
But I do think what I outlined above degrades a bit more gracefully. And
the compatibility scenarios for these two use cases may be different.
Alternate-hash submodule entries will be buried in old history and seen
many people. Conflict markers are probably shorter-lived and less likely
to be seen by people who aren't using modern versions of Git to work
with them.


The other way in which your proposal differs from what I was thinking is
in the use of BER in the filename. It is nice that it can unambiguously
encode a chunk of data, but the fact that it contains binary bytes makes
me worried about a few things:

  1. When users see it, does it look like junk? It is nice, IMHO, if the
     name does leak out to the user for it to be a bit more
     self-explanatory.

  2. When a filesystem sees it, can it handle it? I didn't think hard on
     it, but I'd guess BER generally isn't valid UTF-8. What will HFS+
     do with such a filename?

  3. To what degree can BER encoded bytes conflict with meaningful
     path names? In particular I wonder if "/" can appear, which will
     cause confusion (both in git-fsck, but also when we try to work in
     a directory that does not exist). Or worse, if you can sneak
     ".git/" into a name in a way that is interpreted by _some_ versions
     of Git but not others.

So I was thinking instead of something more ASCII-ish. Something like
"<link_type>-<link_data>-<pathname>". So in a sha256 tree, an entry for
a sha1 submodule might look like (as shown by ls-tree):

  160000 00000000000000000000000000000001 sha1-12345abcde12345abcde12345abcde12345abcde-the-real-path

The sentinel sha256 oid "000...1" would be binary in the tree, of
course, but the sha1 in the filename would be hex. It's not as
efficient, but I don't think that submodules are common enough for this
to be a real issue.

I was vague about "link_data" above. But I think if it is interpreted in
a manner specific to link_type, then this scheme could also eventually
enable non-git submodules. E.g., for the true masochist, you could
imagine svn-<url>-foo (with <url> percent-encoded to avoid dashes and
slashes). I'm not sure if anyone would ever find that useful, and it's
not something I'd plan to look into myself, but maybe it's a bonus?


The other issue of concern is sorting. If sha1-...-foo sorts as "foo",
then older versions will complain the tree is wrongly sorted. And
probably will produce slightly wrong diffs. I think modern Git would
Just Work in most spots, though, provided the handling is done in
decode_tree_entry() or similar.

Sorting the other way, as "sha1-", is mostly going to be a nightmare for
modern Git. If we want it to truly show "foo" in a diff, for example, it
would have to scan forward for any instance of "sha1-...-aaa" before
showing "aab". Yuck.

But what if we accepted that these entries were a bit more user-visible?
That is, the diff itself would not do anything special at all, and you
really would get a delete/add for:

  -sha1-12345abcde12345abcde12345abcde12345abcde-foo
  +sha1-67890fedcb67890fedcb67890fedcb67890fedcb-foo

instead of the more correct path-changing diff. And then either we
accept that ugliness, or we fix up the diff for display via diffcore or
similar (dropping those ugly entries and replacing them with a single
diff_filepair of "foo").

And likewise the submodule code would leave these ugly entries until the
moment it is ready to act on them, when it would realize that we want to
touch "foo" in the checkout (and both here and in a diff, obviously it
is an error if there is a "foo" already, but that is true already for
any tree with duplicate entries).

My gut feeling is that would keep the gross-ness confined to a few bits
of code, and you could still operate on these natively with tools like
mktree, ls-tree, and so on. The ugly names will leak out to the user
sometimes, but most porcelain flows would do the right thing.

-Peff
