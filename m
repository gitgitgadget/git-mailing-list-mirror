Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCEFC4167B
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350485AbiBHNOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 08:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350265AbiBHMPC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 07:15:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3BFC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 04:15:01 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so1883363pja.3
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 04:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vFjCb4DmwVr6H1e3h9iSurKdr0K1TaRcLgkxFEYDV8=;
        b=BzCxCzUYYa2qVYmsMxNUBT6Sbm3t+MT4AIrTIY0Sal3+28E+0yTL3dgzsIf3XDC94D
         FEBW7s6n/uY9Rvl2i6QQ4hdW42ULy71Uh1JOK0o1VVuxpy38ME6VbtKLFNFv8sUU7SZR
         sHC46ZgrGNOU1Zn5BRvY1UbOoP0jLl/whWp52zgPTBeGkca9KotvS9mcigYFyuVhvQRx
         5r5I37RQsxitnamnUAeikAUWHEVMOP8cNghHiDTE9L5Tv/8vDB7SyoxX10znXUbka1O2
         QQHcOqkjxNhZX5UtiTjoT2pzyj7sFryYeMiGeAJ066h2DEFmQ3NO1KSPwEhouyxz1+xn
         XdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vFjCb4DmwVr6H1e3h9iSurKdr0K1TaRcLgkxFEYDV8=;
        b=Tl4JNij5vZY5KaF36Gc/Cmi4CmXjzKavC04B8SDhTgAtbyfXTnvv6YfSy4nv2iZ8kw
         r3gnA4lPq+fzvpaurLnv9kcVssTKWs5uf8PQl48zCZV0JJc0s8ayGba3vH4oMp64K0wl
         cBDe/8QMidKPo55asc2fQh9m7PotonVNcufXHnC+pC+m0/fB43foJsrAGQ2u6BJS3z89
         l/Fty4YkFuVMw1n8J2Mnm5O8a+8q1BqoEfV8z5tqJZryDmmBmpoD4WLqFgI6yE6qnrWA
         TyGDXIx0+LOvzYjLSvTLH8WBKxjsgGgw+gjxnjgHhU0Yr+YGmalCxv8fJdFlmz6vEK0y
         y2Jg==
X-Gm-Message-State: AOAM5323TD51M6i5khzixmP5f29URJsrDpym9ADXFjaUNsNYd2FwQn4r
        m2UamInwGR9zL+mBZsmaiic=
X-Google-Smtp-Source: ABdhPJybNJa/XTeGgTQpCOzbvwGn0SYRF1/AbvTpiBGl9HHKj6uNqmOcZQC/jJFsiiN3mAB0510a1w==
X-Received: by 2002:a17:90a:5206:: with SMTP id v6mr1042146pjh.220.1644322501412;
        Tue, 08 Feb 2022 04:15:01 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id t3sm16973344pfg.28.2022.02.08.04.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:15:01 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com,
        Teng Long <dyronetengb@gmail.com>
Subject: [PATCH v11 06/13] ls-tree: simplify nesting if/else logic in "show_tree()"
Date:   Tue,  8 Feb 2022 20:14:31 +0800
Message-Id: <3816a65fe62b1039c396eb38d27bf2c22e8d84de.1644319434.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.403.gb35f2687cf.dirty
In-Reply-To: <cover.1644319434.git.dyroneteng@gmail.com>
References: <cover.1644319434.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit use "object_type()" to get the type, then remove
some of the nested if to let the codes here become more cleaner.

Signed-off-by: Teng Long <dyronetengb@gmail.com>
---
 builtin/ls-tree.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index ef8c414f61..9c57a36c8c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -66,19 +66,13 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 {
 	int recurse = 0;
 	size_t baselen;
-	enum object_type type = OBJ_BLOB;
+	enum object_type type = object_type(mode);
 
-	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
-	} else if (S_ISDIR(mode)) {
-		if (show_recursive(base->buf, base->len, pathname)) {
-			recurse = READ_TREE_RECURSIVE;
-			if (!(ls_options & LS_SHOW_TREES))
-				return recurse;
-		}
-		type = OBJ_TREE;
-	}
-	else if (ls_options & LS_TREE_ONLY)
+	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
+		recurse = READ_TREE_RECURSIVE;
+	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
+		return recurse;
+	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
 		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
-- 
2.34.1.403.gb35f2687cf.dirty

