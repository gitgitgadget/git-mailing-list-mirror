From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] copy.c: make copy_fd preserve meaningful errno
Date: Mon, 17 Nov 2014 14:14:13 -0800
Message-ID: <1416262453-30349-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 23:14:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqUYw-0006gt-3V
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 23:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbaKQWOS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 17:14:18 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:42720 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaKQWOR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 17:14:17 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so6000974igd.13
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 14:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=MDaPkiOb32lutJGWxwY79lej00FfLbJAfXgu2I822oc=;
        b=MdvHb/yA81ql7/JppeLG1ogCN+fbNKzt5GzTwG12ApcdyYfwCODevNBCHLhVC+89Zb
         1EJefft/eRUUyEC0nHiwbs/vA7jW+CCokYWN612TUkTl01bQP3JPzIQpTufUcwIf0VWG
         rIOqggQhoUMHu4dyTi0Ltkv8ksrASIYl2NT1Qd+R3QgrANnHFaiSh8cY+rnipVj2K+sd
         qGbBmezlXeoSZvvMl9q1rQIrlNdELF781ftcFrrTtpb9IbjyNezBJDaeiLusR1JXgwRm
         TDHYJS0PDkxPsummqm/og+QCc2Qkb2UngULOpngZ5YTc1TQPpH7OXqp2l50rB0IPISZW
         ZBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MDaPkiOb32lutJGWxwY79lej00FfLbJAfXgu2I822oc=;
        b=Tg8p5ygZmxPAhvozUViGpWAwTMeNERj8p/grY3j9ZcVevoTRka2F62m7BkUh/ezZib
         TDxJM7AEeLUFuRYthjXKZADUu82r3Hea+wXbcB9SQToue+JPYfEkBISiw8MVDZHOeyx8
         v9cNAlTG+sBoXVThWpMfB29VKTYbRFACWdDfv2wxlf/asT/IjOWcBy7hcwcqbPaCbKAa
         xeXpW6yI8V0+dR3CUJDknesLj2lhCc20UmHzQm2QXOf8ROjcJSkJAXd2gfb+r0r/QMwc
         eRgVM+9VVVcx4Egg+9YiKPG5T2a0E/K6bgYDNTzSchGv3K0JFYPWp1wURmDCxWBKyN3k
         sXLg==
X-Gm-Message-State: ALoCoQlq+K8GvGb9UFPnLLnM2aymJRuHMxWg7BUNJWovvwQ6wocJyH9NtzBTrj5bSx8Ht5OzRlQ2
X-Received: by 10.107.128.138 with SMTP id k10mr5535373ioi.69.1416262457045;
        Mon, 17 Nov 2014 14:14:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id 5sm6604089igl.17.2014.11.17.14.14.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 14:14:16 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc1.24.g562add4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Update copy_fd to return a meaningful errno on failure and also 
preserve the existing errno variable.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
As announced in [1], I'm going to take over the 
ref-transactions-reflog series by Ronnie Sahlberg.

This patch was sent previously to the list as part of
that series[2], but it seems to be unrelated to me.

Thanks,
Stefan

[1] http://www.mail-archive.com/git@vger.kernel.org/msg61051.html
[2] http://www.spinics.net/lists/git/msg240784.html
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
2.2.0.rc1.24.g562add4
