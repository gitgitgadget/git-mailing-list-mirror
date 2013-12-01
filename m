From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] builtin/remote: remove postfixcmp() and use suffixcmp()
 instead
Date: Sun, 01 Dec 2013 08:49:15 +0100
Message-ID: <20131201074919.3042.71383.chriscool@tuxfamily.org>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 01 08:50:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vn1np-0004Pp-Vx
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 08:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150Ab3LAHub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 02:50:31 -0500
Received: from mail-2y.bbox.fr ([194.158.98.15]:63757 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750807Ab3LAHu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 02:50:27 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 7B1B2F2;
	Sun,  1 Dec 2013 08:50:06 +0100 (CET)
X-git-sha1: 1733888cd931ea7e96402f9197043113f654693d 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131201074818.3042.57357.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238581>

Commit 8cc5b290 (git merge -X<option>, 25 Nov 2009) introduced
suffixcmp() with nearly the same implementation as postfixcmp()
that already existed since commit 211c8968 (Make git-remote a
builtin, 29 Feb 2008).

The only difference between the two implementations is that,
when the string is smaller than the suffix, one implementation
returns 1 while the other one returns -1.

But, as postfixcmp() is only used to compare for equality, the
distinction does not matter and does not affect the correctness of
this patch.

As postfixcmp() has always been static in builtin/remote.c
and is used nowhere else, it makes more sense to remove it
and use suffixcmp() instead in builtin/remote.c, rather than
to remove suffixcmp().

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/remote.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 4e14891..9b3a98e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -80,14 +80,6 @@ static int verbose;
 static int show_all(void);
 static int prune_remote(const char *remote, int dry_run);
 
-static inline int postfixcmp(const char *string, const char *postfix)
-{
-	int len1 = strlen(string), len2 = strlen(postfix);
-	if (len1 < len2)
-		return 1;
-	return strcmp(string + len1 - len2, postfix);
-}
-
 static int fetch_remote(const char *name)
 {
 	const char *argv[] = { "fetch", name, NULL, NULL };
@@ -277,13 +269,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		enum { REMOTE, MERGE, REBASE } type;
 
 		key += 7;
-		if (!postfixcmp(key, ".remote")) {
+		if (!suffixcmp(key, ".remote")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REMOTE;
-		} else if (!postfixcmp(key, ".merge")) {
+		} else if (!suffixcmp(key, ".merge")) {
 			name = xstrndup(key, strlen(key) - 6);
 			type = MERGE;
-		} else if (!postfixcmp(key, ".rebase")) {
+		} else if (!suffixcmp(key, ".rebase")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REBASE;
 		} else
-- 
1.8.4.1.561.g12affca
