From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH 1/2] Make send_sideband() return void
Date: Tue, 14 Jun 2016 16:49:16 +0200
Message-ID: <20160614144917.14163-1-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 16:49:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCpf4-0007U9-SX
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 16:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbcFNOtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 10:49:25 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:23458 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbcFNOtY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 10:49:24 -0400
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 8a4d7bd5
	TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO
	for <git@vger.kernel.org>;
	Tue, 14 Jun 2016 16:49:19 +0200 (CEST)
X-Mailer: git-send-email 2.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297297>

The send_sideband() function uses write_or_die() for writing data which
immediately terminates the process on errors. If no such error occurred,
send_sideband() always returned the value that was passed as fourth
parameter prior to this commit. This value is already known to the
caller in any case, so let's turn send_sideband() into a void function
instead.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
 sideband.c    | 4 +---
 sideband.h    | 2 +-
 upload-pack.c | 6 ++++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sideband.c b/sideband.c
index 0a078c3..9504429 100644
--- a/sideband.c
+++ b/sideband.c
@@ -90,9 +90,8 @@ int recv_sideband(const char *me, int in_stream, int out)
  * fd is connected to the remote side; send the sideband data
  * over multiplexed packet stream.
  */
-ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max)
+void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max)
 {
-	ssize_t ssz = sz;
 	const char *p = data;
 
 	while (sz) {
@@ -114,5 +113,4 @@ ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet
 		p += n;
 		sz -= n;
 	}
-	return ssz;
 }
diff --git a/sideband.h b/sideband.h
index e46bed0..7a8146f 100644
--- a/sideband.h
+++ b/sideband.h
@@ -5,6 +5,6 @@
 #define SIDEBAND_REMOTE_ERROR -1
 
 int recv_sideband(const char *me, int in_stream, int out);
-ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
+void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_max);
 
 #endif
diff --git a/upload-pack.c b/upload-pack.c
index 56d101f..cab71b1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -67,8 +67,10 @@ static void reset_timeout(void)
 
 static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 {
-	if (use_sideband)
-		return send_sideband(1, fd, data, sz, use_sideband);
+	if (use_sideband) {
+		send_sideband(1, fd, data, sz, use_sideband);
+		return sz;
+	}
 	if (fd == 3)
 		/* emergency quit */
 		fd = 2;
-- 
2.8.3
