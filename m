From: Jeff Lasslett <jeff.lasslett@gmail.com>
Subject: [PATCH] Check return value of ftruncate call in http.c.  Remove possible mem leak
Date: Sat,  8 Aug 2009 15:38:01 +1000
Message-ID: <1249709881-31334-1-git-send-email-jeff.lasslett@gmail.com>
Cc: Jeff Lasslett <jeff.lasslett@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 08 07:38:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZedF-0006Ck-PT
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 07:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbZHHFiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 01:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbZHHFiJ
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 01:38:09 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:56737 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbZHHFiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 01:38:08 -0400
Received: by pzk34 with SMTP id 34so1981812pzk.4
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 22:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=7OV6y4QNm+PTCXk85NpqzHmJFnVCUXnWt4tNoqgyBPA=;
        b=f0oIaZiMXMDHilPeYuQj0Nc3QamO9ks2aWDhRZdc915bRd6WFKauLQqWJG8ia4e8y+
         ncazEDmqWhy4aM7HK5EIzzEAvQfMXGP9xVldvmIRVHQPtwZykQzkxHzc67lH3MeaAR+R
         Lc8+vP9AhKdDIi0YngFUHye0FCEaIhE/2jFME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CD8ws8tlTc2lL0TIqeHH4zPWSWwdsQAbPczGggIfrtpNO0QMb3rY8euRsFILrS9y1E
         LAKylvmpqIAxKwwl7IHT8HTQbwMxdUF+DZpACxFbK3RA3+Q8qr9DFvjskYJJIyUg83n4
         AEG6n4POLBxTIRmylLJk28VE6W/BUd3j+ug8Y=
Received: by 10.114.198.11 with SMTP id v11mr2801911waf.178.1249709888805;
        Fri, 07 Aug 2009 22:38:08 -0700 (PDT)
Received: from localhost.localdomain (CPE-58-165-23-40.vic.bigpond.net.au [58.165.23.40])
        by mx.google.com with ESMTPS id m17sm2940639waf.38.2009.08.07.22.38.06
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Aug 2009 22:38:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.59.g4d590.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125246>

In new_http_object_request(), check ftruncate() call return value and
handle possible errors.  Remove possible leak of mem pointed to by url.

Signed-off-by: Jeff Lasslett <jeff.lasslett@gmail.com>
---
 http.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index a2720d5..34a3a35 100644
--- a/http.c
+++ b/http.c
@@ -1098,7 +1098,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	char *hex = sha1_to_hex(sha1);
 	char *filename;
 	char prevfile[PATH_MAX];
-	char *url;
+	char *url = NULL;
 	int prevlocal;
 	unsigned char prev_buf[PREV_BUF_SIZE];
 	ssize_t prev_read = 0;
@@ -1189,7 +1189,11 @@ struct http_object_request *new_http_object_request(const char *base_url,
 		if (prev_posn>0) {
 			prev_posn = 0;
 			lseek(freq->localfile, 0, SEEK_SET);
-			ftruncate(freq->localfile, 0);
+			if (ftruncate(freq->localfile, 0) < 0) {
+				error("Couldn't truncate temporary file %s for %s: %s",
+					  freq->tmpfile, freq->filename, strerror(errno));
+				goto abort;
+			}
 		}
 	}
 
@@ -1216,10 +1220,12 @@ struct http_object_request *new_http_object_request(const char *base_url,
 				 CURLOPT_HTTPHEADER, range_header);
 	}
 
+	free(url);
 	return freq;
 
-	free(url);
 abort:
+	free(url);
+	free(freq->url);
 	free(filename);
 	free(freq);
 	return NULL;
-- 
1.6.4.59.g4d590.dirty
