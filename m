From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: accept any ref for merge
Date: Fri, 19 Sep 2014 05:39:11 -0400
Message-ID: <20140919093910.GA15891@peff.net>
References: <1411112385-33479-1-git-send-email-schacon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 11:39:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUuet-0005E7-8f
	for gcvg-git-2@plane.gmane.org; Fri, 19 Sep 2014 11:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbaISJjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2014 05:39:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:50071 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751097AbaISJjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2014 05:39:14 -0400
Received: (qmail 29345 invoked by uid 102); 19 Sep 2014 09:39:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Sep 2014 04:39:14 -0500
Received: (qmail 29322 invoked by uid 107); 19 Sep 2014 09:39:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Sep 2014 05:39:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Sep 2014 05:39:11 -0400
Content-Disposition: inline
In-Reply-To: <1411112385-33479-1-git-send-email-schacon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257283>

On Fri, Sep 19, 2014 at 09:39:45AM +0200, Scott Chacon wrote:

> Currently if you try to merge notes, the notes code ensures that the
> reference is under the 'refs/notes' namespace. In order to do any sort
> of collaborative workflow, this doesn't work well as you can't easily
> have local notes refs seperate from remote notes refs.
> 
> This patch changes the expand_notes_ref function to check for simply a
> leading refs/ instead of refs/notes to check if we're being passed an
> expanded notes reference. This would allow us to set up
> refs/remotes-notes or otherwise keep mergeable notes references outside
> of what would be contained in the notes push refspec.

I think this change affects not just "git notes merge", but all of the
notes lookups (including just "git notes show"). However, I'd argue
that's a good thing, as it allows more flexibility in note storage. The
downside is that if you have a notes ref like
"refs/notes/refs/heads/master", you can no longer refer to it as
"refs/heads/master" (you have to use the fully qualified name to get the
note). But:

  1. This makes the notes resolution a lot more like regular ref
     resolution (i.e., we now allow fully qualified refs, and you can
     store remote notes outside of refs/notes if you want to).

  2. There are already a bunch of names that have the same problem. You
     cannot refer to "refs/notes/notes/foo" as "notes/foo", nor
     "refs/notes/refs/notes/foo" as "refs/notes/foo". Yes, these are
     silly names, so is the example above.

So it's backwards incompatible with the current behavior, but I think in
a good way.

> ---
>  notes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I think you need to adjust t3308 (and you should probably add a new test
exercising your case; this is exactly the sort of thing that it's easy
to accidentally regress later).

-Peff
