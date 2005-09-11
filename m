From: Qingning Huo <qhuo@mayhq.co.uk>
Subject: [PATCH] Fix buffer overflow in ce_flush().
Date: Sun, 11 Sep 2005 14:27:47 +0100
Message-ID: <20050911132747.GA26401@mayhq.zapto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 15:28:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EERsJ-00057m-RZ
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 15:28:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVIKN2A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 09:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbVIKN2A
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 09:28:00 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:15331 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750813AbVIKN17 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 09:27:59 -0400
Received: from aamta12-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050911132750.IODJ9239.mta09-winn.ispmail.ntl.com@aamta12-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Sun, 11 Sep 2005 14:27:50 +0100
Received: from mayhq.zapto.org ([82.2.192.87])
          by aamta12-winn.ispmail.ntl.com with SMTP
          id <20050911132750.UNMH24380.aamta12-winn.ispmail.ntl.com@mayhq.zapto.org>
          for <git@vger.kernel.org>; Sun, 11 Sep 2005 14:27:50 +0100
Received: (qmail 26416 invoked by uid 1000); 11 Sep 2005 13:27:47 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8294>

Fix buffer overflow in ce_flush().

Add a check before appending SHA1 signature to write_buffer,
flush it first if necessary.

---

 read-cache.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

ca84fa808ba3a314d3d9ea5cfb7b8c2462249ca3
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -462,6 +462,13 @@ static int ce_flush(SHA_CTX *context, in
 		SHA1_Update(context, write_buffer, left);
 	}
 
+	/* Flush first if not enough space for SHA1 signature */
+	if (left + 20 > WRITE_BUFFER_SIZE) {
+		if (write(fd, write_buffer, left) != left)
+			return -1;
+		left = 0;
+	}
+
 	/* Append the SHA1 signature at the end */
 	SHA1_Final(write_buffer + left, context);
 	left += 20;
