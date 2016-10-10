Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A969420989
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbcJJR0H (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:62988 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753251AbcJJR0A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:00 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MNHqL-1bmmZR1rcP-006sR0; Mon, 10 Oct 2016 19:25:48
 +0200
Date:   Mon, 10 Oct 2016 19:25:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 14/25] sequencer: introduce a helper to read files written
 by scripts
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <b554346c600fafa71d2a3461fda8402e377b596e.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:BOsPvTNzWp/6snRoJlXKYwPzQ7Lk3MGz2wLgw6HD6RjnkCDv9qg
 yWoqdPGeONX61ObykWT6fTtzu0WH4ee8YqWnOle+q0cvb5PHjgGx+TlGQln0z70JT/ynVGY
 ZZ3WWurqQwpApBTwDdTRf98wTzcp0dp/Pn7Rd/Ut0evNVR1zwB/IvhyAHeAkgbARsyxYQAL
 7oCX0GywOJ1xzI2pd0Cuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JzMvY3iCSOo=:23NU+xjfWWbCzJY/B0J9HE
 AAFqR2tytgIH5VSqdtU0pyJbXVEpIS1bET4SdBjZnqsU39AzVsWNcZBhEshzGOYzHT0eRWyUz
 EiRFvQcifDmENfnc0QG37Dc6A8m/BZ0Rga3OzMK4dyDlqD1sgIAFJBrZenMk9Sgw0vOQfUY8Y
 qHRjkIofgm3uFIckNqj81benedlicRYaAGFKq5g8oRc0Cue5W+xD80XPbdSXn9Uub6A1Dmrue
 ix45LS1SI30lGBqzISxHw/PFLXtO4phbLvx0JfZopUgcmSVPG8uD8WHhbDiP7Bd0EHRLlMFW3
 YTO8s99xcTyZumz3HN6gyfuoKzkbPZtGUu76Cn3dUriYKTsFdI2RMtp7SYg8uIqAMBguUQ2DZ
 EDhHESnwKziLtaE6Hpfvv1EYQKZTeXkQuJyuBGXwdcEl/zbh0v0CqTdON1mxEL/N11+3zUH5F
 7GkcwD+ddpHVBFapMbL0q85PwePc2eaCx2xhHLk9NTMN6dIeDl12fesY4LmTws5Eas8XPLmMj
 K0lmvjbz3tvaWwogFYrOZVexD/ToUjXj6VWVoC7/ef8QnHfs7YliB6FCvMPFvdgWNeWw4QC+p
 dKy1QpxGRGrbhTsONh9lj0WrzB0ZtQ85MPSAVfGSRtaaGjesCjcEq/Oq+kLMWBQAvtWt/o9Sq
 eD+e7R9Sy/q2harTtWVMU6oxK6QErRBVzDsaxBOVMvc3WBpPvL7VZipsi2BlNjz35jEUuQIwH
 7OQk6tq79z2Ahiq7YxiEVesSO1UFGCzmg2Iggcchrws+HNOx9iXXoaGqcooQMXFhig56m7hfK
 zAaJlFd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we are slowly teaching the sequencer to perform the hard work for
the interactive rebase, we need to read files that were written by
shell scripts.

These files typically contain a single line and are invariably ended
by a line feed (and possibly a carriage return before that). Let's use
a helper to read such files and to remove the line ending.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index b694ace..681552a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,6 +234,37 @@ static int write_message(struct strbuf *msgbuf, const char *filename)
 	return 0;
 }
 
+/*
+ * Reads a file that was presumably written by a shell script, i.e.
+ * with an end-of-line marker that needs to be stripped.
+ *
+ * Returns 1 if the file was read, 0 if it could not be read or does not exist.
+ */
+static int read_oneliner(struct strbuf *buf,
+	const char *path, int skip_if_empty)
+{
+	int orig_len = buf->len;
+
+	if (!file_exists(path))
+		return 0;
+
+	if (strbuf_read_file(buf, path, 0) < 0) {
+		warning_errno(_("could not read '%s'"), path);
+		return 0;
+	}
+
+	if (buf->len > orig_len && buf->buf[buf->len - 1] == '\n') {
+		if (--buf->len > orig_len && buf->buf[buf->len - 1] == '\r')
+			--buf->len;
+		buf->buf[buf->len] = '\0';
+	}
+
+	if (skip_if_empty && buf->len == orig_len)
+		return 0;
+
+	return 1;
+}
+
 static struct tree *empty_tree(void)
 {
 	return lookup_tree(EMPTY_TREE_SHA1_BIN);
-- 
2.10.0.windows.1.325.ge6089c1


