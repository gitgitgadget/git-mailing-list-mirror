From: iheffner@gmail.com
Subject: [PATCH 3/3] use SIDEBAND_*_ERROR constants in pack protocol
Date: Tue, 13 Dec 2011 10:28:51 -0800
Message-ID: <1323800931-37123-4-git-send-email-iheffner@gmail.com>
References: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Cc: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>,
	"Dave Olszewski" <cxreg@pobox.com>,
	Ivan Heffner <iheffner@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 19:30:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaX77-0001io-Q4
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab1LMSaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:30:00 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55547 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab1LMS37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 13:29:59 -0500
Received: by mail-ey0-f174.google.com with SMTP id j10so1367623eaa.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=hdZLjzhVFdJL6Od4sIaJEDHOx05qG6b3rmISmzcSiQU=;
        b=JKZoBC0/8qfmcQ0sqyt1q7wYoGSgstE/xKTM3M8zBrjRBNctdyxZ7/Q328zunrAFAb
         y/zM8iUHGxYPHMYLqD4tk4s3AJMG4gEOFhndLaSDyYe4qAlwysX5rxFWywNZ8NwqdmdS
         cxyGfeTyZSduXOG1Mk4a2/lsIDjxrDsn9XUW0=
Received: by 10.204.154.208 with SMTP id p16mr13618316bkw.12.1323800999155;
        Tue, 13 Dec 2011 10:29:59 -0800 (PST)
Received: from localhost.localdomain (sea02-v612-nat.marchex.com. [174.137.113.43])
        by mx.google.com with ESMTPS id 39sm1014563eei.1.2011.12.13.10.29.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 10:29:58 -0800 (PST)
X-Mailer: git-send-email 1.7.6.553.g917d7.dirty
In-Reply-To: <1323800931-37123-1-git-send-email-iheffner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187040>

From: Ivan Heffner <iheffner@gmail.com>

Switched calls to send_sideband() for pack protocol errors to use
SIDEBAND_PROTOCOL_ERROR and SIDEBAND_REMOTE_ERROR in place of the
sideband magic numbers of -2 and -1, respectively.

Signed-off-by: Ivan Heffner <iheffner@gmail.com>
---
 builtin/fetch-pack.c |    2 +-
 builtin/send-pack.c  |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c6bc8eb..63e9ac4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -245,7 +245,7 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 static void send_request(int fd, struct strbuf *buf)
 {
 	if (args.stateless_rpc) {
-		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
+		send_sideband(fd, SIDEBAND_REMOTE_ERROR, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else
 		safe_write(fd, buf->buf, buf->len);
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index e0b8030..67c9fe5 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -96,7 +96,7 @@ static int pack_objects(int fd, struct ref *refs, struct extra_have_objects *ext
 			ssize_t n = xread(po.out, buf, LARGE_PACKET_MAX);
 			if (n <= 0)
 				break;
-			send_sideband(fd, -1, buf, n, LARGE_PACKET_MAX);
+			send_sideband(fd, SIDEBAND_REMOTE_ERROR, buf, n, LARGE_PACKET_MAX);
 		}
 		free(buf);
 		close(po.out);
@@ -320,7 +320,7 @@ int send_pack(struct send_pack_args *args,
 	if (args->stateless_rpc) {
 		if (!args->dry_run && cmds_sent) {
 			packet_buf_flush(&req_buf);
-			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
+			send_sideband(out, SIDEBAND_REMOTE_ERROR, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
 	} else {
 		safe_write(out, req_buf.buf, req_buf.len);
-- 
1.7.6.553.g917d7.dirty
