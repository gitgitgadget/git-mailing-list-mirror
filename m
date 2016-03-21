From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] git-compat-util: st_add4: work around gcc 4.2.x compiler crash
Date: Mon, 21 Mar 2016 00:35:57 -0400
Message-ID: <1458534958-6956-2-git-send-email-sunshine@sunshineco.com>
References: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Renato Botelho <garga@freebsd.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 05:36:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahra4-0004oe-SM
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 05:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbcCUEgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 00:36:38 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34135 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbcCUEgf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 00:36:35 -0400
Received: by mail-io0-f193.google.com with SMTP id o5so13081572iod.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 21:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ews6RjNvorAYFy7po/zGWb6AuIC3k03kpyj57zcaUII=;
        b=PI4+fFv3UhR8AxiZ9qyHYXUKJ18VkRESAmIX5IA64xsywKyWuq5PVl6iAI8hz3z9b4
         Wc3ODS3hYXygpKw9Uj7r3OLgE7RcG53ImALaMny2FP7K2P7ALCy0n4hdvrmS++cfIOqb
         2tbhICSpiShlZps0EY4CqBINxqRC9evp/tINq34CQBIxyqqoCCKO8qYkR6FuXVFfHWhy
         6pdoUODI4Rn1I82uaImH+KpQ7w+mKSkZXoW9RX8pv0EGhohZ9qTGewxYtBzrEH4hlq8x
         8oxOAQ9964gTwLuDpZxXdmdgGYnSIEcAqNh9Tr0vuHDql0R36RtrW6BfMlAiE1Tgkh3R
         7Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Ews6RjNvorAYFy7po/zGWb6AuIC3k03kpyj57zcaUII=;
        b=NyuKhb/tsp7DK/jDTRiSMsI2O3HEw7XjevCLp2hgSgZEEmgXVYDkgtj48Clo0Zwumo
         +rnQRyjI1Hogd9N+PfhESPeLj8AtdzhVqqmiYqU/DbUc0GDrevsbX5YXLElzqJLTRE7h
         pSIIWvu2u2DWvqiupceK5jMNooJ1++NTQCp5RiHfeB6QDSnnNnGcapolI+xXcb1QwPkX
         lpiwSs3v+dk5bxyQaaTv/QTI71B1C0usGLQZVUytg17m3KU7I/FRO0F7sNOEVrrQ/uYI
         2tnznj70ZJOxry0xfKX6fAIPoiZy+onzAKLnHvtx9KFPmrO11aTBXxwVTsvpjPBqNDJU
         zPGA==
X-Gm-Message-State: AD7BkJKmbiuryH516aDSi+c7jGJhOVdBK7hYecc+XYfvrWwHcsSpJPjP2WsHuDjaHvY62g==
X-Received: by 10.107.3.34 with SMTP id 34mr29629048iod.159.1458534994719;
        Sun, 20 Mar 2016 21:36:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id i187sm10725620ioi.33.2016.03.20.21.36.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 21:36:34 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc3.240.g104e649
In-Reply-To: <1458534958-6956-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289396>

Although changes by 5b442c4 (tree-diff: catch integer overflow in
combine_diff_path allocation, 2016-02-19) are perfectly valid, they
unfortunately trigger an internal compiler error in gcc 4.2.x:

    combine-diff.c: In function 'diff_tree_combined':
    combine-diff.c:1391: internal compiler error: Segmentation fault: 11

Experimentation reveals that changing st_add4()'s argument evaluation
order is sufficient to sidestep this problem.

Although st_add3() does not trigger the compiler bug, for style
consistency, change its argument evaluation order to match.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 git-compat-util.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index c07e0c1..4743954 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -715,8 +715,8 @@ static inline size_t st_add(size_t a, size_t b)
 		    (uintmax_t)a, (uintmax_t)b);
 	return a + b;
 }
-#define st_add3(a,b,c)   st_add((a),st_add((b),(c)))
-#define st_add4(a,b,c,d) st_add((a),st_add3((b),(c),(d)))
+#define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
+#define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
 
 static inline size_t st_mult(size_t a, size_t b)
 {
-- 
2.8.0.rc3.240.g104e649
