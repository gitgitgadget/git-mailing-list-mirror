From: Junio C Hamano <junkio@cox.net>
Subject: Some more pack-objects tweaks
Date: Fri, 24 Feb 2006 02:38:21 -0800
Message-ID: <7vvev5ca8y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 24 11:38:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCaLC-0005Ek-JV
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 11:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWBXKiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 05:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWBXKiX
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 05:38:23 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41466 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750882AbWBXKiX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 05:38:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224103712.KZPH3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 05:37:12 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16692>

I've been working more pack-objects improvements.  There will be
two tweaks in the "next" branch I'll be pushing out tonight.

 * rev-list reports full pathnames not just basenames for
   contained trees and blobs.  pack-objects hashes the incoming
   names (and names obtained from "negative" trees when
   --objects-edge aka "thin pack" is used) taking into account
   the dirname and basename part.

   Earlier, I had a patch that hashes the whole pathname, and
   found it perform worse than the original "hash just the
   basename" approach, so I never published it.  The idea in
   this round is to give "Makefile" and "t/Makefile" a different
   but close hash values.  Type-size sort groups "Makefile"s
   from different revs together, and another group of bunch of
   "t/Makefile"s are found close by.

 * when creating "thin" pack, disable the code to avoid too
   long a delta chain to be made due to reused delta (see
   15b4d57 and ab7cd7b commit log for details).

   This is because limiting delta chain is more costly than let
   it grow by using preexisting delta, and "thin" pack is usable
   by first exploding it, so at that point delta depth does not
   matter.

In Linux 2.6 repository, I've created a thin pack between
v2.6.14..v2.6.15-rc1 (36k objects).  Here are the results:

    [without either patch]
    15463034 bytes
    Total 36248, written 36248 (delta 29046), reused 28306 (delta 22512)
    real    1m38.157s       user    1m32.520s       sys     0m5.440s

    [with full names]
    11138621 bytes
    Total 36248, written 36248 (delta 30368), reused 27918 (delta 22512)
    real    1m36.254s       user    1m28.650s       sys     0m5.470s

    [with full names, and allowing deeper delta]
    9971223 bytes
    Total 36248, written 36248 (delta 30868), reused 27429 (delta 22512)
    real    1m36.923s       user    1m29.770s       sys     0m5.470s

All of these tests were done with the last patch in Nico's delta
enhancement series reverted, because the dataset used in this
test triggers a corner case performance disaster in it (I've
sent a message separately).
