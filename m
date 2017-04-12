Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA380209FA
	for <e@80x24.org>; Wed, 12 Apr 2017 00:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdDLAnG (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 20:43:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:60463 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbdDLAnF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 20:43:05 -0400
Received: (qmail 24133 invoked by uid 109); 12 Apr 2017 00:43:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 12 Apr 2017 00:43:02 +0000
Received: (qmail 9474 invoked by uid 111); 12 Apr 2017 00:43:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Apr 2017 20:43:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Apr 2017 20:42:59 -0400
Date:   Tue, 11 Apr 2017 20:42:59 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2017, #01; Tue, 11)
Message-ID: <20170412004258.olfxsdbc3go25s7x@sigill.intra.peff.net>
References: <xmqqh91vqquf.fsf@gitster.mtv.corp.google.com>
 <20170411224713.GS8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170411224713.GS8741@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 03:47:13PM -0700, Jonathan Nieder wrote:

> Junio C Hamano wrote:
> 
> > * jk/no-looking-at-dotgit-outside-repo-final (2016-10-26) 1 commit
> >   (merged to 'next' on 2017-02-27 at 7373a1b73d)
> >  + setup_git_env: avoid blind fall-back to ".git"
> >
> >  This is the endgame of the topic to avoid blindly falling back to
> >  ".git" when the setup sequence said we are _not_ in Git repository.
> >  A corner case that happens to work right now may be broken by a
> >  call to die("BUG").
> 
> There's one caller we missed, in "git apply" when you apply a binary
> patch outside any repository.

Good catch. This might also trigger with "apply --3way", but I didn't
check. Your patch would presumably fix that, too.

> diff --git a/sha1_file.c b/sha1_file.c
> index 71063890ff..bf1ff2ef77 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3481,6 +3481,8 @@ int has_sha1_file_with_flags(const unsigned char *sha1, int flags)
>  {
>  	struct pack_entry e;
>  
> +	if (!startup_info->have_repository)
> +		return 0;

I added have_git_dir(), which catches some other cases (e.g., we have a
$GIT_DIR but just haven't entered the repo _yet_). TBH, I am not
entirely sure when it would be needed, and when checking have_repository
is enough. I added it to make some cases with early config-reading work,
but now that we have Dscho's discover-the-real-repo, I think it would
supersede that use anyway.

So...maybe you'd want it here and maybe not?

-Peff
