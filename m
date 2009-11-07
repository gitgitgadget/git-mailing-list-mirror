From: Rys Sommefeldt <rys@pixeltards.com>
Subject: [cgit PATCH] Close file descriptor on error in readfile()
Date: Sat, 07 Nov 2009 02:01:16 +0000
Message-ID: <4AF4D4EC.1040806@pixeltards.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 03:08:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6aj8-000490-Im
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 03:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbZKGCIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 21:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755005AbZKGCIQ
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 21:08:16 -0500
Received: from pixeltards.com ([64.22.109.241]:55286 "EHLO mail.pixeltards.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948AbZKGCIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 21:08:16 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Nov 2009 21:08:16 EST
Received: by mail.pixeltards.com (Postfix, from userid 1009)
	id D897E1037A; Sat,  7 Nov 2009 02:01:16 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on pixeltards.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.4
Received: from [192.168.2.3] (87-194-178-245.bethere.co.uk [87.194.178.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.pixeltards.com (Postfix) with ESMTPSA id B5CB810379
	for <git@vger.kernel.org>; Sat,  7 Nov 2009 02:01:15 +0000 (GMT)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132349>

Hi Lars,

My colleagues and I use cgit at work, and we've found that the scanning 
process can consume all available fds pretty quickly on our cgit hosts, 
because it doesn't close them properly on error.  We have a few thousand 
active repositories for cgit to scan, and we noticed it dying after a 
certain amount.

I've attached a patch which should apply against current master, 
although I developed it a while back on an older 0.8 version (sorry it 
took so long to subscribe and send the patch in).

Cheers,

Rys Sommefeldt
---

 From 6446cf839d2104cd40848e439bf97cd7fd6ccfee Mon Sep 17 00:00:00 2001
From: Rys Sommefeldt <rsommefeldt@plus.net>
Date: Fri, 6 Nov 2009 17:14:56 +0000
Subject: [PATCH] Close fd when done

---
 shared.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/shared.c b/shared.c
index d7b2d5a..d5e54e6 100644
--- a/shared.c
+++ b/shared.c
@@ -404,14 +404,19 @@ int readfile(const char *path, char **buf, size_t 
*size)
     struct stat st;
 
     fd = open(path, O_RDONLY);
-    if (fd == -1)
+    if (fd == -1) {
+        close(fd);
         return errno;
-    if (fstat(fd, &st))
+    }
+    if (fstat(fd, &st)) {
+        close(fd);
         return errno;
+    }
     if (!S_ISREG(st.st_mode))
         return EISDIR;
     *buf = xmalloc(st.st_size + 1);
     *size = read_in_full(fd, *buf, st.st_size);
     (*buf)[*size] = '\0';
+    close(fd);
     return (*size == st.st_size ? 0 : errno);
 }
-- 
1.6.5.2
