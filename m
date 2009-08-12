From: Jeff King <peff@peff.net>
Subject: Re: fatal: bad revision 'HEAD'
Date: Wed, 12 Aug 2009 03:58:33 -0400
Message-ID: <20090812075833.GF15152@coredump.intra.peff.net>
References: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
 <20090810011803.GA435@coredump.intra.peff.net>
 <09EE2E57-626B-4686-A6DD-3B8DF1BC3FE2@gmail.com>
 <20090811015615.GA8383@coredump.intra.peff.net>
 <C44788EB-02BA-4D69-8091-9E97827223A0@gmail.com>
 <20090812032740.GA26089@coredump.intra.peff.net>
 <7v7hx98otz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joel Mahoney <joelmahoney@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 09:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb8jL-00009b-Qg
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 09:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbZHLH6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 03:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754238AbZHLH6d
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 03:58:33 -0400
Received: from peff.net ([208.65.91.99]:52674 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZHLH6d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 03:58:33 -0400
Received: (qmail 9754 invoked by uid 107); 12 Aug 2009 07:58:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 Aug 2009 03:58:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Aug 2009 03:58:33 -0400
Content-Disposition: inline
In-Reply-To: <7v7hx98otz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125680>

On Wed, Aug 12, 2009 at 12:37:44AM -0700, Junio C Hamano wrote:

> But just like we twisted the definition of merge to mean "merging
> something into nothing yields that something", we could twist the
> definition of rebase to mean "rebasing nothing on top of something result
> in that something".  It sort of makes sense in a twisted way.

I dunno. It doesn't seem all that twisted to me.

But like many of the "branch to be born" and "initial commit" edge cases
we have dealt with, it is not so much about somebody intentionally
triggering this as it is about doing something sane when some script
_does_ trigger it. And I think the sane thing is obvious and easy to do
here, so why not?

>  * Is "rev-parse -q --verify" a safe test to guarantee that HEAD is
>    unborn?  Shouldn't we be checking with "symbolic-ref" or something?

I'm not sure. The test in git-checkout, for example, seems to basically
just be looking up HEAD as a commit. If it doesn't work, then the branch
is to-be-born (see switch_branches in builtin-checkout.c).

Which is more or less what's happening here (except we don't check that
the type is a commit).

With symbolic-ref, I guess we could find out what the ref is, and check
to see if _that_ exists. But I can't think of a situation where that
would be meaningfully different than just resolving HEAD. Obviously
detached HEADs come to mind, but wouldn't you then by definition not be
a branch-to-be-born, which is what this rev-parse test would tell you?

>  * In such an "unborn branch" case, by definition, a non-empty index won't
>    be based on whatever we are pulling down from the remote.  So how about
>    doing something like the following instead?
> 
> 	if on unborn branch
> 	then
> 		if test -f "$GIT_DIR/index"
>                 then
> 			die "refusing to update; you have a non-empty index"
> 		fi
> 	else
> 		... existing tests against HEAD ...
> 	fi

Yeah, I think that is a better idea. Do you want to tweak the patch, or
should I re-submit?

-Peff
