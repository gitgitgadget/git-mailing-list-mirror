From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 43/56] write_one_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:39:09 +0000
Message-ID: <1432579162-411464-44-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:41:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxJd-0001Ul-0X
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbbEYSla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:41:30 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50736 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751483AbbEYSka (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:30 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 03FAA28099;
	Mon, 25 May 2015 18:40:30 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269878>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/transport.c b/transport.c
index df87386..40692f8 100644
--- a/transport.c
+++ b/transport.c
@@ -278,8 +278,8 @@ static int fetch_objs_via_rsync(struct transport *transport,
 	return run_command(&rsync);
 }
 
-static int write_one_ref(const char *name, const unsigned char *sha1,
-		int flags, void *data)
+static int write_one_ref(const char *name, const struct object_id *oid,
+			 int flags, void *data)
 {
 	struct strbuf *buf = data;
 	int len = buf->len;
@@ -291,7 +291,7 @@ static int write_one_ref(const char *name, const unsigned char *sha1,
 
 	strbuf_addstr(buf, name);
 	if (safe_create_leading_directories(buf->buf) ||
-	    write_file(buf->buf, 0, "%s\n", sha1_to_hex(sha1)))
+	    write_file(buf->buf, 0, "%s\n", oid_to_hex(oid)))
 		return error("problems writing temporary file %s: %s",
 			     buf->buf, strerror(errno));
 	strbuf_setlen(buf, len);
@@ -310,7 +310,7 @@ static int write_refs_to_temp_dir(struct strbuf *temp_dir,
 		if (dwim_ref(refspec[i], strlen(refspec[i]), oid.hash, &ref) != 1)
 			return error("Could not get ref %s", refspec[i]);
 
-		if (write_one_ref(ref, oid.hash, 0, temp_dir)) {
+		if (write_one_ref(ref, &oid, 0, temp_dir)) {
 			free(ref);
 			return -1;
 		}
@@ -363,10 +363,7 @@ static int rsync_transport_push(struct transport *transport,
 	strbuf_addch(&temp_dir, '/');
 
 	if (flags & TRANSPORT_PUSH_ALL) {
-		struct each_ref_fn_sha1_adapter wrapped_write_one_ref =
-			{write_one_ref, &temp_dir};
-
-		if (for_each_ref(each_ref_fn_adapter, &wrapped_write_one_ref))
+		if (for_each_ref(write_one_ref, &temp_dir))
 			return -1;
 	} else if (write_refs_to_temp_dir(&temp_dir, refspec_nr, refspec))
 		return -1;
-- 
2.4.0
