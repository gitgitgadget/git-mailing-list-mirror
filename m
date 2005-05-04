From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'read-tree -m head' vs 'read-tree head'
Date: Tue, 03 May 2005 23:54:29 -0700
Message-ID: <7vr7gnpjkq.fsf@assigned-by-dhcp.cox.net>
References: <20050503124935.GT25004@cip.informatik.uni-erlangen.de>
	<7vbr7sw2aj.fsf@assigned-by-dhcp.cox.net>
	<20050503213444.GD15995@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 08:50:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTDhY-0006hq-8n
	for gcvg-git@gmane.org; Wed, 04 May 2005 08:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVEDGyf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 02:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVEDGyf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 02:54:35 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53999 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262049AbVEDGya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 02:54:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050504065429.EHVF23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 4 May 2005 02:54:29 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050503213444.GD15995@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 3 May 2005 23:34:44 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Dear diary, on Tue, May 03, 2005 at 09:13:40PM CEST, I got a letter
PB> where Junio C Hamano <junkio@cox.net> told me that...

>> That said, I've been wondering ... if there
>> is a valid use case where you would want to use it without "-m"
>> because "-m" does something wrong...

PB> -m fails when your cache file is missing/corrupted. Not that it cannot
PB> be fixed, just remember to fix it if you are going to do what you
PB> described.

Missing case seems to be handled fine.  It spits out a message
from error() on a corrupt cache, but does not choke on it and
creates a valid cache in the end.

I just found out why we *do* need non -m version. The -m version
refuses to work on an unmerged cache, which is the right thing
to do.  If you try a merge, and if you do not like the result,
you can throw the index away and start from scratch with non -m
version.  Of course "rm .git/index" would work just fine as
well.

Another reason we may want to avoid -m version is that it takes
a long time to read the cache on a large project, but I think a
read-tree almost always is followed by a checkout-cache in a
typical use case, and -m version significantly improves the
performance of the latter.

    read-tree -m $other; checkout-cache -f -a
    read-tree    $other; checkout-cache -f -a

A not so scientific benchmark of reading one commit in a work
tree based on a commit several steps away (this is linux-2.6
tree so the index file is 1.6MB), run on my machine with a slow
disk, does the former in 12 seconds and the latter in about 18
seconds.  Comparison between the following is more drastic.

    read-tree -m $other; update-cache --refresh
    read-tree    $other; update-cache --refresh

The version with -m wins by factor of ten.

So Thomas, here is my conclusion:

    Normally "read-tree -m" is the preferred form from
    performance point of view, especially on a large project.
    The only case you need to use "read-tree" without -m is when
    the cache contains conflicting merge results and you want to
    start from scratch.

