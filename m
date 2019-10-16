Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD28D1F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 21:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437446AbfJPVJ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 17:09:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:50056 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727542AbfJPVJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 17:09:58 -0400
Received: (qmail 7170 invoked by uid 109); 16 Oct 2019 21:09:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 16 Oct 2019 21:09:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3226 invoked by uid 111); 16 Oct 2019 21:13:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Oct 2019 17:13:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Oct 2019 17:09:57 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v2] Doc: Bundle file usage
Message-ID: <20191016210957.GA28981@sigill.intra.peff.net>
References: <7vzk4mj38g.fsf@alter.siamese.dyndns.org>
 <20191016095737.1588-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191016095737.1588-1-philipoakley@iee.email>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 16, 2019 at 10:57:37AM +0100, Philip Oakley wrote:

> From: Philip Oakley <philipoakley@iee.org>
> 
> Git URLs can accept bundle files for fetch, pull and clone, include
> in that section. Include git clone in the bundle usage description.
> Correct the quoting of <git-rev-list-args>.
> Detail the <git-rev-list-args> options for cloning a complete repo.

Thanks for picking this up again. :)

A few minor comments:

> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 7d6c9dcd17..0498e4895d 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -21,9 +21,9 @@ Some workflows require that one or more branches of development on one
>  machine be replicated on another machine, but the two machines cannot
>  be directly connected, and therefore the interactive Git protocols (git,
>  ssh, http) cannot be used.  This command provides support for
> -'git fetch' and 'git pull' to operate by packaging objects and references
> +'git fetch' and 'git pull' and 'git clone', to operate by packaging objects and references

Maybe:

  'git fetch', 'git pull', and 'git clone'

? Given the repetition below, though:

>  in an archive at the originating machine, then importing those into
> -another repository using 'git fetch' and 'git pull'
> +another repository using 'git fetch' and 'git pull' or 'git clone',

I wonder if we could rephrase this in a less awkward way. Perhaps:

  The 'git bundle' command packages objects and references in an archive
  at the originating machine, which can then be imported into another
  repository using 'git fetch', 'git pull', or 'git clone'.

> @@ -35,7 +35,7 @@ OPTIONS
>  
>  create <file>::
>  	Used to create a bundle named 'file'.  This requires the
> -	'git-rev-list-args' arguments to define the bundle contents.
> +	'<git-rev-list-args>' arguments to define the bundle contents.

This hunk makes sense. I'd probably use backticks here instead of
single-quotes, but I think we're pretty inconsistent across the
documentation about this. It probably makes sense to match the
existing text.

> @@ -92,6 +92,10 @@ It is okay to err on the side of caution, causing the bundle file
>  to contain objects already in the destination, as these are ignored
>  when unpacking at the destination.
>  
> +To create a bundle for 'git clone', use `--branches --tags` for
> +the <git-rev-list-args>. The (inappropriate) use of `--all` would include
> +refs from refs/remotes/* hierarchy in the resulting bundle.

Should <git-rev-list-args> be in quotes or backticks?

Any bundle created without a negative revision would be appropriate for
a clone. Maybe we could spell that out in more detail, like:

  Any bundle created without negative refspecs (e.g., `new` but not
  `old..new`) can be used on the receiving side with `git clone`. If you
  want to provide the same set of refs that a clone directly from the
  source repository would get, use `--branches --tags`. If you want to
  match `git clone --mirror`, which would clone other refs such as
  `refs/remotes/*`, use `--all`.

> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index bc354fe2dc..1c229d7581 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -53,6 +53,9 @@ These two syntaxes are mostly equivalent, except the former implies
>  --local option.
>  endif::git-clone[]
>  
> +'git clone', 'git fetch' and 'git pull', but not 'git push', will also
> +accept a suitable bundle file. See linkgit:git-bundle[1].

This makes sense to mention here. It's a little funny because the user
would see this included in "man git-clone" or whatever, but I don't
think it hurts to just be exhaustive rather than trying to tailor it to
each individual manpage.

-Peff
