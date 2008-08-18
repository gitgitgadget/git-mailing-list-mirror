From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] unpack-trees.c: work around run-time array initialization
 flaw on IRIX 6.5
Date: Mon, 18 Aug 2008 18:09:52 -0500
Message-ID: <7e_S4wgjMk99ug7uOEQgrscrYYSl9z1jT8V-nSfW25bykfWmGi-mEA@cipher.nrlssc.navy.mil>
References: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 01:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDsZ-0003a9-6v
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 01:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbYHRXJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 19:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbYHRXJy
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 19:09:54 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47192 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbYHRXJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 19:09:53 -0400
Received: by mail.nrlssc.navy.mil id m7IN9qnR026097; Mon, 18 Aug 2008 18:09:52 -0500
In-Reply-To: <giNXZFTxzY3B65dQob7CwvwwfSKlZpw_60oz81RxU5UN3PsTT_3dMQ@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Aug 2008 23:09:52.0183 (UTC) FILETIME=[85168C70:01C90187]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92752>

The c99 MIPSpro Compiler version 7.4.4m on IRIX 6.5 does not properly
initialize run-time initialized arrays. An array which is initialized with
fewer elements than the length of the array should have the unitialized
elements initialized to zero. This compiler does perform proper
initialization when static initialization parameters are used. So, work
around this by initializing with static elements, followed by a simple
assignment.
---
 unpack-trees.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cba0aca..de7cb0b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -143,7 +143,8 @@ static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_o
 
 static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	struct cache_entry *src[5] = { ce, };
+	struct cache_entry *src[5] = { NULL, };
+	src[0] = ce;
 
 	o->pos++;
 	if (ce_stage(ce)) {
-- 
1.6.0.13.ge1c8
