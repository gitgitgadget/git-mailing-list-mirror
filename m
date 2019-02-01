Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 865C41F453
	for <e@80x24.org>; Fri,  1 Feb 2019 19:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfBATkf (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 14:40:35 -0500
Received: from mail525c7.megamailservers.com ([209.235.141.25]:35873 "EHLO
        mail125c7.megamailservers.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbfBATkf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Feb 2019 14:40:35 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2019 14:40:34 EST
X-Authenticated-User: danmcgregor@sasktel.net
X-VIP:  69.49.109.87
Received: from shadrach.duckdns.org (204-83-204-148.prna.hsdb.sasknet.sk.ca [204.83.204.148])
        (authenticated bits=0)
        by mail125c7.megamailservers.com (8.14.9/8.13.1) with ESMTP id x11JUa2c030000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 1 Feb 2019 14:30:38 -0500
Received: by shadrach.duckdns.org (Postfix, from userid 1001)
        id BD14BC112; Fri,  1 Feb 2019 13:30:35 -0600 (CST)
From:   Dan McGregor <dan.mcgregor@usask.ca>
To:     git@vger.kernel.org
Cc:     masayasuzuki@google.com, Dan McGregor <dan.mcgregor@usask.ca>
Subject: [PATCH] http: cast result to FILE *
Date:   Fri,  1 Feb 2019 13:30:04 -0600
Message-Id: <20190201193004.88736-1-dan.mcgregor@usask.ca>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH-RefID: str=0001.0A020206.5C549E5E.009F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-CSC:  0
X-CHA:  v=2.3 cv=eMY9ckh1 c=1 sm=1 tr=0 a=6cqb4ilmvwuDSF4sbTau3A==:117
        a=6cqb4ilmvwuDSF4sbTau3A==:17 a=6l96557QvZYA:10 a=CFTnQlWoA9kA:10
        a=gWDa-L1wAAAA:8 a=KCljDmtMTA85JOKLiEgA:9 a=vg_HiZM2M4GgzivzK9OA:22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 8dd2e88a92 ("http: support file handles for HTTP_KEEP_ERROR",
2019-01-10) introduced an implicit assumption that rewind, fileno, and
fflush are functions. At least on FreeBSD fileno is not, and as such
passing a void * failed.

Explicitly cast result to a FILE * when using standard functions that
may ultimately be macros.

Signed-off-by: Dan McGregor <dan.mcgregor@usask.ca>
---
 http.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 954bebf684..8b9476b151 100644
--- a/http.c
+++ b/http.c
@@ -1996,12 +1996,12 @@ static int http_request_reauth(const char *url,
 		strbuf_reset(result);
 		break;
 	case HTTP_REQUEST_FILE:
-		if (fflush(result)) {
+		if (fflush((FILE *)result)) {
 			error_errno("unable to flush a file");
 			return HTTP_START_FAILED;
 		}
-		rewind(result);
-		if (ftruncate(fileno(result), 0) < 0) {
+		rewind((FILE *)result);
+		if (ftruncate(fileno((FILE *)result), 0) < 0) {
 			error_errno("unable to truncate a file");
 			return HTTP_START_FAILED;
 		}
-- 
2.20.1

