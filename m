From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove various dead assignments and dead increments
 found by the clang static analyzer
Date: Sat, 26 Sep 2009 17:12:20 -0400
Message-ID: <20090926211220.GA3387@coredump.intra.peff.net>
References: <87ab0hepcn.fsf@master.homenet>
 <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
 <871vltefdj.fsf@master.homenet>
 <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
 <87ske9cya9.fsf@master.homenet>
 <20090926204604.GA2960@coredump.intra.peff.net>
 <3f4fd2640909261403n78a7e45cm3d2cd48408b5ff52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:12:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MreZA-00026T-6N
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 23:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbZIZVMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 17:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZIZVMS
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 17:12:18 -0400
Received: from peff.net ([208.65.91.99]:36362 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbZIZVMR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 17:12:17 -0400
Received: (qmail 17056 invoked by uid 107); 26 Sep 2009 21:15:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 26 Sep 2009 17:15:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Sep 2009 17:12:20 -0400
Content-Disposition: inline
In-Reply-To: <3f4fd2640909261403n78a7e45cm3d2cd48408b5ff52@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129180>

On Sat, Sep 26, 2009 at 10:03:27PM +0100, Reece Dunn wrote:

> > Now this is one that I do think is sensible. The variable isn't used, so
> > don't even bother declaring it.
> 
> The status variable is removed in this patch.

Yes. Sorry if I wasn't clear, but what I meant was "this does not fall
under the same idioms as the other ones, and it is a fine thing to be
removing".

> But then shouldn't the status returned be checked and acted on? That
> is, are failures from run_command_v_opt being reported to the user, or
> otherwise reacted to?

Perhaps. This is the post-update hook, so at that point we have already
committed any changes to the repository. Usually it is used for running
"git update-server-info" for repositories available over dumb protocols.

So there is no useful action for receive-pack to do after seeing an
error. But I said "perhaps" above, because it might be useful to notify
the user over the stderr sideband that the hook failed. Even though we
have no action to take, the user might care or want to investigate a
potential problem.

I suspect nobody has cared about this before, though, because the stderr
channel for the hook is also directed to the user. So if
update-server-info (or whatever) fails, presumably it is complaining to
stderr and the user sees that. Adding an additional "by the way, your
hook failed" is just going to be noise in most cases.

> Thus having the same effect (removing the status variable). Callers of
> run_update_post_hook should be checked as well, as should other
> run_command_* calls.

There is exactly one caller, and it doesn't care about the return code
for the reasons mentioned above.

-Peff
