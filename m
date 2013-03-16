From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] safe_create_leading_directories: fix race that could give a false negative
Date: Sat, 16 Mar 2013 15:30:56 -0400
Message-ID: <1363462256-5823-1-git-send-email-stevenrwalter@gmail.com>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 20:31:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGwpI-0005YA-PA
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab3CPTbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 15:31:05 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:44593 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112Ab3CPTbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 15:31:04 -0400
Received: by mail-vc0-f176.google.com with SMTP id ib11so2020026vcb.7
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 12:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=cM5Uujzbvstljo6cfOrS3hLc/sWVRnKYlqGu9ut5m0w=;
        b=RJVhzSDJ459FIQufnzqK37QUO4p5bxpmajI/VPaI3jPybOm6+IVqkC2IM3JGx+9ipo
         EDaAl5opX0+mML7DZ6BN8MoVoyi0zO6WsCoGuaaDQpJj7Gflk+uEWRccBDwSXfMZEMOc
         /O0wr/dQP/pvWhW0DVJ0mdDFqaqdsJTHnEXFezUpSPcdfb+Xoy6+xUQdtbe9zQvWeURN
         71y4ab43gjuu0sF4gUfzQEUaQflUnq8i3/XBROL0KRwoOPtjy5ata1X5cdirf5OMcNAa
         75C4+SUmiaRewBywX3IWlMSzr5m6Kw6YiQLIcw5tt2ErKiSkrBESPR20ITmI3Y5QhtyI
         SgCg==
X-Received: by 10.58.48.166 with SMTP id m6mr12833510ven.59.1363462262428;
        Sat, 16 Mar 2013 12:31:02 -0700 (PDT)
Received: from brock ([2001:470:8:a2c:69b1:30bb:527e:19cb])
        by mx.google.com with ESMTPS id q5sm11891618vdj.5.2013.03.16.12.31.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 12:31:01 -0700 (PDT)
Received: by brock (Postfix, from userid 1000)
	id 542392606D9; Sat, 16 Mar 2013 15:30:57 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218315>

If two processes are racing to create the same directory tree, they will
both see that the directory doesn't exist, both try to mkdir(), and one
of them will fail.  This is okay, as we only care that the directory
gets created.  So, we add a check for EEXIST from mkdir, and continue if
the directory now exists.
---
 sha1_file.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..c7b7fec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -123,6 +123,13 @@ int safe_create_leading_directories(char *path)
 			}
 		}
 		else if (mkdir(path, 0777)) {
+			if (errno == EEXIST) {
+				/* We could be racing with another process to
+				 * create the directory.  As long as the
+				 * directory gets created, we don't care. */
+				if (stat(path, &st) && S_ISDIR(st.st_mode))
+					continue;
+			}
 			*pos = '/';
 			return -1;
 		}
-- 
1.7.10.4
