Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF53C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 14:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjHKOvX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjHKOvX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 10:51:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BA02702
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:51:22 -0700 (PDT)
Received: (qmail 15149 invoked by uid 109); 11 Aug 2023 14:51:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 14:51:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26202 invoked by uid 111); 11 Aug 2023 14:51:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 10:51:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 10:51:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wesley <wesleys@opperschaap.net>, git@vger.kernel.org
Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
Message-ID: <20230811145121.GB2303200@coredump.intra.peff.net>
References: <20230810004956.GA816605@coredump.intra.peff.net>
 <20230810011831.1423208-1-wesleys@opperschaap.net>
 <xmqqcyzupf3b.fsf@gitster.g>
 <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net>
 <xmqqwmy2no2e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwmy2no2e.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 10:30:17PM -0700, Junio C Hamano wrote:

> And embarrassingly, the above is not sufficient, as the way $term is
> used in git-send-email and git-svn are subtly different.
> 
> I think we further need something like this on top, but my Perl is
> rusty.
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index e919c3f172..6033b97a0c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -427,7 +427,7 @@ sub ask {
>  	my $default = $arg{default};
>  	my $resp;
>  	my $i = 0;
> -	term_init() unless $term;
> +	my $term = term_init();
>  
>  	if ( !( defined($term->IN)
>              && defined( fileno($term->IN) )

Hmm. Isn't that an indication that git-svn is OK as-is?

Looking at the version of git-svn.perl on the tip of master, I see we
declare a global $term along with the initializer:

  my $term;
  sub term_init {
          $term = eval { ...etc... }

And then later in ask we call term_init() only if it's uninitialized:

  sub ask {
          ...
          term_init() unless $term;

So those are looking at the same $term, and the result should only be
initialized once.

It could still benefit from cleaning up FakeTerm, since we lazily init
the object since 30d45f798d (git-svn: delay term initialization,
2014-09-14). But I don't think there's a visible bug here with the new
version of Term::ReadLine::Gnu.

-Peff
