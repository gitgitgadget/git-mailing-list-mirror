From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 29/56] http-backend: rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:55 +0000
Message-ID: <1432579162-411464-30-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIr-00013c-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbbEYSkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:35 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50682 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbbEYSkU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:20 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4350F28099;
	Mon, 25 May 2015 18:40:19 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269865>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 http-backend.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index e4f3de3..a2d388d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -350,16 +350,16 @@ static void run_service(const char **argv)
 		exit(1);
 }
 
-static int show_text_ref(const char *name, const unsigned char *sha1,
-	int flag, void *cb_data)
+static int show_text_ref(const char *name, const struct object_id *oid,
+			 int flag, void *cb_data)
 {
 	const char *name_nons = strip_namespace(name);
 	struct strbuf *buf = cb_data;
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid->hash);
 	if (!o)
 		return 0;
 
-	strbuf_addf(buf, "%s\t%s\n", sha1_to_hex(sha1), name_nons);
+	strbuf_addf(buf, "%s\t%s\n", oid_to_hex(oid), name_nons);
 	if (o->type == OBJ_TAG) {
 		o = deref_tag(o, name, 0);
 		if (!o)
@@ -395,18 +395,15 @@ static void get_info_refs(char *arg)
 		run_service(argv);
 
 	} else {
-		struct each_ref_fn_sha1_adapter wrapped_show_text_ref =
-			{show_text_ref, &buf};
-
 		select_getanyfile();
-		for_each_namespaced_ref(each_ref_fn_adapter, &wrapped_show_text_ref);
+		for_each_namespaced_ref(show_text_ref, &buf);
 		send_strbuf("text/plain", &buf);
 	}
 	strbuf_release(&buf);
 }
 
-static int show_head_ref(const char *refname, const unsigned char *sha1,
-	int flag, void *cb_data)
+static int show_head_ref(const char *refname, const struct object_id *oid,
+			 int flag, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 
@@ -419,7 +416,7 @@ static int show_head_ref(const char *refname, const unsigned char *sha1,
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
 	} else {
-		strbuf_addf(buf, "%s\n", sha1_to_hex(sha1));
+		strbuf_addf(buf, "%s\n", oid_to_hex(oid));
 	}
 
 	return 0;
@@ -428,11 +425,9 @@ static int show_head_ref(const char *refname, const unsigned char *sha1,
 static void get_head(char *arg)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct each_ref_fn_sha1_adapter wrapped_show_head_ref =
-		{show_head_ref, &buf};
 
 	select_getanyfile();
-	head_ref_namespaced(each_ref_fn_adapter, &wrapped_show_head_ref);
+	head_ref_namespaced(show_head_ref, &buf);
 	send_strbuf("text/plain", &buf);
 	strbuf_release(&buf);
 }
-- 
2.4.0
