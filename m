From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Remove uneccessary strncmp call in imap-send count_messages
Date: Sun, 22 Oct 2006 15:53:28 +0100
Message-ID: <200610221553.28872.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Oct 22 16:56:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbekC-0000bT-Rx
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 16:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWJVO4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 10:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWJVO4F
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 10:56:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:54291 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751075AbWJVO4D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 10:56:03 -0400
Received: by ug-out-1314.google.com with SMTP id o38so1056719ugd
        for <git@vger.kernel.org>; Sun, 22 Oct 2006 07:56:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=a81W039gXPGxQOlaBviIzLNsD32/pwvMN1dXgYnzZydtuoRblir/z8xUo5j4FfZG6s9mtdAUlWu6RxOJ8HIy4Tc6577EwlXaIK/1g5IAQxgZKY+uxrvZ2eoeWWigT9YV96WD8mkIjsylLGpFMRh0nxgIJj1DYF3zulzZ1DsFQnM=
Received: by 10.67.117.18 with SMTP id u18mr5516428ugm;
        Sun, 22 Oct 2006 07:56:01 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o1sm2553179uge.2006.10.22.07.56.00;
        Sun, 22 Oct 2006 07:56:01 -0700 (PDT)
To: git@vger.kernel.org
X-TUID: 83eef8ee27031a8e
X-UID: 119
X-Length: 1133
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29757>

The strncmp() call in count_messages() was doing the same comparison that 
strstr() did, so there was no need to call it.  A little rewrite and 
count_messages() is simpler.

Obviously no huge benefit, as it's not frequently called.  I'm just getting 
familiar with git.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 imap-send.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 16804ab..cfac17b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1198,15 +1198,14 @@ count_messages( msg_data_t *msg )
 	int count = 0;
 	char *p = msg->data;
 
-	while (1) {
-		if (!strncmp( "From ", p, 5 )) {
-			count++;
+	while (p) {
+		p = strstr( p, "From " );
+		if ( p != NULL ) {
+			if ( p == msg->data || *(p-1) == '\n' ) {
+				count++;
+			}
 			p += 5;
 		}
-		p = strstr( p+5, "\nFrom ");
-		if (!p)
-			break;
-		p++;
 	}
 	return count;
 }
-- 
1.4.2.3
