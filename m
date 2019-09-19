Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2F41F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733022AbfISVro (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37024 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404915AbfISVrh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so4677150wro.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3dDDYIYyi6CnRx8e/3NPMBZL8lDzLq8eR94uAzDL2M=;
        b=u1Wd38qiaTEh5dx8ccJ1mt9DVLzMVaNVXmlbjPEpSVf/T80UsUXk9339/UiuSbrtP+
         AGl4s4o5Zif69njeEhXUFZqrvlRu/q78qx0R8tLGlYwIM7ORIFHE/c/VQiRchiSGfOjt
         C2pzRUyg8dZRglObZkR2UwRrZ9VM1RzfUa2S2tuAV+fuRQysvfkEKXBrN6h1qjVxjS0/
         PkWxKbxtDVixw7jOJFhvaf3PvdgMjhg65grfaV+dXMhKohnWQbkHfXaLkAJmgdNO03Ju
         TSJJUy+zteHocuic4HxQaNI8QgBB/HRQd2hReghHNuBI78DfAwl3YvSJrrxYXv+Dt4RG
         g8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3dDDYIYyi6CnRx8e/3NPMBZL8lDzLq8eR94uAzDL2M=;
        b=BfVBJYetk1g9kXV6iMIOX3Fn1I73shHXNtM8Ut8tfXLZ3qYq4t0Im3Pi71k2Lnm56k
         uxYpsNzM2p8/iEKEPFPF5pzdfKOZGx38OWc1Fk8gRge9lwtNHhbhvcabZeWcwO99LyM1
         eb57QtWKiKh3ZVaxAKqPuQMIJwurIHFe/jNTOrXESGnToQuVB3jzc3XnIdomZ5QSFVdy
         BDRsaV6EwIEomay7ptIxQblnLsM22LXrdRbM8/qU/PQLgnPCJG6YgmIrfkuuwvVF98Er
         lbPv5MVWcMe0P79crLOtyhWD9LS/t6QrWIrGNWv1IFtWcXYcA3D69XG7fyF/rYeWmh/Q
         5V6g==
X-Gm-Message-State: APjAAAW2ZnHpHl7Uw5mmXdYk5BP9IZMzvm8xIeugY0Z9g8lryFIQTSl4
        KrbZc8KMAGF3noqbNM0nmb0=
X-Google-Smtp-Source: APXvYqxeEgpqnNZbPr/mpdcKL8iBocc3FeUT8MUzxJJeuxNLnpMV3v2CUh6BhSQbsI7QeT+D1ycxhg==
X-Received: by 2002:a5d:4ac7:: with SMTP id y7mr9335140wrs.271.1568929655389;
        Thu, 19 Sep 2019 14:47:35 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 14/15] name-rev: plug memory leak in name_rev() in the deref case
Date:   Thu, 19 Sep 2019 23:47:10 +0200
Message-Id: <20190919214712.7348-16-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The name_rev() function's 'tip_name' parameter is a freshly
xstrdup()ed string, so when name_rev() invokes:

  tip_name = xstrfmt("%s^0", tip_name);

then the original 'tip_name' string is leaked.

Make sure that this string is free()d after it has been used as input
for that xstrfmt() call.

This only happens when name_rev() is invoked with a tag, i.e.
relatively infrequently in a usual repository, so any reduction in
memory usage is lost in the noise.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/name-rev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index e202835129..f867d45f0b 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -101,18 +101,22 @@ static struct rev_name *create_or_update_name(struct commit *commit,
 }
 
 static void name_rev(struct commit *start_commit,
-		const char *tip_name, timestamp_t taggerdate,
+		const char *start_tip_name, timestamp_t taggerdate,
 		int from_tag, int deref)
 {
 	struct commit_list *list = NULL;
+	const char *tip_name;
 	char *to_free = NULL;
 
 	parse_commit(start_commit);
 	if (start_commit->date < cutoff)
 		return;
 
-	if (deref)
-		tip_name = to_free = xstrfmt("%s^0", tip_name);
+	if (deref) {
+		tip_name = to_free = xstrfmt("%s^0", start_tip_name);
+		free((char*) start_tip_name);
+	} else
+		tip_name = start_tip_name;
 
 	if (!create_or_update_name(start_commit, tip_name, taggerdate, 0, 0,
 				   from_tag)) {
-- 
2.23.0.331.g4e51dcdf11

