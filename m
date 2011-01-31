From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] default "git merge" without argument to "git merge @{u}"
Date: Mon, 31 Jan 2011 15:14:19 -0500
Message-ID: <20110131201419.GA9070@sigill.intra.peff.net>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Miles Bader <miles@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk08s-0002T8-9r
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab1AaUOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:14:24 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57151 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553Ab1AaUOX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:14:23 -0500
Received: (qmail 13121 invoked by uid 111); 31 Jan 2011 20:14:22 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Jan 2011 20:14:22 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Jan 2011 15:14:19 -0500
Content-Disposition: inline
In-Reply-To: <7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165745>

On Mon, Jan 31, 2011 at 09:06:33AM -0800, Junio C Hamano wrote:

> Existing scripts may prepare what to merge in an array (e.g. in Bourne,
> accumulating them in "$@" by repeatedly doing 'set "$@" "$newbranch"') and
> call 'git merge "$@"', relying on the current behaviour that zero argument
> means no-op.  Such scripts will be broken by this change.  Driving "git
> merge" with xargs without --no-run-if-empty (not POSIX), feeding the
> branches to merge in an Octopus, will be broken the same way.

I am not sure these things are not already broken. "git merge" without
arguments right now is not a no-op. It is an error that spews usage to
stderr and exits 129. Yes, there can be scripts which stupidly do not
bother to see if the merge succeeded, but I'm not sure how much we
should care about such poorly written junk.

> Migration plan:
> 
> Add merge.defaultUpstream configuration variable, which defaults to false
> when unconfigured.  Change "git merge" so that when this configuration is
> set and the command is run without the commit to merge to use the
> configured upstream of the current branch (or error out if there isn't
> one).  Merge this change in the next 1.7.x series.

One nit: upon reading the name of the variable, I assumed it would be
"the default upstream to merge". Perhaps "merge.defaultToUpstream" is a
more descriptive name?

> One release before 1.8.0, issue a warning when "git merge" is run without
> the commit to merge and this configuration variable is not explicitly set
> either way, and notify the user of upcoming incompatibility.

Don't we already issue a giant warning when "git merge" is run without a
commit, namely:

  usage: git merge [options] <remote>...
  ... etc ...

? If people are already not paying attention to that (either because
they are throwing away stderr and exit code indiscriminately, or because
the no-arguments case is a simply an obscure corner that their script
doesn't usually exercise), why would they pay attention to a new
warning?

> In 1.8.0, flip the default for merge.defaultUpstream to true.

Other than that, I think the proposal and migration plan are fine.

-Peff
