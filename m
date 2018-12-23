Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E5D720A1E
	for <e@80x24.org>; Sun, 23 Dec 2018 23:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeLWX1Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Dec 2018 18:27:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46651 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbeLWX1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Dec 2018 18:27:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so4911279pgp.13
        for <git@vger.kernel.org>; Sun, 23 Dec 2018 15:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wl2+uX4HUUEbvHENVQM2slZX0Q8JXPpjqLUnctAL/WE=;
        b=MZ0iWHcGnIyX3gaSfZWU6N0sUM9UwWRjercp3EzfAUR6UCBQ3depavhW4uy7dG6TUR
         uo62ul5WPhWR+eHaKzFJAzBmpxHory1p30FZ6En7QWFDH04cD6t3lVszhUVG0sWGSyhq
         Ft2mEk0fg+uXdzrEwtkEOa5T+Kxp9ETJRV8hJsCF539++uUJUsjO3jhcrzOJo3PZLNnc
         qmiNI+Njz/APb/WbYbtoA6kvcldCRoOJkDTA5+Eg+D0fu/0IYma2/H2aiR9cVaALy+P4
         1toq8eqVUiLjf87E+zw7dFitRHpzSAGqv3vyaBb/xWSbpTQBaS9zYT2hpugY8KXVXZ/a
         +Ciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wl2+uX4HUUEbvHENVQM2slZX0Q8JXPpjqLUnctAL/WE=;
        b=ZMIuW8apbPCQJj8jF5LQ/b9O30rhDqUPSbFs0Gzhc9k8wOWjCEm7Z5ZV6PUaxp1+ex
         sqYhvE42PPKDRgnhjBXtHYnO9zNawu6vwkn/Al2GajALgicO4j2kF9CECJ6o7JyHMXDU
         E3l59CilTdZXMVV/iOK4OS/laHtAOrLhrxjDq4xMTPbB8cmgMki6QKJG2k+Iuy4M16dz
         ph99hmLZekhDhl1N64X2SJNlntEt6q5qdO1GtI1TsniJk6Pg+QhelHr6SwBqS8oUS1VC
         kQgC8N0LtQ115WV3GzodcGcetRw7HMcR9xx9qBCiWtCooC42iWrdFFT5T0odoVc5qi6V
         lYGw==
X-Gm-Message-State: AJcUukfVg4DI8lN4yZgSSG6MFWEjie1vsd8x59xzEjrz01nDbaXQWrq0
        nqf7rv8+DL4SEXgvuAlERomwEaPb
X-Google-Smtp-Source: AFSGD/W8ZWaO8LtGRxjweXoa4pMGySTa/gyhPmWveaYm+0k0SHy+CMYiF+qjWhLfkpM/6fn7Y8lTHw==
X-Received: by 2002:a62:59c9:: with SMTP id k70mr11103060pfj.243.1545607642835;
        Sun, 23 Dec 2018 15:27:22 -0800 (PST)
Received: from stanhu-geo-primary.c.gitlab-internal-153318.internal (99.88.197.35.bc.googleusercontent.com. [35.197.88.99])
        by smtp.gmail.com with ESMTPSA id z9sm76336268pfd.99.2018.12.23.15.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Dec 2018 15:27:22 -0800 (PST)
From:   Stan Hu <stanhu@gmail.com>
To:     git@vger.kernel.org, stanhu@gmail.com
Subject: [PATCH] sha1-name.c: Fix handling of revisions that contain paths with brackets
Date:   Sun, 23 Dec 2018 23:27:16 +0000
Message-Id: <20181223232716.6339-1-stanhu@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, calling ls-tree with a revision such as
`master^{tree}:foo/{{path}}` would show the root tree instead of the
correct tree pointed by foo/{{path}}. If a colon is present in the revision
name, peel_onion() should assume that the presence of a bracket
at the end of the string belongs to the filename.

Signed-off-by: Stan Hu <stanhu@gmail.com>
---
 sha1-name.c               | 14 +++++++++++++-
 t/t3104-ls-tree-braces.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)
 create mode 100644 t/t3104-ls-tree-braces.sh

diff --git a/sha1-name.c b/sha1-name.c
index faa60f69e3..69ecf0a26c 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -1001,9 +1001,21 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 	 * "ref^{commit}".  "commit^{tree}" could be used to find the
 	 * top-level tree of the given commit.
 	 */
-	if (len < 4 || name[len-1] != '}')
+	if (len < 4)
 		return -1;
 
+	/* Check for names in ref:path format in case the path includes
+	 * brackets (e.g. ref^{type}:foo/{{bar}}).
+	 */
+	for (sp = name; sp < name + len; sp++) {
+		if (*sp == ':')
+			return -1;
+	}
+
+	if (sp == name && name[len-1] != '}') {
+		return -1;
+	}
+
 	for (sp = name + len - 1; name <= sp; sp--) {
 		int ch = *sp;
 		if (ch == '{' && name < sp && sp[-1] == '^')
diff --git a/t/t3104-ls-tree-braces.sh b/t/t3104-ls-tree-braces.sh
new file mode 100644
index 0000000000..3ead86c4fe
--- /dev/null
+++ b/t/t3104-ls-tree-braces.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+
+test_description='ls-tree with a folder with braces'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p "newdir/{{curly}}" &&
+	touch "newdir/{{curly}}/one" &&
+	git add "newdir/{{curly}}/one" &&
+	git commit -m test
+'
+
+test_expect_success 'ls-tree with curly brace folder' '
+	cat >expect <<-EOF &&
+	100644 blob $EMPTY_BLOB	one
+	EOF
+	git ls-tree -r "HEAD:newdir/{{curly}}" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'ls-tree with type restriction and curly brace folder' '
+	cat >expect <<-EOF &&
+	100644 blob $EMPTY_BLOB	one
+	EOF
+	git ls-tree "HEAD^{tree}:newdir/{{curly}}" >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.19.1

