From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Removed redundant static functions such as
	update_tracking_ref() and verify_remote_names() from
	builtin-send-pack.c, and made the ones in transport.c not be static
	so they can be used instead.
Date: Fri, 24 Apr 2009 17:04:18 -0400
Message-ID: <20090424210418.GC13561@coredump.intra.peff.net>
References: <1240546432-26212-1-git-send-email-andy@petdance.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: andy@petdance.com
X-From: git-owner@vger.kernel.org Fri Apr 24 23:06:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxSax-0006gf-MB
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 23:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbZDXVEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 17:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbZDXVE3
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 17:04:29 -0400
Received: from peff.net ([208.65.91.99]:51805 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbZDXVE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 17:04:29 -0400
Received: (qmail 31423 invoked by uid 107); 24 Apr 2009 21:04:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 24 Apr 2009 17:04:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Apr 2009 17:04:18 -0400
Content-Disposition: inline
In-Reply-To: <1240546432-26212-1-git-send-email-andy@petdance.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117487>

Great, I think this is something that needs to be done, and it is always
nice to see a diffstat like:

>  6 files changed, 23 insertions(+), 198 deletions(-)

that shows massive cleanup. But your patch is a little hard to review,
so let me try to constructively critique your commit message for a
moment.

First off, it really seems like there are two things happening here:
removing the functions mentioned in the subject, and:

> Added const to some function parameters.

I don't think those are related, so it makes sense to split them into
two patches in a series. This has a few advantages:

  - when reviewers read the patch, they know to which topic each change
    belongs (and yes, we can figure it out by reading the change
    carefully, but it is a lot easier when you start reading a diff to
    say "OK, I know approximately what this is going to do from the
    commit message" and then confirm that it does what you thought)

  - if one of the topics is controversial but the other is not, the
    non-controversial changes are not held hostage while the
    controversial ones are discussed or re-done

Moving on to the message itself, it is very top-heavy:

> Subject: Re: [PATCH] Removed redundant static functions such as
>	update_tracking_ref() and verify_remote_names() from
>	builtin-send-pack.c, and made the ones in transport.c not be static
>	so they can be used instead.

The first line of the message is really supposed to be a one-liner, like
the subject of an email, to give people a general sense of what is going
on. Then you can go into more detail in a follow-on paragraph. That
makes things like "gitk" and "git log --oneline" more useful.

And as a grammatical nit, in git itself we usually use the imperative
mood in commit mesages. So "remove" and "add" instead of "removed and
added".

As far as the details itself, usually you want to talk about _why_ to
make this change. In this case, removing redundant code is a pretty
obvious reason, but I am left wondering another why: why is this OK to
do? In other words, where did the duplication come from, why was it
duplicated instead of refactored in the first place (simple oversight,
or some assumption that was true then, etc), and why are things
different now (correcting an oversight, that assumption no longer holds,
etc). From our prior discussion, the code came from 64fcef2. But I'm not
sure if the duplicated code is completely identical. I.e., was it
tweaked when it was copied to transport.c? If not, then say so, because
that is a question every reviewer should have. If so, then why is it OK
for send-pack to start using the tweaked version?

I have some guesses about the answers to those from our prior
discussions. But part of making the patch would be looking into those
things. And keep in mind that Junio probably didn't read our prior
discussion, nor will somebody reading the commit message two years from
now.

So I think the commmit message you want would be something like:

  remove duplicate functions from builtin-send-pack.c

  These functions are helpers for handling tracking refs, printing
  output, etc. They were originally used only by send-pack, but commit
  64fcef2 copied them to transport.c so that they could be used by all
  transports.

  As the versions in transport.c and builtin-send-pack.c are identical
  [or whatever you find out when you investigate], there is no reason 
  for there to be two copies. Copying instead of moving in 64fcef2
  appears to have simply been an oversight [even better, get
  confirmation from Daniel on why he did it that way].

  This patch just removes the versions in builtin-send-pack.c, and
  makes the ones in transport.c available as library functions.

As for the patch itself, there are a few spots I noticed in my cursory
look:

> --- a/remote.c
> +++ b/remote.c
> @@ -769,9 +769,9 @@ static int match_name_with_pattern(const char *key, const char *name,
> [...]
> +int remote_find_tracking(const struct remote *remote, struct refspec *refspec)
>  {
> -	int find_src = refspec->src == NULL;
> +	const int find_src = (refspec->src == NULL);

I don't think we usually worry about const-ing local variables like
this, but instead just focus on const-ing parameters. The compiler can
generally already detect constness of find_src here, because it can see
all of the places it is used (whereas crossing a function boundary,
anything can happen to a non-const parameter).

> -static const char *status_abbrev(unsigned char sha1[20])
> +static const char *status_abbrev(const unsigned char *sha1)

Is there a good reason to drop this from an array to a pointer?

> +void update_tracking_ref(const struct remote *remote, struct ref *ref, int verbose);
> +void print_push_status(const char *dest, const struct ref *refs, int verbose);
> +int refs_pushed(const struct ref *ref);
> +void verify_remote_names(int nr_heads, const char **heads);

This might need to be given more descriptive names if they will have
global linkage.

I do wonder, though...if http and other transports are using these via
transport.c, then why is the git transport not doing the same thing? In
other words, should they actually be statics, and the calls ripped out
of send_pack()? Or send_pack() just moved into transport.c?

-Peff
