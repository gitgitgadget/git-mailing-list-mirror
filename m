Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6064A20960
	for <e@80x24.org>; Mon, 10 Apr 2017 20:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbdDJUaQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 16:30:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36058 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752099AbdDJUaP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 16:30:15 -0400
Received: by mail-wr0-f196.google.com with SMTP id o21so25539710wrb.3
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 13:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/6BDvbgyTX7ORwyHml4iN/FRPBkqpN9V0mVLP1oiqZg=;
        b=cbYEtQ5TLAIwKZD+Q3x2VGBNTKuJWtj1MEcf/QWmwUMWej6rY+js+YiQDBZ7OIjRHN
         MtgG2lyLSFD0a/5mPgzzijh02NQ8l76RYumJDkj+nR2t/2MegCZH3o2IBNBU6uJvT5og
         +kkVYN+Xokwkr/fRUNU2gwG3lBKIbtXdtw4fHG63GFlIrmtVWQlJv82cpAflWK36nIWk
         aQ3EVNgtIKBb2hfAn2tqyDclK9tT6lrjDSAPMNhcahMox5+mLM3R+DqudbXHEv/EGzEx
         +/NfngfFf3Ygdh13wtw06e58AzYCPL25nHcBrC/YUSclYmLsQ3frYhUZAO1JERS/z1rP
         wP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/6BDvbgyTX7ORwyHml4iN/FRPBkqpN9V0mVLP1oiqZg=;
        b=TZcYYHKfsWIU0+EVjkla3b2lcDOyICDVK6Z1DZkKQY3wKxf6X3qPYDQ84V/x8ADkhq
         wZXRkJbg8ZcHLHP53+QCvN2++o6422ns3Wk4mYWp6i56hIIuKKLpgVrXndg2ZQ+9/e6t
         y+fv92MDMR9kj7JBmWWQFNFZ5CEjqPvGvsm6NPOa8UYEpNzNoc90uzhfUgzaEg1g95Sr
         wrfULqQXiNLViwCv+0Q9eXR6bEdMAYug6eQSU+Cn59BdfbWdvGg2gP23SCLcAorGLNd0
         sOYKJkW402iHsSyx5m4YAlpm2wwm+yjCMOOkM2RIpOpmjQFw4uUVccmh6JsaGY2IDMsR
         Wrsg==
X-Gm-Message-State: AFeK/H0xIA+5byHVmu3FAQ+QQHUVikENGG4/bt/Ja9izMDZQEBT8sAFn0TCLSvharMYcWw==
X-Received: by 10.223.143.107 with SMTP id p98mr31575740wrb.3.1491856214251;
        Mon, 10 Apr 2017 13:30:14 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB54AB.dip0.t-ipconnect.de. [93.219.84.171])
        by smtp.gmail.com with ESMTPSA id 65sm18794796wri.68.2017.04.10.13.30.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 13:30:13 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com
Subject: [PATCH v1] convert: fix return value for apply_multi_file_filter() on SIGPIPE
Date:   Mon, 10 Apr 2017 22:30:11 +0200
Message-Id: <20170410203011.54103-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a pipe write fails and errno is set to EPIPE then we execute the
"error" path. However, as "err" can still be 0 the return value of
apply_multi_file_filter() would indicate success.

Fix this by setting "err" to the value of "errno" in case of a pipe
write failure.

Noticed-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Ref: master
    Web-Diff: https://github.com/larsxschneider/git/commit/41a217c246
    Checkout: git fetch https://github.com/larsxschneider/git errno-check-v1 && git checkout 41a217c246

 convert.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/convert.c b/convert.c
index 8d652bf27c..586e0cdd45 100644
--- a/convert.c
+++ b/convert.c
@@ -753,6 +753,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	sigchain_pop(SIGPIPE);
 
 	if (err || errno == EPIPE) {
+		err = err ? err : errno;
 		if (!strcmp(filter_status.buf, "error")) {
 			/* The filter signaled a problem with the file. */
 		} else if (!strcmp(filter_status.buf, "abort")) {

base-commit: b14f27f91770e0f99f64135348977a0ce1c7993a
-- 
2.12.2

