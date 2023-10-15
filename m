Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B766110A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9522ADC
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:26:37 -0700 (PDT)
Received: (qmail 10456 invoked by uid 109); 15 Oct 2023 03:26:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Oct 2023 03:26:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28572 invoked by uid 111); 15 Oct 2023 03:26:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Oct 2023 23:26:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Oct 2023 23:26:36 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, ks1322@gmail.com
Subject: Re: [PATCH] grep: die gracefully when outside repository
Message-ID: <20231015032636.GC554702@coredump.intra.peff.net>
References: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
 <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 11:02:38PM +0200, Kristoffer Haugsbakk wrote:

> Die gracefully when `git grep --no-index` is run outside of a Git
> repository and the path is outside the directory tree.
> 
> If you are not in a Git repository and say:
> 
>     git grep --no-index search ..
> 
> You trigger a `BUG`:
> 
>     BUG: environment.c:213: git environment hasn't been setup
>     Aborted (core dumped)
> 
> Because `..` is a valid path which is treated as a pathspec. Then
> `pathspec` figures out that it is not in the current directory tree. The
> `BUG` is triggered when `pathspec` tries to advice the user about the path
> to the (non-existing) repository.

Is it even reasonable for "grep --no-index" to care about leaving the
tree in the first place? That is, is there a reason we should not allow:

  git grep --no-index foo ../bar

? And if we do want to care, there is a weirdness here that even with
your patch, we check to see if the file exists:

  $ git grep --no-index foo ../does-exist
  fatal: '../does-exist' is outside the directory tree

  $ git grep --no-index foo ../does-not-exist
  fatal: ../does-not-exist: no such path in the working tree.

If we want to avoid leaving the current directory, then I think we need
to be checking much sooner (but again, I would argue that it is not
worth caring about in no-index mode).

I do think your patch does not make anything worse (and indeed makes the
error output much better). So I do not mind it in the meantime. But I
have a feeling that we'd end up reverting it as part of the fix for the
larger issue.

-Peff
