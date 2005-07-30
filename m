From: Junio C Hamano <junkio@cox.net>
Subject: Re: Dump http servers still slow?
Date: Fri, 29 Jul 2005 19:11:45 -0700
Message-ID: <7vmzo56o0u.fsf@assigned-by-dhcp.cox.net>
References: <1122584423.12374.11.camel@localhost.localdomain>
	<7vy87qpcwg.fsf@assigned-by-dhcp.cox.net>
	<1122645821.4263.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 04:19:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DygwD-000202-EH
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVG3CSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVG3CNc
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:32 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:34706 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262934AbVG3CLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021142.TXQM1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:11:42 -0400
To: Darrin Thompson <darrint@progeny.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Darrin Thompson <darrint@progeny.com> writes:

> Ok... so lets check my assumptions:
>
> 1. Pack files should reduce the number of http round trips.
> 2. What I'm seeing when I check out mainline git is the acquisition of a
> single large pack, then 600+ more recent objects. Better than before,
> but still hundreds of round trips.
> 3. If I wanted to further speed up the initial checkout on my own
> repositories I could frequently repack my most recent few hundred
> objects.
> 4. If curl had pipelining then less pack management would be needed.

All true.  Another possibility is to make multiple requests in
parallel; if curl does not do pipelining, either switch to
something that does, or have more then one process using curl.

The dumb server preparation creates three files, two of which is
currently used by clone (one is list of packs, the other is list
of branches and tags).  The third one is commit ancestry
information.  The commit walker could be taught to read it to
figure out what commits it still needs to fetch without waiting
for the commit being retrieved to be parsed.

Sorry, I am not planning to write that part myself.

One potential low hanging fruit is that even for cloning via
git:// URL we _might_ be better off starting with the dumb
server protocol; get the list of statically prepared packs and
obtain them upfront before starting the clone-pack/upload-pack
protocol pair.
