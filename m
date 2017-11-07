Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA6520281
	for <e@80x24.org>; Tue,  7 Nov 2017 06:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbdKGGkV (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 01:40:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51315 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754806AbdKGGkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 01:40:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DA72A0B47;
        Tue,  7 Nov 2017 01:40:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=Rr38
        0I64aW9wsjfrBAfGvr3m+Bs=; b=s7MkhmNfo+oMZI7AHMPb6RKFEyxyECz4u/DE
        hGd7Vkd4XfLapk5g8ACrldm4d2uri7p6YCnpy/nBLtEb0sZetap3W3sBzUdbqAQg
        yGwa2VsMEhWYf22CnjsrQ1svn7rAjowQww8GlzfloGEpIkckW3GXT6/of8oU9XE0
        5d/veW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=Tt0GTj
        BjjzqmbL5Ky58pfI/LyTKsaN9PUCshZv9+tbOduc0UEZYsbAbSWm7eZtMYONJinC
        0xZ6ytX/qUviASnGVznkozAXoMICro5ewN1xV0AtpbcXg2vDBnksaAz62AJIZZjF
        iNEIB0YzHYdpQDvarXuaygfmqPQvA3TlQMUDY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 958A6A0B46;
        Tue,  7 Nov 2017 01:40:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11E32A0B45;
        Tue,  7 Nov 2017 01:40:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/2] xdiff: reassign xpparm_t.flags bits
Date:   Tue,  7 Nov 2017 15:40:10 +0900
Message-Id: <20171107064011.18399-2-gitster@pobox.com>
X-Mailer: git-send-email 2.15.0-263-g47cc852023
In-Reply-To: <20171107064011.18399-1-gitster@pobox.com>
References: <xmqqshe7j0af.fsf@gitster.mtv.corp.google.com>
 <20171107064011.18399-1-gitster@pobox.com>
X-Pobox-Relay-ID: 8284C078-C386-11E7-B806-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have packed the bits too tightly in such a way that it is not
easy to add a new type of whitespace ignoring option, a new type
of LCS algorithm, or a new type of post-cleanup heuristics.

Reorder bits a bit to give room for these three classes of options
to grow.  Also make use of XDF_WHITESPACE_FLAGS macro where we check
any of these bits are on, instead of using DIFF_XDL_TST() macro on
individual possibilities.  That way, the "is any of the bits on?"
code does not have to change when we add more ways to ignore
whitespaces.

While at it, add a comment in front of the bit definitions to
clarify in which structure these defined bits may appear.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c        |  4 +---
 xdiff/xdiff.h | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index 74283d9001..790250fe86 100644
--- a/diff.c
+++ b/diff.c
@@ -3434,9 +3434,7 @@ void diff_setup_done(struct diff_options *options)
 	 * inside contents.
 	 */
 
-	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
-	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
-	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
+	if ((options->xdl_opts & XDF_WHITESPACE_FLAGS))
 		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index b090ad8eac..cbf5d8e166 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -27,22 +27,26 @@
 extern "C" {
 #endif /* #ifdef __cplusplus */
 
+/* xpparm_t.flags */
+#define XDF_NEED_MINIMAL (1 << 0)
 
-#define XDF_NEED_MINIMAL (1 << 1)
-#define XDF_IGNORE_WHITESPACE (1 << 2)
-#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
-#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
-#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE | XDF_IGNORE_WHITESPACE_AT_EOL)
+#define XDF_IGNORE_WHITESPACE (1 << 1)
+#define XDF_IGNORE_WHITESPACE_CHANGE (1 << 2)
+#define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 3)
+#define XDF_WHITESPACE_FLAGS (XDF_IGNORE_WHITESPACE | \
+			      XDF_IGNORE_WHITESPACE_CHANGE | \
+			      XDF_IGNORE_WHITESPACE_AT_EOL)
 
-#define XDF_PATIENCE_DIFF (1 << 5)
-#define XDF_HISTOGRAM_DIFF (1 << 6)
+#define XDF_IGNORE_BLANK_LINES (1 << 7)
+
+#define XDF_PATIENCE_DIFF (1 << 14)
+#define XDF_HISTOGRAM_DIFF (1 << 15)
 #define XDF_DIFF_ALGORITHM_MASK (XDF_PATIENCE_DIFF | XDF_HISTOGRAM_DIFF)
 #define XDF_DIFF_ALG(x) ((x) & XDF_DIFF_ALGORITHM_MASK)
 
-#define XDF_IGNORE_BLANK_LINES (1 << 7)
-
-#define XDF_INDENT_HEURISTIC (1 << 8)
+#define XDF_INDENT_HEURISTIC (1 << 23)
 
+/* xdemitconf_t.flags */
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_FUNCCONTEXT (1 << 2)
 
-- 
2.15.0-263-g47cc852023

