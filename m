From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Confusing git pull error message
Date: Fri, 09 Oct 2009 07:01:22 +0900
Message-ID: <20091009070122.6117@nanako3.lavabit.com>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
	<20090912211119.GA30966@coredump.intra.peff.net>
	<7v1vmar353.fsf@alter.siamese.dyndns.org>
	<4AC9D952.3050108@viscovery.net>
	<20091005115308.GA2122@coredump.intra.peff.net>
	<7vljjpacax.fsf@alter.siamese.dyndns.org>
	<20091005191257.GA24305@coredump.intra.peff.net>
	<20091005193516.GB20078@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 00:03:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw150-00087i-S5
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 00:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbZJHWCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 18:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756090AbZJHWCE
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 18:02:04 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41894 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467AbZJHWCD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 18:02:03 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 9C5CB11B84B;
	Thu,  8 Oct 2009 17:01:24 -0500 (CDT)
Received: from 9973.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id CS7PB140MAFI; Thu, 08 Oct 2009 17:01:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=auGfRgHGoSx1BBTq0U21PaNFmGuypR6LM+O5iFmpK+0sK6BXIEF1qSoN4caY3VxgsfiE8GcS05unB1fnnECbts+otw2RCuKWfObQh50CzrUb7QM9UJfCfeVEDIH841agRVwWspCVRJ00U1P2kXUL8wUwcNyx9ibdlXxCe5erwIo=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091005193516.GB20078@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129718>

Quoting Jeff King <peff@peff.net>

> On Mon, Oct 05, 2009 at 03:12:57PM -0400, Jeff King wrote:
>
>> > I think you are right.
>> 
>> Nope, I'm not. I figured out one more case that it needs to handle.
>> Revised patch coming up in a few minutes.
>
> OK, here it is, which I think covers all of the cases. I also re-wrapped
> the text, as I agree with JSixt that it was pretty ugly. I also
> re-wrapped some of the existing text, as it gave the very choppy:
>
>   Your configuration specifies to merge the ref
>   'foo' from the remote, but no such ref
>   was fetched.
>
> It would be really nice to just pipe it through 'fmt', but I suspect
> that will create portability problems.
>
> -- >8 --
> Subject: [PATCH] pull: improve advice for unconfigured error case
>
> There are several reasons a git-pull invocation might not
> have anything marked for merge:
>
>   1. We're not on a branch, so there is no branch
>      configuration.
>
>   2. We're on a branch, but there is no configuration for
>      this branch.
>
>   3. We fetched from the configured remote, but the
>      configured branch to merge didn't get fetched (either
>      it doesn't exist, or wasn't part of the fetch refspec).
>
>   4. We fetched from the non-default remote, but didn't
>      specify a branch to merge. We can't use the configured
>      one because it applies to the default remote.
>
>   5. We fetched from a specified remote, and a refspec was
>      given, but it ended up not fetching anything (this is
>      actually hard to do; if the refspec points to a remote
>      branch and it doesn't exist, then fetch will fail and
>      we never make it to this code path. But if you provide
>      a wildcard refspec like
>
>        refs/bogus/*:refs/remotes/origin/*
>
>      then you can see this failure).
>
> We have handled (1) and (2) for some time. Recently, commit
> a6dbf88 added code to handle case (3).
>
> This patch handles cases (4) and (5), which previously just
> fell under other cases, producing a confusing message.
>
> While we're at it, let's rewrap the text for case (3), which
> looks terribly ugly as it is.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-pull.sh |   16 ++++++++++++----
>  1 files changed, 12 insertions(+), 4 deletions(-)

Junio, may I ask what happened to this patch?
