From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] refs.c: fix fread error handling
Date: Sat, 23 Mar 2013 17:16:46 +0000
Message-ID: <ba7cd71b0ac9a885bd894a0bed608cf682afed6d.1364058591.git.john@keeping.me.uk>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 18:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJS4P-0003Hj-6e
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 18:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759Ab3CWRQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 13:16:59 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:55022 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623Ab3CWRQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 13:16:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 4EDB822CBE;
	Sat, 23 Mar 2013 17:16:58 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EQ8lQybs9aP0; Sat, 23 Mar 2013 17:16:57 +0000 (GMT)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 4AB4D22B46;
	Sat, 23 Mar 2013 17:16:52 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218923>

fread returns the number of items read, with no special error return.

Commit 98f85ff (reflog: add for_each_reflog_ent_reverse() API -
2013-03-08) introduced a call to fread which checks for an error with
"nread < 0" which is tautological since nread is unsigned.  The correct
check in this case (which tries to read a single item) is "nread != 1".

Signed-off-by: John Keeping <john@keeping.me.uk>
---
I found this because Clang generated a tautological comparison warning
on this line.

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 56cc93d..de2d8eb 100644
--- a/refs.c
+++ b/refs.c
@@ -2399,7 +2399,7 @@ int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void
 			return error("cannot seek back reflog for %s: %s",
 				     refname, strerror(errno));
 		nread = fread(buf, cnt, 1, logfp);
-		if (nread < 0)
+		if (nread != 1)
 			return error("cannot read %d bytes from reflog for %s: %s",
 				     cnt, refname, strerror(errno));
 		pos -= cnt;
-- 
1.8.2.411.g65a544e
