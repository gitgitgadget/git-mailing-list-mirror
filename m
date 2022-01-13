Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A84AC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 03:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiAMDmf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 22:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiAMDmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 22:42:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526CDC061756
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:32 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so8970224pji.3
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 19:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnvutfgoPVy8ARQIFqCSevdqjzHGqHwG1IPa3F2O7Tc=;
        b=pI+mevWKSJODGz2HMAm2bZ+ra6hyp6wv8CeXz77xD4EVuIF1+ysBJAy4PdW9AVtJhf
         7saEPDJjxCy/ws1vxJ1iUdLXmhe2FvoiNGEwmRnZRAARlHtZ/mEaV7pGLKPisPs0r4jM
         MC1idilxEifT3AaYdbIUQwtAtgiYwIlKj8cY9d9CoscVrTYixTbLMUqiWisZuMsgp1I9
         aICDofttwBpMpSwYg+LtHapLzb2TrnenzbnwX+kzs8ssNSjxpOp42VF6tRzRiQFByWOj
         EfTkuKk9DprPKKptcQvx9QoVwm84w53QCmNLbM5/nvsMfbBHIvYm4hpg0lXDwBWa/hJp
         ZASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnvutfgoPVy8ARQIFqCSevdqjzHGqHwG1IPa3F2O7Tc=;
        b=PHsOwb3FR92q89JWRoxvR3ths1o7YV86ixlTx3sTg49P8nwzEmb7IWtIWQdofzyUHQ
         KkO70CZpgCKC8314BaW3PEl0qhKtGWd9AbYS61KRevHYPksk2YB4rhGBV7GQiwYfAT8q
         KxmHcrNcBRDriUuOXGULqKtgK0Fqb3z937RrhoNwY8d8itoggkiHWzOS1+CS57Jq65a8
         zkFEeewX8Y3jCfDmeSNobvVOTRefPuyC6afm5SLDkLPalzskbL48GRknHZpfrDkZFAUu
         jmmnG/+a/wMVl3NKPFj31XjF80O4Mvkspb9aoJ28kC6C93WE2x55FldBk/6jezBoAPpf
         w3NA==
X-Gm-Message-State: AOAM530oWPN/tyEFayCJor5jeotnIQ8CofGzbjGgDzzHJIOkgtOaWoUW
        1M7fh9ao653iKFJY/ko3at/FG+4ux7xXmlCxWzE=
X-Google-Smtp-Source: ABdhPJw1Wh7abfQZ3Csx/pyV/O/ZUZjgkMdxOgBb1cg8HYN2qH2LeCBHzDpfq+jIGOxNbI/E9SkT6g==
X-Received: by 2002:a17:902:c404:b0:14a:1594:2e69 with SMTP id k4-20020a170902c40400b0014a15942e69mr2576351plk.167.1642045351821;
        Wed, 12 Jan 2022 19:42:31 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.48])
        by smtp.gmail.com with ESMTPSA id c20sm879436pgk.75.2022.01.12.19.42.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jan 2022 19:42:31 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com,
        Teng Long <dyronetengb@gmail.com>
Subject: [PATCH v10 5/9] ls-tree: optimize naming and handling of "return" in show_tree()
Date:   Thu, 13 Jan 2022 11:42:08 +0800
Message-Id: <b04188c822c32aab6ef59099a0c9078aeda065c3.1641978175.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.390.g2ae0a9cb82.dirty
In-Reply-To: <cover.1641978175.git.dyroneteng@gmail.com>
References: <cover.1641978175.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The variable which "show_tree()" return is named "retval", a name that's
a little hard to understand. This commit tries to make the variable
and the related codes more clear in the context.

The commit firstly rename "retval" to "recurse" which is a more
meaningful name than before. Secondly, "get_type()" is introduced
to setup the "type" by "mode", this will remove some of the nested if.
After this, The codes here become a little bit clearer, so we do not
need to take a look at "read_tree_at()" in "tree.c" to make sure the
context of the return value.

Signed-off-by: Teng Long <dyronetengb@gmail.com>
---
 builtin/ls-tree.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index eecc7482d5..9729854a3d 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -61,24 +61,27 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
 	return 0;
 }
 
+static enum object_type get_type(unsigned int mode)
+{
+	return (S_ISGITLINK(mode)
+	        ? OBJ_COMMIT
+	        : S_ISDIR(mode)
+	        ? OBJ_TREE
+	        : OBJ_BLOB);
+}
+
 static int show_tree(const struct object_id *oid, struct strbuf *base,
 		const char *pathname, unsigned mode, void *context)
 {
-	int retval = 0;
+	int recurse = 0;
 	size_t baselen;
-	enum object_type type = OBJ_BLOB;
-
-	if (S_ISGITLINK(mode)) {
-		type = OBJ_COMMIT;
-	} else if (S_ISDIR(mode)) {
-		if (show_recursive(base->buf, base->len, pathname)) {
-			retval = READ_TREE_RECURSIVE;
-			if (!(ls_options & LS_SHOW_TREES))
-				return retval;
-		}
-		type = OBJ_TREE;
-	}
-	else if (ls_options & LS_TREE_ONLY)
+	enum object_type type = get_type(mode);
+
+	if (type == OBJ_TREE && show_recursive(base->buf, base->len, pathname))
+		recurse = READ_TREE_RECURSIVE;
+	if (type == OBJ_TREE && recurse && !(ls_options & LS_SHOW_TREES))
+		return recurse;
+	if (type == OBJ_BLOB && (ls_options & LS_TREE_ONLY))
 		return 0;
 
 	if (!(ls_options & LS_NAME_ONLY)) {
@@ -109,7 +112,7 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
 				   chomp_prefix ? ls_tree_prefix : NULL,
 				   stdout, line_termination);
 	strbuf_setlen(base, baselen);
-	return retval;
+	return recurse;
 }
 
 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
-- 
2.34.1.390.g2ae0a9cb82.dirty

