Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED529CF0
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C939C83
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 09:21:55 -0800 (PST)
Received: (qmail 21773 invoked by uid 109); 6 Nov 2023 17:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 06 Nov 2023 17:21:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11567 invoked by uid 111); 6 Nov 2023 17:21:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Nov 2023 12:21:56 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Nov 2023 12:21:54 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] shallow: fix memory leak when registering shallow
 roots
Message-ID: <20231106172154.GB10414@coredump.intra.peff.net>
References: <cover.1699267422.git.ps@pks.im>
 <137c150e358a8248200e0c7174a79358adb92e45.1699267422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <137c150e358a8248200e0c7174a79358adb92e45.1699267422.git.ps@pks.im>

On Mon, Nov 06, 2023 at 11:45:57AM +0100, Patrick Steinhardt wrote:

> --- a/shallow.c
> +++ b/shallow.c
> @@ -38,8 +38,10 @@ int register_shallow(struct repository *r, const struct object_id *oid)
>  
>  	oidcpy(&graft->oid, oid);
>  	graft->nr_parent = -1;
> -	if (commit && commit->object.parsed)
> +	if (commit && commit->object.parsed) {
> +		free_commit_list(commit->parents);
>  		commit->parents = NULL;
> +	}
>  	return register_commit_graft(r, graft, 0);
>  }

Good catch. When I've dealt with leaks around commit_lists in the past,
one gotcha is that sometimes we've saved a pointer to the list
elsewhere. But in this case it looks pretty clear that the parent list
just goes away. So this patch is doing the right thing.

-Peff
