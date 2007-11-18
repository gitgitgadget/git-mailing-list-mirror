From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [RFC] Alternates and broken repos: A pack and prune scheme to avoid them
Date: Sun, 18 Nov 2007 12:25:52 +0100
Message-ID: <200711181225.52288.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 12:26:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItiI2-0005hI-Dl
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 12:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbXKRLZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 06:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbXKRLZz
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 06:25:55 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:43419 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbXKRLZy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 06:25:54 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id BC06E13A331
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 12:25:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7F52F594AE
	for <git@vger.kernel.org>; Sun, 18 Nov 2007 12:25:52 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65367>

As you know, repo.or.cz uses alternates in order to reduce the space that the 
repositories of forked projects require.

Recently, it happened that a fork (4msysgit.git) became broken because it was 
using an object that was pruned away from the repository that it was 
borrowing from (mingw.git). This happened even though 4msysgit did not use 
the branch of mingw.git that was rebased and whose objects were pruned. The 
reason is that a merge in 4msysgit.git resulted in a blob that was also in 
the rebased branch.

To avoid such situations I propose to introduce "attic" packs. They contain 
objects that are unreachable by the local set of refs. Otherwise they are 
used like regular packs.

git-repack produces "attic" packs like this:

- Places objects of the local object store that are unreachable in an "attic" 
pack.
- Copies objects that are reachable but borrowed from an alternate and are 
only in the alternates' "attic" packs into the local regular pack.

git-prune removes "attic" packs.

Then the strategy of garbage collection can be arranged in the following way:

- Repack by starting at the "most complete" repo and work towards the "most 
borrowing" ones. During this phase "attic" packs are created. Borrowing repos 
get a chance to salvage objects before the alternates prune them away.

- Prune by starting at the "most borrowing" repo and work towards the "most 
complete" ones. During this phase the "attic" packs are cleaned up.

What do you think? Is this a way for a solution?

-- Hannes
