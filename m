From: Greg Price <price@ksplice.com>
Subject: Re: merge ignores --no-commit in fast-forward case
Date: Fri, 18 Sep 2009 15:47:18 -0400
Message-ID: <20090918194717.GA18999@dr-wily.mit.edu>
References: <7vocpfz4gm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Sep 18 21:47:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MojQW-0005eS-98
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 21:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbZIRTrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2009 15:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbZIRTrS
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Sep 2009 15:47:18 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37960 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129AbZIRTrS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Sep 2009 15:47:18 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n8IJlJoJ021006
	for <git@vger.kernel.org>; Fri, 18 Sep 2009 15:47:19 -0400 (EDT)
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n8IJlIGK012980;
	Fri, 18 Sep 2009 15:47:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vocpfz4gm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128809>

I've hit this issue in scripts where someone has written

  if ! git merge some-branch --no-commit; then
    # deal or have the user deal
  fi

  git commit -m '...'

intending that if the merge succeeds it has left the changes from
some-branch uncommitted.  And the script works, until for some reason
some-branch is on top of HEAD.  So Tomas is not the only person who
was surprised or confused by the present behavior. =)

In this case the workaround is to add --no-ff to the command, which is
effectively what the proposed change would do automatically.

Suppose we were to make such a change in 1.7.0 or a later version.
What would the transition plan need to accomplish?  For instance,
we could print a warning every time 'merge --no-commit' does a
fast-forward, and make the change in a later version -- might that suffice?

Cheers,
Greg


PS - Here's one version of a documentation patch for #3.

>From 83282bbbd0c918016e71e4ff6fd8a823315fed0e Mon Sep 17 00:00:00 2001
From: Greg Price <price@ksplice.com>
Date: Fri, 18 Sep 2009 15:34:19 -0400
Subject: [PATCH] Document behavior of --no-commit on fast forward.

This behavior can be surprising, so document it.

Signed-off-by: Greg Price <price@ksplice.com>
---
 Documentation/merge-options.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-options.txt
b/Documentation/merge-options.txt
index adadf8e..6015e5d 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -31,7 +31,10 @@
 --no-commit::
        Perform the merge but pretend the merge failed and do
        not autocommit, to give the user a chance to inspect and
-       further tweak the merge result before committing.
+       further tweak the merge result before committing.  If the
+       merge resolved as a fast-forward, the branch pointer will
+       be updated as usual; --no-ff can be combined with this
+       option to always preserve the branch pointer.
 
 --commit::
        Perform the merge and commit the result. This option can
-- 
1.6.3.1.499.ge7b8da
