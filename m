From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/18] is_refname_available(): use dirname in first loop
Date: Fri,  1 May 2015 14:25:48 +0200
Message-ID: <1430483158-14349-9-git-send-email-mhagger@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 14:27:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoA22-0001MH-HT
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 14:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbbEAM0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 08:26:25 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:55396 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753736AbbEAM0X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 08:26:23 -0400
X-AuditID: 12074413-f79f26d0000030e7-19-554370ece7f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 79.EC.12519.CE073455; Fri,  1 May 2015 08:26:20 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D7E.dip0.t-ipconnect.de [79.201.125.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t41CQ3Zl004310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 May 2015 08:26:19 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqPumwDnU4PUfPouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ+xav4O9YKZsxZqXcQ2MG8W6GDk5JARMJO7cX8kOYYtJXLi3nq2LkYtDSOAyo8SzTd+h
	nBNMEj0Tp7GAVLEJ6Eos6mlmArFFBNQkJrYdYgEpYhboYJS4sHwb2ChhAQ+Jk/c+A3VzcLAI
	qEosnywDEuYVcJE42vqRFWKbnMT54z+ZQUo4BVwlvkxNBAkLAZXc//6VbQIj7wJGhlWMcok5
	pbm6uYmZOcWpybrFyYl5ealFuuZ6uZkleqkppZsYIeEkvINx10m5Q4wCHIxKPLwcJ51ChVgT
	y4orcw8xSnIwKYny2iY4hwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b2nDpTjTUmsrEotyodJ
	SXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwJuYDNQoWpaanVqRl5pQgpJk4OEGGc0mJ
	FKfmpaQWJZaWZMSD4iK+GBgZICkeoL3LQNp5iwsSc4GiEK2nGBWlxHl7QBICIImM0jy4sbAk
	8YpRHOhLYV5WYMoQ4gEmGLjuV0CDmYAGn7/lADK4JBEhJdXAWNqX0WU9qTFBLyTajPHVBtcN
	px7F1m3eeN729bZJWq2OAg03n4jfk+lzqV+ZzyH3d5rUhLpXp1JP7TndVsNydMqeJSxnUjO5
	N14N4CpTLbXU6Wt5F6Jy9HDHRoGdLxMlU25E3umqaDshf3brXTYefbdy1XeTlLce 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268128>

In the first loop (over prefixes of refname), use dirname to keep
track of the current prefix. This is not an improvement in itself, but
in a moment we will start using dirname for a role where a
NUL-terminated string is needed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 0ec3f0a..8e929c7 100644
--- a/refs.c
+++ b/refs.c
@@ -883,8 +883,13 @@ static int is_refname_available(const char *refname,
 	const char *slash;
 	int pos;
 	struct strbuf dirname = STRBUF_INIT;
+	int ret = 0;
 
+	strbuf_grow(&dirname, strlen(refname) + 1);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+		/* Expand dirname to the new prefix, not including the trailing slash: */
+		strbuf_add(&dirname, refname + dirname.len, slash - refname - dirname.len);
+
 		/*
 		 * We are still at a leading dir of the refname; we are
 		 * looking for a conflict with a leaf entry.
@@ -892,10 +897,9 @@ static int is_refname_available(const char *refname,
 		 * If we find one, we still must make sure it is
 		 * not in "skip".
 		 */
-		pos = search_ref_dir(dir, refname, slash - refname);
+		pos = search_ref_dir(dir, dirname.buf, dirname.len);
 		if (pos >= 0) {
-			struct ref_entry *entry = dir->entries[pos];
-			if (skip && string_list_has_string(skip, entry->name)) {
+			if (skip && string_list_has_string(skip, dirname.buf)) {
 				/*
 				 * The fact that entry is a ref whose
 				 * name is a prefix of refname means
@@ -907,10 +911,11 @@ static int is_refname_available(const char *refname,
 				 * is in skip), we can stop looking
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
 
 
@@ -919,9 +924,12 @@ static int is_refname_available(const char *refname,
 		 * the next component; if we come up empty, we know
 		 * there is nothing under this whole prefix.
 		 */
-		pos = search_ref_dir(dir, refname, slash + 1 - refname);
-		if (pos < 0)
-			return 1;
+		strbuf_addch(&dirname, '/');
+		pos = search_ref_dir(dir, dirname.buf, dirname.len);
+		if (pos < 0) {
+			ret = 1;
+			goto cleanup;
+		}
 
 		dir = get_ref_dir(dir->entries[pos]);
 	}
@@ -930,10 +938,9 @@ static int is_refname_available(const char *refname,
 	 * We are at the leaf of our refname; we want to
 	 * make sure there are no directories which match it.
 	 */
-	strbuf_addstr(&dirname, refname);
+	strbuf_addstr(&dirname, refname + dirname.len);
 	strbuf_addch(&dirname, '/');
 	pos = search_ref_dir(dir, dirname.buf, dirname.len);
-	strbuf_release(&dirname);
 
 	if (pos >= 0) {
 		/*
@@ -947,12 +954,14 @@ static int is_refname_available(const char *refname,
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
 
 	/*
@@ -960,7 +969,11 @@ static int is_refname_available(const char *refname,
 	 * node which matches it; such an entry would be the
 	 * ref we are looking for, not a conflict.
 	 */
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
