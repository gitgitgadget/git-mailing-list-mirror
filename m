Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA0BC43381
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6442720784
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 21:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbhACVTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:19:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45746 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727452AbhACVTr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 Jan 2021 16:19:47 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D53CC60811;
        Sun,  3 Jan 2021 21:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1609708746;
        bh=rM8C4HlERsqv2L9g1AnnG9PExC+oyzdpcH4GaE2iv6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=z1qjCJBtfYsc4wariN6x7qksrkTP2zPsPS8ZdD74SvFM4uGF/KjSKoi0oVQn1jV21
         B6fQBxF2Izw80kJgbBlCCSlmvG4KUYBZLtYiSRwmd8zAxExt8iloD5TMqd/0DkmF57
         WVWSqzq6zXBimBJ+gC3jSRU7uM2Ns2eyyf3RMRaAyq8acwvkeDcrBN9V5UWx8LCEYc
         /HhvO57KcE7hw9tJCwj9gtc4IQBenYhclgH/gaaEWk1Occgwanj+7X3Cp6NLvZmNBE
         Mr65kye8Lyf2k2YCseSKsSpRlzXvAo/NgJ45mQTvc3Drw+RFJG3CV/mdVldwP6oi6T
         S4aNzNEiwlGmiTQUo7FNE6j3bFwrxZM8N96xRhwNc92Yw5bd47Q+l5ySjkd96Autg1
         Roi+t6z1Ru7b2+ROnuyzQE8BAxo81fCcjxDdbTwOWgK709vBr8uxWhc8NOETSGc7p8
         TN9SNQhvvRHpZK/9ERxQ3abnIzZ2UCF7UPwXTmT/trC1DND/Sye
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 1/5] mailmap: add a function to inspect the number of entries
Date:   Sun,  3 Jan 2021 21:18:45 +0000
Message-Id: <20210103211849.2691287-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
References: <20210103211849.2691287-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We're soon going to change the type of our mailmap into an opaque struct
so we can add features and improve performance.  When we do so, it won't
be possible for users to inspect its internals to determine how many
items are present, so let's introduce a function that lets users inquire
how many objects are in the mailmap and use it where we want this
information.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 mailmap.c | 5 +++++
 mailmap.h | 1 +
 pretty.c  | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index 962fd86d6d..c9a538f4e2 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -361,3 +361,8 @@ int map_user(struct string_list *map,
 	debug_mm("map_user:  --\n");
 	return 0;
 }
+
+int mailmap_entries(struct string_list *map)
+{
+	return map->nr;
+}
diff --git a/mailmap.h b/mailmap.h
index d0e65646cb..ff57b05a15 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -5,6 +5,7 @@ struct string_list;
 
 int read_mailmap(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
+int mailmap_entries(struct string_list *map);
 
 int map_user(struct string_list *map,
 			 const char **email, size_t *emaillen, const char **name, size_t *namelen);
diff --git a/pretty.c b/pretty.c
index 7a7708a0ea..43a0039870 100644
--- a/pretty.c
+++ b/pretty.c
@@ -681,7 +681,7 @@ static int mailmap_name(const char **email, size_t *email_len,
 		mail_map = xcalloc(1, sizeof(*mail_map));
 		read_mailmap(mail_map, NULL);
 	}
-	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
+	return mailmap_entries(mail_map) && map_user(mail_map, email, email_len, name, name_len);
 }
 
 static size_t format_person_part(struct strbuf *sb, char part,
