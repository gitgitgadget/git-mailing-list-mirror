From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] unpack-trees: free created cache entries
Date: Thu, 30 May 2013 06:58:56 -0500
Message-ID: <1369915136-4248-5-git-send-email-felipe.contreras@gmail.com>
References: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 14:01:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui1XY-0001Vv-0V
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 14:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab3E3MAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 08:00:55 -0400
Received: from mail-ye0-f171.google.com ([209.85.213.171]:60846 "EHLO
	mail-ye0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3E3MAw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 08:00:52 -0400
Received: by mail-ye0-f171.google.com with SMTP id l2so23361yen.16
        for <git@vger.kernel.org>; Thu, 30 May 2013 05:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dp2Px0AVros6QTRGJ/aNaV56a6TYyKy7Oq3IUvq2iYQ=;
        b=0SjCK+e7F2RkHptTdxe4vnM0vvCWQX2RtSMc1/Yc10PD44O8XrC2/X5VucIdMfVan/
         RGPKlVo8fgkGBelhGR/qw0E9EBdqkcX6oHAkzYB2jF9qqvBkH7FRUzBdeZSy7rvXHc1w
         gW5kyx7ufJIbeup20JLUCYeIh5dpNkXesZ4rGM3uEJMo+AdzVEGG1gtitVESg3f+UO8c
         0ETNIzq+g36oGdnUIJcwOLp1Xw3UW2SJ98vEAxc8Vz+pBJG5vwbc7/EfyFD8oXOflfub
         TQQ5MZ+92bFdUaIH/2EMTF4S/hNeDPBonuODNdYLBGDhfAV5qo7hh9KUB0CkpK+qfgDb
         0Kcg==
X-Received: by 10.236.92.208 with SMTP id j56mr2511647yhf.50.1369915251330;
        Thu, 30 May 2013 05:00:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id y24sm59372042yhn.20.2013.05.30.05.00.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 May 2013 05:00:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369915136-4248-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225972>

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
