Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66901F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfGAOqJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:46:09 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48086 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfGAOqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:46:09 -0400
Received: by mail-pf1-f201.google.com with SMTP id f25so8911823pfk.14
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0JhjSv/cDBl67LJ1rJqf4EGtcLtjCHcQTlMhWD7PD5s=;
        b=Z1Vd7dr/QhxWq10LzZf26pay9WbN3pPRppvKzXT5d1h61rm2v2QjDc8OUfXX66KgCX
         fpZ+pJrJIsuC8vAsaXgNQsQpfRlgJvzpKd/ESbwzTU0IOXMSMLwSsX+nfZ94mar7mUq6
         zmwe/QPhz4vhedpLWOZ0fJ1iBlY6WJtMpwMfeDbag42pxLNBpXivmnWtwI9m+w53CEFM
         bDkFPu/wQRrf9mekVr9rok/C6kQhcJxAuJunOl7+WvSR8qN4MUP0/iUES+rvECLD+dRo
         UYpvd5SZxrTtG6fotzLIdeHatAFfw3P0TQ7C+dWqt7cwU27aQXPjbNc1Y2KSWOtcvnKe
         QNYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0JhjSv/cDBl67LJ1rJqf4EGtcLtjCHcQTlMhWD7PD5s=;
        b=J+ivbA9TO3/gdh5sa76m0vzoNusM45Ft2Hvxs+F70kkJ/tNOGq23AgjO4BCYDAuEsf
         wdTAx/kht10M4zyOYXBp0u2A1g7kwTQ43gxz1pqK0uGr5TLxlVjybXKLqviyNPw2iPKg
         bZrzDZN4Tx+zanxaGhFqJfQli5jArJkxrKweawWyBw61g1qDDQ6zUDsUxW2hzcmSrjmK
         H8uV87VkCIEzAXhDNa0lm7xyiImoMN4iiR/qLuKobaZIZMkJ+vJ22AymxTAfuQLHhc1G
         toDIVL6n19bHgJuhSdVQRXNEFKZuqzZenUWwJtBWUMFlGvcUGo0MNsmxFyXk9DIaLoTg
         85og==
X-Gm-Message-State: APjAAAXpSZ4eL8zTtlttFXVupoJepTSRedf6b0S2yIdHgIlXcky1h6rF
        V9jgPPNTIzbFFPXolry+sTKmLRKPj3FU1bCWQE7kJIaG4J7SaB7kMUaKQEVBjMfD2SeLhx70Hgu
        A2+SVs8Vcfr+EzX3TEdGOqwoccimZELeIzIfOatmgOQYpTfphx57a
X-Google-Smtp-Source: APXvYqyX+f+RtHfNWCexohrrBsHEnA0y3YUolPCGhnWjh8M0DtUVJsRQXDoWZtKbOJD1kTw/KsbMc5lx
X-Received: by 2002:a65:5c47:: with SMTP id v7mr3363344pgr.44.1561992368245;
 Mon, 01 Jul 2019 07:46:08 -0700 (PDT)
Date:   Mon,  1 Jul 2019 10:45:42 -0400
In-Reply-To: <20190701144548.129635-1-brho@google.com>
Message-Id: <20190701144548.129635-4-brho@google.com>
Mime-Version: 1.0
References: <20190701144548.129635-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v10 3/9] blame: use a helper function in blame_chunk()
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
2.22.0.410.gd8fdbe21b5-goog

