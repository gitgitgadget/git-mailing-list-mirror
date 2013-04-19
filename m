From: Jeff King <peff@peff.net>
Subject: Re: Find/prune local branches after upstream branch is deleted?
Date: Fri, 19 Apr 2013 14:05:20 -0400
Message-ID: <20130419180520.GA22865@sigill.intra.peff.net>
References: <87ehe64f91.fsf@mcs.anl.gov>
 <20130419173717.GA26964@sigill.intra.peff.net>
 <87bo9a4dfr.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 20:05:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFge-0004wk-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 20:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513Ab3DSSFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 14:05:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:44205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab3DSSFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 14:05:23 -0400
Received: (qmail 11234 invoked by uid 102); 19 Apr 2013 18:05:28 -0000
Received: from 99-108-225-125.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.225.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Apr 2013 13:05:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Apr 2013 14:05:20 -0400
Content-Disposition: inline
In-Reply-To: <87bo9a4dfr.fsf@mcs.anl.gov>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221789>

On Fri, Apr 19, 2013 at 12:50:48PM -0500, Jed Brown wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Try "git branch --merged master" to get a list of branches that have
> > already been merged.
> 
> That's what I use, but I was hoping for something more precise.  For
> example, a branch that started at 'maint' would show up there, but its
> integration hasn't completed until it makes it back to 'maint'.

Yeah, git has no way of knowing that. You can tell it by asking "git
branch --merged maint" and looking for such topics, of course, but I
think you are trying to remove as much thinking as possible from the
process.

So what is the clue that you would like to use to know that the branch
is stale. Deletion of the branch on the remote?

For that, I don't think there is a single command. You can do "git push
--dry-run --all" and look for new branches that would be pushed, but
that is kind of hacky.  The answer you want is:

  comm -23 \
    <(git for-each-ref --format='%(refname:short)' refs/heads) \
    <(git for-each-ref --format='%(refname:short)' refs/remotes/origin |
      sed s,origin/,,)

You said you didn't want to script, but I think that is the only option
to answer that question cleanly.

Note that if you wrap that in an alias, you would want to use "bash -c",
as the <() syntax is not understood by many /bin/sh implementations.

-Peff
