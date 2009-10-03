From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 5/7] imap-send: provide fall-back random-source
Date: Sat,  3 Oct 2009 00:39:43 +0000
Message-ID: <1254530385-2824-5-git-send-email-kusmabite@gmail.com>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-2-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-3-git-send-email-kusmabite@gmail.com>
 <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Sat Oct 03 02:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtsfd-0004T7-K2
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 02:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbZJCAkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 20:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbZJCAkK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 20:40:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:43951 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbZJCAkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 20:40:09 -0400
Received: by qw-out-2122.google.com with SMTP id 3so587565qwe.37
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 17:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Lm+NEmy97L2BFjw/9Uz6TCAAZY4XBj3LYuscuR63Hr8=;
        b=APJTBI/ZRAJ/R/4Nvy2DiW4vYU6/qF5yw4GvTt52h/1n7Coi2XXL80SGUJbjnnkpEG
         CpNBJFb7M+uSDPpex1txOJo8hDdzEa7GE2tfdbQ0Lg1oPDoRvggJ9FS6T6mXqvlVgUrb
         WD+oAINskcw5ErAeAfWS1o0kAfk+kL2nES9R8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NRYDmk9IeQkQUru9mRk+/22yhcXgQMumi3dNM+HwWGgpBxMOEo6XbxO95YEB17WVOu
         vvBcrqJshcuKT5h05xlGhgMF3yDdYToW0hQbdGU7KIdThxbvSp5QYtgEIz2PY+yhu5xQ
         Xej09VTgEg+VLLAJDTzOPfSiqZIpRpzl7uWXI=
Received: by 10.224.81.195 with SMTP id y3mr1656772qak.82.1254530413953;
        Fri, 02 Oct 2009 17:40:13 -0700 (PDT)
Received: from localhost ([75.35.230.210])
        by mx.google.com with ESMTPS id 22sm308803qyk.6.2009.10.02.17.40.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 17:40:13 -0700 (PDT)
X-Mailer: git-send-email 1.6.4
In-Reply-To: <1254530385-2824-4-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129475>

Since some systems (at least Windows) does not have
/dev/random nor friends, we need another random-source.

This patch uses the C-runtime's rand()-function as a
poor-mans random-source.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 imap-send.c |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 8338717..dda7b7f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -511,14 +511,17 @@ static void arc4_init(void)
 	unsigned char j, si, dat[128];
 
 	if ((fd = open("/dev/urandom", O_RDONLY)) < 0 && (fd = open("/dev/random", O_RDONLY)) < 0) {
-		fprintf(stderr, "Fatal: no random number source available.\n");
-		exit(3);
-	}
-	if (read_in_full(fd, dat, 128) != 128) {
-		fprintf(stderr, "Fatal: cannot read random number source.\n");
-		exit(3);
+		/* poor-mans random-source */
+		srand(clock());
+		for (i = 0; i < 128; ++i)
+			dat[i] = rand() & 0xFF;
+	} else {
+		if (read_in_full(fd, dat, 128) != 128) {
+			fprintf(stderr, "Fatal: cannot read random number source.\n");
+			exit(3);
+		}
+		close(fd);
 	}
-	close(fd);
 
 	for (i = 0; i < 256; i++)
 		rs.s[i] = i;
-- 
1.6.5.rc2.7.g4f8d3
