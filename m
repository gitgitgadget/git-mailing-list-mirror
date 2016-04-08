From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 1/2] imap-send: check for NOLOGIN capability only when using
 LOGIN command
Date: Fri, 8 Apr 2016 23:02:24 +0900
Message-ID: <20160408140224.GB13469@chikuwa.rhe.jp>
References: <cover.1460122532.git.k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 16:02:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoWzc-0005og-BD
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 16:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732AbcDHOC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 10:02:28 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:35288 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752639AbcDHOC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 10:02:27 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 8799761B4A;
	Fri,  8 Apr 2016 14:02:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <cover.1460122532.git.k@rhe.jp>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291034>

Don't check for NOLOGIN (LOGINDISABLED) capability when imap.authMethod
is specified.

LOGINDISABLED capability doesn't forbid using AUTHENTICATE, so it should
be allowed, or we can't connect to IMAP servers which only accepts
AUTHENTICATE command.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 imap-send.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 2c52027c8445..30979f0c63cc 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1095,11 +1095,6 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 				srvc->pass = xstrdup(cred.password);
 		}
 
-		if (CAP(NOLOGIN)) {
-			fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n", srvc->user, srvc->host);
-			goto bail;
-		}
-
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
 
@@ -1123,6 +1118,11 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, char *f
 				goto bail;
 			}
 		} else {
+			if (CAP(NOLOGIN)) {
+				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
+					srvc->user, srvc->host);
+				goto bail;
+			}
 			if (!imap->buf.sock.ssl)
 				imap_warn("*** IMAP Warning *** Password is being "
 					  "sent in the clear\n");
-- 
2.8.1.104.g07d5700.dirty
