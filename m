From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Do not use GUID on dir in git init --shared=all on FreeBSD
	4.11p2
Date: Tue, 4 Mar 2008 21:20:47 +0100
Message-ID: <20080304202047.GC3295@steel.home>
References: <20080303234406.GA28158@steel.home> <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org> <20080304072519.GA3070@steel.home> <7vir02ap3b.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 21:21:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWddj-0007Ag-1S
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 21:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbYCDUUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 15:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbYCDUUv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 15:20:51 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:23311 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765675AbYCDUUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 15:20:50 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtoAegw==
Received: from tigra.home (Faa57.f.strato-dslnet.de [195.4.170.87])
	by post.webmailer.de (klopstock mo35) (RZmta 16.8)
	with ESMTP id a03f88k24JxRa6 ; Tue, 4 Mar 2008 21:20:48 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BCEEA277BD;
	Tue,  4 Mar 2008 21:20:47 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 9C45D56D24; Tue,  4 Mar 2008 21:20:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vir02ap3b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76132>

It does not allow changing the bit to a non-root user.
This fixes t1301-shared-repo.sh on the platform.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Junio C Hamano, Tue, Mar 04, 2008 09:08:24 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > It is a directory. The bit 02000 is S_ISGID on FreeBSD too. It just
> > does not work (now I am just observing, no coding).
> 
> IIRC, g+s on directory to make group ownership inherited was a SysVism;
> BSD did not need that as it did the sane thing by default without g+s.
> 
> Perhaps we should make it conditional.
> 

Perhaps like this (FreeBSD 4 and older).

Can someone try the change on the later versions?

 path.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/path.c b/path.c
index af27161..6f09ba2 100644
--- a/path.c
+++ b/path.c
@@ -282,8 +282,10 @@ int adjust_shared_perm(const char *path)
 			 : (shared_repository == PERM_EVERYBODY
 			    ? (S_IXGRP|S_IXOTH)
 			    : 0));
+#if !defined(__FreeBSD__) || (__FreeBSD__ > 4)
 	if (S_ISDIR(mode))
 		mode |= S_ISGID;
+#endif
 	if ((mode & st.st_mode) != mode && chmod(path, mode) < 0)
 		return -2;
 	return 0;
-- 
1.5.4.3.469.gf84e2

