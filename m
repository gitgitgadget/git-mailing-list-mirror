Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E945023751
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C59810EC
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 10:35:13 -0800 (PST)
Received: (qmail 20199 invoked by uid 109); 13 Nov 2023 18:35:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Nov 2023 18:35:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5160 invoked by uid 111); 13 Nov 2023 18:35:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Nov 2023 13:35:10 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 13 Nov 2023 13:35:09 -0500
From: Jeff King <peff@peff.net>
To: Arthur Chan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH v2] fuzz: add new oss-fuzz fuzzer for date.c / date.h
Message-ID: <20231113183509.GA3838361@coredump.intra.peff.net>
References: <pull.1612.git.1699724379458.gitgitgadget@gmail.com>
 <pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1612.v2.git.1699892568344.gitgitgadget@gmail.com>

On Mon, Nov 13, 2023 at 04:22:48PM +0000, Arthur Chan via GitGitGadget wrote:

> +	str = (char *)malloc(size + 1);
> +	if (!str)
> +		return 0;
> +	memcpy(str, data, size);
> +	str[size] = '\0';

Is it important that we avoid calling die() if the malloc fails here?

The usual way to write this in our code base is just:

  str = xmemdupz(data, size);

It's not entirely a style thing; we sometimes audit the code base
looking for computations on malloc sizes (for integer overflows) as well
as sites that should be using xmalloc and are not. Obviously we can
exclude oss-fuzz/ from such audits, but if there's no reason not to
prefer our usual style, it's one less thing to worry about.

-Peff
