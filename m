From: Junio C Hamano <junkio@cox.net>
Subject: Re: Dump http servers still slow?
Date: Thu, 28 Jul 2005 19:24:47 -0700
Message-ID: <7vy87qpcwg.fsf@assigned-by-dhcp.cox.net>
References: <1122584423.12374.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 04:25:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyKYn-0008Ti-Gd
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 04:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVG2CZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 22:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVG2CZC
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 22:25:02 -0400
Received: from [68.230.241.28] ([68.230.241.28]:30392 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262258AbVG2CZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 22:25:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729022442.UNLF12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 22:24:42 -0400
To: Darrin Thompson <darrint@progeny.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Darrin Thompson <darrint@progeny.com> writes:

> I just ran git clone against the mainline git repository using both http
> and rsync. http was still quite slow compared to rsync. I expected that
> the http time would be much faster than in the past due to the pack
> file.
>
> Is there something simple I'm missing?

No, the only thing you missed was that I did not write it to
make it fast, but just to make it work ;-).  The commit walker
simply does not work against a dumb http server repository that
is packed and prune-packed, which is already the case for both
kernel and git repositories.

The thing is, the base pack for the git repository is 1.8MB
currently containing 4500+ objects, while we accumulated 600+
unpacked objects since then which is about ~5MB.  The commit
walker needs to fetched the latter one by one in the old way.

When packed incrementally on top of the base pack, these 600+
unpacked objects compress down to something like 400KB, and I
was hoping we could wait until we accumulate enough to produce
an incremental about a meg or so ...
