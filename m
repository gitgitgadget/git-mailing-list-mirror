From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: fact-import: failed to apply delta
Date: Wed, 11 Feb 2009 10:15:30 -0800
Message-ID: <20090211181530.GO30949@spearce.org>
References: <20090210191220.GT30949@spearce.org> <alpine.LNX.1.00.0902101427300.19665@iabervon.org> <20090210201203.GU30949@spearce.org> <alpine.LNX.1.00.0902101520240.19665@iabervon.org> <20090210212539.GV30949@spearce.org> <alpine.LNX.1.00.0902101628140.19665@iabervon.org> <20090210213612.GW30949@spearce.org> <7vprhqkjrr.fsf@gitster.siamese.dyndns.org> <7vfxillxiu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0902111247300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:17:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJdt-000446-Ln
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbZBKSPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756669AbZBKSPd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:15:33 -0500
Received: from george.spearce.org ([209.20.77.23]:46721 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926AbZBKSPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:15:32 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id ED16F38210; Wed, 11 Feb 2009 18:15:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0902111247300.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109472>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> I think free_pack_by_name() also needs to drop the entries that are from 
> the freed pack, to avoid having repack able to get the same problem, 
> although I wouldn't be surprised if repack happened to never allocate a 
> new pack after freeing an old pack with stale delta cache entries, or 
> never used the delta cache after that, simply because it does one thing 
> and then exits.

Oy.  I missed that we added this function.  Patch follows.

--8<--
Clear the delta base cache if a pack is rebuilt

There is some risk that re-opening a regenerated pack file with
different offsets could leave stale entries within the delta base
cache that could be matched up against other objects using the same
"struct packed_git*" and pack offset.

Throwing away the entire delta base cache in this case is safer,
as we don't have to worry about a recycled "struct packed_git*"
matching to the wrong base object, resulting in delta apply
errors while unpacking an object.

Suggested-by: Daniel Barkalow <barkalow@iabervon.org>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 sha1_file.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 7459a9c..5b6e0f6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -689,6 +689,7 @@ void free_pack_by_name(const char *pack_name)
 	while (*pp) {
 		p = *pp;
 		if (strcmp(pack_name, p->pack_name) == 0) {
+			clear_delta_base_cache();
 			close_pack_windows(p);
 			if (p->pack_fd != -1)
 				close(p->pack_fd);
-- 
1.6.2.rc0.186.g417c
