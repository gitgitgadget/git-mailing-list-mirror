From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 5/6] pack-bitmap.c: fix a memleak
Date: Mon, 30 Mar 2015 18:22:10 -0700
Message-ID: <1427764931-27745-6-git-send-email-sbeller@google.com>
References: <1427764931-27745-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
	tanoku@gmail.com, blees@dcon.de
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 31 03:22:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yckt5-0008Tx-Rm
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 03:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbbCaBWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 21:22:30 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34131 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbbCaBWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 21:22:20 -0400
Received: by iedfl3 with SMTP id fl3so5025605ied.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 18:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mCKRiTIvGIozf3ty2kA56QjuiCpTM+n9ylE+Gh20wOk=;
        b=fPOTy1zhtzDgoUUQ8GC7Pd726MhA/rBElVaFEq9klHm+9DDdd+HUUNM/xj0SnsANSt
         Gxg7KCX3yUq8wd3QJwSMgeAqPlxdJQhYNHUvDzGPALJ6edut/O4R/yQVOZmdaPEjBJrm
         fe3zTQrDCOErWJAlMWJgmcS5KCAFfuxGXbO1fhlBEV1c2v4GW9tvhAkQfVBrpMfY5JJn
         zFSL7ucMSWj19Y+O4PLfU2azGwF21jzywS3pkbLxyLFI2PlbD/b54nmcbkU31wHcVS9G
         V4ap6iZ4uvcz7NH6gNuAfqN58Ww2XOmj9bpVeOFlge2CfQINc+5NLxiI7bs1N9/UQNuk
         wBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mCKRiTIvGIozf3ty2kA56QjuiCpTM+n9ylE+Gh20wOk=;
        b=HrtQL4gCyH6Ogc8JLNz+9BNp5g8kal0OXgpMJez4HjQYDzDFf6n4ZMzMxHx1ymHu1y
         +sG0BG4aDPDkObiFX1Pt90ZYe5MXbMCzpeVjKXudREye59VddJYrtn8k420nj0J+mG42
         wSQRcpCD6dvBmml+l+Dn1HyoploUNmeoZBZCgbqKUMe3zEZ28S5CwSYbcv4WenxGEAdp
         2FqymOGlsFF+XDUQld3LNbZNthsX99PpRLKmZAK4az2IKSFExoGZSov3SxDj0fXqS54/
         m0Q4fTR7eaUWCZhsgUaGFsLhaU8Tyxql4EYha/76Bh3GsSfatdYwvTtemd71dJ+3IDkI
         TXvg==
X-Gm-Message-State: ALoCoQnsw7ffvA1xy6VAiVHTvn008kbtILH7VM1MniPkYzXR44dl843bxXyoST5LzNJ+auVeJSXk
X-Received: by 10.107.37.132 with SMTP id l126mr35963659iol.42.1427764939693;
        Mon, 30 Mar 2015 18:22:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3c88:d48a:4382:4b5])
        by mx.google.com with ESMTPSA id b17sm8643797iob.31.2015.03.30.18.22.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 30 Mar 2015 18:22:19 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1427764931-27745-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266503>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 pack-bitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 365f9d9..62a98cc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -986,6 +986,8 @@ void test_bitmap_walk(struct rev_info *revs)
 		fprintf(stderr, "OK!\n");
 	else
 		fprintf(stderr, "Mismatch!\n");
+
+	free(result);
 }
 
 static int rebuild_bitmap(uint32_t *reposition,
-- 
2.3.0.81.gc37f363
