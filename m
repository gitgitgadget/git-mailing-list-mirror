From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] sha1_name.c: avoid unnecessary strbuf_release
Date: Thu, 16 Jul 2009 16:25:19 -0500
Message-ID: <W0GiRm9n1NEfjVB8xBotan7WQ5BVS-0Yy_3hikrJN4b57ORvs0sreBFZFVMQljOVkzTQg_oO16A@cipher.nrlssc.navy.mil>
References: <W0GiRm9n1NEfjVB8xBotanSRY89hxjLPu3Wksn_EsZusMJjkHNIRf8JuQmUh43ny21xTKBn1Li8@cipher.nrlssc.navy.mil> <W0GiRm9n1NEfjVB8xBotapRpIoR0jr6qkttRpkkGMPpe-bfqtvLM7YBvkMsGo7-vheQxRPBUAEU@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 16 23:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRYTR-0001ME-Qb
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 23:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933426AbZGPVZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 17:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933425AbZGPVZr
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 17:25:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53030 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933421AbZGPVZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 17:25:46 -0400
Received: by mail.nrlssc.navy.mil id n6GLPgvg017334; Thu, 16 Jul 2009 16:25:42 -0500
In-Reply-To: <W0GiRm9n1NEfjVB8xBotapRpIoR0jr6qkttRpkkGMPpe-bfqtvLM7YBvkMsGo7-vheQxRPBUAEU@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 16 Jul 2009 21:25:42.0113 (UTC) FILETIME=[F8E68D10:01CA065B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123428>

From: Brandon Casey <drafnel@gmail.com>

When we fall back to a standard for_each_reflog_ent() after failing to find
the nth branch switch (or if we had a short reflog) with the call to
for_each_recent_reflog_ent(), we do not need to free the memory allocated
for our strbuf's since a strbuf_reset() will be performed in
grab_nth_branch_switch() before assigning to the entry.

Plus, the strbuf_release() negates the non-zero hint we initially gave to
strbuf_init() just above these lines.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 sha1_name.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 904bcd9..44bb62d 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -777,8 +777,6 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	for_each_recent_reflog_ent("HEAD", grab_nth_branch_switch, 40960, &cb);
 	if (cb.cnt < nth) {
 		cb.cnt = 0;
-		for (i = 0; i < nth; i++)
-			strbuf_release(&cb.buf[i]);
 		for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
 	}
 	if (cb.cnt < nth)
-- 
1.6.3.1.24.g152f4
