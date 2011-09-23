From: Jeff King <peff@peff.net>
Subject: config-file includes
Date: Fri, 23 Sep 2011 15:58:29 -0400
Message-ID: <20110923195829.GA27677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 21:58:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7BtP-0007hO-Fj
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 21:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab1IWT6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 15:58:33 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41793
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab1IWT6c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 15:58:32 -0400
Received: (qmail 20142 invoked by uid 107); 23 Sep 2011 20:03:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Sep 2011 16:03:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Sep 2011 15:58:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181998>

On Fri, Sep 23, 2011 at 03:33:41PM -0400, Jeff King wrote:

> [1] I really wish we had an elegant way of versioning meta-information
>     about a repository (like config, info/attributes, etc). I've hacked
>     around this before by having a special meta-branch for each repo,
>     checkout it out in an alternate directory, and then symlinking bits
>     of it into .git. But that's kind of ugly, too.
> 
>     I'm not sure what a good solution would look like. There's a real
>     can of worms with respect to picking and choosing local versus
>     remote bits of meta-information, with some security implications.

Here's one solution I've given a little thought to. Comments welcome.

I've sometimes wanted an "include" mechanism in git config files.
Partially to just keep things tidier, partially to avoid
cutting-and-pasting between some repo-specific config, and partially
because I'd like a conditional inclusion mechanism[1]. I was thinking of
something that would be syntactically compatible but semantically
meaningless in current versions of git, like:

  [include]
  path = /some/file
  path = /some/other/file
  path = ~/some/file/in/your/homedir

You could extend this to look in refs, with something like:

  [include]
  ref = meta:config

which would resolve meta:config to a blob and examine it (i.e., it would
look at refs/heads/meta).

So the procedure for importing and updating config from a remote would
look like:

  git clone project.git
  cd project

  # check that the upstream config looks good
  git show origin/meta:config
  # if so, use it
  git branch meta origin/meta
  git config --add include.ref meta:config

  # later, check updates to upstream's config
  git fetch
  git diff meta origin/meta -- config
  # looks ok, use it
  git branch -f meta origin/meta

And obviously if you wanted to streamline that, you could make "meta"
and "config" well-known names and have clone and fetch interactively
show the config and say "do you want this [y/N]?" or something. Though I
think there is some value to doing it manually, as it gives projects the
flexibility to have different config profiles in their meta branch.

And if you really wanted to live dangerously, you could do:

  git config --add include.ref origin/meta:config

That of course just covers "config". But I think you might be able to do
something similar with core.attributesfile (which could be included from
the config).

-Peff

[1] I want conditional inclusion because sometimes the rules for config
    entries changes from version to version. For example, I have
    pager.diff set to a script in my ~/.gitconfig. But older versions of
    git don't understand non-boolean values and barf. I'd really like to
    do something like:

    [include-ifdef "has-pager-scripts"]
    path = ~/.gitconfig-pager

    where "has-pager-scripts" would be a magic flag compiled into git
    versions that understand that config.
