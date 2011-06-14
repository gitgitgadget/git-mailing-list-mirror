From: Jeff King <peff@peff.net>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Tue, 14 Jun 2011 13:12:05 -0400
Message-ID: <20110614171204.GC26764@sigill.intra.peff.net>
References: <20110608093648.GA19038@elte.hu>
 <BANLkTiku_qvn73cUDBT=OxY-3jR3raoOhg@mail.gmail.com>
 <BANLkTimtxESnZ23tRBYYVN1paUmNOhdPyw@mail.gmail.com>
 <201106141156.56320.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Stephen Rothwell <sfr@canb.auug.org.au>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 19:12:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWX9x-00006E-0H
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 19:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab1FNRMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 13:12:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51500
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab1FNRMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 13:12:07 -0400
Received: (qmail 28428 invoked by uid 107); 14 Jun 2011 17:12:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 13:12:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 13:12:05 -0400
Content-Disposition: inline
In-Reply-To: <201106141156.56320.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175784>

On Tue, Jun 14, 2011 at 11:56:56AM +0200, Johan Herland wrote:

> 2. Interpreting/DWIMing refs
> 
> Changing the ref mappings require a revised set of rules for interpreting 
> shorthand ref names (expanding them into full ref names), and handling 
> ambiguities when they arise:
> [...]
> 
> - "origin/foo" must continue to work, even if "refs/remotes/origin/foo" has 
> now become "refs/remotes/origin/heads/foo". In other words, "foo/bar" where 
> "foo" is a valid remote, must try to resolve "bar" against the refspecs 
> specified for the "foo" remote.

What happens if I ask for foo/bar/baz? Should it try to resolve:

  1. refs/remotes/foo/heads/bar/baz

or

  2. refs/remotes/foo/bar/heads/baz

or both (and if both, in which order)?

I don't know offhand if "git remote" and "git clone" allow slashes in
remote names, but I don't think we forbid it if somebody configures it
themselves (and of course, remote names aside, they are free to write
whatever refspecs they like in the config file).

> - If "refs/tags/foo" does not exist, tag name "foo" is unambiguous if it 
> exists in one or more "refs/remotes/*/tags/foo" and they all point to the 
> same SHA1.
> 
> - If "refs/tags/foo" does not exist, and more than one 
> "refs/remotes/*/tags/foo" exist, and they do NOT all point to the same SHA1, 
> then there is an ambiguity.
> 
> - The user may resolve the ambiguity by creating "refs/tags/foo" pointing to 
> the chosen SHA1 ("refs/tags/foo" takes precedence over 
> "refs/remotes/*/tags/foo").
> 
> - The same rules apply to heads, notes, etc.

I'm not sure we need all of these rules for anything but tags. We
already keep remote heads in a separate namespace, and we don't
automagically look them up. And that's OK, because the way tags and
heads work is fundamentally different. I can peek at your remote heads,
but if I checkout or merge, I better make a local branch that matches
your remote one.  Whereas with tags, I don't think that is the case.
They're really a read-only thing, and you want them to stay in the
remotes namespace.

I think notes should behave more like heads. You can use them as-is if
you just want to look, but you need to use the full remote name. And if
you want to do more (like keeping your own notes and merging somebody's
remote notes in), then you'll make your own local notes branch, and use
"git notes merge" to keep it up to date.

-Peff
