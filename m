From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] diff: prevent pprint_rename from underrunning input
Date: Tue, 26 Feb 2013 21:47:01 +0100
Message-ID: <d74fcfa693e5feb7249023feda8d3ad1f22ab16d.1361911196.git.trast@student.ethz.ch>
References: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 21:47:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UARQy-0000r1-CK
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 21:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759705Ab3BZUrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 15:47:06 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:41065 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759678Ab3BZUrF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 15:47:05 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 26 Feb
 2013 21:46:57 +0100
Received: from pctrast.inf.ethz.ch (129.132.211.237) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 26 Feb
 2013 21:47:01 +0100
X-Mailer: git-send-email 1.8.2.rc1.307.ge0d2dea
In-Reply-To: <1361638125-11245-1-git-send-email-apelisse@gmail.com>
X-Originating-IP: [129.132.211.237]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217180>

The logic described in d020e27 (diff: Fix rename pretty-print when
suffix and prefix overlap, 2013-02-23) is wrong: The proof in the
comment is valid only if both strings are the same length.  *One* of
old/new can reach a-1 (b-1, resp.) if 'a' is a suffix of 'b' (or vice
versa).

Since the intent was to let the loop run down to the '/' at the end of
the common prefix, fix it by making that distinction explicit: if
there is no prefix, allow no underrun.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Hi Antoine,

Unfortunately there's this bug in your patch.  Luckily it was found by
valgrind on t4016 and others.

Cheers
Thomas

 diff.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 7d49cab..8396527 100644
--- a/diff.c
+++ b/diff.c
@@ -1264,6 +1264,7 @@ static char *pprint_rename(const char *a, const char *b)
 	const char *new = b;
 	struct strbuf name = STRBUF_INIT;
 	int pfx_length, sfx_length;
+	int pfx_adjust_for_slash;
 	int len_a = strlen(a);
 	int len_b = strlen(b);
 	int a_midlen, b_midlen;
@@ -1291,14 +1292,16 @@ static char *pprint_rename(const char *a, const char *b)
 	new = b + len_b;
 	sfx_length = 0;
 	/*
-	 * Note:
-	 * if pfx_length is 0, old/new will never reach a - 1 because it
-	 * would mean the whole string is common suffix. But then, the
-	 * whole string would also be a common prefix, and we would not
-	 * have pfx_length equals 0.
+	 * If there is a common prefix, it must end in a slash.  In
+	 * that case we let this loop run 1 into the prefix to see the
+	 * same slash.
+	 *
+	 * If there is no common prefix, we cannot do this as it would
+	 * underrun the input strings.
 	 */
-	while (a + pfx_length - 1 <= old &&
-	       b + pfx_length - 1 <= new &&
+	pfx_adjust_for_slash = (pfx_length ? 1 : 0);
+	while (a + pfx_length - pfx_adjust_for_slash <= old &&
+	       b + pfx_length - pfx_adjust_for_slash <= new &&
 	       *old == *new) {
 		if (*old == '/')
 			sfx_length = len_a - (old - a);
-- 
1.8.2.rc1.307.ge0d2dea
