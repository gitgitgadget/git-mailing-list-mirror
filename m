From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] git-name-rev: don't use printf without format
Date: Sun, 03 Aug 2008 15:44:33 +0200
Message-ID: <4895B641.1050500@lsrfire.ath.cx>
References: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl> <7vfxpnmgkc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 15:45:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPdu1-0002yS-Ow
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 15:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYHCNoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 09:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbYHCNoj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 09:44:39 -0400
Received: from india601.server4you.de ([85.25.151.105]:49150 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759AbYHCNoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 09:44:39 -0400
Received: from [10.0.1.200] (p57B7FDB1.dip.t-dialin.net [87.183.253.177])
	by india601.server4you.de (Postfix) with ESMTPSA id 5003F2F8075;
	Sun,  3 Aug 2008 15:44:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vfxpnmgkc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91239>

printf() without an explicit format string is not a good coding practise,
unless the printed string is guaranteed to not contain percent signs.  While
fixing this, we might as well combine the calls to fwrite() and printf().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-name-rev.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 7055ac3..08c8aab 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -189,6 +189,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			unsigned char sha1[40];
 			const char *name = NULL;
 			char c = *(p+1);
+			int p_len = p - p_start + 1;
 
 			forty = 0;
 
@@ -204,13 +205,10 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 			if (!name)
 				continue;
 
-			if (data->name_only) {
-				fwrite(p_start, p - p_start + 1 - 40, 1, stdout);
-				printf(name);
-			} else {
-				fwrite(p_start, p - p_start + 1, 1, stdout);
-				printf(" (%s)", name);
-			}
+			if (data->name_only)
+				printf("%.*s%s", p_len - 40, p_start, name);
+			else
+				printf("%.*s (%s)", p_len, p_start, name);
 			p_start = p + 1;
 		}
 	}
