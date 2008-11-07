From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/4] builtin-gc.c: use new pack_keep bitfield to detect .keep
 file existence
Date: Thu, 06 Nov 2008 19:56:39 -0600
Message-ID: <3ViIDELaxoBUGtbz27ICr9Qm3avB1LFH5UHtBEWeFrLNfT2qnYqDyA@cipher.nrlssc.navy.mil>
References: <-NKrpBlnD0U49OczAyUd7HiIBqhMblkOkU4lOc2bc9qfTrGNrwpLTg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 02:58:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyGbu-0006VZ-QO
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 02:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbYKGB4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 20:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbYKGB4u
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 20:56:50 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:59942 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbYKGB4q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 20:56:46 -0500
Received: by mail.nrlssc.navy.mil id mA71udxk017575; Thu, 6 Nov 2008 19:56:39 -0600
In-Reply-To: <-NKrpBlnD0U49OczAyUd7HiIBqhMblkOkU4lOc2bc9qfTrGNrwpLTg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Nov 2008 01:56:40.0120 (UTC) FILETIME=[13548B80:01C9407C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100279>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


I think the existing code was broken. Looks like it would only skip
counting a pack if the pack disappeared between the prepare_packed_git()
and the access() call. It never used the path it create with the .keep
extension.

-brandon


 builtin-gc.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 7af65bb..781df60 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -131,19 +131,9 @@ static int too_many_packs(void)
 
 	prepare_packed_git();
 	for (cnt = 0, p = packed_git; p; p = p->next) {
-		char path[PATH_MAX];
-		size_t len;
-		int keep;
-
 		if (!p->pack_local)
 			continue;
-		len = strlen(p->pack_name);
-		if (PATH_MAX <= len + 1)
-			continue; /* oops, give up */
-		memcpy(path, p->pack_name, len-5);
-		memcpy(path + len - 5, ".keep", 6);
-		keep = access(p->pack_name, F_OK) && (errno == ENOENT);
-		if (keep)
+		if (p->pack_keep)
 			continue;
 		/*
 		 * Perhaps check the size of the pack and count only
-- 
1.6.0.3.552.g12334
