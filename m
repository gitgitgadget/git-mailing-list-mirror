From: Jeff King <peff@peff.net>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Sat, 24 Sep 2011 02:15:55 -0400
Message-ID: <20110924061555.GB13974@sigill.intra.peff.net>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
 <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
 <20110922171340.GA2934@sigill.intra.peff.net>
 <CAG+J_DxdP2qHhttJOtWQTKeiDV2YbC_A_F+b9sDOZsWhWxjcjw@mail.gmail.com>
 <20110922205856.GA8563@sigill.intra.peff.net>
 <4E7C5A3B.10703@alum.mit.edu>
 <20110923193341.GA26820@sigill.intra.peff.net>
 <4E7D7329.7070800@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 24 08:16:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7LWu-0000jT-2D
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 08:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372Ab1IXGP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 02:15:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42134
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab1IXGP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:58 -0400
Received: (qmail 25496 invoked by uid 107); 24 Sep 2011 06:20:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 24 Sep 2011 02:20:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Sep 2011 02:15:55 -0400
Content-Disposition: inline
In-Reply-To: <4E7D7329.7070800@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182021>

On Sat, Sep 24, 2011 at 08:05:29AM +0200, Michael Haggerty wrote:

> This could be implemented by having a single local config option that
> enables the use of an in-tree .gitconfig file:
> 
>     git config core.useTreeConfig true
> 
> (or whatever the correct naming convention would be).  This option would
> default to false, so the in-tree config would only occur following an
> affirmative decision by the cloner.

But once you've verified that the config looks OK and turned this option
on, how do you protect yourself from malicious config entering the repo
through a fetch?

> If finer granularity is required, config options could be classified
> into "security-relevant" and "non-security-relevant" options, where the
> former group basically includes anything that can cause arbitrary code
> to be executed.  Then there could be a "core.useTreeConfig = safeonly"
> option to allow only the harmless options.

This is the "can of worms" I referred to earlier. You have to start
classifying each option.

> I think the priority of config options (highest to lowest) should be
> 
>        $GIT_DIR/config
>        in-tree .gitconfig
>        ~/.gitconfig
>        $(prefix)/etc/gitconfig

One catch with any precedence scheme is that there are certain config
constructs that cannot be overridden. For example, some options are
respected multiple times to form a list (e.g., remote fetch and push
refspecs). There's no way in you $GIT_DIR/config to say "forget all of
the previous values you saw for this key" that may have come from the
in-tree .gitconfig.

I think you could introduce a special syntax for that, maybe just:

  # make a list with two elements
  [foo]
    bar = one
    bar = two

  # now let's imagine this is our "reset" syntax
    bar =
  # and now we can put in our own new values
    bar = three

where the final value of the config above would be (three).

It's actually not a new problem with in-tree config, and it doesn't tend
to come up all that much because most config values are treated as
simple scalars, and later values overwrite earlier ones.

> Of course, just like for attributes, it would have to be decided which
> version of the .gitconfig to use in which situations.

I'm not sure it makes sense to have it in the tree at all. For
attributes it makes sense, because you are annotating a path at a
_specific_ revision. But config is often much more meta- than that.
Take textconv for an example. The gitattributes say "foo.pdf should use
the 'pdf' diff driver". That makes sense to go in a revision. But the
config will say "pdf files can be converted to text using
/usr/bin/pdftotext". That is not something that is tied to the revision
at all, and should exist outside of any revision. I.e., whether I am
doing a "git show" on the HEAD, or on some ancient commit, I would want
to use the same value, not whatever tool I used to convert PDFs years
ago.

-Peff
