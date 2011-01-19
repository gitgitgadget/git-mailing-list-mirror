From: Libor Pechacek <lpechacek@suse.cz>
Subject: Re: git-config does not check validity of variable names
Date: Wed, 19 Jan 2011 11:01:05 +0100
Message-ID: <20110119100105.GB8034@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110111055922.GD10094@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 19 11:01:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfUqp-0003zG-3o
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 11:01:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab1ASKBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 05:01:08 -0500
Received: from cantor2.suse.de ([195.135.220.15]:56689 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644Ab1ASKBH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 05:01:07 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 207E2867E2;
	Wed, 19 Jan 2011 11:01:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110111055922.GD10094@sigill.intra.peff.net>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165253>

Hi Jeff,

On Tue 11-01-11 00:59:22, Jeff King wrote:
> On Sat, Jan 08, 2011 at 03:46:44PM +0100, Libor Pechacek wrote:
> 
> > I've noticed that git-config accepts variable names in the form "a=b" for its
> > "get" operation.  That means "git config a=b" does not write anything to its
> > output and exists with status 1.
> > 
> > According to the man page only alphanumeric characters and - are allowed in
> > variable names.  Would it make sense to spit out an error message when the user
> > supplies an invalid variable name like the above?
> 
> Probably. The current behavior isn't all that terrible, in that it
> simply tries to look up the key, which of course doesn't exist (because
> it cannot syntactically), and does signal an error (with the exit code).
> So it is in some ways no worse than a typo like "git config
> color.dif.branch". And we probably don't want to start writing to stderr
> in such a case, as scripts assume they can call git config to find out
> whether the variable is defined without having to redirect stderr.

I fully agree that there should be no extra output if the user searches for an
undefined variable.  My idea is to warn the user when the variable name is
clearly invalid.

> That being said, I can see how the lack of a message could be confusing
> for a user who mistakenly thinks "git config color.diff.branch=red"
> should work. So I think a patch to make that better would get a
> favorable response.
> 
> Note, though, that what you wrote above is not strictly true. The
> manpage says variable names and section names must be alphanumeric. But
> subsection names can contain any character except newline. So it is
> valid syntactically to do:
> 
>   git config color.diff=red.branch
> 
> where the subsection contains the "=". Obviously this example is
> nonsense, and in practice most such "a=b" forms will end up not being
> syntactically valid (because the = will be part of the variable name,
> not the subsection).

That was new for me, so I had to learn the concept.  Thanks for thorough
explanation.

> But if you are going to write a patch, you need to
> make sure not to accidentally disallow:
> 
>   git config 'diff.my custom diff driver.command'

There is already a check in git_config_set_multivar to prevent the user from
creating variables with invalid names.  That can probably be separated and
reused in the "get value" path.  I'll have a look.


In the course of reading the code I've spotted another trouble related to
regexps.  Variable and section names are case insensitive, while subsection
names are case sensitive.  How can regexp matching be made "partially case
sensitive"?  That's a challenge.

The current approach is to lowercase everything in the pattern from the
beginning until the first dot and from the last dot till the end.  That has its
limitations as regular expressions can be fairly complex.

Just to illustrate the situation:
$ git config --get-regexp '(CORE|USER)\.'
user.email lpechacek@suse.cz
core.repositoryformatversion 0
core.filemode true

$ git config --get-regexp '(COR.|USER)\.'
core.repositoryformatversion 0
core.filemode true

Currently have no idea how to fix that apart from fixing the documentation. :) 

Libor
-- 
Libor Pechacek
SUSE L3 Team, Prague
