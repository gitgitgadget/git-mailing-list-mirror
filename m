From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 09/23] remote-curl: accept empty line as terminator
Date: Sat, 16 Jul 2011 15:03:29 +0200
Message-ID: <1310821424-4750-10-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4dI-0007Zj-Rw
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab1GPNKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:10:00 -0400
Received: from mail-ey0-f171.google.com ([209.85.215.171]:33909 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755082Ab1GPNJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:09:57 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jul 2011 09:09:56 EDT
Received: by eye22 with SMTP id 22so584959eye.2
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IPWHX+pOSqldtQthkrV9KAoUAPlYt2giLM9hPRV6Nk0=;
        b=GWqFPGJNappcnztpx5oZ8MzSG/8SYnQGZ+plVws+ExOIkEVRajNCIs53xg/N1XswG3
         57mw2gUebm2/7NIHHOFC9Hv7+I8M5P3XusdplZhCZZf54YosDgaA2tSI1Wo4DEukkB9m
         iuCTk67NVhW4k7OShnSuZ06fVjaTkE6b8Te2I=
Received: by 10.213.8.135 with SMTP id h7mr593360ebh.108.1310821480686;
        Sat, 16 Jul 2011 06:04:40 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177273>

This went unnoticed because the transport helper infrastructore did
not check the return value of the helper, nor did the helper print
anything before exiting.

While at it also make sure that the stream doesn't end unexpectedly.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Added the 'check fo unexpected EOF' chunk.

 remote-curl.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index b5be25c..30554f4 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -857,7 +857,14 @@ int main(int argc, const char **argv)
 	http_init(remote);
 
 	do {
-		if (strbuf_getline(&buf, stdin, '\n') == EOF)
+		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
+			if (ferror(stdin))
+				fprintf(stderr, "Error reading command stream\n");
+			else
+				fprintf(stderr, "Unexpected end of command stream\n");
+			return 1;
+		}
+		if (buf.len == 0)
 			break;
 		if (!prefixcmp(buf.buf, "fetch ")) {
 			if (nongit)
@@ -897,6 +904,7 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else {
+			fprintf(stderr, "Unknown command '%s'\n", buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
-- 
1.7.5.1.292.g728120
