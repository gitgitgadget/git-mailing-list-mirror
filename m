From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-relink-script to fix up missing hardlinks
Date: Sun, 26 Jun 2005 12:07:58 -0700
Message-ID: <7v7jghq6lt.fsf@assigned-by-dhcp.cox.net>
References: <20050626181516.GC20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 26 21:02:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmcNs-0000Ey-Kk
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 21:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVFZTIU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 15:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbVFZTIU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 15:08:20 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53380 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261567AbVFZTIA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 15:08:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050626190757.HCXZ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Jun 2005 15:07:57 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050626181516.GC20369@mythryan2.michonline.com> (Ryan
 Anderson's message of "Sun, 26 Jun 2005 14:15:16 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Not that I think it matters that much anymore since I am
proposing removal of "delta" support and Linus seems to be
inclined in the same direction, but I said "most of the time" in
the earlier message on this same topic for a reason:

    Message-ID: <7vy89h36da.fsf@assigned-by-dhcp.cox.net>
    Subject: Re: RFE: git relink
    Date: Fri, 10 Jun 2005 20:44:01 -0700
    References: <42A88C07.5050907@pobox.com>

    Whoever is doing this script needs to be a bit careful.

    ...

    Ryan Anderson code will notice delta vs full object case most of
    the time because it checks and makes sure the sizes of
    corresponding files from two repositories match.  The problem
    with the code is that it dies, instead of just ignoring, when
    size differs....

Your latest version has an option not to die which is very good
[*1*], but in a very narrow corner case, without comparing the
file contents, I think the code would still do a wrong thing.
Two trees can store the same object both in delitified form but
based on different base objects, and the deltified
representation still having the same length, no?  And I suspect
you would end up linking them together, corrupting one of the
trees.

Of course, even when you do not have "delta", if an object in
one tree is corrupted (but has the correct size), you would end
up relinking the corrupt one into another tree, nuking a good
copy, if you do not compare the file contents.

If/when/after the proposed removal of "delta" support happens, I
think the correct way to do git-relink-script would be to keep
most of your latest version intact, except:

 (1) make it always die when you see differences in size.
     Without "delta" in the repository, SHA1 files that
     represent the same object must have the same size.

 (2) make --safe also check on file contents.  You do not need
     the flag for the "delta" reason anymore, so I am suggesting
     reusing the flag to detect file corruption, to be extra
     safe, when the user permits you to spend cycles to be more
     careful.

[Footnote]

*1* and other parts of the script all look nicely done.
