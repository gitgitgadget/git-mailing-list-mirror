Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C41A76C7
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077542; cv=none; b=t3a8AWNt0wSKb7XTyPJl7pZ9xnh/KhECDLq+sbLySjlJk5EYwkdx4i4la6eAlJ9XrRsWgxOJrrt9lerlFHo+mLpIkQ4rNbhmNZWZstCj/Ijd6ycIfw0BWAF8MNNH8uldruDJcObJ4OpU8jNyJcajMnxv/leN9VhZydeDlijhwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077542; c=relaxed/simple;
	bh=Q05wTkes3t2FaL20AH8ow1twiAetVhuaQGByl8vfeM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcdIN/lKxYjqLxhewgm6HKqsCxMj3P6aC7ozO1ENBCWHBp3OCCSkHPqx3Mz08/Q+C8IUfqg4rNRDd4T5sgEs2ND4JnxzKOGe1HS8TMlI3eWkK6HHbHGqGGWnr5zmXfHdTenYMygvOeSkJD1yaFJ4yw/8+nci2uMNfATR5D/mjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eHDWlRyQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eHDWlRyQ"
Received: (qmail 14896 invoked by uid 109); 13 Dec 2024 08:12:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Q05wTkes3t2FaL20AH8ow1twiAetVhuaQGByl8vfeM8=; b=eHDWlRyQ+1iIzc++LLK8XXOw+J8vXGgqIPSY5eq/fScXCwND50WBPFQuxmzaSUhaAH+3n3pEkv4J0pFrTHiuKL0DrUv5Lk/x2/25Bgse+/d3NWurwe19aouahu05LwucEdY03VICLjl/BkOZNzvCLZ8nhxQOjyLUDC72QZVHtc0EiSv4NEcA0GlV77TC2Gzb++FQbrIRF2jlPOgLoeC4jYCargjBrzFddXdwcNWCl7O+cg2fqj6IJwZ3Qz+9d6IwPHfASfPBbZJKlMmpVEV8am+t7W7DCXOmIDzMCfW+VMPiGnZGimyVmq4Rgqh5AgMqW19h7FlBwZG/3cq7uDC3Jw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Dec 2024 08:12:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25567 invoked by uid 111); 13 Dec 2024 08:12:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Dec 2024 03:12:12 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 13 Dec 2024 03:12:11 -0500
From: Jeff King <peff@peff.net>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241213081211.GA1443203@coredump.intra.peff.net>
References: <20241213042312.2890841-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213042312.2890841-1-jltobler@gmail.com>

On Thu, Dec 12, 2024 at 10:23:09PM -0600, Justin Tobler wrote:

> To enable support for batch diffs of multiple blob pairs, this
> series introduces a new diff plumbing command git-diff-blob(1). Similar
> to git-diff-tree(1), it provides a "--stdin" option that reads a pair of
> blobs on each line of input and generates the diffs. This is intended to
> be used for scripting purposes where more fine-grained control for diff
> generation is desired. Below is an example for each usage:
> 
>     $ git diff-blob HEAD~5000:README.md HEAD:README.md
> 
>     $ git diff-blob --stdin <<EOF
>     88f126184c52bfe4859ec189d018872902e02a84 665ce5f5a83647619fba9157fa9b0141ae8b228b
>     HEAD~5000:README.md HEAD:README.md
>     EOF

In the first example, I think just using "git diff" would work (though
it is not a plumbing command). But the stdin example is what's
interesting here anyway, since it can handle arbitrary inputs. So let's
focus on that.

Feeding just blob ids has a big drawback: we don't have any context! So
you get bogus filenames in the patch, no mode data, and so on.

Feeding the paths along with their commits, as you do on the second
line, gives you those things from the lookup context. But it also has
some problems. One, it's needlessly expensive; we have to traverse
HEAD~5000, and then dig into its tree to find the blobs (which
presumably you already did, since how else would you end up with those
oids). And two, there are parsing ambiguities, since arbitrary revision
names can contain spaces. E.g., are we looking for the file "README.md
HEAD:README.md" in HEAD~5000?

So ideally we'd have an input format that encapsulates that extra
context data and provides some mechanism for quoting. And it turns out
we do: the --raw diff format.

If the program takes that format, then you can manually feed it two
arbitrary blob oids if you have them (and put whatever you like for the
mode/path context), like:

  git diff-blob --stdin <<\EOF
  :100644 100644 88f126184c52bfe4859ec189d018872902e02a84 665ce5f5a83647619fba9157fa9b0141ae8b228b M	README.md
  EOF

Or you can get the real context yourself (though it seems to me that
this is a gap in what "cat-file --batch" should be able to do in a
single process):

  git ls-tree HEAD~5000 README.md >out
  read mode_a blob oid_a path <out
  git ls-tree HEAD README.md >out
  read mode_b blob oid_b path <out
  printf ":$mode_a $mode_b $oid_a $oid_b M\tREADME.md" |
  git diff-blob --stdin

But it also means you can use --raw output directly. So:

  git diff-tree --raw -r HEAD~5000 HEAD -- README.md |
  git diff-blob --stdin

Now that command by itself doesn't look all that useful; you could have
just asked for patches from diff-tree. But by splitting the two, you can
filter the set of paths in between (for example, to omit some entries,
or to batch a large diff into more manageable chunks for pagination,
etc).

The patch might look something like this:

  https://lore.kernel.org/git/20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net/

:) That is what has been powering the diffs at github.com since 2016 or
so. And continues to do so, as far as I know. I don't have access to
their internal repository anymore, but I've continued to rebase the
topic forward in my personal repo. You can fetch it from:

  https://github.com/peff/git jk/diff-pairs

in case that is helpful.

-Peff
