From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH] receive-pack: avoid sending duplicate "have" lines
Date: Sat,  7 Nov 2015 00:16:13 +0100
Message-ID: <1446851773-32390-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 00:16:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuqF5-0006Gy-AM
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 00:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757686AbbKFXQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 18:16:19 -0500
Received: from elnino.cryptocrack.de ([46.165.227.75]:24389 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbbKFXQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 18:16:18 -0500
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 7953878c;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Sat, 7 Nov 2015 00:16:15 +0100 (CET)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281003>

Alternates and refs outside the current namespace are advertised as
"have" lines. To this end, the object identifiers of alternates are
collected in an array and repeated hashes are omitted before
transmission. In contrast, refs outside the used namespace are currently
converted into "have" lines and transmitted immediately, without
checking for duplicate lines. This means that exactly the same "have"
line might be transmitted several times.

Optimize this by using a single pool to collect all object identifiers
to be converted into "have" lines (including both alternates and refs
outside the namespace) first and transmit them later, omitting any
duplicates.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
This is based on pu. I am not sure whether we should also change the
name of show_one_alternate_sha1() in this patch since it is now used
to transmit refs outside the current namespace as well...

 builtin/receive-pack.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index f06f70a..548d4ce 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -217,23 +217,24 @@ static void show_ref(const char *path, const unsigned char *sha1)
 }
 
 static int show_ref_cb(const char *path_full, const struct object_id *oid,
-		       int flag, void *unused)
+		       int flag, void *data)
 {
 	const char *path = strip_namespace(path_full);
 
 	if (ref_is_hidden(path, path_full))
 		return 0;
 
-	/*
-	 * Advertise refs outside our current namespace as ".have"
-	 * refs, so that the client can use them to minimize data
-	 * transfer but will otherwise ignore them. This happens to
-	 * cover ".have" that are thrown in by add_one_alternate_ref()
-	 * to mark histories that are complete in our alternates as
-	 * well.
-	 */
-	if (!path)
-		path = ".have";
+	if (!path) {
+		/*
+		 * Advertise refs outside our current namespace as ".have"
+		 * refs, so that the client can use them to minimize data
+		 * transfer but will otherwise ignore them.
+		 */
+		struct sha1_array *sa = data;
+		sha1_array_append(sa, oid->hash);
+		return 0;
+	}
+
 	show_ref(path, oid->hash);
 	return 0;
 }
@@ -254,9 +255,9 @@ static void write_head_info(void)
 	struct sha1_array sa = SHA1_ARRAY_INIT;
 
 	for_each_alternate_ref(collect_one_alternate_ref, &sa);
+	for_each_ref(show_ref_cb, &sa);
 	sha1_array_for_each_unique(&sa, show_one_alternate_sha1, NULL);
 	sha1_array_clear(&sa);
-	for_each_ref(show_ref_cb, NULL);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
 
-- 
2.6.2
