From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/18] is_refname_available(): use dirname in first loop
Date: Mon, 11 May 2015 17:25:10 +0200
Message-ID: <1431357920-25090-9-git-send-email-mhagger@alum.mit.edu>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 17:26:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrpah-0002aa-JN
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 17:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754032AbbEKPZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 11:25:47 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:61531 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752740AbbEKPZn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 11:25:43 -0400
X-AuditID: 12074414-f797f6d000004084-38-5550c9f6f59b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 83.94.16516.6F9C0555; Mon, 11 May 2015 11:25:42 -0400 (EDT)
Received: from michael.fritz.box (p5DDB195E.dip0.t-ipconnect.de [93.219.25.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t4BFPNnK002156
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 11 May 2015 11:25:41 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsUixO6iqPvtZECowYS/8hZdV7qZLBp6rzBb
	3F4xn9niR0sPs8Xmze0sFmfeNDI6sHn8ff+ByWPBplKPZ717GD0uXlL2WPzAy+PzJrkAtihu
	m6TEkrLgzPQ8fbsE7oy3C0IKVslWLNvXy97AuEisi5GTQ0LARKLn81Y2CFtM4sK99UA2F4eQ
	wGVGiSdNVxkhnONMElcmLWMHqWIT0JVY1NPMBGKLCKhJTGw7xAJSxCywi1Hi3tKpLCAJYQFv
	iT03LjGC2CwCqhIzt+8AW8Er4CIxr+E7K8Q6OYnzx38yg9icAq4SS69eBusVAqppenyPZQIj
	7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuhZ6uZkleqkppZsYIUEmsoPxyEm5Q4wCHIxK
	PLwGF/xDhVgTy4orcw8xSnIwKYny/tobECrEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhFd5DVCO
	NyWxsiq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCt/EEUKNgUWp6akVaZk4J
	QpqJgxNkOJeUSHFqXkpqUWJpSUY8KDbii4HRAZLiAdq7G6Sdt7ggMRcoCtF6ilFRSpx3IUhC
	ACSRUZoHNxaWOl4xigN9Kcz7EaSKB5h24LpfAQ1mAhrsGAc2uCQRISXVwBgvEagzOT7fZ62l
	Yc2vSKN7lq3e/twTV3gIPT0i3BW9vD+u6uLBjXs3x8Qkcft1C1uddnnRWKFscXByZ5b/rBOr
	r13T0XiVv+fw8/X7b1yYvU181ZR27dUWeXcsCvlufTY2vHtuwfLFj1NK6y/zJqiv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268783>

In the first loop (over prefixes of refname), use dirname to keep
track of the current prefix. This is not an improvement in itself, but
in a moment we will start using dirname for a role where a
NUL-terminated string is needed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index effd91a..8316bb1 100644
--- a/refs.c
+++ b/refs.c
@@ -878,26 +878,30 @@ static int is_refname_available(const char *refname,
 	const char *slash;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
+	int ret = 0;
 
 	/*
 	 * For the sake of comments in this function, suppose that
 	 * refname is "refs/foo/bar".
 	 */
 
+	strbuf_grow(&dirname, strlen(refname) + 1);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+		/* Expand dirname to the new prefix, not including the trailing slash: */
+		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
+
 		/*
 		 * We are still at a leading dir of the refname (e.g.,
 		 * "refs/foo"; if there is a reference with that name,
 		 * it is a conflict, *unless* it is in skip.
 		 */
-		pos = search_ref_dir(dir, refname, slash - refname);
+		pos = search_ref_dir(dir, dirname.buf, dirname.len);
 		if (pos >= 0) {
 			/*
 			 * We found a reference whose name is a proper
 			 * prefix of refname; e.g., "refs/foo".
 			 */
-			struct ref_entry *entry = dir->entries[pos];
-			if (skip && string_list_has_string(skip, entry->name)) {
+			if (skip && string_list_has_string(skip, dirname.buf)) {
 				/*
 				 * The reference we just found, e.g.,
 				 * "refs/foo", is also in skip, so it
@@ -910,10 +914,11 @@ static int is_refname_available(const char *refname,
 				 * "refs/foo"). So we can stop looking
 				 * now and return true.
 				 */
-				return 1;
+				ret = 1;
+				goto cleanup;
 			}
-			error("'%s' exists; cannot create '%s'", entry->name, refname);
-			return 0;
+			error("'%s' exists; cannot create '%s'", dirname.buf, refname);
+			goto cleanup;
 		}
 
 
@@ -922,14 +927,16 @@ static int is_refname_available(const char *refname,
 		 * the next component. So try to look up the
 		 * directory, e.g., "refs/foo/".
 		 */
-		pos = search_ref_dir(dir, refname, slash + 1 - refname);
+		strbuf_addch(&dirname, '/');
+		pos = search_ref_dir(dir, dirname.buf, dirname.len);
 		if (pos < 0) {
 			/*
 			 * There was no directory "refs/foo/", so
 			 * there is nothing under this whole prefix,
 			 * and we are OK.
 			 */
-			return 1;
+			ret = 1;
+			goto cleanup;
 		}
 
 		dir = get_ref_dir(dir->entries[pos]);
@@ -943,10 +950,9 @@ static int is_refname_available(const char *refname,
 	 * names are in the "refs/foo/bar/" namespace, because they
 	 * *do* conflict.
 	 */
-	strbuf_addstr(&dirname, refname);
+	strbuf_addstr(&dirname, refname + dirname.len);
 	strbuf_addch(&dirname, '/');
 	pos = search_ref_dir(dir, dirname.buf, dirname.len);
-	strbuf_release(&dirname);
 
 	if (pos >= 0) {
 		/*
@@ -960,15 +966,21 @@ static int is_refname_available(const char *refname,
 		dir = get_ref_dir(entry);
 		data.skip = skip;
 		sort_ref_dir(dir);
-		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data))
-			return 1;
+		if (!do_for_each_entry_in_dir(dir, 0, nonmatching_ref_fn, &data)) {
+			ret = 1;
+			goto cleanup;
+		}
 
 		error("'%s' exists; cannot create '%s'",
 		      data.conflicting_refname, refname);
-		return 0;
+		goto cleanup;
 	}
 
-	return 1;
+	ret = 1;
+
+cleanup:
+	strbuf_release(&dirname);
+	return ret;
 }
 
 struct packed_ref_cache {
-- 
2.1.4
