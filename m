Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E9FEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjF0QTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjF0QT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:26 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4987335BE
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:13 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 776245B41A;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=roUffxrrYw+j4Wriq1S2ybBGeuzTJzZlK30/Quqzk3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=QmrR5KFyPk57K33yS+ZlR/uLZDMjalBo0KsrkaMtgiXkI7BO8e+RaKoyul02eIAhD
         ZWXcQ4/dKe0rUjJ7iOGcxIHs/vLR5JIylA/vuOcldJQPg/c6QxEmbyXeJdWE1tJ/od
         H/OPDSO1aFsTn8qthGaUzMSTkbehCBxpAn4Wh9dBx6DmtuTKaLt3trY2QKjzN4MhYg
         fXAm6B28VQnamUzg2rNTTe8tf8n59HdBaEQbL7+FeX1rnZZ2ZHj26x2Ohd/AAK9Th3
         jBVkwGvzQv/7I82lbl+5KC4zkkONbizz0ouOKXfqKG2iO4NnkviorgpTRoTUMFmc5+
         PkztfJ8FZ3SWqCHj+MYKhj5VCu1U2TNlO6l/nRyD2V+29QWM84+vin8cvAXZcg901K
         puBY4AOfCUCdV4WJWbdYvo5M7+A7z6w7JKITj8goD7oK2e74TZUlDhqEKZ4wNDz58Y
         DTS8lbDjONfAvE0uCDEwdWWuk5jhNqfwmdF6qBIbjH0oO1OcDzp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 1/8] var: mark unused parameters in git_var callbacks
Date:   Tue, 27 Jun 2023 16:18:55 +0000
Message-ID: <20230627161902.754472-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230627161902.754472-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230627161902.754472-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We abstract the set of variables into a table, with a "read" callback to
provide the value of each. Each callback takes a "flag" argument, but
most callbacks don't make use of it.

This flag is a bit odd. It may be set to IDENT_STRICT, which make sense
for ident-based callbacks, but is just confusing for things like
GIT_EDITOR.

At first glance, it seems like this is just a hack to let us directly
stick the generic git_committer_info() and git_author_info() functions
into our table. And we'd be better off to wrap them with local functions
which pass IDENT_STRICT, and have our callbacks take no option at all.

But that doesn't quite work. We pass IDENT_STRICT when the caller asks
for a specific variable, but otherwise do not (so that "git var -l" does
not bail if the committer ident cannot be formed).

So we really do need to pass in the flag to each invocation, even if the
individual callback doesn't care about it. Let's mark the unused ones so
that -Wunused-parameter does not complain. And while we're here, let's
rename them so that it's clear that the flag values we get will be from
the IDENT_* set. That may prevent confusion for future readers of the
code.

Another option would be to define our own local "strict" flag for the
callbacks, and then have wrappers that translate that to IDENT_STRICT
where it matters. But that would be more boilerplate for little gain
(most functions would still ignore the "strict" flag anyway).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: brian m. carlson <bk2204@github.com>
---
 builtin/var.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 2149998980..10ee62f84c 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -12,17 +12,17 @@
 
 static const char var_usage[] = "git var (-l | <variable>)";
 
-static const char *editor(int flag)
+static const char *editor(int ident_flag UNUSED)
 {
 	return git_editor();
 }
 
-static const char *sequence_editor(int flag)
+static const char *sequence_editor(int ident_flag UNUSED)
 {
 	return git_sequence_editor();
 }
 
-static const char *pager(int flag)
+static const char *pager(int ident_flag UNUSED)
 {
 	const char *pgm = git_pager(1);
 
@@ -31,7 +31,7 @@ static const char *pager(int flag)
 	return pgm;
 }
 
-static const char *default_branch(int flag)
+static const char *default_branch(int ident_flag UNUSED)
 {
 	return git_default_branch_name(1);
 }
