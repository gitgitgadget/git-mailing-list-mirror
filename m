Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546DD20375
	for <e@80x24.org>; Tue, 14 Mar 2017 02:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753981AbdCNCKm (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 22:10:42 -0400
Received: from crossperf.com ([5.39.84.17]:35799 "EHLO crossperf.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753645AbdCNCKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 22:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crossperf.com; s=rsa2048; h=Message-ID:Sender:Content-Transfer-Encoding:
        Content-Type:Mime-Version:Subject:References:In-Reply-To:Cc:To:From:Date:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZD4GWDEORltl+WVhIZsNocpFVUuqKeKBGr1TBNHXewA=; b=Gza/FVsMXhw4CleJNXxlS5ZlvA
        kwoxlD9CK5mhQJrCoBAgX9jg9Bo/n99zqooR03hMFpYA3eOCRFDTBmNu4an9e1tA+nsopMdl5fvCY
        wtVodDT0hSDDDqeju33VZOPscTadwR/yk0nyVpLCVShrU51jlXVzAbXQaBHnWQabf3zwWyGUCsbzO
        qPle7OglV+8+iPN+4n/sOOB/bSk14C7AmA4REqrJAzGE2y1qfNnJdPFwh1ZuxtXG/VL09XdyH0nGa
        XT++mkX/QLdFwfoS3dAUms40Tnx8G1iKOzATWayGg8SYcNvBTI+jmlWGKd8JGh2Em67lywRQSnIfV
        XHSAgFng==;
Date:   Tue, 14 Mar 2017 02:10:24 +0000
From:   mash <mash+git@crossperf.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
In-Reply-To: <1488007487-12965-5-git-send-email-kannan.siddharth12@gmail.com>
References: <1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com>
 <1488007487-12965-5-git-send-email-kannan.siddharth12@gmail.com>
Subject: [PATCH 6/6 v5] sha1_name.c: avoid parsing @{-1} unnecessarily
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Message-ID: <1cnbut-0000Vd-Rz@crossperf.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move dash is previous branch check to get_sha1_basic.
Introduce helper function that gets nth prior branch switch from reflog.

Signed-off-by: mash <mash+git@crossperf.com>
---
RE: [PATCH 4/6 v5] sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
> +	if (*name == '-' && len == 1) {
> +		name = "@{-1}";
> +		len = 5;
> +	}

We could avoid parsing @{-1} unnecessarily with something like this patch.

Forgive me I don't understand how the patch numbering works just yet. This is
6/6 because format-patch made it 6/6 with however I got the patches applied on
my end. This should apply cleanly on pu anyways.

Thanks to Stefan since he suggested that I might want to review this.

mash

 sha1_name.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2f86bc9..363bbe7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -568,6 +568,7 @@ static inline int push_mark(const char *string, int len)
 }
 
 static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
+static int get_branch_switch(int nth, struct strbuf *buf);
 static int interpret_nth_prior_checkout(const char *name, int namelen, struct strbuf *buf);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
@@ -628,11 +629,12 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 	if (len && ambiguous_path(str, len))
 		return -1;
 
-	if (nth_prior) {
+	if (nth_prior || !strcmp(str, "-")) {
 		struct strbuf buf = STRBUF_INIT;
 		int detached;
 
-		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
+		if (nth_prior ? interpret_nth_prior_checkout(str, len, &buf) > 0
+			      : get_branch_switch(1, &buf) > 0) {
 			detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
 			strbuf_release(&buf);
 			if (detached)
@@ -1078,6 +1080,25 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	return 0;
 }
 
+static int get_branch_switch(int nth, struct strbuf *buf)
+{
+	int retval;
+	struct grab_nth_branch_switch_cbdata cb;
+
+	cb.remaining = nth;
+	strbuf_init(&cb.buf, 20);
+
+	retval = for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch,
+					     &cb);
+	if (0 < retval) {
+		strbuf_reset(buf);
+		strbuf_addbuf(buf, &cb.buf);
+	}
+
+	strbuf_release(&cb.buf);
+	return retval;
+}
+
 /*
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
@@ -1086,8 +1107,6 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 					struct strbuf *buf)
 {
 	long nth;
-	int retval;
-	struct grab_nth_branch_switch_cbdata cb;
 	const char *brace;
 	char *num_end;
 
@@ -1103,18 +1122,8 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 		return -1;
 	if (nth <= 0)
 		return -1;
-	cb.remaining = nth;
-	strbuf_init(&cb.buf, 20);
 
-	retval = 0;
-	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
-		strbuf_reset(buf);
-		strbuf_addbuf(buf, &cb.buf);
-		retval = brace - name + 1;
-	}
-
-	strbuf_release(&cb.buf);
-	return retval;
+	return 0 < get_branch_switch(nth, buf) ? brace - name + 1 : 0;
 }
 
 int get_oid_mb(const char *name, struct object_id *oid)
-- 
2.9.3
