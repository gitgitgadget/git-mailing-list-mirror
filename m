From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix update-index --refresh for submodules if stat(2)
	returns st_size 0
Date: Mon, 21 Jul 2008 19:35:11 +0200
Message-ID: <20080721173511.GB5387@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 19:36:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKzJ1-0005P0-Af
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 19:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbYGURfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 13:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbYGURfP
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 13:35:15 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:60231 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbYGURfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 13:35:14 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20hf4EbVSQ==
Received: from tigra.home (Faa8f.f.strato-dslnet.de [195.4.170.143])
	by post.webmailer.de (klopstock mo24) (RZmta 16.47)
	with ESMTP id v0237ak6LH61ez ; Mon, 21 Jul 2008 19:35:11 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 75BA6277BD;
	Mon, 21 Jul 2008 19:35:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2FA3E56D2A; Mon, 21 Jul 2008 19:35:11 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89370>

For example - Cygwin.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Can MSys folks please try it? I noticed it when the test
t2103-update-index-ignore-missing.sh (the 5th case) started failing.

 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index a50a851..eb30c20 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -281,7 +281,7 @@ int ie_modified(const struct index_state *istate,
 	 * the length field is zero.  For other cases the ce_size
 	 * should match the SHA1 recorded in the index entry.
 	 */
-	if ((changed & DATA_CHANGED) && ce->ce_size != 0)
+	if ((changed & DATA_CHANGED) && (ce->ce_size != 0 || S_ISGITLINK(ce->ce_mode)))
 		return changed;
 
 	changed_fs = ce_modified_check_fs(ce, st);
-- 
1.5.6.4.452.g7b2a
