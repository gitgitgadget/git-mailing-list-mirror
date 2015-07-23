From: Jeff King <peff@peff.net>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Wed, 22 Jul 2015 22:14:45 -0700
Message-ID: <20150723051445.GA24029@peff.net>
References: <20150723012343.GA21000@peff.net>
 <20150723044007.GA3651@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:14:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI8qL-00011n-O4
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 07:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbbGWFOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 01:14:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:33922 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750871AbbGWFOt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 01:14:49 -0400
Received: (qmail 30108 invoked by uid 102); 23 Jul 2015 05:14:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 00:14:49 -0500
Received: (qmail 9074 invoked by uid 107); 23 Jul 2015 05:14:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 01:14:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jul 2015 22:14:45 -0700
Content-Disposition: inline
In-Reply-To: <20150723044007.GA3651@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274477>

On Wed, Jul 22, 2015 at 09:40:10PM -0700, David Aguilar wrote:

> On Wed, Jul 22, 2015 at 06:23:44PM -0700, Jeff King wrote:
> > This patch adds an option to turn on --first-parent all the
> > time, along with the corresponding --no-first-parent to
> > disable it.
> 
> [Putting on my scripter hat]
> 
> I sometimes think, "it would be really helpful if we had a way
> to tell Git that it should ignore config variables".
> 
> This is especially helpful for script writers.   It's pretty
> easy to break existing scripts by introducing new config knobs.

I think the purpose of --no-first-parent here is slightly orthogonal. It
is meant to help the user during the odd time that they need to
countermand their config.

Script writers should not care here, because they should not be parsing
the output of the porcelain "log" command in the first place. It already
has many gotchas (e.g., log.date, log.abbrevCommit).

I am sympathetic, though. There are some things that git-log can do that
rev-list cannot, so people end up using it in scripts. I think you can
avoid it with a "rev-list | diff-tree" pipeline, though I'm not 100%
sure if that covers all cases. But I would much rather see a solution
along the lines of making the plumbing cover more cases, rather than
trying to make the porcelain behave in a script.

> That way, script writers don't have to do version checks to
> figuring out when and when not to include flags like
> --no-first-parent, etc.

One trick you can do is:

  git -c log.firstparent=false log ...

Older versions of git will ignore the unknown config option, and newer
ones will override anything the user has in their config file.

> Would something like,
> 
> 	GIT_CONFIG_WHITELIST="user.email user.name" \
> 	git ...
> 
> be a sensible interface to such a feature?

I dunno.  That's at least easy to implement. But the existing suggested
interface is really "run the plumbing", and then it automatically has a
sensible set of config options for each command, so that scripts don't
have to make their own whitelist (e.g., diff-tree still loads userdiff
config, but not anything that would change the output drastically, like
diff.mnemonicprefix).

-Peff
