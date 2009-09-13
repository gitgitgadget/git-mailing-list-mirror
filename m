From: Jeff King <peff@peff.net>
Subject: Re: git push --confirm ?
Date: Sun, 13 Sep 2009 06:52:47 -0400
Message-ID: <20090913105247.GA21750@coredump.intra.peff.net>
References: <1252777897.2974.24.camel@localhost.localdomain>
 <20090912184342.GB20561@coredump.intra.peff.net>
 <7vvdjn8ymk.fsf@alter.siamese.dyndns.org>
 <20090913093324.GB14438@coredump.intra.peff.net>
 <7vljkjuo43.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Owen Taylor <otaylor@redhat.com>, git@vger.kernel.org,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 12:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmmhW-0004WL-7y
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 12:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbZIMKwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 06:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbZIMKws
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 06:52:48 -0400
Received: from peff.net ([208.65.91.99]:45574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbZIMKwr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 06:52:47 -0400
Received: (qmail 17423 invoked by uid 107); 13 Sep 2009 10:53:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 13 Sep 2009 06:53:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 06:52:47 -0400
Content-Disposition: inline
In-Reply-To: <7vljkjuo43.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128355>

On Sun, Sep 13, 2009 at 03:37:32AM -0700, Junio C Hamano wrote:

> With --confirm, the wait happens while the --confirm waits for the human,
> and perhaps the command does "git log --oneline old...new" as convenience.
> While all this is happening, the TCP connection to the remote end is still
> kept open.  We do not lock anything, but if somebody else pushed from
> sideways, at the end of this session we would notice that, and the push
> will be aborted.
> 
> This somewhat makes me worry about DoS point of view, but it does make it
> somewhat safer.

I don't see how it makes a DoS any worse. A malicious attacker can
always open the TCP connection and let it sit; we are changing only the
client code, after all.

It does increase the possibility of _accidentally_ wasting a TCP
connection. I don't know if that is a real-world problem or not. I would
think heavily-utilized sites might put a time-out on the connection to
avoid such a DoS in the first place.

However, such a timeout is perhaps reason for us to be concerned with
implementing this feature with a single session. Will users looking at
the commits for confirmation delay enough to hit configured timeouts,
dropping their connection and forcing them to start again?

One other way to implement this would be with two TCP connections:

  1. git push --dry-run, recording <old-sha1> for each ref to be pushed.
     Afterwards, drop the TCP connection.

  2. Get confirmation from the user.

  3. Do the push again, confirming that the <old-sha1> values sent by
     the server match what we showed the user for confirmation. If not,
     abort the push.

Besides being a lot more annoying to implement, there is one big
downside: in many cases the single TCP connection is a _feature_. If you
are pushing via ssh and providing a password manually, it is a
significant usability regression to have to input it twice.

Also, given that ssh is going to be by far the biggest transport for
pushing via the git protocol, I suspect any timeouts are set for
_before_ the authentication phase (i.e., SSH times you out if you don't
actually log in). So in that sense it may not be worth worrying about
how long we take during the push itself.

> I think the largest practical safety would come from the fact that this
> would make it convenient (i.e. a single command "push --confirm") than
> having to run two separate ones with manual inspection in between.  A
> safety feature that is cumbersome to use won't add much to safety, as that
> is unlikely to be used in the first place.

Sure. But that is about packaging it up as a single session for the
user. If there is no concern about atomicity, you could do that with a
simple wrapper script.

-Peff
