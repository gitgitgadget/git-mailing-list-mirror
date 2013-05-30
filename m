From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/3] unpack-trees: free created cache entries
Date: Thu, 30 May 2013 08:34:21 -0500
Message-ID: <1369920861-30030-4-git-send-email-felipe.contreras@gmail.com>
References: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 15:36:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui31r-0006yY-6m
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 15:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab3E3NgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 09:36:20 -0400
Received: from mail-ye0-f179.google.com ([209.85.213.179]:58938 "EHLO
	mail-ye0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756453Ab3E3NgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 09:36:14 -0400
Received: by mail-ye0-f179.google.com with SMTP id l3so47126yen.10
        for <git@vger.kernel.org>; Thu, 30 May 2013 06:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dp2Px0AVros6QTRGJ/aNaV56a6TYyKy7Oq3IUvq2iYQ=;
        b=ND0RzDayzmCjiZSdAxfSPSJXds8d7kYQq5Wc4ud2jibWHsmDwb9ZijacgspOR9nh6L
         hGiQlzE0VYTx8Jgm16nXZWfy4z4RtgTk5fF6Sfoa9P2OkYE/1n4K/71m75XLNcBuTxEW
         2VleilwHWxxQVncJLScK/WMWnrsw2xwfSnyWYODfCZp4yGvU+8XrL79IS55TNsRaLUqM
         bg53lLqynn0jNuNpTxa8OFuYuAAXTre8KoscThD6X211zN6pYijB7ypbTVVUAnLBYv3+
         S+qchYJ3+RS2kawaJohYGs4N4ti1m2tIJCK1dTDBxFWnm3acRMsqP/IvURqf+wxiEA2y
         t7EQ==
X-Received: by 10.236.82.46 with SMTP id n34mr3814245yhe.65.1369920974176;
        Thu, 30 May 2013 06:36:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d91sm59953443yhq.16.2013.05.30.06.36.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 06:36:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225987>

We created them, and nobody else is going to destroy them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 unpack-trees.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index eff2944..9f19d01 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -590,8 +590,16 @@ static int unpack_nondirectories(int n, unsigned long mask,
 		src[i + o->merge] = create_ce_entry(info, names + i, stage);
 	}
 
-	if (o->merge)
-		return call_unpack_fn(src, o);
+	if (o->merge) {
+		int ret = call_unpack_fn(src, o);
+		for (i = 0; i < n; i++) {
+			struct cache_entry *ce = src[i + o->merge];
+			if (!ce || ce == o->df_conflict_entry)
+				continue;
+			free(ce);
+		}
+		return ret;
+	}
 
 	for (i = 0; i < n; i++)
 		if (src[i] && src[i] != o->df_conflict_entry)
-- 
1.8.3.rc3.312.g47657de
