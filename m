From: Jeff King <peff@peff.net>
Subject: Re: Trust issues with hooks and config files
Date: Fri, 7 Mar 2014 16:04:04 -0500
Message-ID: <20140307210403.GA6790@sigill.intra.peff.net>
References: <5318ECFF.40908@0x4a42.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Julian Brost <julian@0x4a42.net>
X-From: git-owner@vger.kernel.org Fri Mar 07 22:04:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WM1wD-00051b-Jq
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 22:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbaCGVEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 16:04:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:34961 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753463AbaCGVEG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 16:04:06 -0500
Received: (qmail 7267 invoked by uid 102); 7 Mar 2014 21:04:05 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 07 Mar 2014 15:04:05 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Mar 2014 16:04:04 -0500
Content-Disposition: inline
In-Reply-To: <5318ECFF.40908@0x4a42.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243628>

On Thu, Mar 06, 2014 at 10:47:43PM +0100, Julian Brost wrote:

> I've noticed some behavior of git that might lead to some security
> issues if the user is not aware of this.
> 
> Assume we have an evil user on a system, let's call him eve. He
> prepares a repository where he allows other user to push changes to.
> If he now adds a post-receive hook, git will happly execute it as
> whatever user pushes to this repository:

Yes, this is a well-known issue. The only safe operation on a repository
for which somebody else controls hooks and config is to fetch from it
(upload-pack on the remote repository does not respect any dangerous
config or hooks).

> Something similiar might happen if eve adds some alias to the config
> file in the repository and grants any other user read access to the
> repository. These aliases will be executed when some other user is
> running any git command in this repository. Even though git does not
> allow defining aliases for existing commands, you might mistype
> something, so adding an alias for "lg" instead of "log" might succeed:

Much easier is to define an external diff or textconv tool; then the
victim does not even have to typo.

> I'd suggest taking a similar approach as Mercurial [1], i.e. ignoring
> configuration files and hooks owned by another user unless the owner
> is explicitly trusted

It has been discussed, but nobody has produced patches. I think that
nobody is really interested in doing so because:

  1. It introduces complications into previously-working setups (e.g., a
     daemon running as "nobody" serving repos owned by a "git" user
     needs to mark "git" as trusted).

  2. In most cases, cross-server boundaries provide sufficient
     insulation (e.g., I might not push to an evil person's repo, but rather
     to a shared repo whose hooks and config are controlled by root on
     the remote server).

If you want to work on it, I think it's an interesting area. But any
development would need to think about the transition plan for existing
sites that will be broken.

At the very least, the current trust model could stand to be documented
much better (I do not think the rule of "fetching is safe, everything
else is not" is mentioned anywhere explicitly).

-Peff
