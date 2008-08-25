From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: What's cooking in git.git (Aug 2008, #07; Sat, 23)
Date: Mon, 25 Aug 2008 18:32:03 +0200
Message-ID: <20080825163203.GD22184@cuci.nl>
References: <7v1w0ft750.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0808241955550.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vd4jymdfn.fsf@gitster.siamese.dyndns.org> <7vwsi6kvow.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 18:33:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXf0C-0005PM-Sp
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 18:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbYHYQcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 12:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYHYQcH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 12:32:07 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:53424 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297AbYHYQcG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 12:32:06 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 4815A5465; Mon, 25 Aug 2008 18:32:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vwsi6kvow.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93639>

Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>>> * sb/daemon (Thu Aug 14 20:02:20 2008 +0200) 4 commits
>>>>  - git-daemon: rewrite kindergarden, new option --max-connections
>>>>  - git-daemon: Simplify dead-children reaping logic
>>>>  - git-daemon: use LOG_PID, simplify logging code
>>>>  - git-daemon: call logerror() instead of error()

>>>> Can somebody who actually runs the daemon standalone comment on this 
>>>> one?

>> Well, I didn't ask anybody to _run_ it.

Actually I *am* running it in production (obviously).

>It seems that kill_some_child() will not kill anything if nobody else is
>coming from the same address, while the old code did kill some.  Is this
>intended?

This is intended.
The reasoning goes a bit like this:
- We already allow a --timeout to be specified, that is taken care of
  by the child process.
- The child process is well-behaved, so it should honour its own timeout
  setting.
- If the daemon would need to cater for child processes failing to
  honour their own timeout setting, we have some serious bugs in the
  child-code, and *that* should be fixed ASAP instead of letting that
  kind of problems linger by not getting noticed because some daemon
  tries to clean up after badly-behaving children.
- Therefore, the only two problems that are left are:
  + Many connections in total.  That would mean that we can't handle the
    load.  Well, the best way to respond to that is to diligently
    process the ones that *did* manage to connect, and *not* to randomly
    disconnect sessions which are already halfway there.
  + Many connections in total, but also multiple connections from the
    same IP-address.  In this case, we could try and evenly distribute
    the resource and kill off the *newest* connections from the same IP
    addresses, to allow everyone an equal share to the daemon.

That means:
- Random killing is not necessary.
- Since we know exactly how many clients are running, we can keep tabs
  on when to fork and when not (further reducing the load problem on
  a busy site).  Which means that at most we need to
  kill one client for every new connection.
- Since we don't want to force old connections to die (we trust our
  children), we simply refuse further connections as soon as we've
  reached our limit and don't have resource-eaters (duplicate sessions
  from the same IP address).

>By the way, add_child() compares the whole "struct sockaddr_storage" in
>order to queue the newborn in front of an existing connection from the
>same address, and kill_some_child() takes advanrage of this to kill the
>newest connection ("We kill the newest" comment should probably be moved
>to add_child() to describe why the queuing is done this way).  If you
>simplify add_child() to queue the newborn always at the front of the list,
>your kill_some_child() will continue to do so, so I do not see the point
>of the loop in add_child().  Am I mistaken?

You are mistaken.
The point is that we need to find out *duplicate* IP-adresses.
I.e. when looking for the child to be killed, the IP-address we're looking
for is not the IP-address of the new connection, but we're looking for
two consecutive duplicate addresses.  In order for this to work, we need
to cluster the connections of the same IP-address, and the newest
connection needs to be inserted in front, in order for kill_child to
kill the most recent connection.

Shall I incorporate your suggested changes (as far as I consider them ok)
into my patches and resubmit them?
-- 
Sincerely,
           Stephen R. van den Berg.
Auto repair rates: basic labor $40/hour; if you wait, $60; if you watch, $80;
if you ask questions, $100; if you help, $120; if you laugh, $140.
