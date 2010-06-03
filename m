From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Don't warn about missing EOL for symlinks
Date: Thu, 3 Jun 2010 16:17:59 -0400
Message-ID: <20100603201759.GA20120@sigill.intra.peff.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <vpq1vco41go.fsf@bauges.imag.fr>
 <4C07C2E8.508@drmicha.warpmail.net>
 <20100603170724.GB22779@coredump.intra.peff.net>
 <4C0808CE.2000506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 03 22:18:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKGrm-00010f-6C
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 22:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab0FCUSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 16:18:08 -0400
Received: from peff.net ([208.65.91.99]:37639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783Ab0FCUSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 16:18:06 -0400
Received: (qmail 1974 invoked by uid 107); 3 Jun 2010 20:18:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 03 Jun 2010 16:18:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jun 2010 16:18:00 -0400
Content-Disposition: inline
In-Reply-To: <4C0808CE.2000506@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148359>

On Thu, Jun 03, 2010 at 09:55:58PM +0200, Michael J Gruber wrote:

> > Yes, but you are breaking "git diff | git apply", aren't you? It is
> 
> We don't have any tests for that then. I ran all tests with my patch.

That doesn't mean people don't do it, or that we don't want to support
it. The tests _can_ be wrong or incomplete. :)

> ...which is why you need to use diff --no-textconv for scripting, which
> is why I use that to decide about the symlink warnings!

But until now, people who didn't use textconv _didn't_ need to use diff
--no-textconv. So you are breaking things for them.

Plus, it is not about scripting versus not scripting. I may use "git
diff >foo.diff" manually to generate a diff. I think most users would
expect the result to be applicable by git-apply.

Perhaps textconv opened a can of worms here that we should not have. I
think it is slightly less bad in the case of textconv for two reasons:

  1. You at least have to start using the textconv feature to shoot
     yourself in the foot, so hopefully you are aware of it and its
     implications (or at least feel a little dumb when the implications
     bite you. :) ).

  2. Trying to apply a textconv patch is _obviously_ wrong. The
     application will fail, you'll look at it and say "Oh, this isn't
     even close to right. Clearly the binary part is missing." Somebody
     who tries to apply a symlink patch which has suppressed the "no
     newline" message will silently get a newline in their symlink
     value, won't they (or even if it does get rejected, it is not
     obvious that it is the missing newline indicator that is the
     problem).

> One could introduce a separate config for that, of course, if you mind
> unguarded diff|apply. But don't you think that those "No newline"
> warnings are just plain stupid for symlinks?

I do think they make the output harder for humans to read. But I also
think that producing working, correct diffs is an important job for "git
diff". Unfortunately because the diff format serves the dual purpose of
being human and machine-readable, these sorts of conflicts are
inevitable.

Another source of this conflict is colorization. The solution we took
there is show it only when output goes to the terminal or pager. Perhaps
we should do the same here (and arguably, that would be the right thing
for textconv, too).

-Peff
