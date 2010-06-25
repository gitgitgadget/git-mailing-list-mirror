From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Fri, 25 Jun 2010 09:46:23 +0200
Message-ID: <20100625074623.GA4734@pvv.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <20100624111757.GB3453@pvv.org> <7veifwchb6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 09:46:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS3cQ-0001JW-HX
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 09:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0FYHq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 03:46:29 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:44681 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab0FYHq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 03:46:28 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OS3cF-0001qA-EG; Fri, 25 Jun 2010 09:46:23 +0200
Content-Disposition: inline
In-Reply-To: <7veifwchb6.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149668>

On Thu, Jun 24, 2010 at 01:21:49PM -0700, Junio C Hamano wrote:
> >
> > If .gitattributes is different on the different sides, or if you
> > enable autocrlf, the current repo contents may change after
> > git-to-worktree and worktree-to-git again.
> 
> IOW, g2w-then-w2g may not be an identity function.

Absolutely, pretty much by definition this cannot be the case (and is
not the case for any of the built-in filters like eol, autocrlf,
ident), since you have no control of what you have in the repository
before you enable the filter.

What we assume though is that g2w(g2w(x)) == g2w(x). I think it is
very hard to come up with a reasonable case for a filter where that is
not the case.

> If we were to encourage use of this codepath to wider audiences, we may
> need to have a document for people who write smudge/clean filters.  In
> order for the result to be stable, applying g2w-then-w2g once again on top
> of the result of running g2w-then-w2g on anything should be no-op, no?

This _has_ to work, otherwise you would get dirty contents after a
checkout, and that would be horrible.

So, the follolwing should be true:

g2w(x) == g2w(g2w(x))
A -> g2w() -> B -> g2w() -> B ... 

w2g(g2w(x)) == w2g(g2w(w2g(g2w(x))))
X -> g2w() -> w2g() -> Y -> g2w() -> w2g() -> Y ...

Running w2g() twice should also be the same as running it once. 
I thought nothing in git required it as such, but in the case of a
missing smudge filter git will call w2g() on something that is already
cleaned. I think the clean/smudge guidelines should be:

  "Both clean and smudge filters should be idempotent; running them
   multiple times should not alter the contents further."

- Finn Arne
