Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43881F404
	for <e@80x24.org>; Fri, 23 Feb 2018 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbeBWOsH (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 09:48:07 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45241 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeBWOsF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 09:48:05 -0500
Received: by mail-lf0-f68.google.com with SMTP id x196so12683940lfd.12
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 06:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PEKvxZKN3TTCmHNpcKQJ2EJY6Rgo5Gcq7wuXipb9FW0=;
        b=g0yaOxudx/nWWhWTmS99XjAslYCsYV2iu0AlTKZJ+0rNKYh5qYPDYAdE+nlTj7zGOh
         6S+eWk9GaXoIe/yRJyvXlnkfUaUKCNwJ++uIFqXQH+iFhg5Ium0lDExy5+q29NBA/O6C
         6qcaNN/+NL5riLGrS4InQFJUxw8ZcD0A+DoRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PEKvxZKN3TTCmHNpcKQJ2EJY6Rgo5Gcq7wuXipb9FW0=;
        b=jP3uwjmU7AplW19/h/TxAwXlGFrImxoKk5AeJfAM+Kq9gkZXmdpbIVEAj22hDmR0Ih
         4tx8w/LGfr6r1CPJd+Sj/0XZ+JbYwXrgrhYLYK6cULgTTlQNcTt3Juz/sScAQq+ersNp
         MtZ8raDEsI3sOQ/MumFWxBWNkSh4X1UwhKtEVsGcvfrait6YFOa7rlwAxZ5VipxuzTcA
         4XW1S8WzVBjKygTGlKeVI72Arg8YurYqugm4gI3eLOWB4zd9KzYh6R0ynbDXarMVEsuw
         bqc2N+af+0IigBmsAOgQwGTC1U6JSFKgwCkH0T0MYBkRlgngPSAX/iFZ33y3SlCW+gVK
         gGxg==
X-Gm-Message-State: APf1xPDZUK7NU2UTKhjOpDno7yn+n/ArCsqsLXRNtmI00Ct8dVJ07N/J
        qQkuBQ2EOaUgOz6pg+seaeXiitWfw5E=
X-Google-Smtp-Source: AG47ELuZRYorPC3u8FHKaLQ/U+SPKQzS+IpUUKQ1p4Nqe6sMpxyxUats24DtRuMgcTdRfCkOQEBy4g==
X-Received: by 10.46.66.152 with SMTP id h24mr1527502ljf.42.1519397284032;
        Fri, 23 Feb 2018 06:48:04 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t21sm497958ljd.55.2018.02.23.06.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 06:48:03 -0800 (PST)
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 2/2] grep: simplify grep_oid and grep_file
Date:   Fri, 23 Feb 2018 15:47:57 +0100
Message-Id: <20180223144757.31875-3-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180223144757.31875-1-rv@rasmusvillemoes.dk>
References: <20180215215615.21208-1-rv@rasmusvillemoes.dk>
 <20180223144757.31875-1-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the NO_PTHREADS or !num_threads case, this doesn't change
anything. In the threaded case, note that grep_source_init duplicates
its third argument, so there is no need to keep [path]buf.buf alive
across the call of add_work().

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 builtin/grep.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index aad422bb6..9a8e4fada 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -326,6 +326,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	}
 
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
+	strbuf_release(&pathbuf);
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
@@ -334,14 +335,12 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
-		strbuf_release(&pathbuf);
 		return 0;
 	} else
 #endif
 	{
 		int hit;
 
-		strbuf_release(&pathbuf);
 		hit = grep_source(opt, &gs);
 
 		grep_source_clear(&gs);
@@ -360,6 +359,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		strbuf_addstr(&buf, filename);
 
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
+	strbuf_release(&buf);
 
 #ifndef NO_PTHREADS
 	if (num_threads) {
@@ -368,14 +368,12 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		 * its fields, so do not call grep_source_clear()
 		 */
 		add_work(opt, &gs);
-		strbuf_release(&buf);
 		return 0;
 	} else
 #endif
 	{
 		int hit;
 
-		strbuf_release(&buf);
 		hit = grep_source(opt, &gs);
 
 		grep_source_clear(&gs);
-- 
2.15.1

