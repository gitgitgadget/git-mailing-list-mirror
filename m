Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12871FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbcFWQ3s (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:29:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36493 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbcFWQ3q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:29:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id a2so18848336lfe.3
        for <git@vger.kernel.org>; Thu, 23 Jun 2016 09:29:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZqRq/+0EVj6VhJu2aCee3in8rNnIiwguYV+P/0F49lk=;
        b=us8BkOatL9T/Ju1VeKPkW3Fd7kW6y51+N1jrIIFYV9rEVzg3zZVgzhdVCFVMgmQz/o
         P1VdABGmr9Z2O4qvdlr1nROof3PMv14tlhFlbVG129CSFZYo2exIpc3wqbhtde6LClP3
         4WnrSXLSybpL5dNOaQfNevE2Nnyefpr4KTXkPaj4jDWcqIqUn46J/i3uzqt4oOQICkIG
         18/yJqxWNvt5tq4OyPZxC1ScaCsUAbr/8a5UDzVo2zN/2HbQFzpFu+1TWLN69I/m54JB
         CDzQOm3HbJPqhZsRxSv5PCrgXk/G9PYBbIEDo07mny/8OR2/+7gRi/Lcxar3dTHP8Bhq
         KPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZqRq/+0EVj6VhJu2aCee3in8rNnIiwguYV+P/0F49lk=;
        b=d+UFhXxy3nQTlWY6B3PzIDwOGZHEE1RxBcmKEu+mlt8G+PdwnOndoLZT+vN7lxALci
         9mJ66EIRhzE7j/fRCF7UHo5QjTI4EoZEeKI6I0lK6UrJTm524vS7vqvb5dVQLnNyTN05
         MmBUQkCnHW1s4691Uhe6Lk6IPn8qXPhevz0dGwccDaHB3iczL2V7ceVPNCimn1a8qm34
         wngwFtyRiP4d8YSaxOn/wDPbmNvIWxSdvGalrj3Tlihx6WZ6Yc10sEgSE11RVAfKtwNP
         XYdQd1anAN/ixwP0gU6GZrinGeLqQngfyiGM5llhDcZZVLElML5VRG3OOX0mQVRtTBEq
         th6Q==
X-Gm-Message-State: ALyK8tLbez44LNJ5XT/IROXx0//lT3bvm/6PrnVs4rJHX4pvd75td9nsuC4+rClAfJPOZg==
X-Received: by 10.25.77.132 with SMTP id a126mr10058365lfb.3.1466699379795;
        Thu, 23 Jun 2016 09:29:39 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id u21sm157948lja.16.2016.06.23.09.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jun 2016 09:29:39 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/11] diffcore-pickaxe: support case insensitive match on non-ascii
Date:	Thu, 23 Jun 2016 18:29:06 +0200
Message-Id: <20160623162907.23295-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160623162907.23295-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Similar to the "grep -F -i" case, we can't use kws on icase search
outside ascii range, so we quote the string and pass it to regcomp as
a basic regexp and let regex engine deal with case sensitivity.

The new test is put in t7812 instead of t4209-log-pickaxe because
lib-gettext.sh might cause problems elsewhere, probably.

Noticed-by: Plamen Totev <plamen.totev@abv.bg>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-pickaxe.c              | 11 +++++++++++
 t/t7812-grep-icase-non-ascii.sh |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 69c6567..0a5f877 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -7,6 +7,8 @@
 #include "diffcore.h"
 #include "xdiff-interface.h"
 #include "kwset.h"
+#include "commit.h"
+#include "quote.h"
 
 typedef int (*pickaxe_fn)(mmfile_t *one, mmfile_t *two,
 			  struct diff_options *o,
@@ -212,6 +214,15 @@ void diffcore_pickaxe(struct diff_options *o)
 			cflags |= REG_ICASE;
 		err = regcomp(&regex, needle, cflags);
 		regexp = &regex;
+	} else if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE) &&
+		   has_non_ascii(needle)) {
+		struct strbuf sb = STRBUF_INIT;
+		int cflags = REG_NEWLINE | REG_ICASE;
+
+		basic_regex_quote_buf(&sb, needle);
+		err = regcomp(&regex, sb.buf, cflags);
+		strbuf_release(&sb);
+		regexp = &regex;
 	} else {
 		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
 			       ? tolower_trans_tbl : NULL);
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 08ae4c9..169fd8d 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -61,4 +61,11 @@ test_expect_success REGEX_LOCALE 'grep string with regex, with -F' '
 	test_cmp expect2 debug2
 '
 
+test_expect_success REGEX_LOCALE 'pickaxe -i on non-ascii' '
+	git commit -m first &&
+	git log --format=%f -i -S"TILRAUN: HALLÓ HEIMUR!" >actual &&
+	echo first >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.8.2.526.g02eed6d

