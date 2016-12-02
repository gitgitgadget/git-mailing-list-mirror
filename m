Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CCFE1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759402AbcLBUbd (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Dec 2016 15:31:33 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37849 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759294AbcLBUba (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 15:31:30 -0500
Received: by mail-wm0-f41.google.com with SMTP id t79so25839108wmt.0
        for <git@vger.kernel.org>; Fri, 02 Dec 2016 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xr27eq0ZJBfgBNnqLUDZDEExS9Rntp5KnJlcYhXyse4=;
        b=fS0fm6IFV754FRBVKfvpHbL5S6do3/1nBqbqzT4vMjx8Q4J/98oH76zuKo8iuSzMkl
         cwvzxwpPFr2r/SaraCXBr+OKuAq19o8KymTz0d85xghk13YcPKAyYZyUDkpztFp4THBp
         BccHK2R7c4d1mKX0A7qTwqL2ZFLd8QBh3eN2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xr27eq0ZJBfgBNnqLUDZDEExS9Rntp5KnJlcYhXyse4=;
        b=A2XkXaYBv9w2l3QsLHa6Y1nEddHM3x1fiYTlMSJteS5axcku9TbCFLjtd6SR/abQvh
         uCKu5AVvcT94oD7WztUPlNpwpBp9NV89SwCZKwNGc93Sw4inZ/xOSeODbli641iGkzae
         ETKsGPuNOtPocd9Kufq4JACyzLBxXRDRUJG5W7n1msaVA9Tm2h7OzxKUQJ58nYW/j5y5
         p5f1up2WK6s6Khac7O/KZTN7zDLXYFwGsvErtI/3gQZ0D0GPOz6o/hCjZEzBnrAsinde
         385vaop1UZORCIPoQmyRJpl+NR+8pWzqxQf5uvbV4oYVUtDXGLI1awRrssw3uYxEd6XN
         j/2A==
X-Gm-Message-State: AKaTC02Rhf8w/dujaKU/w87glZj2R/mi+CwYDMzO0j/ho3yY20CecmuQF2YCHXH1yQBCdw==
X-Received: by 10.28.1.135 with SMTP id 129mr4916616wmb.108.1480710688802;
        Fri, 02 Dec 2016 12:31:28 -0800 (PST)
Received: from lvps87-230-87-209.dedicated.hosteurope.de (wildmoose.dk. [87.230.87.209])
        by smtp.gmail.com with ESMTPSA id w79sm4938178wmw.0.2016.12.02.12.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Dec 2016 12:31:28 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 3/4] shallow.c: bit manipulation tweaks
Date:   Fri,  2 Dec 2016 21:31:03 +0100
Message-Id: <1480710664-26290-3-git-send-email-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, 1 << 31 is technically undefined behaviour, so let's just
use an unsigned literal.

If i is 'signed int' and gcc doesn't know that i is positive, gcc
generates code to compute the C99-mandated values of "i / 32" and "i %
32", which is a lot more complicated than simple a simple shifts/mask.

The only caller of paint_down actually passes an "unsigned int" value,
but the prototype of paint_down causes (completely well-defined)
conversion to signed int, and gcc has no way of knowing that the
converted value is non-negative. Just make the id parameter unsigned.

In update_refstatus, the change in generated code is much smaller,
presumably because gcc is smart enough to see that i starts as 0 and is
only incremented, so it is allowed (per the UD of signed overflow) to
assume that i is always non-negative. But let's just help less smart
compilers generate good code anyway.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 shallow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/shallow.c b/shallow.c
index 8b1c35d..5aec5a5 100644
--- a/shallow.c
+++ b/shallow.c
@@ -464,7 +464,7 @@ static uint32_t *paint_alloc(struct paint_info *info)
  * all walked commits.
  */
 static void paint_down(struct paint_info *info, const unsigned char *sha1,
-		       int id)
+		       unsigned int id)
 {
 	unsigned int i, nr;
 	struct commit_list *head = NULL;
@@ -476,7 +476,7 @@ static void paint_down(struct paint_info *info, const unsigned char *sha1,
 	if (!c)
 		return;
 	memset(bitmap, 0, bitmap_size);
-	bitmap[id / 32] |= (1 << (id % 32));
+	bitmap[id / 32] |= (1U << (id % 32));
 	commit_list_insert(c, &head);
 	while (head) {
 		struct commit_list *p;
@@ -650,11 +650,11 @@ static int add_ref(const char *refname, const struct object_id *oid,
 
 static void update_refstatus(int *ref_status, int nr, uint32_t *bitmap)
 {
-	int i;
+	unsigned int i;
 	if (!ref_status)
 		return;
 	for (i = 0; i < nr; i++)
-		if (bitmap[i / 32] & (1 << (i % 32)))
+		if (bitmap[i / 32] & (1U << (i % 32)))
 			ref_status[i]++;
 }
 
-- 
2.1.4

