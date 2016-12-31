Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA4720C24
	for <e@80x24.org>; Sat, 31 Dec 2016 03:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754714AbcLaDOD (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Dec 2016 22:14:03 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62485 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754632AbcLaDNY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 30 Dec 2016 22:13:24 -0500
X-AuditID: 12074413-44dff70000000a33-fe-5867224a910b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id AC.5B.02611.A4227685; Fri, 30 Dec 2016 22:13:17 -0500 (EST)
Received: from bagpipes.fritz.box (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV3D6tw010692
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 30 Dec 2016 22:13:13 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/23] safe_create_leading_directories(): set errno on SCLD_EXISTS
Date:   Sat, 31 Dec 2016 04:12:44 +0100
Message-Id: <ea26c628a22d169063b781d87ea961f4b787a8f4.1483153436.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1483153436.git.mhagger@alum.mit.edu>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsUixO6iqOurlB5hsGydrEXXlW4mi4beK8wW
        t1fMZ7ZY8vA1s8WPlh5mB1aPv+8/MHl0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mo79PsBW0MVTcfzlVaYGxoOcXYycHBICJhLnuvYxdzFycQgJXGaU2D+nmRXCOc4k8fnT
        ORaQKjYBXYlFPc1MILaIgJrExLZDLCBFzAITGSWmbbkElhAWCJX4+X82G4jNIqAq0fRpNVgz
        r0CUxOmfa1gh1slJXNr2hRnE5hSwkFj8qQ+sV0jAXGLdzkvMExh5FjAyrGKUS8wpzdXNTczM
        KU5N1i1OTszLSy3SNdfLzSzRS00p3cQICR7hHYy7TsodYhTgYFTi4X1wIy1CiDWxrLgy9xCj
        JAeTkiivpWVqhBBfUn5KZUZicUZ8UWlOavEhRgkOZiUR3oVy6RFCvCmJlVWpRfkwKWkOFiVx
        XrUl6n5CAumJJanZqakFqUUwWRkODiUJXgVFoEbBotT01Iq0zJwShDQTByfIcB6g4f4gNbzF
        BYm5xZnpEPlTjIpS4rxrFYASAiCJjNI8uF5YdL9iFAd6RZiXFaSdB5gY4LpfAQ1mAhqslpMM
        MrgkESEl1cAo/fqafsP8hwvtM7Ny1+8/2NK7p7Xe9tz1EyefTtZO/MOTsdk21+vELK4Dei+0
        C7e93ZPYrK/x1/pN0MvvIvlr57wyPaPDl/496U5m+PKc19KzuoytPm9PnH/+DLuf1cu5776t
        9lu5aJXL7W0WsZ0y11W6313h3btX6FrZhXUXmLTmlVnZJHPbKbEUZyQaajEXFScCAJky8JrJ
        AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The exit path for SCLD_EXISTS wasn't setting errno, which some callers
use to generate error messages for the user. Fix the problem and
document that the function sets errno correctly to help avoid similar
regressions in the future.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 cache.h     | 5 +++--
 sha1_file.c | 4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index a50a61a..8177c3a 100644
--- a/cache.h
+++ b/cache.h
@@ -1031,8 +1031,9 @@ int adjust_shared_perm(const char *path);
 
 /*
  * Create the directory containing the named path, using care to be
- * somewhat safe against races.  Return one of the scld_error values
- * to indicate success/failure.
+ * somewhat safe against races. Return one of the scld_error values to
+ * indicate success/failure. On error, set errno to describe the
+ * problem.
  *
  * SCLD_VANISHED indicates that one of the ancestor directories of the
  * path existed at one point during the function call and then
diff --git a/sha1_file.c b/sha1_file.c
index 10395e7..ae8f0b4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -137,8 +137,10 @@ enum scld_error safe_create_leading_directories(char *path)
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode))
+			if (!S_ISDIR(st.st_mode)) {
+				errno = ENOTDIR;
 				ret = SCLD_EXISTS;
+			}
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
 			    !stat(path, &st) && S_ISDIR(st.st_mode))
-- 
2.9.3

