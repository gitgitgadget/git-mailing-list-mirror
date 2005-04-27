From: Bram Cohen <bram@bitconjurer.org>
Subject: The criss-cross merge case
Date: Wed, 27 Apr 2005 13:25:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504271254120.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Apr 27 22:21:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQt16-000421-4S
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVD0UZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVD0UZf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:25:35 -0400
Received: from wax.eds.org ([64.147.163.246]:11212 "EHLO wax.eds.org")
	by vger.kernel.org with ESMTP id S261898AbVD0UZW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 16:25:22 -0400
Received: by wax.eds.org (Postfix, from userid 1044)
	id 7B65F324036; Wed, 27 Apr 2005 13:25:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by wax.eds.org (Postfix) with ESMTP id 78A74B401A
	for <git@vger.kernel.org>; Wed, 27 Apr 2005 13:25:18 -0700 (PDT)
X-X-Sender: bram@wax.eds.org
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's an example of where simple three-way merge can't do the right
thing. Each letter represents a snapshot of the history, and time goes
downwards. The numbers after some letters refer to which line number was
modified at that time.


A
|\
| \
|  \
|   \
|    \
|     \
|      \
B8      C3
|\     /|
| \   / |
|  \ /  |
|   X   |
|  / \  |
| /   \ |
|/     \|
D8      E3
 \      |
  \     |
   \    |
    \   |
     \  |
      \ |
       \|
        ?

In this case the ? should have a clean merge with the D vesion of line 8
(because it was made with the B version already in the history) and the E
version of line 3 (because it was made with the C version already in the
history).

The problem is that there's no single ancestor for the three-way merge
which does the right thing. If one picks B, then there will be an
unnecessary merge conflict at line 3, because D will have the C version
and E will have the E version but B will have neither. Likewise if one
picks C, there will be an unnecessary conflict at line 8 because D will
have the D version and E will have the B version but C will have neither.
Picking A will cause unnecessary conflicts on *both* lines.

The problem can actually be much worse than a simple unnecesary conflict,
because if the later updates were strict undos of the earlier updates,
then picking either B or C will merge something *wrong*. Using A as the
ancestor will keep that from happening, but it also maximizes unnecessary
conflicts.

Note that the above criss-cross case only involves two branches, using the
methodology of each one modifying their own section and pulling in old
versions of the other one from time to time. Cogito's interface encourages
exactly this work flow, which is not a bad thing from a work flow
perspective, but does make it hit this case regularly.

The way Git handles this currently is very bad, because it forces the
common ancestor to be from the same snapshot across all files, so this
problem will happen if the modifications are made even in different files,
not just different lines within the same file. That could be improved
greatly by finding an LCA for each file individually, which is what
Monotone does. Darcs, Codeville, and all the Arch descendants have better
merge algorithms which don't have to pick a single common ancestor.

-Bram

