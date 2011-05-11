From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git revert option parsing too lenient?
Date: Wed, 11 May 2011 16:36:45 -0400
Message-ID: <20110511203645.GB28742@sigill.intra.peff.net>
References: <BANLkTi=dPzu0wrDr3aycEv68M2tw7k5m8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 11 22:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKG9Q-0008B4-Oh
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 22:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282Ab1EKUgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 16:36:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49319
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198Ab1EKUgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 16:36:50 -0400
Received: (qmail 5703 invoked by uid 107); 11 May 2011 20:38:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 May 2011 16:38:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 May 2011 16:36:45 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=dPzu0wrDr3aycEv68M2tw7k5m8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173424>

On Wed, May 11, 2011 at 12:40:27PM +0200, Sverre Rabbelier wrote:

> I just did 'git revert -p <commit>', hoping I might be able to
> partially revert a commit, but it just ignored the -p (it's not
> supported) rather than erroring out. Is this expected behavior?

Yeah, this is a problem with many commands that take revision
parameters. The revision option parser will parse all of the log and
diff options, modifying the rev_info struct, and then the resulting
command may or may not do anything useful with the values. You can even
do:

  git revert --pretty=oneline -p --date=iso --renames $sha1

all of which is equivalent to just:

  git revert $sha1

So yeah, it's a bug, but it is a known one. The trouble is that fixing
it means splitting the revision options into a set of "these are OK for
picking a revision or range of revisions" and "other options", and
letting commands like revert use one set but not the other. And I'm not
even sure if that distinction is sufficient for all of the commands that
use setup_revisions.

-Peff
