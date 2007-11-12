From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Update the tracking references only if they were
	succesfully updated on remote
Date: Mon, 12 Nov 2007 22:39:38 +0100
Message-ID: <20071112213938.GC2918@steel.home>
References: <20071112213823.GB2918@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 22:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irh0e-000851-Kx
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbXKLVjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbXKLVjl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:39:41 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:47213 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbXKLVjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:39:40 -0500
Received: from tigra.home (Faf31.f.strato-dslnet.de [195.4.175.49])
	by post.webmailer.de (fruni mo27) (RZmta 14.0)
	with ESMTP id k021b2jACI6ihg ; Mon, 12 Nov 2007 22:39:38 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5FE28277AE;
	Mon, 12 Nov 2007 22:39:38 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4841A56D22; Mon, 12 Nov 2007 22:39:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071112213823.GB2918@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOR49Q==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64715>

It fixes the bug where local tracing branches were filled with zeroed SHA-1
if the remote branch was not updated because, for instance, it was not
an ancestor of the local (i.e. had other changes).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Jeff, I think your change (334f4831e5a77) was either not complete or
got broken some time later.

 send-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index b74fd45..d56d980 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -349,7 +349,8 @@ static int send_pack(int in, int out, struct remote *remote, int nr_refspec, cha
 
 	if (!dry_run && remote && ret == 0) {
 		for (ref = remote_refs; ref; ref = ref->next)
-			update_tracking_ref(remote, ref);
+			if (!is_null_sha1(ref->new_sha1))
+				update_tracking_ref(remote, ref);
 	}
 
 	if (!new_refs && ret == 0)
-- 
1.5.3.5.648.g1e92c
