From: Jeff King <peff@peff.net>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Thu, 19 Mar 2015 14:55:17 -0400
Message-ID: <20150319185517.GB8788@peff.net>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
 <20150316011343.GA928@peff.net>
 <xmqqfv90khpd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 19:55:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYfbJ-0003zk-9H
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 19:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbbCSSzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 14:55:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:35337 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbbCSSzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 14:55:20 -0400
Received: (qmail 31733 invoked by uid 102); 19 Mar 2015 18:55:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 13:55:19 -0500
Received: (qmail 16100 invoked by uid 107); 19 Mar 2015 18:55:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 14:55:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 14:55:17 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv90khpd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265817>

On Thu, Mar 19, 2015 at 10:41:50AM -0700, Junio C Hamano wrote:

> Just to make sure we do not keep this hanging forever and eventually
> forget it, I'm planning to queue this.

Thanks for following up. A few minor nits (and maybe a more serious
problem) on the explanation in the commit message:

> be complete., 2005-10-19) and ever since we instead stuffed a random
> bytes in ref->new_sha1 here.

s/a random/random/

> It turns out that no codepath that comes after this assignment even
> looks at ref->new_sha1 at all.
> 
>  - The only caller of everything_local(), do_fetch_pack(), returns
>    this list of ref, whose element has bogus new_sha1 values, to its
>    caller.  It does not look at the elements and acts on them.

s/list of ref/list of refs/ ? Or did you mean "the list we store in the
'ref' variable"?

I'm not sure what the final sentence means. Should it be "It does not
look at the elements nor act on them"?

do_fetch_pack actually does pass them down to find_common. But the
latter does not look at ref->new_sha1, so we're OK.

>  - The only caller of do_fetch_pack(), fetch_pack(), returns this
>    list to its caller.  It does not look at the elements and acts on
>    them.

Ditto on the wording in the final sentence here (but it is correct in
this case that we do not touch the list at all).

>  - The other caller of fetch_pack() is fetch_refs_via_pack() in the
>    transport layer, which is a helper that implements "git fetch".
>    It only cares about whether the returned list is empty (i.e.
>    failed to fetch anything).

So I thought I would follow this up by adding a free_refs() call in
fetch_refs_via_pack. After all, we just leak that list, right?

If only it were so simple. It turns out that the list returned from
fetch_pack() is _mostly_ a copy of the incoming refs list we give it.
But in filter_refs(), if allow_tip_sha1_in_want is set, we actually add
the unmatched "sought" refs here, too.

Which means we may be setting new_sha1 in one of these "sought" refs,
and that broadens the scope of code that might be affected by the patch
we have been discussing. However, I think the filter_refs code is wrong,
and should be making a copy of the sought refs to put in the new list.

I'm working up a few patches in that area, which I'll send out in a few
minutes. Once that is done, then I think the explanation you give above
would be correct.

-Peff
