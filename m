From: "David Jeske" <jeske@willowmail.com>
Subject: Re: is rebase the same as merging every commit?
Date: Fri, 27 Jun 2008 15:39:03 -0000
Message-ID: <42989.1632324599$1214581901@news.gmane.org>
References: <vpqd4m349hk.fsf@bauges.imag.fr>
	<willow-jeske-01l79c1jFEDjCWw6-01l7HsC6FEDjCV3k>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 17:51:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGEH-00080I-Sl
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 17:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYF0PuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 11:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbYF0PuU
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 11:50:20 -0400
Received: from w2.willowmail.com ([64.243.175.54]:33013 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751328AbYF0PuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 11:50:19 -0400
Received: (qmail 24851 invoked by uid 90); 27 Jun 2008 15:50:16 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Fri, 27 Jun 2008 15:39:03 -0000
In-Reply-To: <vpqd4m349hk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86575>

This example you provided Matthieu is exactly my confusion with rebase..

If I want to bring a 'broken feature-a' branch into my topic branch to build on
it, one commit of which is this:

> +	int * x = malloc(sizeof(char));

if I merge, my tree looks like:

:         /<--G<--H<--Qj jeske/topic1
:        /           /
:       /<--P<------Q    feature-a
:      /
: -----A<---B<---C master

or if I rebase, it looks like:

:                  /<--G'<--H' jeske/topic1
:                 /
:       /<--P<---Q    feature-a
:      /
: -----A<---B<---C master

-----

..and then through 'fixing' the patch, it ends up rebased and accepted onto the
mainline origin/master, as a single patch, which (among other things) changed
this line to:

> +	int * x = malloc(sizeof(int));

...if I merged above, it will look like,

:         /<--G<--H<--Qj jeske/topic1
:        /           /
:       /<--P<------Q    feature-a
:      /
: -----A<---B<---C<---Q' master

...if I rebased above, it will look like:

:                  /<--G'<--H' jeske/topic1
:                 /
:       /<--P<---Q    feature-a
:      /
: -----A<---B<---C<---Q' master


However, in both cases, because Q' is not connected to Q, I don't see how git
will do anything sane to help me accept Q' correctly.

If I rebased my merge-q-branch against the master, I would expect to get this
(which will cause a conflict I have to resolve):

:           /<--G<--H<--Qj jeske/topic1
:          /
: <--C<---Q' master

If I rebased my rebase-q-branch against master, I would expect to get this
(which will cause a conflict I have to resolve):

:                     /<--G'<--H' jeske/topic1
:                    /
:          /<--P<---Q    feature-a
:         /
: --C<---Q' master

However, if that Q' rebase contained a link back to (P,Q), it would know that
the Q' rebase was replacing (P,Q), and would know to back them out of my tree
when I rebased back onto the head, producing this in BOTH cases above (whether
I rebased or merged from the feature-a branch):


:          /<--G'<--H' jeske/topic1
:         /
: --C<---Q' master

This operation above of "working will pulling uncompleted patches into my tree"
seems like a fairly common thing for developers. I've never provided any
patches to linux-kernel, but when I did try hacking on it years ago, I was
doing exactly this. (pulling unaccepted patches into my kernel, then building
on those patches). When I read about the DAG and its universal naming, I always
assumed that the above workflow was what it was DESIGNED to make automatic. I'm
confused, how does this work in git?



-- Matthieu Moy wrote:
> Well, look at the [PATCH] messages on this list, and how they evolve.
> Patch series give a clean way to go from a point to another. That's
> what you want to see in upstream history.
>
> Then, patch series usually get reviewed, and the patches themselves
> are modified. There's a kind of meta-history: the changes you make to
> your own changes.
>
> Suppose I send a patch containing
>
> +	int * x = malloc(sizeof(char));
>
> and someone notices how wrong it is. I send another patch with
>
> +	int * x = malloc(sizeof(int));
>
> The first version was basicaly a mistake, and if it hasn't been
> released, no one want to bother with it longer that the time to resend
> the patch. No one want to be hit by the bug while using bisect later
> on the upstream repository. And no one wants to see both patches when
> reviewing or "git blame"-ing.
