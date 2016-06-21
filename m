Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CDAD1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 19:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbcFUTiq (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 15:38:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:58090 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751504AbcFUTip (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 15:38:45 -0400
Received: (qmail 2532 invoked by uid 102); 21 Jun 2016 19:38:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 15:38:26 -0400
Received: (qmail 27864 invoked by uid 107); 21 Jun 2016 19:38:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 15:38:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 15:38:24 -0400
Date:	Tue, 21 Jun 2016 15:38:24 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5614: don't use subshells
Message-ID: <20160621193824.GA22183@sigill.intra.peff.net>
References: <1466443278-21591-1-git-send-email-sbeller@google.com>
 <xmqqh9cmpcze.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh9cmpcze.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 12:18:29PM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> >  Unlike the prior patch we would not want this patch to fall through
> >  to origin/maint fast, but allow cooking?
> 
> I do not see anything that makes this treated differently from the
> other fix.  The only difference in behaviour is that "lines" file is
> now created at the root level of the trash repository's working tree
> instead of tested clones', and I do not think any test depends on
> the number of untracked paths in the trash working tree or tries to
> make sure a file called "lines" is not in there.

I think it is only that the other patch is actually fixing something,
whereas this is cleanup. So the cost/benefit equation is different. I
agree neither is high-risk and a test cleanup is generally OK for maint
(the other is a serious-ish regression IMHO).

> Having said that, I wonder if we want further reduction of the
> repetition.  Each test except "setup" in this script does an
> identical thing with very small set of parameters:
> 
>     - make sure super_clone will be removed when done.
>     - clone file://$pwd/. to super_clone but with different set of options.
>     - check the commits in super_clone and super_clone/sub.
> 
> So, the above would ideally become something like
> 
> do_test 3 3 --recurse-submodules
> 
> where the helper would look like
> 
> do_test () {
> 	cnt_super=$1 cnt_sub=$2 &&
>         shift 2 &&
>         test_when_finished "rm -fr super_clone" &&
>         git clone "$@" "file://$pwd/." super_clone &&
>         git -C super_clone log --oneline >lines &&
>         test_line_count = $cnt_super lines &&
>         git -C super_clone/sub log --oneline >lines &&
>         test_line_count = $cnt_sub lines
> }
> 
> Would it rob too much flexibility from future tests to be added to
> this script if we did it that way?

I think that's an improvement, too. Even if we add further tests, they
don't have to follow the same format. I would give the function a better
name than "do_test" though. :P

-Peff
