From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/15] copy.c: make copy_fd preserve meaningful errno
Date: Tue, 21 Oct 2014 12:24:13 -0700
Message-ID: <1413919462-3458-7-git-send-email-sahlberg@google.com>
References: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 21:31:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xgf9u-0003lN-52
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 21:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932986AbaJUTbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 15:31:48 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:39695 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875AbaJUTbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 15:31:40 -0400
Received: by mail-vc0-f202.google.com with SMTP id hy10so126484vcb.5
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rN9te3SiHWBJJSwpTltYPnkYvgVdofPgDUqTKPhKboY=;
        b=lamCINo0EWnZoqHct2ddcGz536QYn7sbTHyaHrakWVIHEoPJXLJqtmRIpFdtDkz5qo
         Imm3I7C1sNEKMp2tW/obKYatiHiwDBIPOmFsR++fvFL/E18CUpkCyvuEfTggBUDxeX4b
         qEib8Up6SOEj5bj3TcF4AHc1PmSg3HfGq4emYeTafB9HW+35Z47K/S8oGgtkX5RKafVj
         LAEtKchUoolecVRupHbjfSYE5qV6TjKAajEwVyf9PIgckTlCBrPI61Fe5yBkC4wi5J60
         iWWJVXiRiyux5fifcKBSKUD5GhpJSayB4suFfazU6RzXjirkivGjF59/eo8N0m4siAzX
         fgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rN9te3SiHWBJJSwpTltYPnkYvgVdofPgDUqTKPhKboY=;
        b=kdGXKsyG5XytdK/xgADLA3MkDAGl+7632tyrY5WArAZ1E8CP0T+ltvQcBdRo/MP1+Y
         EA7nxL0GAaY4BVt28fLRv+iWNu8Nw/9EBt5vlXOTwhj2c6jKJrAvX0mZ39umWZxVtReA
         XXc3WZiJGD/JSkDDyX0uteeMhChQ24mCn7Tg+CJN7GC41m03rFEJhp2TPp/sqTamQqOq
         seRfTPnBdPKl3Kktr49WGJoSFAGZEKiFw2cWgv5R8sjTUDnPliL6+iGjKdb3hwrTIFpD
         mPoLy4KH2o80RucJ7ido6+vEETw06mpqaQGBYmWlZtN+qMcdI7pslJrOUotWyflCO00x
         TDRQ==
X-Gm-Message-State: ALoCoQn9ilOqBUdJbK0ADWLFPItxLvtzoLpCYV/xEeZw/42SIZD9EbHJQ+tYLzhSNkqi7EuK+SxB
X-Received: by 10.236.41.43 with SMTP id g31mr1958070yhb.55.1413919899842;
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id n24si583866yha.6.2014.10.21.12.31.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 12:31:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id H7uvYj90.1; Tue, 21 Oct 2014 12:31:39 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 92766E117F; Tue, 21 Oct 2014 12:24:34 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.728.g406752a
In-Reply-To: <1413919462-3458-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit 306805ccd147bfdf160b288a8d51fdf9b77ae0fa upstream.

Update copy_fd to return a meaningful errno on failure.

Change-Id: I771f9703acc816902affcf35ff2a56d9426315ac
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 copy.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/copy.c b/copy.c
index f2970ec..a8d366e 100644
--- a/copy.c
+++ b/copy.c
@@ -8,12 +8,17 @@ int copy_fd(int ifd, int ofd)
 		if (!len)
 			break;
 		if (len < 0) {
-			return error("copy-fd: read returned %s",
-				     strerror(errno));
+			int save_errno = errno;
+			error("copy-fd: read returned %s", strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
+		if (write_in_full(ofd, buffer, len) < 0) {
+			int save_errno = errno;
+			error("copy-fd: write returned %s", strerror(errno));
+			errno = save_errno;
+			return -1;
 		}
-		if (write_in_full(ofd, buffer, len) < 0)
-			return error("copy-fd: write returned %s",
-				     strerror(errno));
 	}
 	return 0;
 }
-- 
2.1.0.rc2.206.gedb03e5
