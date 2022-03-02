Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C667AC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbiCBRLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243697AbiCBRLc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:11:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507DECFB8A
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:10:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u1so3803270wrg.11
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/MuljZWG/x+WplVgacAb4xeHTO6lSPdUvWtQFpFdr2g=;
        b=BZgNdAGzIWCR79MhRdpmj80NTpRx2eV1IimCMWLEgUbhTyaq9YEmFw77qDkTB8shbM
         Oh7pn8B543qgcpzp0EVUVtnYZnurH6WDHDR5I4O6xgFxMt1pCXzEXTdeHnTi8Vs8IAtM
         IHGEL2iAREIk2IHGTpIXY4efonpSvljTN/233EzotqnJo67JlpWWArfn+k0m08orlYML
         NE3hjo/hckMIyx8nxBuPP5OE/+IGNXCYpR0cJOC3/SK7/4OEaXIznqz/NyZIrSvYecr8
         l3EZ7A9eaOOslrtWajgjqcK3VzNxlRmDDJ/sjRVe+eJaiytX8vvUDiRuAS4trOswskmG
         Xwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/MuljZWG/x+WplVgacAb4xeHTO6lSPdUvWtQFpFdr2g=;
        b=taZPacQVnXFs1AA6TogVyIHBc/cG1fVZDb8E1ePszgAdloA/VJTIxP6SE42A+JA/0B
         /o5Qk6i+FlvvMfImf0m5ZfGX6fJTHPBgsDH2WufnSPCKvX/mc3rAjxULc3FBYtDx58O2
         kyCmpATougQtjJbFQ1l24q0QEUwq3Cz8qkPkOjVOevLYuzzBjvurXCxcjPTJwJhb773W
         DDqBVzWOLdH9Fw2dySZZX32rSjL5h6aIY5qKO4MESWXpZeszlU9HgIfPieUAgglvALHn
         YRgXHjCc54SywJ6FsHvHqWzvT8otV/6cceWmmHVHf7x768u7Zv8t97+hD1FotXJdTGFC
         w6LA==
X-Gm-Message-State: AOAM532w5EUXgMubEhFD8sXV1Xymfn/PG6XFVYz/OzQnVhXRo8RggDln
        /vPZEzas1ozjvah3PuEFCSoKCa4U7uhTyg==
X-Google-Smtp-Source: ABdhPJwTZURWR2Nvn1d8UXhgiSto4iJepZ5casIJcvYY9QiIok2m3ZcfLeI3oaIMWtCXkOYOyn7E9A==
X-Received: by 2002:a5d:66c8:0:b0:1ed:b016:aa62 with SMTP id k8-20020a5d66c8000000b001edb016aa62mr23898314wrw.678.1646241036594;
        Wed, 02 Mar 2022 09:10:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b003813b489d75sm6178001wms.10.2022.03.02.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:10:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/14] range-diff: plug memory leak in read_patches()
Date:   Wed,  2 Mar 2022 18:10:19 +0100
Message-Id: <patch-13.14-e7b823f70c8-20220302T170718Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1228.g56895c6ee86
In-Reply-To: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend code added in d9c66f0b5bf (range-diff: first rudimentary
implementation, 2018-08-13) to use a "goto cleanup" pattern. This
makes for less code, and frees memory that we'd previously leak.

The reason for changing free(util) to FREE_AND_NULL(util) is because
at the end of the function we append the contents of "util" to a
"struct string_list" if it's non-NULL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 range-diff.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index b2a2961f521..b72eb9fdbee 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -40,6 +40,7 @@ static int read_patches(const char *range, struct string_list *list,
 	char *line, *current_filename = NULL;
 	ssize_t len;
 	size_t size;
+	int ret = -1;
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=no",
@@ -68,10 +69,10 @@ static int read_patches(const char *range, struct string_list *list,
 	if (strbuf_read(&contents, cp.out, 0) < 0) {
 		error_errno(_("could not read `log` output"));
 		finish_command(&cp);
-		return -1;
+		goto cleanup;
 	}
 	if (finish_command(&cp))
-		return -1;
+		goto cleanup;
 
 	line = contents.buf;
 	size = contents.len;
@@ -95,12 +96,9 @@ static int read_patches(const char *range, struct string_list *list,
 			CALLOC_ARRAY(util, 1);
 			if (get_oid(p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
-				free(util);
-				free(current_filename);
+				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
-				strbuf_release(&buf);
-				strbuf_release(&contents);
-				return -1;
+				goto cleanup;
 			}
 			util->matching = -1;
 			in_header = 1;
@@ -111,11 +109,8 @@ static int read_patches(const char *range, struct string_list *list,
 			error(_("could not parse first line of `log` output: "
 				"did not start with 'commit ': '%s'"),
 			      line);
-			free(current_filename);
 			string_list_clear(list, 1);
-			strbuf_release(&buf);
-			strbuf_release(&contents);
-			return -1;
+			goto cleanup;
 		}
 
 		if (starts_with(line, "diff --git")) {
@@ -136,12 +131,9 @@ static int read_patches(const char *range, struct string_list *list,
 			if (len < 0) {
 				error(_("could not parse git header '%.*s'"),
 				      orig_len, line);
-				free(util);
-				free(current_filename);
+				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
-				strbuf_release(&buf);
-				strbuf_release(&contents);
-				return -1;
+				goto cleanup;
 			}
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
@@ -219,6 +211,9 @@ static int read_patches(const char *range, struct string_list *list,
 		strbuf_addch(&buf, '\n');
 		util->diffsize++;
 	}
+
+	ret = 0;
+cleanup:
 	strbuf_release(&contents);
 
 	if (util)
@@ -226,7 +221,7 @@ static int read_patches(const char *range, struct string_list *list,
 	strbuf_release(&buf);
 	free(current_filename);
 
-	return 0;
+	return ret;
 }
 
 static int patch_util_cmp(const void *dummy, const struct patch_util *a,
-- 
2.35.1.1228.g56895c6ee86

