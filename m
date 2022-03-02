Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E942C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbiCBRLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbiCBRLP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:15 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5A5793B6
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:32 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i66so1552749wma.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KRuOCIhV1ryoVBMNBsoKP/W+0/8xwy5JpZ99TTPpRvQ=;
        b=ELWIceEKlA/UfLZ/8qj5zB8QGrhARs7DQ00IqugM8anETxBM0kh1VqbHavmmLzdAS7
         Fzxkd2tCuL8iiI8HttjTPVja/k/X3zjgETFJTaZW1gKYuE0BCXGfIuNWoFzmD5M7tkLb
         +Fj4adrCjxpvLJs5uNXEeLgPw5EIyoucYTXP6aUrW/5QOOP/FUSqh6jL6+A8ERPlRMeI
         TJcVanTslLGzIkRUEB/pYn4sCn/SJIW+XzLUxCqrYKjcGqgJOQuoUEVT49HZpLK9EBMa
         xyAG0SkOdKx8qQpCc6oI5eZP5KcSkzBo3OE9emaSpaYQkdIL9ODu3Je34uJIyAYL8djN
         pOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KRuOCIhV1ryoVBMNBsoKP/W+0/8xwy5JpZ99TTPpRvQ=;
        b=Ruk2DE0nu+K3uR59MuABHhDPkEkFdWPlUzwXmgwyvWYfji0UM9J4rGZz+w+wZMhu5b
         cjBDQqZCp0iRdEk6m2fTsgH+FwRHoOkYuHNEGBI8P/s/MaSYtR2JKfFdCbqacGtW7Y8m
         ZcigZgat1jKQQdobBE5dYrZYoWmqGSzzTy/LLGZbfRCQeLUtmXWJdL88X94ziNV3G7nc
         7aMzObKbk8NX4izpDyOpXWDz6tvPyoLy5T5GDv7qRB17PO3rBMvWEJs67J7gR7cEZSQu
         h3GGNqX9UP6kbJ5bnUHBOnAM7Nsuy1oRIHwhowpbhl6ypZyK069GZDzmgeQcSQT0kPJh
         PZ+Q==
X-Gm-Message-State: AOAM5334t41QsKYL9tgQ9abyLoiMyBQC5foRy1OYxsbLD93x127D4eRS
        /JyGuRLIE5XJjHBTf5QucEC62R3bPoFpzQ==
X-Google-Smtp-Source: ABdhPJwmusX6cjmMctQtyg5n1AhGNQj5d80sJT0QVViBufZJtRNh2jfTTf81qgHCHB2BRJpv+SS7lQ==
X-Received: by 2002:a05:600c:4a02:b0:380:deae:2c2d with SMTP id c2-20020a05600c4a0200b00380deae2c2dmr600265wmp.133.1646241030509;
        Wed, 02 Mar 2022 09:10:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/14] transport: stop needlessly copying bundle header references
Date:   Wed,  2 Mar 2022 18:10:13 +0100
Message-Id: <patch-07.14-be62ca89bf5-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the logic added in fddf2ebe388 (transport: teach all vtables to
allow fetch first, 2019-08-21) and save ourselves pointless work in
fetch_refs_from_bundle().

The fetch_refs_from_bundle() caller doesn't care about the "struct
ref *result" return value of get_refs_from_bundle(), and doesn't need
any of the work we were doing in looping over the
"data->header.references" in get_refs_from_bundle().

So this change saves us work, and also fixes a memory leak that we had
when called from fetch_refs_from_bundle(). The other caller of
get_refs_from_bundle() is the "get_refs_list" member we set up for the
"struct transport_vtable bundle_vtable". That caller does care about
the "struct ref *result" return value.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 transport.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/transport.c b/transport.c
index 253d6671b1f..9a7d32b4b7d 100644
--- a/transport.c
+++ b/transport.c
@@ -125,6 +125,19 @@ struct bundle_transport_data {
 	unsigned get_refs_from_bundle_called : 1;
 };
 
+static void get_refs_from_bundle_inner(struct transport *transport)
+{
+	struct bundle_transport_data *data = transport->data;
+
+	if (data->fd > 0)
+		close(data->fd);
+	data->fd = read_bundle_header(transport->url, &data->header);
+	if (data->fd < 0)
+		die(_("could not read bundle '%s'"), transport->url);
+
+	transport->hash_algo = data->header.hash_algo;
+}
+
 static struct ref *get_refs_from_bundle(struct transport *transport,
 					int for_push,
 					struct transport_ls_refs_options *transport_options)
@@ -136,15 +149,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 	if (for_push)
 		return NULL;
 
-	data->get_refs_from_bundle_called = 1;
-
-	if (data->fd > 0)
-		close(data->fd);
-	data->fd = read_bundle_header(transport->url, &data->header);
-	if (data->fd < 0)
-		die(_("could not read bundle '%s'"), transport->url);
-
-	transport->hash_algo = data->header.hash_algo;
+	get_refs_from_bundle_inner(transport);
 
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct string_list_item *e = data->header.references.items + i;
@@ -168,8 +173,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
 	if (transport->progress)
 		strvec_push(&extra_index_pack_args, "-v");
 
-	if (!data->get_refs_from_bundle_called)
-		get_refs_from_bundle(transport, 0, NULL);
+	if (!data->get_refs_from_bundle_called++)
+		get_refs_from_bundle_inner(transport);
 	ret = unbundle(the_repository, &data->header, data->fd,
 		       &extra_index_pack_args);
 	transport->hash_algo = data->header.hash_algo;
-- 
2.35.1.1228.g56895c6ee86

