From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH] strbuf_read: skip unnecessary strbuf_grow at eof
Date: Sun, 31 May 2015 11:16:45 -0700
Message-ID: <1433096205-14516-1-git-send-email-gjthill@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 20:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz7n6-00085V-2b
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 20:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758563AbbEaSQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 14:16:51 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36245 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758490AbbEaSQv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 14:16:51 -0400
Received: by pdjm12 with SMTP id m12so8207682pdj.3
        for <git@vger.kernel.org>; Sun, 31 May 2015 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=wds7bLTGUB2eisUyNWjlFLMrsB/yde+cuc5CrA68gMw=;
        b=CZB21OnmxCREHQS2jkbRMGBaKQrbWsTdky2usK98roCp1j2gOhStAuHjLpqehMx102
         ADj9ncbFP3i2z8mBAiI89H+tq5xZgpmVioHtqXa5s96bpO6pgLVkxt199ZvVFemk+s/9
         lvJIvzSR/GuZkFxHBVAafKyC/tmhpPJVVdhJ1QrFwLBrc4fVxKhg8oUDrnVZFVOVpXa3
         gy8wwyNa42jonEU70psambk3vTxQ5neJ2lqzgFCPU3tOIbwRk9OB8XnHhsJ0jVSIoJaO
         xbpnmkbFJoXaeZpWVUwK3IaUyXOr0L+Vqz+uDL3b6qwg5m11gMUkwpi2b+SkeZiVdzh6
         HZOw==
X-Received: by 10.70.118.5 with SMTP id ki5mr34024262pdb.6.1433096210754;
        Sun, 31 May 2015 11:16:50 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id ng13sm11858535pdb.82.2015.05.31.11.16.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 11:16:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.4.gfc728c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270344>

Make strbuf_read not try to do read_in_full's job too.  If xread returns
less than was requested it can be either eof or an interrupted read.  If
read_in_full returns less than was requested, it's eof. Use read_in_full
to detect eof and not iterate when eof has been seen.

Signed-off-by: Jim Hill <gjthill@gmail.com>
---
 strbuf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 88cafd4..c70733e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -364,19 +364,19 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 	strbuf_grow(sb, hint ? hint : 8192);
 	for (;;) {
-		ssize_t cnt;
+		ssize_t want = sb->alloc - sb->len - 1;
+		ssize_t got = read_in_full(fd, sb->buf + sb->len, want);
 
-		cnt = xread(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
-		if (cnt < 0) {
+		if (got < 0) {
 			if (oldalloc == 0)
 				strbuf_release(sb);
 			else
 				strbuf_setlen(sb, oldlen);
 			return -1;
 		}
-		if (!cnt)
+		sb->len += got;
+		if (got < want)
 			break;
-		sb->len += cnt;
 		strbuf_grow(sb, 8192);
 	}
 
-- 
2.4.1.4.gfc728c2
