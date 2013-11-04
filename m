From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] builtin/remote: remove postfixcmp() and use suffixcmp()
 instead
Date: Mon, 04 Nov 2013 21:42:49 +0100
Message-ID: <20131104204251.16987.48072.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 04 21:44:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdR0i-0000JI-IO
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 21:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab3KDUoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 15:44:22 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:44705 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab3KDUoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 15:44:21 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 9A76B54;
	Mon,  4 Nov 2013 21:44:18 +0100 (CET)
X-git-sha1: f70f1f170ca4270c99a8642f112946c976b0e272 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237301>

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
1.8.4.1.576.g36ba827.dirty
