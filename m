From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] "cg-object-id -p" ignore grafts, breaks cg-admin-rewritehist
Date: Wed, 10 May 2006 00:25:19 +0200
Message-ID: <20060509222519.GF27397@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed May 10 00:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdaT5-0001RP-WE
	for gcvg-git@gmane.org; Wed, 10 May 2006 00:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWEIWOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 18:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWEIWOF
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 18:14:05 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:2960 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751205AbWEIWOF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 18:14:05 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 935C2547FF;
	Wed, 10 May 2006 00:14:03 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fdadr-0007FS-SS; Wed, 10 May 2006 00:25:19 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19854>


Currently (cogito 0.17.2), using "cg-object-id -p" to lookup a
commit's parents fetches information directly from the commit object
through "git-cat-file commit".  This causes all its callers to ignore
any grafts, and probably causes various problems.  The one I stumbled
upon is an inconstency in the data seen by cg-admin-rewritehist, when
a graft is used to replace the single parent of a commit with another
single parent - tentative recovery of a tarball import done on a wrong
branch, in the hope that cg-admin-rewritehist would allow to fix the
history as defined by the graft.

In that case, after identifying the commits to rewrite through legal
means, rewritehist attempts to lookup the parents for each of those
original commits and map them to already-rewritten ones, but
cg-object-id returns the pre-graft parent, which was not to be
rewritten, and the tool fails (miserably with an invalid rewritten
branch, as the exception is not caught).

A patch follows (depending on an updated "set -e" patch for
rewritehist) to have rewritehist at least abort in error when it can
identify such an inconsistency.

What should cg-object-id use to lookup parent information in a sane
way that does not ignore grafts ?

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
