Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8CFC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD1164EBC
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhBKCJg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:09:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45906 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhBKCJc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Feb 2021 21:09:32 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CC9A460B17;
        Thu, 11 Feb 2021 02:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1613009300;
        bh=M9t46w/vM4+qYX83f3WRBZiAP2AXsVCD2DupWiZVol0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=ogcwWr9hsRbvEONEewWZu0WVUViisvPke1Y0+5AsMvRDC7qLPVHMBl8vt7rwJR++S
         5YavN4kOEYNVQQtLuFYY3OKbRiRuckn+rjxqokVbWLd56np2I1xRHRbvkg6V/zrfR+
         t0NQHkxWCUdNoZXs2s2XQWs8N/m6Ox4TAgtUP66qYo9UMecMSdPmO510ysM9ncW/4A
         Fwe8BUbRL/2WnxYSz5B2olaMOhCDz9V5xw9489Fcb3LQ6g4H8UDtscNPqG1rwy6oGj
         acHqwJiYe9cnBo4VADsYQWgDeBoUIWU/6QS76ePBybwFVP/xLM8XudaCxsjeIbPUnx
         iXEan2zsik4vvq2AaKR5YqYex1YB80sPt1EFpu7cC7XlmfDtShNTiSWmAEH6kC2wHc
         tfkmbn4tMFm0YJxfnT5c0szpDgXg2M5VrBKGmySfjcMe+gDEysUjkexPIAtFPeHnh3
         l0wV1tWnxGpVAaPwM7i87CE5jgp3gZH5Mcg7zBHQyI+4wVX/tCN
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 1/6] ref-filter: switch some uses of unsigned long to size_t
Date:   Thu, 11 Feb 2021 02:08:01 +0000
Message-Id: <20210211020806.288523-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210211020806.288523-1-sandals@crustytoothpaste.net>
References: <20210118234915.2036197-1-sandals@crustytoothpaste.net>
 <20210211020806.288523-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we'll want to pass some of the arguments of find_subpos
to strbuf_detach, which takes a size_t.  This is fine on systems where
that's the same size as unsigned long, but that isn't the case on all
systems.  Moreover, size_t makes sense since it's not possible to use a
buffer here that's larger than memory anyway.

Let's switch each use to size_t for these lengths in
grab_sub_body_contents and find_subpos.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ref-filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index fd994e1874..cf617a62e1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1210,10 +1210,10 @@ static void grab_person(const char *who, struct atom_value *val, int deref, void
 }
 
 static void find_subpos(const char *buf,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
+			const char **sub, size_t *sublen,
+			const char **body, size_t *bodylen,
+			size_t *nonsiglen,
+			const char **sig, size_t *siglen)
 {
 	const char *eol;
 	/* skip past header until we hit empty line */
@@ -1285,7 +1285,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
-	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
