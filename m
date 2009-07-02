From: Jeff King <peff@peff.net>
Subject: Re: Bug report: .gitattributes: -diff Unset causes files to be
	reported as binaries
Date: Thu, 2 Jul 2009 13:04:59 -0400
Message-ID: <20090702170459.GA15802@sigio.peff.net>
References: <200907011208.35397.fenglich@fastmail.fm> <20090702053534.GA13255@sigio.peff.net> <200907021014.06540.fenglich@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Frans Englich <fenglich@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Jul 02 19:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMPgs-0002DR-BO
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 19:03:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbZGBRDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 13:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbZGBRDG
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 13:03:06 -0400
Received: from peff.net ([208.65.91.99]:45156 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094AbZGBRDF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 13:03:05 -0400
Received: (qmail 15812 invoked by uid 1000); 2 Jul 2009 17:04:59 -0000
Content-Disposition: inline
In-Reply-To: <200907021014.06540.fenglich@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122654>

On Thu, Jul 02, 2009 at 10:14:06AM +0200, Frans Englich wrote:

> > I think you are a little confused by the syntax. Each line of the
> > gitattributes file has a filename pattern and a set of attributes. Each
> > attribute is either set, unset, set to a value, or unspecified. For your
> > example (file.txt and the "diff" attribute), they look like:
> 
> Perhaps that should be considered another bug; that invalid syntax is 
> accepted, instead of being communicated to the user.

It's not invalid syntax; it just doesn't do what you thought it did. And
even though it is _semantically_ useless to git, it is a feature of
gitattributes (and the git config) to allow unknown keys, so that they
can be used by other programs and scripts built on top of git.

> > So as far as I can see, git is behaving exactly as it is supposed to.
> > Maybe you can be more specific about what effect you were trying to
> > achieve by setting gitattributes in the first place?
> 
> To exclude it in diffs, such as from `git show`. Take the case where
> you have a grammar file for a parser and generate a source file from
> it(or any similar scenario); the diff for the generated source file is
> not of interest and is just noisy when read as part of a patch. This
> applies to all kinds of generated files. However, this doesn't mean
> that the file should be treated as a binary, and what practicalities
> that implies.

The usual workflow is not to check in generated files at all. You can
mark them with '.gitignore' to make sure they are not actually added.

However, I can imagine a case where your workflow required checking in
generated files (because, e.g., the tools to generate them were
difficult to use or not available to all developers), but most of the
time seeing their diffs is just clutter. So the instruction you want to
give to git is "when diffing these, generate nothing". And that is:

  $ echo file.txt diff=invisible >>.gitattributes
  $ git config diff.invisible.command /bin/true

Or even some other custom script of your choosing that might show a more
condensed diff.

> If -diff affects whether a file is treated as a binary, as opposed
> whether it's diff'ed, it would imo make sense to call it -binary.

I'm not sure I agree, but even if I did, it is far too late to change
the semantics of the "diff" and "binary" attributes; you would be
breaking the existing setup of many other users.

-Peff
