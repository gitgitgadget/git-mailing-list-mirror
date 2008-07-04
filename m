From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/v2] git-basis, a script to manage bases for git-bundle
Date: Fri, 4 Jul 2008 15:51:11 -0400
Message-ID: <20080704195110.GA3752@sigill.intra.peff.net>
References: <1214272713-7808-1-git-send-email-adambrewster@gmail.com> <c376da900807011836i76363d74n7f1b87d66ba34cd6@mail.gmail.com> <20080702032155.GA13581@sigill.intra.peff.net> <200807021144.46423.jnareb@gmail.com> <20080703195915.GA18532@sigill.intra.peff.net> <c376da900807031638l219229bcy983ed994b37512c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 21:52:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KErKM-0005Xa-JW
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 21:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbYGDTvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbYGDTvT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 15:51:19 -0400
Received: from peff.net ([208.65.91.99]:2627 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbYGDTvT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 15:51:19 -0400
Received: (qmail 3531 invoked by uid 111); 4 Jul 2008 19:51:14 -0000
Received: from c-75-75-7-53.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.7.53)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 04 Jul 2008 15:51:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jul 2008 15:51:11 -0400
Content-Disposition: inline
In-Reply-To: <c376da900807031638l219229bcy983ed994b37512c9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87415>

On Thu, Jul 03, 2008 at 07:38:21PM -0400, Adam Brewster wrote:

> There's still plenty of potential for improvements, like a --gc mode
> to clean up basis files, a --rewind option to undo an incorrect
> --update, or improvements in the way it calculates intersections, but
> I think that with these changes the system is as simple as possible
> while maximizing flexibility, utility, and usability.

I was thinking about Mark's approach, and I think there are two distinct
differences from yours:

  1. he updates the basis upon bundle creation, rather than as a
     separate step (and I have already commented on this)

  2. he stores the basis in the refs hierarchy

I actually think '2' makes a lot of sense. Storing the basis as refs
gets you:

  - an easy implementation; you use existing git tools

  - correct reachability analysis, since the refs will be taken into
    account by git-fsck, meaning you won't ever accidentally prune
    your basis objects

  - free logging of your basis history, in the form of reflogs

  - free gc in the usual reflog way

IIRC, Mark suggested putting them under refs/remotes/<bundle>, and you
objected that you didn't want to clutter that hierarchy. If that is a
problem, you can always use refs/basis/<bundle>, which will be ignored
by gitk and "git branch -a", but will be correctly handled by other
tools.

And then suddenly your perl script gets a lot simpler, and is either a
short shell script, or even better, can be written in C as part of
git-bundle. So you would have something like "git bundle --update-basis
<basis>" instead of "git-basis", and a config option like
"bundle.autoUpdateBasis" to update the basis whenever you create a
bundle.

-Peff
