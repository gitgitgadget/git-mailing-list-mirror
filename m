From: rogan@dawes.za.net
Subject: [PATCH] Fix type confusion in pkt-line
Date: Tue, 27 Mar 2007 03:54:07 -0700
Message-ID: <1174992847659-git-send-email-rogan@dawes.za.net>
Cc: Rogan Dawes <rogan@dawes.za.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 27 13:21:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW9jg-0001gM-Uf
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 13:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbXC0LUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 07:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753811AbXC0LUl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 07:20:41 -0400
Received: from judo.dreamhost.com ([66.33.216.100]:52564 "EHLO
	judo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbXC0LUk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 07:20:40 -0400
X-Greylist: delayed 1591 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Mar 2007 07:20:40 EDT
Received: from smarty.dreamhost.com (smarty.dreamhost.com [66.33.216.24])
	by judo.dreamhost.com (Postfix) with ESMTP id A75F4179B4D
	for <git@vger.kernel.org>; Tue, 27 Mar 2007 03:55:13 -0700 (PDT)
Received: from lucas.dreamhost.com (lucas.dreamhost.com [64.111.99.14])
	by smarty.dreamhost.com (Postfix) with ESMTP id 856A8EE249;
	Tue, 27 Mar 2007 03:54:07 -0700 (PDT)
Received: by lucas.dreamhost.com (Postfix, from userid 81257)
	id 73830784BA; Tue, 27 Mar 2007 03:54:07 -0700 (PDT)
X-Mailer: git-send-email 1.5.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43263>

From: Rogan Dawes <rogan@dawes.za.net>

We were using unsigend and signed int when we should have been
using size_t and ssize_t.

Signed-off-by: Rogan Dawes <rogan@dawes.za.net>
---
 pkt-line.c |   10 +++++-----
 pkt-line.h |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index b4cb7e2..559a944 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -63,12 +63,12 @@ void packet_write(int fd, const char *fmt, ...)
 	safe_write(fd, buffer, n);
 }
 
-static void safe_read(int fd, void *buffer, unsigned size)
+static void safe_read(int fd, void *buffer, size_t size)
 {
-	int n = 0;
+	size_t n = 0;
 
 	while (n < size) {
-		int ret = xread(fd, (char *) buffer + n, size - n);
+		ssize_t ret = xread(fd, (char *) buffer + n, size - n);
 		if (ret < 0)
 			die("read error (%s)", strerror(errno));
 		if (!ret)
@@ -77,10 +77,10 @@ static void safe_read(int fd, void *buffer, unsigned size)
 	}
 }
 
-int packet_read_line(int fd, char *buffer, unsigned size)
+ssize_t packet_read_line(int fd, char *buffer, size_t size)
 {
 	int n;
-	unsigned len;
+	size_t len;
 	char linelen[4];
 
 	safe_read(fd, linelen, 4);
diff --git a/pkt-line.h b/pkt-line.h
index 9df653f..073fcd4 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -9,7 +9,7 @@
 void packet_flush(int fd);
 void packet_write(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 
-int packet_read_line(int fd, char *buffer, unsigned size);
+ssize_t packet_read_line(int fd, char *buffer, size_t size);
 ssize_t safe_write(int, const void *, ssize_t);
 
 #endif
-- 
1.5.0.3
