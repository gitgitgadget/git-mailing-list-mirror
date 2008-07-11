From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] Convert CR/LF to LF in tag signatures
Date: Fri, 11 Jul 2008 18:55:57 +0200
Message-ID: <1215795357-4478-1-git-send-email-prohaska@zib.de>
References: <200807022046.28141.johannes.sixt@telecom.at>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Jul 11 18:58:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHLwH-0004iX-Gj
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 18:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbYGKQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 12:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbYGKQ4l
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 12:56:41 -0400
Received: from mailer.zib.de ([130.73.108.11]:59285 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754123AbYGKQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 12:56:40 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6BGtvNV028287;
	Fri, 11 Jul 2008 18:56:02 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6BGtv3O011185;
	Fri, 11 Jul 2008 18:55:57 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <200807022046.28141.johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88144>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, gpg outputs CR/LF signatures.  But since the tag messages
are already stripped of the CR by stripspace(), it is arguably nicer
to do the same for the tag signature.  Actually, this patch does not
look for CR/LF, but strips all CRs from the signature.  It does so not
only on Windows but on all platforms to keep the code simpler.

[ spr: ported code to use strbuf ]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 builtin-tag.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 3c97c69..a70922b 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -202,6 +202,7 @@ static int do_sign(struct strbuf *buffer)
 	const char *args[4];
 	char *bracket;
 	int len;
+	int i, j;
 
 	if (!*signingkey) {
 		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
@@ -241,6 +242,15 @@ static int do_sign(struct strbuf *buffer)
 	if (finish_command(&gpg) || !len || len < 0)
 		return error("gpg failed to sign the tag");
 
+	/* Strip CR from the line endings, in case we are on Windows. */
+	for (i = j = 0; i < buffer->len; i++)
+		if (buffer->buf[i] != '\r') {
+			if (i != j)
+				buffer->buf[j] = buffer->buf[i];
+			j++;
+		}
+	strbuf_setlen(buffer, j);
+
 	return 0;
 }
 
-- 
1.5.6.1.282.gd8a0d
