Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1059477F12
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710233938; cv=none; b=uHWgUCyu/Pcfps6GRzlVnrxH06EYMKBugYrr5HD60ZBNWlizeqNs/cGae8FBRW7tkKdDet/Wss5NVWT7OOFW6g5YaRobh7ubf3cIPqScZuaYPXj/1JPzgZT4RFhQi7MupQqF76SwE4WoSXVplbqOiPuXptS6hdSLdGvYWe3IvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710233938; c=relaxed/simple;
	bh=hk1EVygZ4rMdseCY9DrkYKaWT7ESLuzv83yLUv9rG+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwpMaik2/eLA/kh7aG0BSKhfBavt/kfrImLGgHs0s63UTu4DMWB4/RW061f/wk3WWfume1aNv6eAzMbPocw14o0iE39JBAxE0QtqdCk4s68RUiMYNVsKXKmT3opkzeNOxBnkPEp+pIJkeVsAjhxvdyu/LvgTpl3191Wx4nSFB40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17260 invoked by uid 109); 12 Mar 2024 08:58:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 08:58:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27813 invoked by uid 111); 12 Mar 2024 08:58:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 04:58:59 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 04:58:54 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] cat-file: avoid verifying submodules' OIDs
Message-ID: <20240312085854.GA94437@coredump.intra.peff.net>
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
 <951f73397c15f76da75bbd74a02f36da0116623f.1710183362.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <951f73397c15f76da75bbd74a02f36da0116623f.1710183362.git.gitgitgadget@gmail.com>

On Mon, Mar 11, 2024 at 06:56:02PM +0000, Johannes Schindelin via GitGitGadget wrote:

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index de29e6d79d9..69b50d2042f 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -412,6 +412,11 @@ Note also that multiple copies of an object may be present in the object
>  database; in this case, it is undefined which copy's size or delta base
>  will be reported.
>  
> +Submodules are handled specially in `git cat-file`, as the objects
> +corresponding to the recorded OIDs are not expected to be present in the
> +current repository. For that reason, submodules are reported as having
> +type `submodule` and mode 1600000 and all other fields are zeroed out.

I think there's an extra 0 in the mode here?

It may also be worth being more explicit about when Git knows something
is a submodule. Naively, reading the above I might think that:

  git ls-tree --format='%(objectname)' HEAD | git cat-file --batch-check

would do something special with submodules. But it can't, as there's no
context carried in just the objectname. This is obvious if you are
familiar with how Git works, but I'm not sure it would be for all end
users. So we could say something along the lines of:

  When `cat-file` is given a name within a tree that points to a
  submodule (e.g., `HEAD:my-submodule`), ...

-Peff
