From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 0/3] Handling merge conflicts a bit more gracefully
Date: Thu, 09 Jun 2005 00:02:34 -0700
Message-ID: <7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 09:23:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgH03-0001ZX-Pg
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 08:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVFIHCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 03:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVFIHCn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 03:02:43 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59064 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S262311AbVFIHCg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 03:02:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609070236.CXKS1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 03:02:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 16:35:48 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This series consists of three patches.

  [PATCH 1/3] read-tree.c: rename local variables used in 3-way merge code.
  [PATCH 2/3] read-tree -m 3-way: loosen index requirements that is too strict.
  [PATCH 3/3] read-tree -m 3-way: handle more trivial merges internally

You may have noticed that I already described some "alternative
semantics" in the 3-way merge test script t1000.  This set of
patches implements some of them, namely the following 5 cases:

     O       A       B         result      index requirements
-------------------------------------------------------------------
  5  missing exists  A==B      take A      must match A, if exists.
 ------------------------------------------------------------------
  6  exists  missing missing   remove      must not exist.
 ------------------------------------------------------------------
  8  exists  missing O==B      remove      must not exist.
 ------------------------------------------------------------------
 10  exists  O==A    missing   remove      must match A and be
                                           up-to-date, if exists.
 ------------------------------------------------------------------
 14  exists  O==A    O!=B      take B      if exists, must either (1)
                                           match A and be up-to-date,
                                           or (2) match B.
-------------------------------------------------------------------

The first patch is to match the local variable names used in the
functions involved to the names used in the case matrix.

Case #14 is resolved identically as the old code does, but the
index requirement old code placed on this case was stricter than
necessary.  In this case, satisfying the usual rule of "match A
and be up-to-date if exists" is certainly OK, but additionally,
if the original index matches the tree being merged (without
even being up-to-date) is also permissible, because there would
be no information loss or work-tree clobbering if we allowed it.
The second patch in the series corrects this.

Case #5, #6, #8, and #10 were traditionally kept unmerged in the
index file when read-tree is done, and resolving them was left
to the script.  By resolving these internally, we can loosen the
index requirements without compromising correctness for case #5.
Other three cases could still be left for the "script policy"
because this change does not affect the index requirements for
these cases, but it was simple enough to implement them and this
would not be too controversial a change.  The third patch in the
series implements these changes.

