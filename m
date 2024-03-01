Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA64692FE
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 06:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276219; cv=none; b=MogZiIRng4XKadq4NeUBJRIT28OPoWsfyhCof6a7CLr2sE8k6fw6xInyZC1bl0QwGeqrdXzzM9zJnhkxbi7ALnHzhkhAmqGqNJac+AYIx7vmfpF05nxm1kZvU6ZkLI5mruyFBSgwrOaiHhd4ePCuMwGgEafdPscvP75xlDDleBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276219; c=relaxed/simple;
	bh=M3Dz1UsGf0N4d8wrDMazsEpHO5j3ALPH4aHwHmOJOuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b962poSmFKoTGXixieXez7Udi1kNGiXgGjEqpa9/mK1aAZIk2wPgknaa5rEi0nHRRJbV4Lq5sCv0y9GFemdFb3SXVfe9vb+H5JNI5xRY2+JCeQNrMjrHSbfK83bOiUS91o8mA+1O6KJU9W8inHDQf3pdn+ANOjqK0zSQpHaCGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1982 invoked by uid 109); 1 Mar 2024 06:56:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 01 Mar 2024 06:56:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9725 invoked by uid 111); 1 Mar 2024 06:56:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 01 Mar 2024 01:56:52 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 1 Mar 2024 01:56:47 -0500
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 03/11] Start reporting missing commits in
 `repo_in_merge_bases_many()`
Message-ID: <20240301065647.GA2680308@coredump.intra.peff.net>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
 <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
 <4dd214f91d4783f29b03908cc0034156253889a7.1708608110.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dd214f91d4783f29b03908cc0034156253889a7.1708608110.git.gitgitgadget@gmail.com>

On Thu, Feb 22, 2024 at 01:21:42PM +0000, Johannes Schindelin via GitGitGadget wrote:

> @@ -1402,6 +1436,8 @@ static int merge_mode_and_contents(struct merge_options *opt,
>  							&o->oid,
>  							&a->oid,
>  							&b->oid);
> +			if (result->clean < 0)
> +				return -1;

Coverity flagged this code as NO_EFFECT. The issue is that result->clean
is an unsigned single-bit boolean, so it can never be negative. If we
expand the context a bit, it's

                        result->clean = merge_submodule(opt, &result->blob.oid,
                                                        o->path,
                                                        &o->oid,
                                                        &a->oid,
                                                        &b->oid);
                        if (result->clean < 0)
                                return -1;

So it's possible there's also a problem in the existing assignment, as a
negative return from merge_submodule() would be truncated. But from my
read of it, it will always return either 0 or 1 (if it sees errors from
repo_in_merge_bases(), for example, it will output an error message and
return 0).

So I think we'd want either:

  1. Drop this hunk, and let result->clean stay as a pure boolean.

  2. Propagate errors from merge_submodule() using -1, in which case the
     code needs to be more like:

       int ret = merge_submodule(...);
       if (ret < 0)
               return -1;
       result->clean = !!ret;

I didn't follow the series closely enough to know which would be better.
I guess alternatively it could be a tri-state that carries the error
around (it looks like it is in ort's "struct merge_result"), but that
probably means auditing all of the spots that look at "clean" to see
what they would do with a negative value.

-Peff
