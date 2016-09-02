Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81B061F6BF
	for <e@80x24.org>; Fri,  2 Sep 2016 00:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751085AbcIBAzw (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 20:55:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:36916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750980AbcIBAzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 20:55:51 -0400
Received: (qmail 12109 invoked by uid 109); 2 Sep 2016 00:55:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 00:55:50 +0000
Received: (qmail 21063 invoked by uid 111); 2 Sep 2016 00:55:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Sep 2016 20:55:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2016 20:55:45 -0400
Date:   Thu, 1 Sep 2016 20:55:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Should "git symbolic-ref -d HEAD" be forbidden?
Message-ID: <20160902005545.rbfxxdcv7nekzqku@sigill.intra.peff.net>
References: <xmqqpoonuy4n.fsf@gitster.mtv.corp.google.com>
 <20160901211907.iivokwu3yjuxz3qf@sigill.intra.peff.net>
 <xmqq8tvbuu9r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tvbuu9r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 01, 2016 at 03:31:28PM -0700, Junio C Hamano wrote:

> -- >8 --
> Subject: symbolic-ref -d: do not allow removal of HEAD
> 
> If you delete the symbolic-ref HEAD from a repository, Git no longer
> considers it valid, and even "git symbolic-ref HEAD refs/heads/master"
> would not be able to recover from that state.
> 
> In the spirit similar to afe5d3d5 ("symbolic ref: refuse non-ref
> targets in HEAD", 2009-01-29), forbid removal of HEAD.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Makes sense. You might want to change "it" in "no longer considers it
valid" to "the repository". At first I thought "it" referred to the
symref. Which obviously shouldn't be valid after being deleted. :)

>  I decided against it for now for no good reason, other than I am a
>  bit superstitious, but it may be a good idea to move these safety
>  checks to delete_ref() and create_symref() in the longer term.

Yeah, that somehow feels weird and too low-level to me. After all, we
_do_ want to drop HEAD as a symref when we turn it into a detached HEAD.
The point of this (and afe5d3d5) is to prevent people from shooting
themselves in the foot. Internal Git code should know to avoid this
foot-shooting itself.

OTOH, I think "git update-ref --no-deref -d HEAD" is another user-facing
hole-in-foot opportunity, and it would be blocked by putting this into
delete_ref().

> -test_expect_success 'symbolic-ref deletes HEAD' '
> -	git symbolic-ref -d HEAD &&
> +test_expect_success 'HEAD cannot be removed' '
> +	test_must_fail git symbolic-ref -d HEAD
> +'
> +
> +test_expect_success 'symbolic-ref can be deleted' '
> +	git symbolic-ref NOTHEAD refs/heads/foo &&
> +	git symbolic-ref -d NOTHEAD &&
>  	test_path_is_file .git/refs/heads/foo &&
> -	test_path_is_missing .git/HEAD
> +	test_path_is_missing .git/NOTHEAD
>  '
>  reset_to_sane

Do you want another "reset_to_sane" call after your new test? Otherwise
if it fails the "symbolic-ref can be deleted" test will start operating
on the parent repository.

-Peff
