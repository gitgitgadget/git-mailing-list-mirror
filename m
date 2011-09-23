From: Jeff King <peff@peff.net>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Fri, 23 Sep 2011 15:33:41 -0400
Message-ID: <20110923193341.GA26820@sigill.intra.peff.net>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
 <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
 <20110922205856.GA8563@sigill.intra.peff.net>
 <4E7C5A3B.10703@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 23 21:33:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7BVS-0003wN-St
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab1IWTdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:33:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41767
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751784Ab1IWTdo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:33:44 -0400
Received: (qmail 19832 invoked by uid 107); 23 Sep 2011 19:38:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Sep 2011 15:38:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2011 15:33:41 -0400
Content-Disposition: inline
In-Reply-To: <4E7C5A3B.10703@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181994>

On Fri, Sep 23, 2011 at 12:06:51PM +0200, Michael Haggerty wrote:

> This is a very dangerous line of thought.  When content is read out of a
> historical commit, the content must be identical to what was checked
> into that commit.  For example, the EOL characters that I see in an old
> file revision must not depend on my current HEAD or index.  This rule
> should apply regardless of whether the content is being read to be
> checked out, put into an archive, or diffed against some other revision.
>  So for these purposes, I think there is no choice but to honor the
> gitattributes files in the tree/index/directory from which the content
> was read.
> 
> If the user really wants to say "this is what this file is like
> throughout history" (thereby altering history), then this should be a
> local decision that should be stored locally in $GIT_DIR/info/attributes.

I think we're in agreement here that this is the right way to do things.
My points are that:

  1. The current behavior is often convenient, even though it is wrong
     in some cases. Using $GIT_DIR/info/attributes is manual and
     annoying[1]. Turning on .gitattributes in the working tree and
     having it impact "git log -p" on older commits is a huge
     convenience. When it's right.

  2. This isn't how we're doing it now, and I don't see a lot of bug
     reports.  That doesn't mean there isn't room for improvement, but
     it may mean the current strategy is good enough, especially if the
     alternative ends up being very complex or hard to understand.

My biggest fear is not that we are wrong in some minority of the cases,
but that there is no good way to tell git it's wrong and to do something
else.

[1] I really wish we had an elegant way of versioning meta-information
    about a repository (like config, info/attributes, etc). I've hacked
    around this before by having a special meta-branch for each repo,
    checkout it out in an alternate directory, and then symlinking bits
    of it into .git. But that's kind of ugly, too.

    I'm not sure what a good solution would look like. There's a real
    can of worms with respect to picking and choosing local versus
    remote bits of meta-information, with some security implications.

> There are other attributes that affect "two-argument" operations like
> diff.  Here the policy has to depend on the situation.  In the case of
> diff, I suggest that the relevant attributes be read from *both*
> versions of the file.  If they are the same, then obviously use them.
> If they differ, then fall back to a "safe" default (for example, the
> diff that would be used if *no* attributes had been specified).
> However, as a special case, if an attribute is specified in one version
> and unspecified in another, it would *usually* be OK to use the
> specified version of the attributes and that might be considered a
> reasonable alternative.

Those are sane ground rules. But specific contexts would want to be
smarter in some cases. For example, if you have two conflicting diff
attributes that both define a textconv, you would not want to fallback
to not doing any textconv (which is what your above text prescribes).
Instead, you want to textconv each side individually according to its
attributes, and then compare the result.

One could argue that textconv is therefore not a "two-argument"
operation, since it works on each side individually. But it is part of
the "diff" attribute, and so it ends up being processed in a
two-argument context (this is possibly a mistake in the original design
of textconv).

> By the way, it is possible that the two ends of a diff operation have
> different filenames (e.g., with -M or -C).  In this case the attributes
> should be looked up using the filename corresponding to the commit.

We do some of this already. For example, textconv will look up each side
based on its individual filename. But the funcname code, for example
does this ("one" is the "from" side of the diff, "two" is the "to"
side):

  pe = diff_funcname_pattern(one);
  if (!pe)
          pe = diff_funcname_pattern(two);

whereas I think your proposed code would do:

  pe1 = diff_funcname_pattern(one);
  pe2 = diff_funcname_pattern(two);
  if (!pe1)
          pe = pe2; /* only one side, or both empty */
  else if (!pe2)
          pe = pe1; /* only one side */
  else if (!pattern_cmp(pe1, pe2))
          pe = pe1; /* identical, pick one */
  else
          pe = NULL; /* conflict, default to nothing */

> > So if the status quo with working trees (i.e., retroactively applying
> > the current gitattributes to past commits) is good enough, perhaps the
> > bare-repository solution should be modeled the same way? In other words,
> > should "git log -p" in a bare repo be looking for attributes not in the
> > commits being diffed, but rather in HEAD[2]?
> 
> This would be a very poor policy, modeled on a status quo that is
> *not* good enough.  For example, HEAD might not even be a descendant
> of the commit whose content is being interrogated; the commit might
> have new files and new gitattributes that would be ignored.

Notice the "if" in my statement. :)

Yes, that is a corner case that is utterly broken. It's also utterly
broken in the current code with a non-bare repository, where we respect
the checked-out .gitattributes (which generally come from HEAD). This
would just be a very simple way of harmonizing bare repositories with
the current non-bare behavior (broken or not).

> I suppose your suggestion is better than the status quo, so it would
> be fine as a starting point, *provided* it is clear that people should
> not rely on this behavior not being improved later.

Sure. If we go down this road, we will be breaking the non-bare case,
too, so we will have to deal with deprecations and all that, anyway.

-Peff
