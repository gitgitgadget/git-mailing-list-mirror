From: Guanqun Lu <guanqun.lu@gmail.com>
Subject: [PATCH 2/2] lockfile: set lk->fd = -1 in 'rollback_lock_file()'
Date: Wed, 11 Feb 2009 14:43:32 +0800
Message-ID: <1234334612-24907-2-git-send-email-guanqun.lu@gmail.com>
References: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
Cc: Guanqun Lu <guanqun.lu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 15:41:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtnj-0005xL-Ef
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755355AbZBJOkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbZBJOkB
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:40:01 -0500
Received: from ti-out-0910.google.com ([209.85.142.189]:30441 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbZBJOkA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 09:40:00 -0500
Received: by ti-out-0910.google.com with SMTP id d10so2315103tib.23
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 06:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pcnexHid/LJUgqCqcObSSRBBfedoV+s+OOC2YnQW2EA=;
        b=p3awzQw2uKyHwQvMskhAKKHVPFLlOoqjqYtEKAS0Vx+tyvNztlNwtgYrFXETyaFqT3
         DyWHnxFjT9lDB0V377OvdvuPqp8dD44GyYDdUePPpPHMLq0IWZKOCXjnYzMKlWlG5cZv
         Z1P3QNn5gP3XKvpy1u/aEhdjsrtg5R/L50ppA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=l7kNNFsqactsnJ0hsyd4Vuw2BLqtSAbaglYF5jJv6odOadpOEEkEZEYp7Wk0jJwf6Y
         jkkp1KJzLJgjapkInGCXArtov5gzKTvuTwZ6/iz9Sbto8GR61WGggaeAI+gGXXBroYTu
         kLjwmx2JKm1K8QhikYpIoTECK84CNJlEzIpSI=
Received: by 10.110.84.3 with SMTP id h3mr841407tib.54.1234276798630;
        Tue, 10 Feb 2009 06:39:58 -0800 (PST)
Received: from localhost ([202.120.224.18])
        by mx.google.com with ESMTPS id j5sm1383878tid.1.2009.02.10.06.39.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 06:39:57 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.392.gb04d1
In-Reply-To: <1234334612-24907-1-git-send-email-guanqun.lu@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109249>

Post-conditions when these functions return successfully:
                    lk->fd == -1?    lk->filename[0] == '\0'?
close_lock_file()       yes                 no
commit_lock_file()      yes                 yes
rollback_lock_file()    no*                 yes

[*] This commit changes this 'no' in rollback_lock_file() to 'yes',
which achieves more robust and unified interface.

Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
---
 lockfile.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 021c337..44e5253 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -243,8 +243,10 @@ int commit_locked_index(struct lock_file *lk)
 void rollback_lock_file(struct lock_file *lk)
 {
 	if (lk->filename[0]) {
-		if (lk->fd >= 0)
+		if (lk->fd >= 0) {
 			close(lk->fd);
+			lk->fd = -1;
+		}
 		unlink(lk->filename);
 	}
 	lk->filename[0] = 0;
-- 
1.6.1.2.392.gb04d1
