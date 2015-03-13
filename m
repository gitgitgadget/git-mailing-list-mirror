From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] upload-pack: fix transfer.hiderefs over smart-http
Date: Fri, 13 Mar 2015 00:42:12 -0400
Message-ID: <20150313044212.GA18532@peff.net>
References: <20150313044101.GA18476@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 05:42:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWHQR-0000kz-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 05:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbbCMEmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 00:42:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:60809 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750806AbbCMEmO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 00:42:14 -0400
Received: (qmail 30416 invoked by uid 102); 13 Mar 2015 04:42:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Mar 2015 23:42:14 -0500
Received: (qmail 9477 invoked by uid 107); 13 Mar 2015 04:42:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Mar 2015 00:42:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2015 00:42:12 -0400
Content-Disposition: inline
In-Reply-To: <20150313044101.GA18476@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265392>

When upload-pack advertises the refs (either for a normal,
non-stateless request, or for the initial contact in a
stateless one), we call for_each_ref with the send_ref
function as its callback. send_ref, in turn, calls
mark_our_ref, which checks whether the ref is hidden, and
sets OUR_REF or HIDDEN_REF on the object as appropriate.  If
it is hidden, mark_our_ref also returns "1" to signal
send_ref that the ref should not be advertised.

If we are not advertising refs, (i.e., the follow-up
invocation by an http client to send its "want" lines), we
use mark_our_ref directly as a callback to for_each_ref. Its
marking does the right thing, but when it then returns "1"
to for_each_ref, the latter interprets this as an error and
stops iterating. As a result, we skip marking all of the
refs that come lexicographically after it. Any "want" lines
from the client asking for those objects will fail, as they
were not properly marked with OUR_REF.

To solve this, we introduce a wrapper callback around
mark_our_ref which always returns 0 (even if the ref is
hidden, we want to keep iterating). We also tweak the
signature of mark_our_ref to exclude unnecessary parameters
that were present only to conform to the callback interface.
This should make it less likely for somebody to accidentally
use it as a callback in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 11 +++++++++++
 upload-pack.c               | 14 ++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 6cbc12d..b970773 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -213,6 +213,17 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 	test_cmp expect_cookies.txt cookies_tail.txt
 '
 
+test_expect_success 'transfer.hiderefs works over smart-http' '
+	test_commit hidden &&
+	test_commit visible &&
+	git push public HEAD^:refs/heads/a HEAD:refs/heads/b &&
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		config transfer.hiderefs refs/heads/a &&
+	git clone --bare "$HTTPD_URL/smart/repo.git" hidden.git &&
+	test_must_fail git -C hidden.git rev-parse --verify a &&
+	git -C hidden.git rev-parse --verify b
+'
+
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	(
 	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
diff --git a/upload-pack.c b/upload-pack.c
index b531a32..c8e8713 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -681,7 +681,7 @@ static void receive_needs(void)
 }
 
 /* return non-zero if the ref is hidden, otherwise 0 */
-static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int mark_our_ref(const char *refname, const unsigned char *sha1)
 {
 	struct object *o = lookup_unknown_object(sha1);
 
@@ -695,6 +695,12 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 	return 0;
 }
 
+static int check_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	mark_our_ref(refname, sha1);
+	return 0;
+}
+
 static void format_symref_info(struct strbuf *buf, struct string_list *symref)
 {
 	struct string_list_item *item;
@@ -713,7 +719,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
-	if (mark_our_ref(refname, sha1, flag, NULL))
+	if (mark_our_ref(refname, sha1))
 		return 0;
 
 	if (capabilities) {
@@ -767,8 +773,8 @@ static void upload_pack(void)
 		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
-		head_ref_namespaced(mark_our_ref, NULL);
-		for_each_namespaced_ref(mark_our_ref, NULL);
+		head_ref_namespaced(check_ref, NULL);
+		for_each_namespaced_ref(check_ref, NULL);
 	}
 	string_list_clear(&symref, 1);
 	if (advertise_refs)
-- 
2.3.2.472.geadab3c
