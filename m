From: Junio C Hamano <junkio@cox.net>
Subject: new read-tree questions.
Date: Mon, 06 Jun 2005 01:43:03 -0700
Message-ID: <7v64wrvpt4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 10:40:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfD9K-0003Jg-5D
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 10:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFFInf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 04:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVFFInf
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 04:43:35 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49284 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261236AbVFFIna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 04:43:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050606084303.VGAJ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Jun 2005 04:43:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I am trying to understand the new git-read-tree, by using
git-resolve-script as an example and also reading read-tree.c; I
am somewhat confused.

* two-way merge (git-read-tree -m $H $M)

My understanding is that the current index is allowed to be
empty, but if it is not, they are kept at stage0, and each of
them must match $H and must be up-to-date if the merge involves
them.

To summarize my understanding of what should happen for each
path:

  stage0 (index)  stage1 ($H)             stage2 ($M)
------------------------------------------------------------
  no such path    no such path            no such path
  * this does not happen (the code would not see such thing).
  ----------------------------------------------------------
  no such path    no such path            exists
  * take $M without complaining.
  ----------------------------------------------------------
  no such path    exists                  (does not matter)   *0*
  * although index does not match $H, we do not reject, so
    that a merge can happen on an empty cache.  We take $M.
  ----------------------------------------------------------
  exists          no such path            no such path
  * reject, because index does not match $H.
  ----------------------------------------------------------
  exists          no such path            exists (index!=$M)
  * reject, because index does not match $H.
  ----------------------------------------------------------
  exists          no such path            exists (index=$M)   *1*
  * take $M (same as "keep stage0").
  ----------------------------------------------------------
  exists          exists (index!=$H)      (does not matter)
  * reject, because index does not match $H.
  ----------------------------------------------------------
  exists          exists (index=$H)       no such path        *2*
  * path is removed.
  ----------------------------------------------------------
  exists          exists (index=$H)       exists
  * take stage2.
  ----------------------------------------------------------

Does the above matrix represent the intended behaviour?

I think I understand why we would want *0*, but this asymmetry
feels wrong.

I am having trouble with the case *1*.  This would call
twoway_check with !seen_stage1 and it says OK, because the
merged tree has the same contents as what we started with.  Is
it to help the case where" the merged tree changes things the
same way we already have as our local change" case?

Also I am not sure if the code does the right thing for case
*2*.  If I am reading the code right, for such a path, we will
see stage0 and stage1, and at that point say seen_stage1 = 1 and
keep stage0 entry in "old".  Then we continue on to the next
path.  When it happens to be:

    - stage0: we barf because we still have our "old".

    - stage1: we barf because our "old" does not match the new
      path; !path_matches(old,ce) triggers.

    - stage2: we barf because our "old" does not match the new
      path; twoway_check(old, seen_stage1, ce) triggers.

Only when such a "exists-exists-removed" were the last entry,
the control falls out of the loop and "unmatched with a new
entry?"  check takes care of it without barfing.  The path is
removed which is what I understand you want to happen in the
case *2*.

Maybe my version of intended behaviour for case *2* is wrong,
but then I do not understand why.

I'll do a similar matrix for three-way merge case later and
probably ask more questions.

