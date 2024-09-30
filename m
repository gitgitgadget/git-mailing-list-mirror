Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69F7DA79
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727715479; cv=none; b=IwrrPWwP3rBgPwIbONDyvTE/l5B07cqAKeiWbG1QwUE1VO0mVpTpqYgBt3kaDBAG7s75lsMredKri13cQRPAv3wXin7RnSQSi3mqsiXO1sm0Wp6SyNpF7ZtTgezuYbz+uRGlqge2zhBoStkHPGSNgOfDtE6kDJeyMB4YdKtFWA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727715479; c=relaxed/simple;
	bh=uXD6DMx1838T4HEKCyObRbQh2j0NDS+KibqF7Pvf2oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkiK+7EqtGIJ6xX3UDsAWqY1hKJsXeD1kOKwo+PkBhnQFtsw0vetYjPp2N2skS+Wl0wLzuXhDXeMQRPZI2fcAAlu3zWbWcsxlXrs2k/GKOrzFB78p4aDylzovXTbMXocRoqxwUIG2ookmNa17NLuIqSl7/04ZU8ismpdy75BYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u6Lco2Hj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u6Lco2Hj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FEBC4CECE;
	Mon, 30 Sep 2024 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727715477;
	bh=uXD6DMx1838T4HEKCyObRbQh2j0NDS+KibqF7Pvf2oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6Lco2Hj2iE2+Y8pQ4VXTnvSZIiyb7s+cZWZl+Iq+1lukmc8N5yrr4KGspEWG5JUV
	 PNWZXRtAXKpANKkOGjB6EkZzSWleFLcYTXXICyAvuWjJK5VIpmX0RCmm3edM/delno
	 zk5oA0bB7RfpyG97hXgSPoZj35+6SCT+OXEAvWyw=
Date: Mon, 30 Sep 2024 12:57:56 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Emily Shaffer <nasamuffin@google.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: Linking topic merges to mailing list threads
Message-ID: <20240930-sly-outstanding-boar-c16e9c@lemur>
References: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com>

On Mon, Sep 30, 2024 at 09:21:11AM GMT, Emily Shaffer wrote:
> Hi all,
> 
> We've been wanting to gather metrics on Git's code review process -
> how long it takes from first contact on list to merge, how many
> iterations are needed, time between iterations, etc. One missing link
> is the actual merge time in `next` and `master` - a human can infer
> the link between the patch and the mailing list thread, but it's more
> challenging for a script to do it.
> 
> Would it be possible to modify the maintainer workflow to include a
> link to the cover letter as merged in the merge commit message (or the
> link to the latest iteration of the patch if it's a single-patch
> change)? What issues could come up with that workflow?

One of the goals of b4 on the kernel side of things was to promote the use of
cover letters as merge commit templates, but this requires buy-in from
maintainers. It also doesn't really work for single-patch series.

For example, applying a series with "b4 shazam -M" will:

- fetch the series into FETCH_HEAD
- use the cover letter as the basis for the merge commit message
- insert the links to the source of the series
- open up the editor, allowing the maintainer to edit the merge commit message

Here's an example of such merge:

https://git.kernel.org/pub/scm/utils/b4/b4.git/commit/?id=b6b73918d94985bb2a017784fc14e013b36b38d0

> I guess one is that we could move from lore.kernel.org to something
> else, like we saw the migration from public-inbox.org some years ago.
> But the Message-ID was preserved between the two archives, so maybe
> it's enough to include the Message-ID in the merge commit?

This should be sufficient, yes, because you should still be able to find the
origin thread even if lore.kernel.org is defunct at some point.

> Another is, of course, the added burden on the maintainer. But maybe there
> is some script that is already used that we can modify to make the extra
> load negligible?

There is. :)

> (Or, even better, if anybody else is already successfully measuring
> these kinds of metrics without such a reference, could you let me know
> how you're doing it? :) )

On the kernel side, any time the topic of metrics comes up, it gets
immediately bogged down in "how much tracking is okay and how much is spying"
kinds of discussions that have never resulted in anything, really.

-K

