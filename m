From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] hex.c: reduce memory footprint of sha1_to_hex static buffers
Date: Fri, 13 Feb 2015 13:18:49 -0800
Message-ID: <1423862329-7899-1-git-send-email-sbeller@google.com>
Cc: torvalds@linux-foundation.org, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 22:19:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMNde-0004tD-A2
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbbBMVS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:18:58 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:40914 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbbBMVS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:18:57 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so13295823igq.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2015 13:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nuWBViQIdd0PUINPSBV7eNrmB/jrrkGq0Yc1BuDzHc4=;
        b=Bkek1BT1mPE/t7XO4qN6BbsCI3XJJHOUcPuS5xOSIWoMFzmFD4JmTdUfqzA292g74Z
         Bgs6/OWf5D3sQHevem3Hq7XmCM+C/73myV4EzPalato8FXy9CQOhqjoMoJaxo+bqkBzl
         XQbtQLVqm64+vCNpQzAy7QIOQ60BvMdH2iB18sAYGLq25ieq51aakta+x81cSr0uGxth
         rEYWpvR8sZKqvmBKLMZNR4+ZwIVjXths+/t9WODMpSqymGCjOyottjuEfXqJCvaF8rhq
         DzP7w+cVbrd3YDXy+SiTc9W2ekN8lfE2ter1PCRWSisKwwTDfhGHsitYmJUyue+lBFk8
         u9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nuWBViQIdd0PUINPSBV7eNrmB/jrrkGq0Yc1BuDzHc4=;
        b=BtwApNGUrbdJ/arakObLSLuK0dcRh6OFBRLfxBJfsvvyWQ4GKNmMJhweM7VCkpsoKP
         Vlnuwdm0ycn6Uw1sksUI+yuNMMkfrAThv8tOw+HEoP5MCuEBS/fgCW6vJKmDUXeIcbK0
         va9X/8DACRUOmgFi2D0VC2qopaY+DmN2cTcMJeWPXvmdXaLNAqwFdYavn61CJ0Ia7DUj
         HUafwTnjIiDsH6ZKZH/wnvuo9oifpxiBFzlPVayGfufJF8OfWpXEFEveKEiyY4iULrpi
         x4C12vCgi6sC05hoIEeXOodONoaKFaTn/FirM5KT2R2q7Y5HsRty/+TQRQfv+iRUAm/p
         73hQ==
X-Gm-Message-State: ALoCoQk9IbuVyad2+L3Oy/9sJdMdtVQvNT0zd8VlLLQCk2cXQzmc84VJl2JQc0Se+rq5c2wS6A80
X-Received: by 10.42.153.132 with SMTP id m4mr16902128icw.49.1423862336996;
        Fri, 13 Feb 2015 13:18:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:380e:e39a:f95:c662])
        by mx.google.com with ESMTPSA id 5sm3903531igr.17.2015.02.13.13.18.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Feb 2015 13:18:56 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263836>

41 bytes is the exact number of bytes needed for having the returned
hex string represented. 50 seems to be an arbitrary number, such
that there are no benefits from alignment to certain address boundaries.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 hex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hex.c b/hex.c
index 9ebc050..cfd9d72 100644
--- a/hex.c
+++ b/hex.c
@@ -59,7 +59,7 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
-	static char hexbuffer[4][50];
+	static char hexbuffer[4][41];
 	static const char hex[] = "0123456789abcdef";
 	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
 	int i;
-- 
2.3.0.81.gc37f363
