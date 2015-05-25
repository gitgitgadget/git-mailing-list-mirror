From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 10/56] grab_single_ref(): rewrite to take an object_id argument
Date: Mon, 25 May 2015 18:38:36 +0000
Message-ID: <1432579162-411464-11-git-send-email-sandals@crustytoothpaste.net>
References: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 20:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwxIY-0000s9-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbbEYSkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 14:40:19 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50592 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290AbbEYSkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2015 14:40:09 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BD6922809B;
	Mon, 25 May 2015 18:40:08 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1432579162-411464-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269854>

From: Michael Haggerty <mhagger@alum.mit.edu>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/for-each-ref.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index caccd93..05ce28c 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -840,7 +840,8 @@ struct grab_ref_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int grab_single_ref(const char *refname, const struct object_id *oid,
+			   int flag, void *cb_data)
 {
 	struct grab_ref_cbdata *cb = cb_data;
 	struct refinfo *ref;
@@ -878,7 +879,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 */
 	ref = xcalloc(1, sizeof(*ref));
 	ref->refname = xstrdup(refname);
-	hashcpy(ref->objectname, sha1);
+	hashcpy(ref->objectname, oid->hash);
 	ref->flag = flag;
 
 	cnt = cb->grab_cnt;
@@ -1072,8 +1073,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int maxcount = 0, quote_style = 0;
 	struct refinfo **refs;
 	struct grab_ref_cbdata cbdata;
-	struct each_ref_fn_sha1_adapter wrapped_grab_single_ref =
-		{grab_single_ref, &cbdata};
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -1113,7 +1112,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.grab_pattern = argv;
-	for_each_rawref(each_ref_fn_adapter, &wrapped_grab_single_ref);
+	for_each_rawref(grab_single_ref, &cbdata);
 	refs = cbdata.grab_array;
 	num_refs = cbdata.grab_cnt;
 
-- 
2.4.0
