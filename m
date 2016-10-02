Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45CC51F4F8
	for <e@80x24.org>; Sun,  2 Oct 2016 16:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbcJBQgC (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Oct 2016 12:36:02 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36512 "EHLO
        iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750927AbcJBQgA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 2 Oct 2016 12:36:00 -0400
Received: from x590cd088.dyn.telefonica.de ([89.12.208.136] helo=localhost.localdomain)
        by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
        iface 141.3.10.81 id 1bqjjz-00042W-0j; Sun, 02 Oct 2016 18:35:56 +0200
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] ref-filter: strip format option after a field name only once while parsing
Date:   Sun,  2 Oct 2016 18:35:11 +0200
Message-Id: <20161002163511.609-1-szeder@ira.uka.de>
X-Mailer: git-send-email 2.10.0.516.gccda3a9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1475426156.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parse_ref_filter_atom() iterates over a list of valid atoms to
check that a field name is one of them, it has to strip the optional
colon-separated format option suffix that might follow the field name.
However, it does so inside the loop, i.e. it performs the exact same
stripping over and over again.

Move stripping the format option suffix out of that loop, so it's only
performed once for each parsed field name.

Signed-off-by: SZEDER Gábor <szeder@ira.uka.de>
---
 ref-filter.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9adbb8af3eaa..9a8f55e45a16 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -235,7 +235,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 {
 	const char *sp;
 	const char *arg;
-	int i, at;
+	int i, at, atom_len;
 
 	sp = atom;
 	if (*sp == '*' && sp < ep)
@@ -250,19 +250,19 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 			return i;
 	}
 
+	/*
+	 * If the atom name has a colon, strip it and everything after
+	 * it off - it specifies the format for this entry, and
+	 * shouldn't be used for checking against the valid_atom
+	 * table.
+	 */
+	arg = memchr(sp, ':', ep - sp);
+	atom_len = (arg ? arg : ep) - sp;
+
 	/* Is the atom a valid one? */
 	for (i = 0; i < ARRAY_SIZE(valid_atom); i++) {
 		int len = strlen(valid_atom[i].name);
-
-		/*
-		 * If the atom name has a colon, strip it and everything after
-		 * it off - it specifies the format for this entry, and
-		 * shouldn't be used for checking against the valid_atom
-		 * table.
-		 */
-		arg = memchr(sp, ':', ep - sp);
-		if (len == (arg ? arg : ep) - sp &&
-		    !memcmp(valid_atom[i].name, sp, len))
+		if (len == atom_len && !memcmp(valid_atom[i].name, sp, len))
 			break;
 	}
 
-- 
2.10.0.516.gccda3a9

