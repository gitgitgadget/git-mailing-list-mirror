From: Jeff King <peff@peff.net>
Subject: Re: Auto detaching head options (update) (Re: Working copy
	revision and push pain)
Date: Sat, 29 Mar 2008 04:47:43 -0400
Message-ID: <20080329084743.GA19200@coredump.intra.peff.net>
References: <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com> <alpine.LSU.1.00.0803231519380.4353@racer.site> <47E66DAA.4080807@jwatt.org> <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org> <alpine.LSU.1.00.0803231658460.4353@racer.site> <20080325192552.GC4857@efreet.light.src> <20080325232424.GB5273@coredump.intra.peff.net> <7v3aqde2wn.fsf@gitster.siamese.dyndns.org> <20080329082757.GA4920@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sat Mar 29 09:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfWjk-0004uc-TC
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 09:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbYC2Irr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 04:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbYC2Irr
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 04:47:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2466 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbYC2Irq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 04:47:46 -0400
Received: (qmail 19539 invoked by uid 111); 29 Mar 2008 08:47:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 04:47:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 04:47:44 -0400
Content-Disposition: inline
In-Reply-To: <20080329082757.GA4920@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78455>

On Sat, Mar 29, 2008 at 09:27:57AM +0100, Jan Hudec wrote:

> Excluding push to non-bare repository and extra work trees, the local
> branches are only ever updated through the HEAD. And as long as they are
> updated with update-ref, it writes the value to the reflog, so HEAD^{0}
> should always equal HEAD.

I assume by HEAD^{0} you mean HEAD@{0}? The first is for peeling tags,
while the latter is "the latest reflog entry."

There are a few other ways I can think of to manipulate branches besides
through HEAD:

  - git branch -f existing new_ref (though I'm not sure if this works if
    the branch is HEAD)

  - git update-ref refs/heads/branch_that_is_HEAD_but_we_call_it_by_name

However, in both cases the HEAD ref is being munged behind the user's
back to some degree, and it can result in a situation where the index
doesn't match HEAD anymore. So in both cases, I think the safety check
you propose would actually be a benefit.

But I'm not sure if there aren't some "innocent" uses of the second form
in people's scripts. For example, a script that operates on HEAD but
resolves it internally to "refs/heads/master" and begins using that (and
takes care itself to keep the index in sync with the new value written
into the ref).

> There are actually two use-cases for this. One is this pushing to non-bare
> repo, which is indeed just shooting oneself in the foot out of lack of
> [...]
> But the other usecase is using additional work trees

I like the fact that it deals with both these cases, and I think it can
cover even more. It is a general safety valve for "somebody changed this
ref while you weren't looking."

> Besides whith the update above, I no longer propose to keep any new
> information -- just to add a safety-check.

And I like that, too. But I am a little worried that the information
will not be sufficient. You are asking for a consistency guarantee of
HEAD and HEAD@{0} that comes from using current porcelain. But there are
many uses of plumbing that would violate that consistency guarantee. And
some of those are exactly what you're trying to catch and warn about.
But I suspect there are some false positives (either in people's
plumbing-oriented workflows, in other scripts outside of core git, or
even in core git itself (I didn't carefully audit how each script
works)). And maybe it is OK to warn and force a "-f" there, or cause
those scripts to be updated.

By all of these "maybes" what I am saying is "I think this is a
promising approach but I am not entirely convinced it won't run into
implementation problems." And of course producing a patch is a good
first step in figuring it out. :)

-Peff
