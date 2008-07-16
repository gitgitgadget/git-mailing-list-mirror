From: "Barak A. Pearlmutter" <barak@cs.nuim.ie>
Subject: git-cvsexportcommit keyword mismatch issue
Date: Wed, 16 Jul 2008 10:09:06 +0100
Message-ID: <E1KJ30U-0004EL-BV@corti>
Reply-To: barak+git@cs.nuim.ie
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 12:10:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ3xa-0000Ok-Ub
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759280AbYGPKJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759260AbYGPKJK
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:09:10 -0400
Received: from banyan.nuim.ie ([149.157.1.4]:35062 "EHLO banyan.nuim.ie"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758899AbYGPKJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:09:09 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jul 2008 06:09:08 EDT
Received: from corti ([149.157.192.252])
 by mango.nuim.ie (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3
 2007; 32bit)) with ESMTPS id <0K4300AKNDF61Q30@mango.nuim.ie> for
 git@vger.kernel.org; Wed, 16 Jul 2008 10:09:06 +0100 (IST)
Received: from barak by corti with local (Exim 4.69)
	(envelope-from <barak@cs.nuim.ie>)	id 1KJ30U-0004EL-BV; Wed,
 16 Jul 2008 10:09:06 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88654>

I used git-cvsimport -k to create my own git repo to deal with a
project that uses CVS.  I push my mods upstream using
git-cvsexportcommit.  This works fine *unless* there is a keyword
mismatch, i.e., some file in git has $Id: foo$ while in CVS keyword
expansion somehow changed it to $Id: bar$.  In that case
git-cvsexportcommit barfs with a patch failure.

When that happens I use git-format-patch to generate a patch file and
integrate it manually.  BLECH!  This also confuses git-cvsimport when
I try to pull upstream changes, so I end up manually resolving the
keyword conflict again at that point, i.e., twice.

Simply avoiding expanded keywords should solve the problem.  I thought
git-cvsimport -k would keep them out of my git repo, but no such luck.
Even when I use "cvs checkout -kk" for the CVS sandbox and then
"git-cvsimport -k", keywords were *still* expanded in my git repo.
(This is with both git 1.4.4.4 and git 1.5.6.)  Either the -k switch
to git-cvsimport is busted, or I'm doing something wrong.  In any case
even if this approached worked it would introduce a host of new
issues, since others on the project *are* using keyword expansion, and
the build process relies upon them.

One solution that occurs to me would be for git-cvsexportcommit to do
the dirty work of ignoring keyword mismatches for files that do not
have keywords disabled in CVS.  It seems like it is in the best
position to solve the problem---everything else is hacking around to
avoid it instead of actually solving it, which gets brittle.  So what
I'm hoping is that this lengthy discourse of mine will convince
someone to add code to git-cvsexportcommit that causes the patch
creation and application stuff inside it to ignore keyword expansion
mismatches (on files which do not have -kb on in CVS), perhaps by
simply contracting keywords on all files/patches from both CVS/git at
an early stage.

The same hack could be used in git-cvsimport to avoid the same problem
in the other direction, albeit with a little more work since keywords
that were not unexpanded in the git files would need to be re-expanded
in git to avoid gratuitous keyword-value-change patches.


Or perhaps I'm missing some other solution...?
--
Barak A. Pearlmutter
 Hamilton Institute & Dept Comp Sci, NUI Maynooth, Co. Kildare, Ireland
 http://www.bcl.hamilton.ie/~barak/
