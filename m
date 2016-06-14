From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH 2/2] Make send_client_data() return void
Date: Tue, 14 Jun 2016 16:49:17 +0200
Message-ID: <20160614144917.14163-2-lfleischer@lfos.de>
References: <20160614144917.14163-1-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 16:49:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCpf5-0007U9-FV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 16:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcFNOt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 10:49:29 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:23458 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbcFNOt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 10:49:27 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id ed4a09f5
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO
	for <git@vger.kernel.org>;
	Tue, 14 Jun 2016 16:49:20 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160614144917.14163-1-lfleischer@lfos.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297296>

The send_client_data() function uses write_or_die() for writing data
which immediately terminates the process on errors. If no such error
occurred, send_client_data() always returned the value that was passed
as third parameter prior to this commit. This value is already known to
the caller in any case, so let's turn send_client_data() into a void
function instead.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 upload-pack.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index cab71b1..432d585 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -65,11 +65,11 @@ static void reset_timeout(void)
 	alarm(timeout);
 }
 
-static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
+static void send_client_data(int fd, const char *data, ssize_t sz)
 {
 	if (use_sideband) {
 		send_sideband(1, fd, data, sz, use_sideband);
-		return sz;
+		return;
 	}
 	if (fd == 3)
 		/* emergency quit */
@@ -77,10 +77,9 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 	if (fd == 2) {
 		/* XXX: are we happy to lose stuff here? */
 		xwrite(fd, data, sz);
-		return sz;
+		return;
 	}
 	write_or_die(fd, data, sz);
-	return sz;
 }
 
 static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
@@ -245,9 +244,7 @@ static void create_pack_file(void)
 			}
 			else
 				buffered = -1;
-			sz = send_client_data(1, data, sz);
-			if (sz < 0)
-				goto fail;
+			send_client_data(1, data, sz);
 		}
 
 		/*
@@ -274,9 +271,7 @@ static void create_pack_file(void)
 	/* flush the data */
 	if (0 <= buffered) {
 		data[0] = buffered;
-		sz = send_client_data(1, data, 1);
-		if (sz < 0)
-			goto fail;
+		send_client_data(1, data, 1);
 		fprintf(stderr, "flushed.\n");
 	}
 	if (use_sideband)
-- 
2.8.3
