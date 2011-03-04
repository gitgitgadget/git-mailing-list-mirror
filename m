From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] transport-helper.c: fix check for size_t < 0
Date: Fri, 4 Mar 2011 20:28:34 +0100
Organization: -
Message-ID: <20110304202834.2e74d56d@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 21:06:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvbGD-0004ZV-9I
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 21:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760148Ab1CDUFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 15:05:46 -0500
Received: from webhosting01.bon.m2soft.com ([195.38.20.32]:44813 "EHLO
	webhosting01.bon.m2soft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760145Ab1CDUFp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 15:05:45 -0500
X-ClientAddr: 85.127.41.184
Received: from absol.kitzblitz (85-127-41-184.dynamic.xdsl-line.inode.at [85.127.41.184])
	(authenticated bits=0)
	by webhosting01.bon.m2soft.com (8.13.8/8.13.8) with ESMTP id p24JCdjW025425;
	Fri, 4 Mar 2011 20:12:40 +0100
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Claws Mail (Linux)
X-m2soft-MailScanner-Information: Please contact the ISP for more information
X-m2soft-MailScanner-ID: p24JCdjW025425
X-m2soft-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-m2soft-MailScanner-From: nikai@nikai.net
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168464>

'bytes' is unsigned of type size_t, and can't be negative.
But the assigned write() returns ssize_t, and -1 on error.
For testing < 0, 'bytes' needs to be of a signed type.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---
Testsuite did not regress at my place.

 transport-helper.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4e4754c..710b6f1 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -973,7 +973,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
  */
 static int udt_do_write(struct unidirectional_transfer *t)
 {
-	size_t bytes;
+	int bytes;
 
 	if (t->bufuse == 0)
 		return 0;	/* Nothing to write. */
@@ -989,7 +989,7 @@ static int udt_do_write(struct unidirectional_transfer *t)
 		if (t->bufuse)
 			memmove(t->buf, t->buf + bytes, t->bufuse);
 		transfer_debug("Wrote %i bytes to %s (buffer now at %i)",
-			(int)bytes, t->dest_name, (int)t->bufuse);
+			bytes, t->dest_name, (int)t->bufuse);
 	}
 	return 0;
 }
-- 
1.7.3.4
