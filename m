From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clear_child_for_cleanup must correctly manage
 children_to_clean
Date: Tue, 11 Sep 2012 11:20:41 -0400
Message-ID: <20120911152041.GA11994@sigill.intra.peff.net>
References: <62cd8d4a1853cb6fe8fda9f534cc269c8b2e0f6c>
 <1347373967-29248-1-git-send-email-david@optimisefitness.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, kusmabite@gmail.com
To: David Gould <david@optimisefitness.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 17:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBSGo-00074g-2H
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 17:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556Ab2IKPUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 11:20:49 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41127 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759157Ab2IKPUs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 11:20:48 -0400
Received: (qmail 11130 invoked by uid 107); 11 Sep 2012 15:21:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Sep 2012 11:21:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Sep 2012 11:20:41 -0400
Content-Disposition: inline
In-Reply-To: <1347373967-29248-1-git-send-email-david@optimisefitness.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205235>

On Tue, Sep 11, 2012 at 03:32:47PM +0100, David Gould wrote:

> Subject: Re: [PATCH] clear_child_for_cleanup must correctly manage
>   children_to_clean

Thanks for the patch. Overall it looks good, but let me nit-pick your
commit message a little (not because it is that horrible, but because
you are so close to perfect that I want to fix the minor things and then
encourage you to submit more patches :) ).

Your subject is a bit vague, and it is not clear if it is not correct
now, and this is a bugfix, or if it is a feature enhancement. I would
have said something like:

  Subject: fix broken list iteration in clear_child_for_cleanup

which is _also_ vague about what exactly the breakage is, but is clear
that this is a bugfix. So then you can go on to describe the actual
problem:

  We iterate through the list of children to cleanup, but do not keep
  our "last" pointer up to date. As a result, we may end up cutting off
  part of the list instead of removing a single element.

And then describe your fix:

> Iterate through children_to_clean using 'next' fields but with an
> extra level of indirection. This allows us to update the chain when
> we remove a child and saves us managing several variables around
> the loop mechanism.

which I think is good.

> -	last = &children_to_clean;
> -	for (p = children_to_clean; p; p = p->next) {
> -		if (p->pid == pid) {
> -			*last = p->next;
> -			free(p);
> +	for (pp = &children_to_clean; *pp; pp = &(*pp)->next) {
> +		if ((*pp)->pid == pid) {
> +			struct child_to_clean *clean_me = *pp;
> +			*pp = clean_me->next;
> +			free(clean_me);
>  			return;
>  		}

I think using the indirect pointer is a nice compromise; it makes it
clear from just the for loop that this is not an ordinary for-each
traversal. You could hoist the extra pointer out of the conditional and
save one set of parentheses in the "if" statement, but I don't think it
is a big deal either way.

Acked-by: Jeff King <peff@peff.net>

Thanks for the bug report and the patch.

-Peff
