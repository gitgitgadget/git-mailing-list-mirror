Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CD01F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfFTQii (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:38:38 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:41836 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfFTQih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:38:37 -0400
Received: by mail-vs1-f74.google.com with SMTP id a200so1068989vsd.8
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 09:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0JhjSv/cDBl67LJ1rJqf4EGtcLtjCHcQTlMhWD7PD5s=;
        b=qsBroerz+yhBKSFTQN2WqkCKmdFNHY9w3WSS6S5a6GGzn1yPKSb4V1MTdUvF74PVGN
         +ri/1R5gDNIl8ZtYr5/PCETCxZ1joPAAFMn2jDJfd4vrNg3X59mBDMn/398baTKY0w3V
         A504K86kZWylJfKnT7KIpW1YG1ajQ7FqipV5WkvtUWJ2Otghb1n10Io8/73rw4VItUlp
         evUddgkjOWXIgoVx2y8TGCmgRKkrixN7KdjLomEqGVOql7WSUwVN5JMbxrEfD/H6cRaL
         7dbxY5YqvQ5BrAQ4f0SA+dWD9sDw/YFrkDMSCmkXusJpYyj7J+E3jWgqPo2skm92qYBB
         UbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0JhjSv/cDBl67LJ1rJqf4EGtcLtjCHcQTlMhWD7PD5s=;
        b=rj+0T3u28uDWE1LsO/Ky92UrCl/QJoRjg7HTlDpin406pFNueisKF/jI6u46BBMpln
         7yCz/2Kt8HP24qCJmODBO5EHkrD4acLw///5n3Oh8xmLsJnjrsn2POQEM+cmMFhufWl/
         f8X2wBlQFPrm9ecp7uQayfQuyKUSNGK5o7OYvL1mf0PJMITpb4PFtHCC0yz2D2bwdWJb
         aI/NDtoIR4TQZSXdXIa2VPmHqm6PXSbpccthxanpLW7CoCir5nLlukqOcV0TtQn5ZyR5
         Zh8Px6u3LZiZ6s9Il/xZIOUKPu07nZ0TZlYzkA6MMRHIHNioiwWcN+0AD3Qvx/NKbq5y
         awDA==
X-Gm-Message-State: APjAAAW/ckpb4jmpWuLmp2YB6oy4IxU90U8wBUyUOO6l7vgPA2ApB0cn
        yf0DlJd1YO9/fRUYRQumHPnR3JOfmwNwDpihsfXciaPedbzOLNOLYVd5rp2h5V6eFkJZrN/w2AR
        5w5ZbwpEk4EkAfyTnOQune5G8+TxftdX5wm0RVsapkDOGn8GKO0Lc
X-Google-Smtp-Source: APXvYqwOSlRokopA9mMriKKM1ezkRlfg8pInL1qR6p8q1gkn1h93JhdcB6jC5hXxd8A/UPG72NTIQ9HO
X-Received: by 2002:ab0:2789:: with SMTP id t9mr3625324uap.69.1561048716670;
 Thu, 20 Jun 2019 09:38:36 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:38:14 -0400
In-Reply-To: <20190620163820.231316-1-brho@google.com>
Message-Id: <20190620163820.231316-4-brho@google.com>
Mime-Version: 1.0
References: <20190620163820.231316-1-brho@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v9 3/9] blame: use a helper function in blame_chunk()
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

