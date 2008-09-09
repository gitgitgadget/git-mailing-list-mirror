From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [RFC] origin link for cherry-pick and revert
Date: Tue, 9 Sep 2008 15:22:12 +0200
Message-ID: <20080909132212.GA25476@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 15:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd3Bk-00052p-7r
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 15:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbYIINWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 09:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754243AbYIINWP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 09:22:15 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:50455 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014AbYIINWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 09:22:14 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 3D5685465; Tue,  9 Sep 2008 15:22:12 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95381>

I've read and digested the old threads about prior and related links.
Here's a new proposal which should be able to pass muster, if I read all
the relevant suggestions and objections in the old threads:

Consider an origin field as such:

commit bbb896d8e10f736bfda8f587c0009c358c9a8599
tree b83f28279a68439b9b044bccc313bbeaa3e973f5
parent ed0f47a8c431f27e0bd131ea1cf9cabbd580745b
origin d2b9dff8a08cc2037a7ba0463e90791f07cb49dd
origin a1184d85e8752658f02746982822f43f32316803 2
author Junio C Hamano <gitster@pobox.com> 1220132115 -0700
committer Junio C Hamano <gitster@pobox.com> 1220153445 -0700

The definition of the origin field reads as follows:

- There can be an arbitrary number of origin fields per commit.
  Typically there is going to be at most one origin field per commit.

- At the time of creation, the origin field contains a hash B which refers
  to a reachable commit pair (B, B~1).  If B has multiple parents and the pair
  being referred to needs to be e.g. (B, B~2), then the hash is followed by
  a space and followed by an integer (base10, two in this case),
  which designates the proper parentnr of B (see: mainline in git
  cherry-pick/revert).

- In an existing repository gc/prune shall not delete commits being
  referred to by origin links.

- During fetch/push/pull the full commit including the origin fields is
  transmitted, however, the objects the origin links are referring to
  are not (unless they are being transmitted because of other reasons).

- When fetching/pulling it is optionally possible to tell git to
  actually transmit objects referred to by origin links even if it would
  otherwise not have done so.

- git cherry-pick/revert allow for the creation of origin links only if
  the object they are referring to is presently reachable.

- git fsck will traverse origin links, but will stay silent if the
  object an origin link points to is unreachable (kind of like a shallow
  repository).

- git rev-list --topo-order will take origin links into account to
  ensure proper ordering.

- gitk allows for (e.g.) dotted lines to show the origin links.

- git log would show something like:

  commit bbb896d8e10f736bfda8f587c0009c358c9a8599
  Origin: d2b9dff..53d1589
  Origin: a1184d8..e596cdd
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Sat Aug 30 14:35:15 2008 -0700

  Note that for easy viewing: git diff d2b9dff..53d1589
  will show the exact diff the origin link is referring to.

- git log --graph will show a dotted line of somesort just like gitk.

- git blame will follow and use the origin link if the object exists.

- git merge disregards the whole origin field entirely, just like all
  the rest of git-core.

Anything I missed?
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
