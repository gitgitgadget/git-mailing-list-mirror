From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 4/6] add a test for semantic errors in config files
Date: Mon, 28 Jul 2014 03:33:53 -0700
Message-ID: <1406543635-19281-5-git-send-email-tanayabh@gmail.com>
References: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 12:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBiGZ-0008L7-U6
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 12:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbaG1Kes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 06:34:48 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49044 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbaG1Keq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 06:34:46 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so10188577pad.7
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KQPviVDI+vwbw1AhwoR4t/vcgYHEPcOh45DxcThN6Lw=;
        b=QWCu1V8zyd3+4ahum1Bz8UOvOh1lEu5KUZVTOJBDN1Bo7Qqps4+xWuMMei3X0qqECO
         sM6P0KNm0LZGiPCaPbmtLkr862/8e8piFd/1TQg6dP8BIGomCp5qfgBUwJYOOkYntJcU
         HZH39qwBml37e5FvLigniCMmUpVv8B8ZLCNB/ahmkFOYqawWBgxSr72q4Eebi7hRLFbE
         fFS84fF9fHoKS0PoKMaAAvm7uSjwrrshYpqN9rPGZBWau6BqmxFnIGYvNCLkzqYZGLQS
         npnj2m2B0Kvr10seMC1lWmJtVwRRLK8dS0xZ8cnZXU6ADGus9gdI9djl49vSrR8z3Zz2
         eNaA==
X-Received: by 10.70.37.10 with SMTP id u10mr37206703pdj.35.1406543685547;
        Mon, 28 Jul 2014 03:34:45 -0700 (PDT)
Received: from localhost.localdomain ([106.211.56.253])
        by mx.google.com with ESMTPSA id v8sm23639483pdr.45.2014.07.28.03.34.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jul 2014 03:34:45 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406543635-19281-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254294>

Semantic errors (for example, for alias.* variables NULL values are
not allowed) in configuration files cause a die printing the line
number and file name of the offending value.

Add a test documenting that such errors cause a die printing the
accurate line number and file name.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 t/t1308-config-set.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7fdf840..35c6ee2 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -197,4 +197,15 @@ test_expect_success 'proper error on error in custom config files' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check line errors for malformed values' '
+	mv .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	cat >.git/config <<-\EOF &&
+	[alias]
+		br
+	EOF
+	test_expect_code 128 git br 2>result &&
+	grep "fatal: bad config file line 2 in .git/config" result
+'
+
 test_done
-- 
1.9.0.GIT
