X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] mailinfo: hack to accept in-line annotations in patches.
Date: Mon, 11 Dec 2006 17:15:48 -0800
Message-ID: <7vu001zzgb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 01:16:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34053>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtwFi-0005mZ-5I for gcvg-git@gmane.org; Tue, 12 Dec
 2006 02:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750809AbWLLBPv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 20:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWLLBPu
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 20:15:50 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:51517 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750809AbWLLBPt (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006
 20:15:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061212011548.ZFGD25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Mon, 11
 Dec 2006 20:15:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id xdFz1V00w1kojtg0000000; Mon, 11 Dec 2006
 20:16:00 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Long before git-apply, when I wanted to talk about rationale of
individual changes, I used to add annotation between hunks
(delimited @@ -n,m, +l,k @@) as unindented plain text and rely
on GNU patch to discard them as garbage.  Because git-apply is
much less forgiving than GNU patch, this is not possible.

This patch teaches mailinfo that lines that begin with a '|' would
never appear in the patch text and can be discarded safely.
Which means that we can generate a patch as usual using format-patch,
and add annotations inline, prefixed with '|'.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * I am not seriously suggesting this for inclusion but people
   might find this handy -- see the first edition of my
   git-commit documentation patch for an example (although I
   seem to have botched the hand-munge of that message).

 builtin-mailinfo.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b8d7dbc..7819be1 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -710,8 +710,11 @@ static void handle_patch(void)
 		 * here; we are dealing with the user payload.
 		 */
 		decode_transfer_encoding(line);
-		fputs(line, patchfile);
-		patch_lines++;
+
+		if (line[0] != '|') {
+			fputs(line, patchfile);
+			patch_lines++;
+		}
 	} while (fgets(line, sizeof(line), fin) != NULL);
 }
 
-- 
1.4.4.2.g7d2d-dirty

