Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B994C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 06:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJQGPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 02:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJQGPE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 02:15:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA12EF33
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 23:15:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso8826843wmq.0
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 23:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zDi26FdkCdUmj+41J6lDuOqbgL5usSyPP6K13fQwyA=;
        b=gF26sLAwBo8iKdjVdEpF75nde45KOkVSJqWgdYLKCJWS0YXIsfr8mihSQAg/5P1yY3
         4FToGp2v9oS2JaDO/vqHptDQfHoCofSJaa3+5nMnd6s6xZifH3BKatUKp/28nS/5JNh4
         atdXLcAm+BA3zanYX0Tkny+nT41KKD6cyZx+hhXERrTVopDDqEGwH83S2VzKRY1qcy1N
         vL88A/qe2gG2qPPOm0orBYxm1GlTWiX/bxLDzEhO7/faOpBHfIvyn5lgsrzWlkZxYCmC
         eDRFp+weGJozEHmidK2L/nawjiuBcLGgfX1gLoekcK5F3c7ZcGa4TQtmgO2gQe0q3tzH
         pLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zDi26FdkCdUmj+41J6lDuOqbgL5usSyPP6K13fQwyA=;
        b=ynaHsPT4dRJlcOfoB79IlryGhTmSkPdJqaiaPWNmkNqkidAgZM8iiYdaIlXxCNjCTe
         RZXP4YnR58ajKAn8h5Qr227Yfr1qq5jvp3C+Io8FLrheo1v+vD7qfUpDSruSRwutW7q2
         dAQ7SqUCw2+n9dRAKS0XKWVfV0OOSCVgE2eQPmgyrDLGgld7dDqmqTrwafJKrnWWsang
         EqD5RYQU7R/dykHvEzIjBaNJPKwgN/c6pyiEN4rUtNpg02nV3ExMUrt6+vrC6js8vFZG
         E/CE2Agvy4kwuP7VWTDlT8qx0HGY1xvv+j8lucEqragJjbNQgsyEh5so8WF1NWTZ0d/e
         dlxg==
X-Gm-Message-State: ACrzQf3wcPk+sM4EWQFBjaiT32eHWD7zJE7SpbWTzf4vKXDvP1ho+OF5
        N0QUcxPIuC4xjBZ92Dj7BeAOt87hXas=
X-Google-Smtp-Source: AMsMyM5GJa8NvWl1fRMus4M6mbjSQCHBSjNpEeGz0hIb/rlRIT2ALp4ukQxM7RjGRhYx/Sat6pV+hQ==
X-Received: by 2002:a05:600c:34d4:b0:3c6:f695:b5f8 with SMTP id d20-20020a05600c34d400b003c6f695b5f8mr2834545wmq.203.1665987301231;
        Sun, 16 Oct 2022 23:15:01 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id a15-20020adfeecf000000b00228692033dcsm7393154wrp.91.2022.10.16.23.15.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 23:15:00 -0700 (PDT)
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Subject: [PATCH] path.c: do not alloc for .contents in the trie
Message-ID: <4db3d1ed-d530-2429-f578-33196ff71fb1@gmail.com>
Date:   Mon, 17 Oct 2022 08:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4e09cf2ac (path: optimize common dir checking, 2015-08-31) a trie was
introduced to search non-linearly over common_list.  The nodes in the
trie are constructed from the values in that static variable.  Each of
those nodes can have in .contents a heap allocated string with the
characters to be considered for the node, and in .len the count of this
characters.  Having this .len there is no need to have a local copy of
the string, we can just have in .contents a pointer to a specific
position in the specific string in the specific value in common_list.
Only .len characters will be considered.

Let's make .contents const and remove that unneeded xstrndups.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 path.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/path.c b/path.c
index a3cfcd8a6e..94483d98f9 100644
--- a/path.c
+++ b/path.c
@@ -159,7 +159,7 @@ static struct common_dir common_list[] = {
 struct trie {
 	struct trie *children[256];
 	int len;
-	char *contents;
+	const char *contents;
 	void *value;
 };
 
@@ -167,10 +167,8 @@ static struct trie *make_trie_node(const char *key, void *value)
 {
 	struct trie *new_node = xcalloc(1, sizeof(*new_node));
 	new_node->len = strlen(key);
-	if (new_node->len) {
-		new_node->contents = xmalloc(new_node->len);
-		memcpy(new_node->contents, key, new_node->len);
-	}
+	if (new_node->len)
+		new_node->contents = key;
 	new_node->value = value;
 	return new_node;
 }
@@ -204,10 +202,8 @@ static void *add_to_trie(struct trie *root, const char *key, void *value)
 		memcpy(child->children, root->children, sizeof(root->children));
 
 		child->len = root->len - i - 1;
-		if (child->len) {
-			child->contents = xstrndup(root->contents + i + 1,
-						   child->len);
-		}
+		if (child->len)
+			child->contents = root->contents + i + 1;
 		child->value = root->value;
 		root->value = NULL;
 		root->len = i;
-- 
2.36.1
