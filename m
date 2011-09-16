From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/2] check_expirations: don't copy over same element
Date: Fri, 16 Sep 2011 13:51:35 +0200
Message-ID: <29010bf6134beb20efca498e7b4f7a9d9bdb21a6.1316173346.git.trast@student.ethz.ch>
References: <a6397f7f28a5adcd34aeac98cca6500e336698aa.1316173346.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 16 13:51:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4WxO-0001mg-3O
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 13:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab1IPLvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 07:51:40 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34918 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353Ab1IPLvj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 07:51:39 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 16 Sep
 2011 13:51:35 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.339.1; Fri, 16 Sep
 2011 13:51:36 +0200
X-Mailer: git-send-email 1.7.7.rc1.366.ge210a6
In-Reply-To: <a6397f7f28a5adcd34aeac98cca6500e336698aa.1316173346.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181530>

The credentials expiry loop looks at a credential, and if it's
expired, frees it and memcpy()s the last credential in the now free
place.

This results in a memcpy() with source=destination, which technically
yields undefined behaviour.  Instead of turning it into a memmove,
don't copy anything if we deleted the last entry.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Valgrind complained.  Sorry for not running it earlier when we were
discussing the poll issue...


 credential-cache--daemon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index d6769b1..128c5ce 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -77,7 +77,8 @@ static int check_expirations(void)
 			free(entries[i].item.unique);
 			free(entries[i].item.username);
 			free(entries[i].item.password);
-			memcpy(&entries[i], &entries[entries_nr], sizeof(*entries));
+			if (i != entries_nr)
+				memcpy(&entries[i], &entries[entries_nr], sizeof(*entries));
 			/*
 			 * Stick around 30 seconds in case a new credential
 			 * shows up (e.g., because we just removed a failed
-- 
1.7.7.rc1.366.ge210a6
