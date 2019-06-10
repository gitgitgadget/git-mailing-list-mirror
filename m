Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7EF41F462
	for <e@80x24.org>; Mon, 10 Jun 2019 15:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390395AbfFJPab (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 11:30:31 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45666 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389786AbfFJPab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 11:30:31 -0400
Received: by mail-qk1-f201.google.com with SMTP id u129so8413856qkd.12
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PKQ1Uzhehz2HdPsSKFyIwH51YZIvUrvrL9wzn5xJgYU=;
        b=FRbb/BDl+vynYfSJx6Keh36+nmAbH7bQvPoO8s779nPf4Yg5F6PH2TuGgcoo9scFgW
         rNzNeIPjI08LN0Bj26PGdLK06FdfZJ8Z+Dqk2NVm90GvKP8r9Jc6Mp9k7fvtU59hfcwM
         Dr3rEtk995OOb7PhXVdlByFgJ9o+R+vyqvDqVJFvNHXWyy4kFKsjPXOT15SYrPExU3En
         4wDD8XiSB+3F/bAioQuZ0M9v6JGlfceDG9WaeGpaakoEOkVuzXloj8bsoYMVw7ZTSLCL
         ibYfzyap7Rxz0NaRkwAeFqq7pSwvb8YYb5+E0Iy8zFtKU78s4OJGplO6RX9jhHG3AEiC
         QYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PKQ1Uzhehz2HdPsSKFyIwH51YZIvUrvrL9wzn5xJgYU=;
        b=UkR4PmDJbZ3hvSQabt84V+I/MP8jHgqg+95u7JsF2zAeUNq3tRnYE6c4LwpADzCz1p
         V2SLk0GCO8FWiJ6xr6/zA5Scr3/qpNbZDbY7Wu1HFTP5d7jxgxxecMFu+64pqwGlN0Tj
         lBa2/Ut7UJSTLNFs6ZbKxbgzZGbk/katQp70oz94o8X5IeyostxNA5kGTS3ec/afxVvo
         ohxgRYF7k7Ts91BCw5wesVZvK9oKx0WmxM8aY7XPESmbZxGnBZoVW7QN7qcwXhv9gYSb
         Zxefta1vwNVFZ+p02B+r/0EJhktB+TtpGjVDy3wPFrq8Xzy1dfk1BSN5Wj9oy3xX0/Kc
         l78Q==
X-Gm-Message-State: APjAAAWgqxdQ/TdUbRT55sptuH3scD8CskkoZIwmV/tQVrZK0ZxxkLSe
        h3sNj9wgFf/jEur2KuIXVCk6cH7PW4pNZ4fkhKOqRZS+t6h+YAUFdt/RiK+E0+jlldFbAWV+MXi
        k+K5vDrqyZDk5ZHt9KUatJAX8Q3inD93VVa1J5Ymsox04ajDCcATn
X-Google-Smtp-Source: APXvYqznlDaf/ZbKfIva0s1zKayKmwODDrJ3jKV9kKu1OoljPy6813HevnO78iEHJk2akFXCRtl4XaJR
X-Received: by 2002:a0c:8b54:: with SMTP id d20mr57601570qvc.1.1560180630380;
 Mon, 10 Jun 2019 08:30:30 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:30:08 -0400
In-Reply-To: <20190610153014.42055-1-brho@google.com>
Message-Id: <20190610153014.42055-4-brho@google.com>
Mime-Version: 1.0
References: <20190610153014.42055-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v8 3/9] blame: use a helper function in blame_chunk()
From:   Barret Rhoden <brho@google.com>
To:     git@vger.kernel.org
Cc:     "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?Ren=C3=A9=20Scharfe?=" <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same code for splitting a blame_entry at a particular line was used
twice in blame_chunk(), and I'll use the helper again in an upcoming
patch.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 blame.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/blame.c b/blame.c
index 145eaf2faf9c..5369be9a2233 100644
--- a/blame.c
+++ b/blame.c
@@ -839,6 +839,27 @@ static struct blame_entry *reverse_blame(struct blame_entry *head,
 	return tail;
 }
 
+/*
+ * Splits a blame entry into two entries at 'len' lines.  The original 'e'
+ * consists of len lines, i.e. [e->lno, e->lno + len), and the second part,
+ * which is returned, consists of the remainder: [e->lno + len, e->lno +
+ * e->num_lines).  The caller needs to sort out the reference counting for the
+ * new entry's suspect.
+ */
+static struct blame_entry *split_blame_at(struct blame_entry *e, int len,
+					  struct blame_origin *new_suspect)
+{
+	struct blame_entry *n = xcalloc(1, sizeof(struct blame_entry));
+
+	n->suspect = new_suspect;
+	n->lno = e->lno + len;
+	n->s_lno = e->s_lno + len;
+	n->num_lines = e->num_lines - len;
+	e->num_lines = len;
+	e->score = 0;
+	return n;
+}
+
 /*
  * Process one hunk from the patch between the current suspect for
  * blame_entry e and its parent.  This first blames any unfinished
@@ -865,14 +886,9 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 		 */
 		if (e->s_lno + e->num_lines > tlno) {
 			/* Move second half to a new record */
-			int len = tlno - e->s_lno;
-			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = e->suspect;
-			n->lno = e->lno + len;
-			n->s_lno = e->s_lno + len;
-			n->num_lines = e->num_lines - len;
-			e->num_lines = len;
-			e->score = 0;
+			struct blame_entry *n;
+
+			n = split_blame_at(e, tlno - e->s_lno, e->suspect);
 			/* Push new record to diffp */
 			n->next = diffp;
 			diffp = n;
@@ -919,14 +935,10 @@ static void blame_chunk(struct blame_entry ***dstq, struct blame_entry ***srcq,
 			 * Move second half to a new record to be
 			 * processed by later chunks
 			 */
-			int len = same - e->s_lno;
-			struct blame_entry *n = xcalloc(1, sizeof (struct blame_entry));
-			n->suspect = blame_origin_incref(e->suspect);
-			n->lno = e->lno + len;
-			n->s_lno = e->s_lno + len;
-			n->num_lines = e->num_lines - len;
-			e->num_lines = len;
-			e->score = 0;
+			struct blame_entry *n;
+
+			n = split_blame_at(e, same - e->s_lno,
+					   blame_origin_incref(e->suspect));
 			/* Push new record to samep */
 			n->next = samep;
 			samep = n;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

