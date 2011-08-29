From: <trast@student.ethz.ch>
Subject: [PATCH] Use memmove in ident_to_git
Date: Mon, 29 Aug 2011 22:06:04 +0200
Message-ID: <c9efd696eb2361246b06008985013ebe68511f8d.1314648121.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Pierre Habouzit <madcoder@debian.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 22:06:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy861-0003DD-UN
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab1H2UGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:06:09 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:55456 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754795Ab1H2UGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:06:08 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:06:05 +0200
Received: from localhost.localdomain (129.132.153.219) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 22:06:05 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180337>

From: Thomas Rast <trast@student.ethz.ch>

convert_to_git sets src=dst->buf if any of the preceding conversions
actually did any work.  Thus in ident_to_git we have to use memmove
instead of memcpy as far as src->dst copying is concerned.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Valgrind intermittently detected this for me in t0021, hence the
patch.  As far as I'm aware it has been broken since the rewrite to
memcpy back in 5ecd293 (Rewrite convert_to_{git,working_tree} to use
strbuf's., 2007-09-16).  It probably never really mattered as all
involved copies are towards lower addresses (content is only removed)
and thus a straightforward memcpy operation will do the right thing by
accident.

 convert.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/convert.c b/convert.c
index 416bf83..3bb5a4d 100644
--- a/convert.c
+++ b/convert.c
@@ -533,7 +533,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 		dollar = memchr(src, '$', len);
 		if (!dollar)
 			break;
-		memcpy(dst, src, dollar + 1 - src);
+		memmove(dst, src, dollar + 1 - src);
 		dst += dollar + 1 - src;
 		len -= dollar + 1 - src;
 		src  = dollar + 1;
@@ -553,7 +553,7 @@ static int ident_to_git(const char *path, const char *src, size_t len,
 			src  = dollar + 1;
 		}
 	}
-	memcpy(dst, src, len);
+	memmove(dst, src, len);
 	strbuf_setlen(buf, dst + len - buf->buf);
 	return 1;
 }
-- 
1.7.7.rc0.370.gdcae57
