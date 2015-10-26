From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] daemon: plug memory leak
Date: Mon, 26 Oct 2015 15:47:53 -0400
Message-ID: <20151026194753.GA25534@sigill.intra.peff.net>
References: <562B756F.1020305@web.de>
 <562B7838.8050009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 20:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqnkP-0003r0-FA
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 20:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbbJZTr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2015 15:47:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:48085 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751108AbbJZTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 15:47:56 -0400
Received: (qmail 4890 invoked by uid 102); 26 Oct 2015 19:47:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 14:47:56 -0500
Received: (qmail 17307 invoked by uid 107); 26 Oct 2015 19:48:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Oct 2015 15:48:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2015 15:47:53 -0400
Content-Disposition: inline
In-Reply-To: <562B7838.8050009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280212>

On Sat, Oct 24, 2015 at 02:23:20PM +0200, Ren=C3=A9 Scharfe wrote:

> Call child_process_clear() when a child ends to release the memory
> allocated for its environment.  This is necessary because unlike all
> other users of start_command() we don't call finish_command(), which
> would have taken care of that for us.
>=20
> This leak was introduced by f063d38b (daemon: use cld->env_array
> when re-spawning).

I agree this is a leak we need to address, but I find the solution a
little unsatisfactory (but tl;dr, it's probably the best we can do).

It would be nice if we could call finish_command() here to do the
wait(). But it does not know about WNOHANG, so we would have to
introduce a new helper anyway.

However, the whole check_dead_children function is accidentally
quadratic, and should probably be refactored in general. It loops over
the list of children, calling `waitpid(pid, WNOHANG)` on each. So if `n=
`
children connect at one time, we make `O(n^2)` waitpid calls.

I have patches to instead loop over waitpid(-1, WNOHANG) until there ar=
e
no dead children left (and use a hash to go from pid to each "struct
child").

But the reason I haven't posted them is that I'm somewhat of the opinio=
n
that this child-list can go away altogether. The main use is in
enforcing the max_connections variable. Just enforcing that can be done
with a counter, but we do something much weirder: when we get a new
connection, we try to kill an _existing_ child by finding the first
client with multiple connections, killing that, sleeping for a second
(!), and then if that killed something, giving the slot to the new
connection.

This has a few problems:

  1. Under non-malicious heavy load, you probably want to reject the ne=
w
     request rather than killing an existing one. If you kill a fetch
     that is 99% completed, that client is likely to come back and fetc=
h
     again, and you've just thrown away all of the effort (both CPU and
     bandwidth) put into the failed clone. You haven't spent anything o=
n
     the incoming connection, so you'd much rather they go away and com=
e
     back in a moment.

  2. I think the kill_some_child algorithm was meant to enforce
     fairness so that a single IP cannot monopolize all of your slots.
     I'm not sure that's realistic for a few reasons:

       a. Real bad guys will just hit you with a DDoS from many IPs.

       b. Real sites have load-balancing in front of git-daemon, and th=
e
          client IPs may not be meaningful.

       c. The duplicate selection is pretty naive. A bad guy with tons
	  of duplicate connections is no more likely to be killed than a
	  normal client with exactly two connections (it actually
	  depends solely on when the latest connection from either came
	  in). So I suspect a determine attacker with a single IP could
	  still present a problem.

  3. Calling sleep() in the server parent process is a great way to kil=
l
     performance. :)

Of course my view is somewhat skewed by running a really big site with
load balancers and such (and we have long set --max-connections high
enough that it has never been hit). Maybe it's more realistic protectio=
n
for a "normal" site.

But my inclination would be to drop kill_some_child entirely in favor o=
f
simply rejecting new connections that are over the limit, and getting
rid of the child-list entirely (and calling waitpid only to reap the
zombie PIDs).

I guess we'd still need something like child_process_clear(), though. W=
e
could just run it immediately after spawning the child, rather than whe=
n
we cleaned it up.  So in that sense this series is the first incrementa=
l
step toward that future, anyway.

-Peff
