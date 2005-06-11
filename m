From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFE: git relink
Date: Fri, 10 Jun 2005 20:44:01 -0700
Message-ID: <7vy89h36da.fsf@assigned-by-dhcp.cox.net>
References: <42A88C07.5050907@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 05:40:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgwqe-0003sz-EU
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 05:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVFKDoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 23:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVFKDoL
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 23:44:11 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27873 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261619AbVFKDoF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 23:44:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050611034403.YRBZ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Jun 2005 23:44:03 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42A88C07.5050907@pobox.com> (Jeff Garzik's message of "Thu, 09
 Jun 2005 14:35:51 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JG" == Jeff Garzik <jgarzik@pobox.com> writes:

JG> It would be nice if somebody were motivated enough to create a command
JG> that functions like:

JG> 	git relink repoA repoB repoC repoD... repoX

JG> which would examine

JG> 	repoA/.git
JG> 	repoB/.git
JG> 	repoC/.git
JG> 	repoD/.git

JG> and verify (updating, if necessary) that each of the A/B/C/D repos are
JG> hardlinked to repoX.

Whoever is doing this script needs to be a bit careful.

If you end up unlinking a full object and hard-linking a
deltified object representation (delta) in its place, the
repository can get corrupted, because it might not have the
necessary base object for the delta.

There are two strategies to solve this.  Either (1) the relinker
refuses to replace a full object with a delta, or (2) the
relinker notices a delta, and makes an additional hard link to
the base object when replacing a full object with a delta (this
needs to be done recursively until you hit a full base object).

(1) is simpler and cleaner, but does not get full advantage of
the delta compression.  (2) gives you delta compression but it
will add possibly "unwanted" objects to a repository that
happens to slurp in a delta (fsck would not complain, though).

My knee-jerk vote goes to (1), but in either case the relinker
needs to check if it is dealing with a delta; this cannot be
done with git-cat-file -t AFAIK.

Ryan Anderson code will notice delta vs full object case most of
the time because it checks and makes sure the sizes of
corresponding files from two repositories match.  The problem
with the code is that it dies, instead of just ignoring, when
size differs.  Dying is good for ordinary case (two full object
representations of the same file should not have different
sizes), but it is not the right thing to do when it sees one
side using the full object representation and the other side
using a delta.

