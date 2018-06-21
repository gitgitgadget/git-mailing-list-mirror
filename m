Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8FD31F516
	for <e@80x24.org>; Thu, 21 Jun 2018 12:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933631AbeFUMKg (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 08:10:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42735 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933199AbeFUMKd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 08:10:33 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so2933719wrk.9
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 05:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ugsbBtltNSw8lzFqeBPCAmY3T/SGqJWCvYA0OvWKF38=;
        b=fZoOmAPm4iXRaJxiRNmkc+Lw1KnNcA4+Db5iZ3giFjfyYDWfico+H/sEO05oA5ohtr
         X5gUefgJ33JVaqrXEDeZgAaqFpKbNANhOo0T5FbgQUeptQMTx9CITb0WC7vQWc0wFUhh
         hrt7ONaXRWmBUG4D0NTLF8gW5oNyAd1ItAKfBgsOrbUosRx/sHT86tV+ltmA5uC40Cks
         vrfyTEbd2vAsp+6bv+/O/Lt5P7lagl9wGUSV+uVzi1GkC9YNKEEGyvfb2E1TxWwa4DJQ
         hSfqKafrsgpUJvDAQ3inwoYkyxO1YPMipwmY9c38QggZiUBkoZ8OvRIFl2iAA6/1m00M
         81pg==
X-Gm-Message-State: APt69E1TvHQNdzNVwnfdUAiM/dFzut+LgZhLbFsITUx/yVo9dD6hUdtE
        QyNwbUeT5zP5oFlA89ZkjIdW+vg1KjE+Cw==
X-Google-Smtp-Source: ADUXVKLBmK3orJYNZEkn6MglgfUCw5p/AC26jEEOB0V1Lj6DyZqb0vD99hMbx+IVH0GJ03B1ClB9uA==
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr20729122wro.279.1529583032217;
        Thu, 21 Jun 2018 05:10:32 -0700 (PDT)
Received: from skisela-redhat.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s13-v6sm4659856wrq.48.2018.06.21.05.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 05:10:31 -0700 (PDT)
From:   Sebastian Kisela <skisela@redhat.com>
X-Google-Original-From: Sebastian Kisela <sebastian.kisela@gmail.com>
To:     git@vger.kernel.org
Cc:     nico@fluxnic.net, larsxschneider@gmail.com, lfleischer@lfos.de,
        skisela@redhat.com
Subject: [PATCH] Sanitize escape char sequences coming from server
Date:   Thu, 21 Jun 2018 14:10:30 +0200
Message-Id: <20180621121030.1721-1-sebastian.kisela@gmail.com>
X-Mailer: git-send-email 2.14.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sebastian Kisela <skisela@redhat.com>

Fix volnurability against MITM attacks on client side
by replacing non printable and non white space characters
by "?".

Fixes: CVE-2018-1000021
Signed-off-by: Sebastian Kisela <skisela@redhat.com>
---
 sideband.c              | 20 ++++++++++++++++++++
 t/t5401-update-hooks.sh | 23 +++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/sideband.c b/sideband.c
index 325bf0e97..8c9d74ace 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,3 +1,4 @@
+#include <wchar.h>
 #include "cache.h"
 #include "pkt-line.h"
 #include "sideband.h"
@@ -18,6 +19,20 @@
 #define ANSI_SUFFIX "\033[K"
 #define DUMB_SUFFIX "        "
 
+int sanitize_server_message(struct strbuf *outbuf)
+{
+	wchar_t *wcstring = xmalloc(sizeof(wchar_t) * outbuf->len);
+	int len = mbstowcs(wcstring, outbuf->buf, outbuf->len);
+	if (len == -1)
+		return 1;
+	for(int i = 0; i <= len; i++)
+		if(!isprint(wcstring[i]) && !isspace(wcstring[i]) )
+			wcstring[i] = '?';
+		if (wcstombs(outbuf->buf, wcstring, outbuf->len) == -1)
+			return 1;
+	return 0;
+}
+
 int recv_sideband(const char *me, int in_stream, int out)
 {
 	const char *suffix;
@@ -74,6 +89,9 @@ int recv_sideband(const char *me, int in_stream, int out)
 				} else {
 					strbuf_addch(&outbuf, *brk);
 				}
+
+				if (sanitize_server_message(&outbuf))
+					retval = SIDEBAND_REMOTE_ERROR;
 				xwrite(2, outbuf.buf, outbuf.len);
 				strbuf_reset(&outbuf);
 
@@ -97,6 +115,8 @@ int recv_sideband(const char *me, int in_stream, int out)
 
 	if (outbuf.len) {
 		strbuf_addch(&outbuf, '\n');
+		if (sanitize_server_message(&outbuf))
+			retval = SIDEBAND_REMOTE_ERROR;
 		xwrite(2, outbuf.buf, outbuf.len);
 	}
 	strbuf_release(&outbuf);
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 7f278d8ce..cc1f6ca29 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -148,4 +148,27 @@ test_expect_success 'pre-receive hook that forgets to read its input' '
 	git push ./victim.git "+refs/heads/*:refs/heads/*"
 '
 
+cat <<EOF >expect
+remote: foo?[0;31mbar?[0m
+To ./victim.git
+ * [new branch]      victim_branch -> victim_branch
+EOF
+cat >victim.git/hooks/pre-receive <<'EOF'
+#!/bin/sh
+  printf "foo\033[0;31mbar\033[0m"
+  exit 0
+EOF
+chmod u+x victim.git/hooks/pre-receive
+test_expect_success 'pre-receive stderr contains ANSI colors' '
+	rm -f victim.git/hooks/update victim.git/hooks/post-receive &&
+
+  git branch victim_branch master &&
+	git push ./victim.git "+refs/heads/victim_branch:refs/heads/victim_branch"\
+    >send.out 2>send.err &&
+
+  cat send.err > actual &&
+
+  test_cmp expect actual
+'
+
 test_done
-- 
2.14.4

