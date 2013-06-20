From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] pull: merge into unborn by fast-forwarding from empty
 tree
Date: Thu, 20 Jun 2013 09:47:26 -0400
Message-ID: <20130620134726.GB18200@sigill.intra.peff.net>
References: <20130620124758.GA2376@sigill.intra.peff.net>
 <aca810600b895ed3f0a3fc575e0f6861e591de5b.1371733403.git.trast@inf.ethz.ch>
 <20130620131547.GA11073@sigill.intra.peff.net>
 <87zjuk6hr2.fsf@linux-k42r.v.cablecom.net>
 <87mwqk6h5d.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:47:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpfD4-00029F-Dj
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965588Ab3FTNra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:47:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:56927 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965461Ab3FTNr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:47:29 -0400
Received: (qmail 20240 invoked by uid 102); 20 Jun 2013 13:48:28 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 08:48:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 09:47:26 -0400
Content-Disposition: inline
In-Reply-To: <87mwqk6h5d.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228504>

On Thu, Jun 20, 2013 at 03:33:34PM +0200, Thomas Rast wrote:

> >> I naively would have expected this to leave us in a conflicted state
> >> over "file".  But I guess read-tree just rejects it, because we are not
> >> doing a real three-way merge.  I'm not sure it is that big a deal; this
> >> is more about safety than about creating a conflicted/resolvable state.
> >
> > Note that the test_must_fail essentially tests that the merge is rejected.
> 
> Bah, no it doesn't, a conflicting merge also returns a nonzero status.
> Sigh.
> 
> If you meant we should actually conflict,

Yes, that's what I meant.

> I'm not sure what options there would be other than actually calling a
> merge driver.  And we could actually do this like so (it'll obviously
> break the tests):

I'd rather not invoke a merge driver directly if we can avoid it.  I
think you could get rid of this special code-path entirely if you just
lied to the "git-merge" and said "the ancestor and current tree are fake
commits with an empty tree", and then followed the usual path. But that
lying through git-merge is ugly and complicated (and is more or less
what you're doing with the merge-recursive patch here).

> diff --git i/git-pull.sh w/git-pull.sh
> index 1f84383..b3d36a8 100755
> --- i/git-pull.sh
> +++ w/git-pull.sh
> @@ -276,7 +276,7 @@ then
>  	# lose index/worktree changes that the user already made on
>  	# the unborn branch.
>  	empty_tree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
> -	git read-tree -m -u $empty_tree HEAD || exit 1
> +	git merge-recursive $empty_tree -- $(git write-tree) HEAD || exit 1

I don't think there is any advantage to using merge-recursive over
read-tree here, in the sense that there cannot be any interesting
content-level merging going on (our ancestor is the empty tree, so we
know that differing content cannot be resolved).

So I think you could just use read-tree with a 3-way merge, but I cannot
seem to provoke it to leave a conflict. Hrm.

I also noticed that the procedure in this code path is:

  1. Update HEAD with the fetched ref.

  2. Checkout the contents with read-tree.

I wonder if it would make sense to update HEAD only _after_ we had
resolved successfully. As it is now, you are left in a weird state where
pull has reported failure, but we actually update the HEAD (and "git
status" afterwards reflects that you are building on top of the pulled
HEAD).

-Peff
