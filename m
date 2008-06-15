From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/4 v2] Prepare testsuite for a "git clone" that packs refs
Date: Mon, 16 Jun 2008 01:16:53 +0200
Message-ID: <200806160116.53446.johan@herland.net>
References: <200806151602.03445.johan@herland.net>
 <20080615175418.GB6127@sigill.intra.peff.net>
 <m3bq22poby.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 01:18:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K81UO-0002mM-Sh
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 01:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYFOXR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 19:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbYFOXR3
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 19:17:29 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36293 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbYFOXR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 19:17:28 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2J00J0J2134C00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 16 Jun 2008 01:17:27 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2J00AM8205GW00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 16 Jun 2008 01:16:53 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2J007Z3205M750@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 16 Jun 2008 01:16:53 +0200 (CEST)
In-reply-to: <m3bq22poby.fsf@localhost.localdomain>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85151>

t5515-fetch-merge-logic removes many, but not all, refs between each test.
This is done by removing the corresponding refs/foo/* files in the .git/refs
hierarchy. However, once "git clone" starts producing packed refs, these refs
will no longer be in the .git/refs hierarchy, but rather listed in
.git/packed-refs. This patch teaches t5515-fetch-merge-logic to remove the
refs using "git update-ref -d" which properly handles packed refs.

Signed-off-by: Johan Herland <johan@herland.net>
---

On Sunday 15 June 2008, Jakub Narebski wrote:
> Jeff King <peff@peff.net> writes:
> > Might it not be simpler to just convert it to use plumbing to delete
> > the refs? Something like piping for-each-ref into update-ref -d?
>
> Or use git-for-each-ref with --shell option to generate code for
> deleting refs?

Thanks for the tip. The following seems to do the job, and looks much better.


Have fun! :)

...Johan

 t/t5515-fetch-merge-logic.sh |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
index 3def75e..9de8408 100755
--- a/t/t5515-fetch-merge-logic.sh
+++ b/t/t5515-fetch-merge-logic.sh
@@ -142,9 +142,12 @@ do
 			set x $cmd; shift
 			git symbolic-ref HEAD refs/heads/$1 ; shift
 			rm -f .git/FETCH_HEAD
-			rm -f .git/refs/heads/*
-			rm -f .git/refs/remotes/rem/*
-			rm -f .git/refs/tags/*
+			git for-each-ref --format="%(refname)" \
+				refs/heads refs/remotes/rem refs/tags | \
+			while read refname
+			do
+				git update-ref -d "$refname"
+			done
 			git fetch "$@" >/dev/null
 			cat .git/FETCH_HEAD
 		} >"$actual_f" &&
-- 
1.5.6.rc2.128.gf64ae
