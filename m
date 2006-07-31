From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix double "close()" in ce_compare_data
Date: Mon, 31 Jul 2006 12:05:17 -0700
Message-ID: <7vlkq961ea.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 21:05:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7d4s-0008Ny-MV
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 21:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWGaTFU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 15:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWGaTFU
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 15:05:20 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48546 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030328AbWGaTFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 15:05:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731190518.ULWI27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 15:05:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607310945490.4168@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 31 Jul 2006 09:55:15 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24540>

Linus Torvalds <torvalds@osdl.org> writes:

> The way I found this also showed a potential performance problem: if you 
> do a "git reset --hard" (or similar) after you have changes in your tree, 
> it will write the index file with the same timestamp as the checked out 
> files that it re-wrote.
>...
> We should really try to have some way to re-generate the index 
> automatically when this case triggers, so that we only need to do it 
> _once_ rather than keep doing it forever while the index is "potentially 
> stale".
>
> Any ideas?

Just before writing the index out, we could do a gettimeofday()
and wait for 1 second (or two if you are on FAT) if we have many
many paths that have the same timestamp.  Ugly and would not
work on NFS I suspect.

We could do gratuitous "update-index --refresh" but that is
uglier especially if done at the core level; the caller does not
expect the index file to be updated.

Or we could remove the check and tell the user not to touch the
working tree after calling update-index (I am not seriously
suggesting this).
