Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6322F2070D
	for <e@80x24.org>; Sat, 31 Dec 2016 03:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754666AbcLaDNe (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:13:34 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62488 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754662AbcLaDNd (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:33 -0500
X-AuditID: 12074413-465ff70000000a33-0c-5867225b8c92
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DD.5B.02611.B5227685; Fri, 30 Dec 2016 22:13:31 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6uB010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:30 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/23] delete_ref_loose(): derive loose reference path from lock
Date:   Sat, 31 Dec 2016 04:12:57 +0100
Message-Id: <c9627b22c46572c8a76c6a3d9ca81f221c2d2b59.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsUixO6iqButlB5h0LDIxqLrSjeTRUPvFWaL
        2yvmM1ssefia2eJHSw+zA6vH3/cfmDy62o+weTzr3cPocfGSssfnTXIBrFFcNimpOZllqUX6
        dglcGdvnnWEueMlW8XZiZQPjYdYuRk4OCQETieW/1zB3MXJxCAlcZpTYsngrE0hCSOA4k8TH
        yfkgNpuArsSinmawuIiAmsTEtkMsIA3MAhMZJaZtuQSWEBYIlrh/+TTYVBYBVYkVC28zg9i8
        AlESR26/Y4LYJidxadsXsDingIXE4k99UMvMJdbtvMQ8gZFnASPDKka5xJzSXN3cxMyc4tRk
        3eLkxLy81CJdc73czBK91JTSTYyQwBHewbjrpNwhRgEORiUe3gc30iKEWBPLiitzDzFKcjAp
        ifJaWqZGCPEl5adUZiQWZ8QXleakFh9ilOBgVhLhXSiXHiHEm5JYWZValA+TkuZgURLnVVui
        7ickkJ5YkpqdmlqQWgSTleHgUJLgXagI1ChYlJqeWpGWmVOCkGbi4AQZzgM03B+khre4IDG3
        ODMdIn+KUZfjwPsVT5mEWPLy81KlxHnXKgAVCYAUZZTmwc2BRfwrRnGgt4R5a0FG8QCTBdyk
        V0BLmICWqOUkgywpSURISTUwijgeju7LbXSdkGm8QjGftXnJ6+NnvqixzE+8LPmZ2XeLr4am
        /DTXs2pKWzt2ZQU9ML5qFJTia7zwRUHyP9f917wtg5v7VE9Hu1qJCJSFLdZ7tblm5xL72L8L
        Om9r5VWVbzu6dbWa9ksfi82GMfXhy6xTYo0V2xae6U5t/v5yv1+07lOP+yuUWIozEg21mIuK
        EwEdyv/g0wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is simpler to derive the path to the file that must be deleted from
"lock->ref_name" than from the lock_file object.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index a4e0de5..847af81 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2430,10 +2430,7 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 		 * loose.  The loose file name is the same as the
 		 * lockfile name, minus ".lock":
 		 */
-		char *loose_filename = get_locked_file_path(lock->lk);
-		int res = unlink_or_msg(loose_filename, err);
-		free(loose_filename);
-		if (res)
+		if (unlink_or_msg(git_path("%s", lock->ref_name), err))
 			return 1;
 	}
 	return 0;
-- 
2.9.3

