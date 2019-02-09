Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DD9D1F453
	for <e@80x24.org>; Sat,  9 Feb 2019 02:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfBICgq (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 21:36:46 -0500
Received: from mail519c7.megamailservers.com ([209.235.141.19]:32855 "EHLO
        mail119c7.megamailservers.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfBICgq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 21:36:46 -0500
X-Authenticated-User: danmcgregor@sasktel.net
X-VIP:  69.49.109.87
Received: from shadrach.duckdns.org (204-83-204-148.prna.hsdb.sasknet.sk.ca [204.83.204.148])
        (authenticated bits=0)
        by mail119c7.megamailservers.com (8.14.9/8.13.1) with ESMTP id x192agfp031404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Feb 2019 21:36:43 -0500
Received: by shadrach.duckdns.org (Postfix, from userid 1001)
        id 4C7CD8622; Fri,  8 Feb 2019 20:36:41 -0600 (CST)
From:   Dan McGregor <dan.mcgregor@usask.ca>
To:     git@vger.kernel.org
Cc:     Dan McGregor <dan.mcgregor@usask.ca>
Subject: [PATCH v2] git-compat-util: undefine fileno if defined
Date:   Fri,  8 Feb 2019 20:36:21 -0600
Message-Id: <20190209023621.75255-1-dan.mcgregor@usask.ca>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201193004.88736-1-dan.mcgregor@usask.ca>
References: <20190201193004.88736-1-dan.mcgregor@usask.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH-RefID: str=0001.0A020205.5C5E3CBB.005B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=M/pj1R4s c=1 sm=1 tr=0 a=6cqb4ilmvwuDSF4sbTau3A==:117
        a=6cqb4ilmvwuDSF4sbTau3A==:17 a=6l96557QvZYA:10 a=CFTnQlWoA9kA:10
        a=gWDa-L1wAAAA:8 a=_na0suTFRNiqHvkgmA4A:9 a=vg_HiZM2M4GgzivzK9OA:22
        a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
2019-01-10) introduced an implicit assumption that rewind, fileno, and
fflush are functions. At least on FreeBSD fileno is not, and as such
passing a void * failed.

All systems tested (FreeBSD and NetBSD) that define fineo as a macro
also have a function defined. Undefine the macro on these systems so
that the function is used.

Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
---
 git-compat-util.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 29a19902aa..b5489bbcf2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -764,6 +764,15 @@ char *gitstrdup(const char *s);
 extern FILE *git_fopen(const char*, const char*);
 #endif
 
+/* Some systems (the various BSDs for eaxmple) define
+ * fileno as a macro as an optimization. All systems I
+ * know about also define it as a real funcion, so use
+ * the real function to allow passing void *s to fileno.
+ */
+#ifdef fileno
+# undef fileno
+#endif
+
 #ifdef SNPRINTF_RETURNS_BOGUS
 #ifdef snprintf
 #undef snprintf
-- 
2.20.1

