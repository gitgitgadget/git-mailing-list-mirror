Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 201661FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751816AbdBIN2j (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:28:39 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54452 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751058AbdBIN2P (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 08:28:15 -0500
X-AuditID: 1207440e-059ff70000000a39-10-589c6e3be2b0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 10.1D.02617.B3E6C985; Thu,  9 Feb 2017 08:27:23 -0500 (EST)
Received: from bagpipes.fritz.box (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19DRB5H023019
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 08:27:21 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 5/5] read_loose_refs(): read refs using resolve_ref_recursively()
Date:   Thu,  9 Feb 2017 14:27:02 +0100
Message-Id: <024d6b2e5ca1ffa876c2911e6d9d0bb4f6091730.1486629195.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsUixO6iqGudNyfC4OExTYuuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJabN7czuLA7vH3/Qcmj52z7rJ7fPgY57FgU6lHV/sRNo+L
        l5Q9Pm+SC2CP4rJJSc3JLEst0rdL4Mq4eeoRc8EtkYrTR/6zNzC2C3QxcnJICJhIbJp6la2L
        kYtDSOAyo8Tbv4vYIZyTTBIX2ncwglSxCehKLOppZgKxRQTUJCa2HWIBKWIWWM8kcXreB1aQ
        hLBAoMTGn1vZQGwWAVWJC13nWEBsXoEoiYmLe9gh1slJXNr2hRnE5hSwkPg94QrYAiEBc4m/
        x78zTWDkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJMD4djC2r5c5
        xCjAwajEw3vBenaEEGtiWXFl7iFGSQ4mJVHeiP9AIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8
        KTlzIoR4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8f0EaBYtS01Mr
        0jJzShDSTBycIMN5gIZfARteXJCYW5yZDpE/xagoJc6bDZIQAElklObB9cISwCtGcaBXhHm/
        g1TxAJMHXPcroMFMQIOvn54FMrgkESEl1cDI479hlccbifhc8R1lchxt0rz5DQuX/6rZEvFs
        e2Big+mLyP9R90yk/cvZ2M2XuTA7bD3taLE78Hm+bu0jXsFlKSKxO+U+beLIuJF9XpJ/7hc7
        o2PyUdt0TyW0vEgO9920d9OKN0vVNZIN7z21ttD6doeR7cPpvVrfPwiU79nxPEXNNHvD2+tK
        LMUZiYZazEXFiQCaHaXT2wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to call read_ref_full() or resolve_gitlink_ref() from
read_loose_refs(), because we already have a ref_store object in hand.
So we can call resolve_ref_recursively() ourselves. Happily, this
unifies the code for the submodule vs. non-submodule cases.

This requires resolve_ref_recursively() to be exposed to the refs
subsystem, though not to non-refs code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  8 ++++----
 refs/files-backend.c | 18 ++++--------------
 refs/refs-internal.h |  5 +++++
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 6012f67..210a453 100644
--- a/refs.c
+++ b/refs.c
@@ -1235,10 +1235,10 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 }
 
 /* This function needs to return a meaningful errno on failure */
-static const char *resolve_ref_recursively(struct ref_store *refs,
-					   const char *refname,
-					   int resolve_flags,
-					   unsigned char *sha1, int *flags)
+const char *resolve_ref_recursively(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    unsigned char *sha1, int *flags)
 {
 	static struct strbuf sb_refname = STRBUF_INIT;
 	int unused_flags;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 069a8ee..f087a99 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1267,20 +1267,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					 create_dir_entry(refs, refname.buf,
 							  refname.len, 1));
 		} else {
-			int read_ok;
-
-			if (refs->submodule) {
-				hashclr(sha1);
-				flag = 0;
-				read_ok = !resolve_gitlink_ref(refs->submodule,
-							       refname.buf, sha1);
-			} else {
-				read_ok = !read_ref_full(refname.buf,
-							 RESOLVE_REF_READING,
-							 sha1, &flag);
-			}
-
-			if (!read_ok) {
+			if (!resolve_ref_recursively(&refs->base,
+						     refname.buf,
+						     RESOLVE_REF_READING,
+						     sha1, &flag)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			} else if (is_null_sha1(sha1)) {
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 73281f5..af9e5fe 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -673,4 +673,9 @@ struct ref_store *lookup_ref_store(const char *submodule);
  */
 struct ref_store *get_ref_store(const char *submodule);
 
+const char *resolve_ref_recursively(struct ref_store *refs,
+				    const char *refname,
+				    int resolve_flags,
+				    unsigned char *sha1, int *flags);
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.9.3

