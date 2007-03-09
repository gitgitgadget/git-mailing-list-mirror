From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in bundle
Date: Thu, 08 Mar 2007 23:17:58 -0800
Message-ID: <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45F0D1B3.9020204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 08:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPZN7-0000uI-Pl
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 08:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993043AbXCIHSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 02:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993041AbXCIHSE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 02:18:04 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59264 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993026AbXCIHSA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 02:18:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070309071759.TDAO2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 9 Mar 2007 02:17:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YXHy1W00m1kojtg0000000; Fri, 09 Mar 2007 02:17:59 -0500
In-Reply-To: <45F0D1B3.9020204@gmail.com> (Mark Levedahl's message of "Thu, 08
	Mar 2007 22:17:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41788>

Mark Levedahl <mlevedahl@gmail.com> writes:

> ... Without, I
> can just do git bundle ... <list of refs> and those which have been
> updated get included.

I am not sure if the above is true.  How are you preventing the
command from bundling everything?  You must have some limiter at
the bottom, something like --since=25.hours (to account for cron
schedule skew), not just <list of refs>.

I do not think the max-age limiter works as you are expecting,
especially when merges and clock skew among committing machines
are involved (just as you are distributing from central repo, I
am assuming you are getting work back from worker-bee machines
to the central repo at some point, and doing sneakernet implies
to me that they are disconnected machines, not running ntp, but
this is just me guessing).

In any case, the semantics of --since=25.hours limiter is not
"show everything newer than 25.hours that are reachable from any
of these refs"; it is "start digging from these tips, and stop
exploring the path as soon as you hit something that is newer
than 25.hours".

It appears that for the past few days we have been spending
significant effort to make --max-count and --max-age work with
bundles, but my honest impression is they do not play well in
the real world, especially when clock skew is involved.  On the
other hand, revision ranges ("include these, exclude those") are
always precise, and that is what you would want to be using,
especially from an automated script.

If I were doing a nightly script, I would probably be doing
something like this:

	#!/bin/sh
	yesterday=$(git bundle list-heads yesterday.bdl | sed -e 's/ .*//')
	git bundle create today.bdl --all --not $yesterday
	# mail it out

After sending today's bundle out, you will rotate it out to
yesterday.bdl in order to prepare for the next round.  It is
likely that you would want to keep a few day's worth of bundles
for other reasons _anyway_ (say, some project members might be
out of office, or mail gets dropped, or whatever), I think the
above is a reasonably clean and easy thing to arrange.
