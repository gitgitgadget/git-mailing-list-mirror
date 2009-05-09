From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/10] bisect: implement "rev_argv_push" to fill an argv with
	revs
Date: Sat, 09 May 2009 17:55:39 +0200
Message-ID: <20090509155548.5387.25844.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 18:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2p1j-00065t-1P
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 18:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290AbZEIQDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 12:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753209AbZEIQDj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 12:03:39 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:37215 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbZEIQDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 12:03:38 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id BE8D5D480BD;
	Sat,  9 May 2009 18:03:33 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C9F16D480FB;
	Sat,  9 May 2009 18:03:30 +0200 (CEST)
X-git-sha1: 10911360a028b04d94693b925a36554f4bbdeb24 
X-Mailer: git-mail-commits v0.4.0
In-Reply-To: <20090509154419.5324.96204.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is a minor clean up right now, but the new function
will evolve and be used more later.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 bisect.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 12df855..f99637d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -409,20 +409,23 @@ struct commit_list *find_bisection(struct commit_list *list,
 	return best;
 }
 
+static void rev_argv_push(const unsigned char *sha1, const char *format)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, format, sha1_to_hex(sha1));
+	ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
+	rev_argv[rev_argv_nr++] = strbuf_detach(&buf, NULL);
+}
+
 static int register_ref(const char *refname, const unsigned char *sha1,
 			int flags, void *cb_data)
 {
 	if (!strcmp(refname, "bad")) {
-		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
 		current_bad_sha1 = sha1;
-		rev_argv[rev_argv_nr++] = xstrdup(sha1_to_hex(sha1));
+		rev_argv_push(sha1, "%s");
 	} else if (!prefixcmp(refname, "good-")) {
-		const char *hex = sha1_to_hex(sha1);
-		char *good = xmalloc(strlen(hex) + 2);
-		*good = '^';
-		memcpy(good + 1, hex, strlen(hex) + 1);
-		ALLOC_GROW(rev_argv, rev_argv_nr + 1, rev_argv_alloc);
-		rev_argv[rev_argv_nr++] = good;
+		rev_argv_push(sha1, "^%s");
 	} else if (!prefixcmp(refname, "skip-")) {
 		ALLOC_GROW(skipped_revs.sha1, skipped_revs.sha1_nr + 1,
 			   skipped_revs.sha1_alloc);
-- 
1.6.3.rc1.112.g17e25
