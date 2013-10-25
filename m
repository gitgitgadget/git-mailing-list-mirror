From: Jeff King <peff@peff.net>
Subject: Re: Setting per-repository configuration for git
Date: Fri, 25 Oct 2013 04:25:13 -0400
Message-ID: <20131025082513.GE17029@sigill.intra.peff.net>
References: <884520645.9668515.1382684531443.JavaMail.root@openwide.fr>
 <834511791.9670586.1382685155770.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Fri Oct 25 10:25:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZchw-0006J9-Po
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 10:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab3JYIZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 04:25:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:55443 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752303Ab3JYIZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 04:25:16 -0400
Received: (qmail 10399 invoked by uid 102); 25 Oct 2013 08:25:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Oct 2013 03:25:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 04:25:13 -0400
Content-Disposition: inline
In-Reply-To: <834511791.9670586.1382685155770.JavaMail.root@openwide.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236697>

On Fri, Oct 25, 2013 at 09:12:35AM +0200, Jeremy Rosen wrote:

> however I can't find a way to have the repository's configuration 
> saved and transmited with the repository in a way similar to how
> .gitignore is transmitted...
> [...]
> Knowing how mature git is I can only assume that this has already
> been discussed and that there is a good reason not to do it. Is it
> because of hooks ? would it break something I don't see in git ?

There are a few reasons.

One, there are security implications.  You can execute arbitrary code
using git config options (e.g., by defining diff helpers). While it's
true that you often run the code that you fetch into your git
repository, you at least have an opportunity to verify it using git
commands before it is run.

Two, the config is not really tied to a specific revision in the same
way that a .gitignore is. If I move to another branch, or checkout an
old revision, I would want to use the .gitignore from the currently
checked-out commit. But git config does not typically work that way. If
I am sight-seeing back to last year's history, I do not want to use a
different remote URL, or different diff settings, etc. So managing a
.gitconfig directly in the repository has some ugly edge cases.

I have proposed in the past letting config includes access git objects
directly. Then a project could ship dedicated config in the "config"
branch, and you would always use the tip of that branch, even if you
were moving your working tree elsewhere in history. And if you want to
protect yourself from incoming config, you can point it to your _local_
config branch, and only merge remote changes to it after verifying they
are sane.

That would address both issues, but after some discussion, we realized
that you are really not any better off than simply pulling the data out
of git and including it as a file. So something like:

  1. Project ships recommended git config settings as `docs/gitconfig`.

  2. User clones the repo.

  3. User looks at `docs/gitconfig`, verifies that it's OK.

  4. User copies `docs/gitconfig` to `.git/project-config`.

  5. User points git at project config with `git config include.path
     project-config`.

  6. Periodically, user examines updates to `docs/gitconfig` and copies
     it to `.git/project-config`.

I don't know of any projects that do this, though, or even that ship a
recommended config. I don't know what one would put in such a config
file. Most settings are matters of personal preference, or local
configuration for the machine.

-Peff
