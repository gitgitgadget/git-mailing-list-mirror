From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Do not use ctime if file mode is not used
Date: Thu, 24 Jul 2008 21:00:56 +0200
Message-ID: <20080724190056.GA3677@blimp.local>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org> <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local> <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:15:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM7DK-00081n-Bv
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 22:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYGXUOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 16:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYGXUN7
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 16:13:59 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:8210 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbYGXUN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 16:13:57 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20pf40K7
Received: from tigra.home (Fac14.f.strato-dslnet.de [195.4.172.20])
	by post.webmailer.de (fruni mo21) (RZmta 16.47)
	with ESMTP id 601fcck6OHDWfX ; Thu, 24 Jul 2008 22:13:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id E681F277BD;
	Thu, 24 Jul 2008 22:13:53 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 90B2736D19; Thu, 24 Jul 2008 21:00:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr69lihkt.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89955>

On some file systems, the only part of inode information we need
(executable) cannot be used, so ctime can be ignored as well. Change
time is updated when file attributes were changed (or it is written
to, but in this case, mtime is updated as well).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Wed, Jul 23, 2008 02:12:50 +0200:
> > I had that at first (NO_DEPENDABLE_CTIME, than IGNORE_CTIME), than
> > deemed it excessive.
> 
> Why is it excessive?  My initial reaction was "what does trustable
> filemode nor trust_executable_bit has anything to do with ctime".  Please
> explain.

You know, you have a good point... (and I'm sometimes really stupid)
Of course it depends on the underlying filesystem!

The updated patch is untested yet, but should be obviously correct.

BTW, any idea how to check if all callers of ce_match_stat_basic have
read the configuration? It is not that essential to have
trust_executable_bit set correctly, though. In worst case an index
entry will be marked not up-to-date.

 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a50a851..f2fa0d9 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -181,7 +181,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime != (unsigned int) st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (ce->ce_ctime != (unsigned int) st->st_ctime)
+	if (trust_executable_bit && ce->ce_ctime != (unsigned int) st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 	if (ce->ce_uid != (unsigned int) st->st_uid ||
-- 
1.6.0.rc0.70.g5aae9
