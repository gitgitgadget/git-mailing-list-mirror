Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4152B20451
	for <e@80x24.org>; Tue, 13 Dec 2016 23:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbcLMXQd (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 18:16:33 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33765 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbcLMXQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 18:16:31 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so796874pgd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 15:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JcrjzCUYxF9imA8cG3BxSic9z8N+qd6wM1l7/aX3Acw=;
        b=OO0Dmzynkg40K5gnXscoMcjmhqkr9EMp5FGGkdrY/mnK8nT8drzpo5/GPApmdhszo8
         MMm/z3a4VbjmSukQxbVrpNkn9lIutC1boRRt6qoyd1HbxkpDYV5zlJWSUchJcJYGNJ6D
         puRRGjNIDxmUIfm2G2MHA4BfHx2pjBOpLxbK2RZ/4y+TzRrGpvNRZrmWa+Sn1CADn3vi
         k7HHj/NhyY7IHl0z6GevIVJyYqpbqapEkdtDriOEqJwHT8lEsg5bmX/0FrxU1rq2qV9e
         2Zfi3WeNXMUo3aeF3p2RIrSdmHxtG4GnTp5FsRiKyJwOmuLlSndc5k5a38z8Kc5RBLJc
         1KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JcrjzCUYxF9imA8cG3BxSic9z8N+qd6wM1l7/aX3Acw=;
        b=lj75XimAq03K2Q5Ti80M11lb18XPJfdu/bIsIcsOI6Vf39y3Paect4CqJXeD6fLYYS
         q0063I/8P/k1fsLkpQJ67Nfw9RVa2xoUYP+I1qhyJcEhsyH8IfbE+f8r26ZPNnqPeBoO
         HrRAYSqWkxBpHtZD5ppm4slO9Hj3BrSRrCALwIjzELmCUecv8PCtK1l1aIIxwzPusjrI
         Wtr+2qRtSpHfLykW+jFxiBOwfT71YZC5/7qRvi0iqxdoJRFlrBjgQXLjZ0BncAsUoAKA
         vuPHiu69qUSy/tu3IfnTfKUbZYmjKOp+3EVmeYzRfAv/b9W1SRmsbuj46QTzlzudk4Tn
         PStg==
X-Gm-Message-State: AKaTC01of1woqKZNjmzs/UIX7Uf8zqwdBLjHMjG1Cf3i7esfIXiXJRXeyRp1ZHz71W1EvNm/
X-Received: by 10.98.61.152 with SMTP id x24mr103721848pfj.88.1481670885579;
        Tue, 13 Dec 2016 15:14:45 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([172.27.69.28])
        by smtp.gmail.com with ESMTPSA id c15sm82308567pfd.36.2016.12.13.15.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 15:14:44 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com, gitster@pobox.com
Subject: [PATCH v3 04/16] ls-tree: convert show_recursive to use the pathspec struct interface
Date:   Tue, 13 Dec 2016 15:14:18 -0800
Message-Id: <1481670870-66754-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1481670870-66754-1-git-send-email-bmwill@google.com>
References: <1481223550-65277-1-git-send-email-bmwill@google.com>
 <1481670870-66754-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'show_recursive()' to use the pathspec struct interface from
using the '_raw' entry in the pathspec struct.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 0e30d86..d7ebeb4 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -31,21 +31,18 @@ static const  char * const ls_tree_usage[] = {
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
-	const char **s;
+	int i;
 
 	if (ls_options & LS_RECURSIVE)
 		return 1;
 
-	s = pathspec._raw;
-	if (!s)
+	if (!pathspec.nr)
 		return 0;
 
-	for (;;) {
-		const char *spec = *s++;
+	for (i = 0; i < pathspec.nr; i++) {
+		const char *spec = pathspec.items[i].match;
 		int len, speclen;
 
-		if (!spec)
-			return 0;
 		if (strncmp(base, spec, baselen))
 			continue;
 		len = strlen(pathname);
@@ -59,6 +56,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 			continue;
 		return 1;
 	}
+	return 0;
 }
 
 static int show_tree(const unsigned char *sha1, struct strbuf *base,
@@ -175,8 +173,8 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	 * cannot be lifted until it is converted to use
 	 * match_pathspec() or tree_entry_interesting()
 	 */
-	parse_pathspec(&pathspec, PATHSPEC_GLOB | PATHSPEC_ICASE |
-				  PATHSPEC_EXCLUDE,
+	parse_pathspec(&pathspec, PATHSPEC_ALL_MAGIC &
+				  ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
 		       PATHSPEC_PREFER_CWD,
 		       prefix, argv + 1);
 	for (i = 0; i < pathspec.nr; i++)
-- 
2.8.0.rc3.226.g39d4020

