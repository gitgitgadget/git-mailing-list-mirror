From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/14] fetch_pack(): update sought->nr to reflect number of unique entries
Date: Sun,  9 Sep 2012 08:19:42 +0200
Message-ID: <1347171589-13327-8-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:22:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAau5-0003F9-0O
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab2IIGVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:18 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:60998 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752425Ab2IIGUk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:40 -0400
X-AuditID: 1207440d-b7f236d000000943-e4-504c3538c9d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id FD.F1.02371.8353C405; Sun,  9 Sep 2012 02:20:40 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlk029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:38 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsUixO6iqGth6hNgMP0pj0XXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M/5fv8FY8FOwYvWhdywNjA/5uhg5OSQETCS6Zl1jgrDFJC7cW8/WxcjFISRwmVHi79Ql
	UM4ZJomFU+eBVbEJ6Eos6mkGs0UE1CQmth1iASliFuhilFi+7hcbSEJYIFbix6l/QAkODhYB
	VYkjc8JBwrwCLhJ3Nl5lhdimKPHj+xpmEJtTwFXi1czdjCC2EFDNpp3XWCcw8i5gZFjFKJeY
	U5qrm5uYmVOcmqxbnJyYl5dapGukl5tZopeaUrqJERJSvDsY/6+TOcQowMGoxMPLfMc7QIg1
	say4MvcQoyQHk5Ior4aJT4AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6r7EA53pTEyqrUonyY
	lDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IErzHIUMGi1PTUirTMnBKENBMHJ4jgAtnA
	A7QhGKSQt7ggMbc4Mx2i6BSjopQ4bxlIQgAkkVGaBzcAFv2vGMWB/hHmrQWp4gEmDrjuV0CD
	mYAGizzzABlckoiQkmpgrI7etfpuk6HdXsY/v3k3ek1wnp7xPH/+avk9b63cvq/10WiITD1/
	RdPwXVcIy/4PV53YQ12/hbJ2ik7cOKm5+/b/+pZPrx15i7nlr+9Kes/0JLXqVpWx6akNWpsn
	8EdeNnM6KX6+a9a8xv8P90zPXsy4TM3+vqDAqdC7px3n/VnEff2//85Fv5RYijMS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205063>

fetch_pack() removes duplicates from the "sought" list, thereby
shrinking the list.  But previously, the caller was not informed about
the shrinkage.  This would cause a spurious error message to be
emitted by cmd_fetch_pack() if "git fetch-pack" is called with
duplicate refnames.

Instead, remove duplicates using string_list_remove_duplicates(),
which adjusts sought->nr to reflect the new length of the list.

The last test of t5500 inexplicably *required* "git fetch-pack" to
fail when fetching a list of references that contains duplicates;
i.e., it insisted on the buggy behavior.  So change the test to expect
the correct behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c  | 15 +--------------
 t/t5500-fetch-pack.sh |  2 +-
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 63d455f..6cd734a 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -858,19 +858,6 @@ static struct ref *do_fetch_pack(int fd[2],
 	return ref;
 }
 
-static int remove_duplicates(struct string_list *sought)
-{
-	int src, dst;
-
-	if (!sought->nr)
-		return 0;
-
-	for (src = dst = 1; src < sought->nr; src++)
-		if (strcmp(sought->items[src].string, sought->items[dst-1].string))
-			sought->items[dst++] = sought->items[src];
-	return dst;
-}
-
 static int fetch_pack_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "fetch.unpacklimit") == 0) {
@@ -1090,7 +1077,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 
 	if (sought->nr) {
 		sort_string_list(sought);
-		remove_duplicates(sought);
+		string_list_remove_duplicates(sought, 0);
 	}
 
 	if (!ref) {
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 15d277f..acd41e8 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -391,7 +391,7 @@ test_expect_success 'fetch mixed refs from cmdline and stdin' '
 test_expect_success 'test duplicate refs from stdin' '
 	(
 	cd client &&
-	test_must_fail git fetch-pack --stdin --no-progress .. <../input.dup
+	git fetch-pack --stdin --no-progress .. <../input.dup
 	) >output &&
 	cut -d " " -f 2 <output | sort >actual &&
 	test_cmp expect actual
-- 
1.7.11.3
