From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] pack-refs: add fully-peeled trait
Date: Sun, 17 Mar 2013 01:55:20 -0400
Message-ID: <20130317055520.GC16070@sigill.intra.peff.net>
References: <20130316090018.GA26708@sigill.intra.peff.net>
 <20130316090116.GB26855@sigill.intra.peff.net>
 <7vvc8qshgm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:55:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6ZS-0005co-9n
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855Ab3CQFzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 01:55:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54038 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab3CQFzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 01:55:23 -0400
Received: (qmail 7034 invoked by uid 107); 17 Mar 2013 05:57:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Mar 2013 01:57:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Mar 2013 01:55:20 -0400
Content-Disposition: inline
In-Reply-To: <7vvc8qshgm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218336>

On Sat, Mar 16, 2013 at 10:50:17PM -0700, Junio C Hamano wrote:

> I however wonder if the above implies it may make sense to add this
> on top?  Perhaps it is not worth it, because it makes a difference
> only to a repository with annotated tags outside refs/tags hierarchy
> and still has the packed-refs file that was created with an older
> version of Git, so we can just tell "repack with new Git" to users
> with such a repository.
> 
>  refs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index 7f84efd..afc4dde 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -847,8 +847,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  		    refline[0] == '^' &&
>  		    strlen(refline) == 42 &&
>  		    refline[41] == '\n' &&
> -		    !get_sha1_hex(refline + 1, sha1))
> +		    !get_sha1_hex(refline + 1, sha1)) {
>  			hashcpy(last->u.value.peeled, sha1);
> +			last->flag |= REF_KNOWS_PEELED;
> +		}
>  	}
>  }
>  

Almost. The older version of Git would not have written those peel lines
in the first place. So yes, if we saw such a file, we could assume the
peel lines are valid. But nobody has ever generated that (with the
except of git between my two patches).

I do think it may be worth doing, though, just because it makes the
handling of the flag more obvious; somebody reading it later would
wonder "hey, shouldn't we be setting REF_KNOWS_PEELED here?", and it is
simple and harmless to just do it, rather than confusing a later reader.

I'll re-roll in a second to incorporate the comments from Michael.

-Peff
