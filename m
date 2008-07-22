From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Build configuration to skip ctime for modification test
Date: Tue, 22 Jul 2008 21:39:01 +0200
Message-ID: <20080722193901.GA5113@blimp.local>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <7vy73tltf5.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 21:40:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLNiV-0003Nc-Bi
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 21:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbYGVTjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 15:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbYGVTjI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 15:39:08 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:41772 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbYGVTjG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 15:39:06 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jepV
Received: from tigra.home (Fa955.f.strato-dslnet.de [195.4.169.85])
	by post.webmailer.de (klopstock mo6) (RZmta 16.47)
	with ESMTP id z03849k6MGmDwf ; Tue, 22 Jul 2008 21:39:02 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 2751D277BD;
	Tue, 22 Jul 2008 21:39:02 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id ED18036D17; Tue, 22 Jul 2008 21:39:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy73tltf5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89515>

On Windows, the only file attribute we need (executable) cannot be
used, so ctime can be ignored as well. Change time is updated when
file attributes were changed (or it is written to, but in this case,
mtime is updated as well).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Tue, Jul 22, 2008 19:28:46 +0200:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
> >> +	if ((changed & DATA_CHANGED) && (ce->ce_size != 0 || S_ISGITLINK(ce->ce_mode)))
> >
> > Does this mean that ce->ce_size is non-zero for gitlinks, at least on
> > Unix? Is this value useful in anyway? I don't think so. Then it shouldn't
> > be a random value that lstat() happens to return.
> 
> These ce_xxx fields are the values we read from lstat(2) when the user
> told us to stage that working tree entity, be it a regular file, a
> symlink, or a directory that is a submodule.  The only thing required for
> them is that they are stable (i.e. if you haven't touched the working tree
> entity, the value stays the same), and changes across modification.  The
> value itself does not have to "mean" anything.

This reminds me... We can't use the only file attribute we care about
on Windows, so we can as well skip check for ctime. Besides, Google
Desktop Search keeps changing ctime when crawling files (ok, GDS is a
major usability nuance anyway, but the point is - we don't use the
file attribute).

 read-cache.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a50a851..c4f2718 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -181,8 +181,10 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime != (unsigned int) st->st_mtime)
 		changed |= MTIME_CHANGED;
+#ifndef NO_TRUSTABLE_FILEMODE
 	if (ce->ce_ctime != (unsigned int) st->st_ctime)
 		changed |= CTIME_CHANGED;
+#endif
 
 	if (ce->ce_uid != (unsigned int) st->st_uid ||
 	    ce->ce_gid != (unsigned int) st->st_gid)
-- 
1.6.0.rc0.41.g70446
