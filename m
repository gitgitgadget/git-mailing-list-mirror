From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] strbuf_write: omit system call when length is zero
Date: Thu, 25 Feb 2016 14:34:38 -0800
Message-ID: <1456439678-5433-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	sunshine@sunshineco.com, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 25 23:34:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ4Uj-0002wy-2c
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbcBYWep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 17:34:45 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33240 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbcBYWeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 17:34:44 -0500
Received: by mail-pf0-f177.google.com with SMTP id q63so40103261pfb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 14:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=f1+lklWBBQz3xnNliILIPwB6Nnk2689SDop0LIudRH0=;
        b=dZD8jkrgP+jV1Zde8zIGAfi38eS2vdhZMqz23tuU4cehuOU1JLrH1X5j4YW8u6EGEH
         bhIBQE5tFcaJBCEaIY6VYIVwK9BscKKHtYi42fXj4ajFCzxRW0u5IjL3uQVNoUGjSvW5
         f5I2TZxBYkOMVKJUCH/VQZuNzZfDrGwIfxS6h+MpwetIq4mfJ5CskShOPamX+lEW5CNA
         2e/GkaxUHLdaFV9Bm80IdQK1zhq5DTnVjFoEfSWBfXA0zaI2gVlTLnNoOs2ZueSWl+vJ
         cqVQppWnjtOI4OJ6hObbgwVg9O7uPN86Undi9G1CsFd5gmncc3eWAuzunZMGZO1JJFOn
         NMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f1+lklWBBQz3xnNliILIPwB6Nnk2689SDop0LIudRH0=;
        b=T0PFD+ozXuciHOhZ7yDljkFfD0XXCUjUjcXCGEP6aH+xtApsqGmlCEt1YBZi/r57a+
         iI74LzveWePU/wmGqbakRauKWC7CmSrss3a00iQN8QiV/pFpcSEb4S7VLEhushYOlC60
         bLzuCaK1wXtOglEDx3xYes9D1x0kCiZPSAIXCJj33sBLBXkZd983YDnPA6nH8lC0ROI4
         /SOHpvwckgcUxgrXtlVKT095MLIveUMK+pKRBkCjp+c3ohbbXcF4F7uaMOGC+EtMiADk
         gOtYb11dfHElUVihXYiwBR0OuMZ24ALTQ+ExfPpkasDzMpBv5Lv0kL2XNqB6lmv2XOqI
         uszA==
X-Gm-Message-State: AG10YORYRUBg6SuRMMvhvAW4e4sYO96In3CcNe+YIeYkrCXPFvmR4yLUkQmXdyOW210J5du8
X-Received: by 10.98.87.90 with SMTP id l87mr66582008pfb.70.1456439683884;
        Thu, 25 Feb 2016 14:34:43 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a893:1c03:aadb:c3d])
        by smtp.gmail.com with ESMTPSA id n78sm14429053pfb.53.2016.02.25.14.34.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Feb 2016 14:34:43 -0800 (PST)
X-Mailer: git-send-email 2.7.2.374.ga5f0819.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287448>

In case the length of the buffer is zero, we do not need to call the
fwrite system call as a performance improvement.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 This applies on top of v17 for origin/sb/submodule-parallel-update.
 
 In case there are other reasons for origin/sb/submodule-parallel-update
 to need a reroll I'll squash it in. But as this is a pure performance
 optimization in a case we are not running into with that series and that
 series is clashing with Davids refs backend series, I figure we may not
 want to have a reroll for this fix alone.
 
 Thanks,
 Stefan
  

 strbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 71345cd..5f6da82 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -397,7 +397,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 
 ssize_t strbuf_write(struct strbuf *sb, FILE *f)
 {
-	return fwrite(sb->buf, 1, sb->len, f);
+	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
 }
 
 
-- 
2.7.2.374.ga5f0819.dirty
