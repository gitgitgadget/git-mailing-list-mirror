From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] server-info to help clients
Date: Tue, 19 Jul 2005 18:53:52 -0700
Message-ID: <7vd5pegs3z.fsf@assigned-by-dhcp.cox.net>
References: <m1u0iuo63i.fsf@ebiederm.dsl.xmission.com>
	<7vu0iqiaz9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0507191728380.18963@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	ebiederm@xmission.com
X-From: git-owner@vger.kernel.org Wed Jul 20 03:54:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv3mk-0001ue-D9
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 03:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVGTBx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 21:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVGTBx5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 21:53:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:43995 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261362AbVGTBx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2005 21:53:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050720015352.ETUN8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 19 Jul 2005 21:53:52 -0400
To: David Lang <david.lang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.62.0507191728380.18963@qynat.qvtvafvgr.pbz> (David Lang's message of "Tue, 19 Jul 2005 17:35:49 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The management of multiple packs and strategy of deciding when
to create the next incremental (be it throw-away or permanent)
is something I am not particularly interested in at this moment,
and as you correctly pointed out, the "single throw-away pack"
is an example of _bad_ strategy [*1*].  I am more interested in
designing a concise way to express what the server side has
(after applying such packing/repacking strategy) to help clients
coming over a dumb transport.

One thing that I forgot to mention is that there is another
per-repository information "$repo/info/revinfo".  This lists all
the commit ancestry reachable from "$repo/refs", and is needed
for clients to find out the closest commit from the very tip of
branches, which are likely not packed yet, that appears as a
head in "$repo/objects/info/pack" and go from there.


[Footnote]

*1* As I said, I am not interested in thinking about this at
this moment, but I suspect a scheme that employs the base pack,
permanent incrementals, and N new throw-aways every day for the
N-th day of the month may work reasonably well.

On the N-th day of the month, you create incrementals relative
to what existed on the N-1th, N-2th, ..., 1st of the month.  At
the end of the day, create N+1 new throw-aways for the N+1th day
of the month (you can garbage collect older days' throw-away
incrementals whenever you like).  At the end of the month, you
mark the throw-away incremental that is relative to the
beginning of the month as the latest permanent incremental.

Bootstrappers can slurp base, permanent incremental and the
throwaway for today that is relative to the last permanent
incremental.  Updaters can pick the one relative to the day they
updated last time.
