From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] config: arbitrary number of matches for --unset and --replace-all
Date: Wed, 13 Nov 2013 11:19:00 +0100
Message-ID: <06ba1524cbe4fa31b6e1a8d644882521aeaff4f4.1384337608.git.tr@thomasrast.ch>
References: <CAB8C745oJjw6pZ1MFy73Wy=WM-8n=aRY7VUh73u__VLB5e8mQA@mail.gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 13 11:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgXXm-0008Px-Sl
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 11:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab3KMKTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 05:19:22 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:60232 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759008Ab3KMKTP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 05:19:15 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id B79064D6510;
	Wed, 13 Nov 2013 11:19:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nmgr7tn2IEiZ; Wed, 13 Nov 2013 11:19:02 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (89-73.60-188.cust.bluewin.ch [188.60.73.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id AF5464D6414;
	Wed, 13 Nov 2013 11:19:01 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc0.346.g150976e
In-Reply-To: <CAB8C745oJjw6pZ1MFy73Wy=WM-8n=aRY7VUh73u__VLB5e8mQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237787>

git-config used a static match array to hold the matches we want to
unset/replace when using --unset or --replace-all.  Use a
variable-sized array instead.

This in particular fixes the symptoms git-svn had when storing large
numbers of svn-remote.*.added-placeholder entries in the config file.

While the tests are rather more paranoid than just --unset and
--replace-all, the other operations already worked.  Indeed git-svn's
usage only breaks the first time *after* creating so many entries,
when it wants to unset and re-add them all.

Reported-by: Jess Hottenstein <jess.hottenstein@gmail.com>
Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

This should fix it, though I haven't actually tested with such a funny
use-case, nor written a proper git-svn test for it.  My analysis about
the failure mode is from briefly looking at the code.

git-svn should probably be changed to use another way of storing
these, as git-config is not a very efficient database, but I'm leaving
that for someone who cares about SVN.  (Note that it's also much
harder as it'll need a migration plan.)


 config.c                | 19 ++++++++++-----
 t/t1303-wacky-config.sh | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 3c2434a..ef63bf2 100644
--- a/config.c
+++ b/config.c
@@ -1197,15 +1197,14 @@ int git_config(config_fn_t fn, void *data)
  * Find all the stuff for git_config_set() below.
  */
 
-#define MAX_MATCHES 512
-
 static struct {
 	int baselen;
 	char *key;
 	int do_not_match;
 	regex_t *value_regex;
 	int multi_replace;
-	size_t offset[MAX_MATCHES];
+	size_t *offset;
+	unsigned int offset_alloc;
 	enum { START, SECTION_SEEN, SECTION_END_SEEN, KEY_SEEN } state;
 	int seen;
 } store;
@@ -1228,11 +1227,11 @@ static int store_aux(const char *key, const char *value, void *cb)
 		if (matches(key, value)) {
 			if (store.seen == 1 && store.multi_replace == 0) {
 				warning("%s has multiple values", key);
-			} else if (store.seen >= MAX_MATCHES) {
-				error("too many matches for %s", key);
-				return 1;
 			}
 
+			ALLOC_GROW(store.offset, store.seen+1,
+				   store.offset_alloc);
+
 			store.offset[store.seen] = cf->do_ftell(cf);
 			store.seen++;
 		}
@@ -1260,11 +1259,15 @@ static int store_aux(const char *key, const char *value, void *cb)
 		 * Do not increment matches: this is no match, but we
 		 * just made sure we are in the desired section.
 		 */
+		ALLOC_GROW(store.offset, store.seen+1,
+			   store.offset_alloc);
 		store.offset[store.seen] = cf->do_ftell(cf);
 		/* fallthru */
 	case SECTION_END_SEEN:
 	case START:
 		if (matches(key, value)) {
+			ALLOC_GROW(store.offset, store.seen+1,
+				   store.offset_alloc);
 			store.offset[store.seen] = cf->do_ftell(cf);
 			store.state = KEY_SEEN;
 			store.seen++;
@@ -1272,6 +1275,9 @@ static int store_aux(const char *key, const char *value, void *cb)
 			if (strrchr(key, '.') - key == store.baselen &&
 			      !strncmp(key, store.key, store.baselen)) {
 					store.state = SECTION_SEEN;
+					ALLOC_GROW(store.offset,
+						   store.seen+1,
+						   store.offset_alloc);
 					store.offset[store.seen] = cf->do_ftell(cf);
 			}
 		}
@@ -1570,6 +1576,7 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			}
 		}
 
+		ALLOC_GROW(store.offset, 1, store.offset_alloc);
 		store.offset[0] = 0;
 		store.state = START;
 		store.seen = 0;
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 46103a1..7d55730 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -3,17 +3,28 @@
 test_description='Test wacky input to git config'
 . ./test-lib.sh
 
+# Leaving off the newline is intentional!
 setup() {
 	(printf "[section]\n" &&
 	printf "  key = foo") >.git/config
 }
 
+# 'check section.key value' verifies that the entry for section.key is
+# 'value'
 check() {
 	echo "$2" >expected
 	git config --get "$1" >actual 2>&1
 	test_cmp actual expected
 }
 
+# 'check section.key regex value' verifies that the entry for
+# section.key *that matches 'regex'* is 'value'
+check_regex() {
+	echo "$3" >expected
+	git config --get "$1" "$2" >actual 2>&1
+	test_cmp actual expected
+}
+
 test_expect_success 'modify same key' '
 	setup &&
 	git config section.key bar &&
@@ -47,4 +58,57 @@ test_expect_success 'do not crash on special long config line' '
 	check section.key "$LONG_VALUE"
 '
 
+setup_many() {
+	setup &&
+	# This time we want the newline so that we can tack on more
+	# entries.
+	echo >>.git/config &&
+	# Semi-efficient way of concatenating 5^5 = 3125 lines. Note
+	# that because 'setup' already put one line, this means 3126
+	# entries for section.key in the config file.
+	cat >5to1 <<EOF
+  key = foo
+  key = foo
+  key = foo
+  key = foo
+  key = foo
+EOF
+	cat 5to1 5to1 5to1 5to1 5to1 >5to2 &&	   # 25
+	cat 5to2 5to2 5to2 5to2 5to2 >5to3 &&	   # 125
+	cat 5to3 5to3 5to3 5to3 5to3 >5to4 &&	   # 635
+	cat 5to4 5to4 5to4 5to4 5to4 >>.git/config # 3125
+}
+
+test_expect_success 'get many entries' '
+	setup_many &&
+	git config --get-all section.key >actual &&
+	test_line_count = 3126 actual
+'
+
+test_expect_success 'get many entries by regex' '
+	setup_many &&
+	git config --get-regexp "sec.*ke." >actual &&
+	test_line_count = 3126 actual
+'
+
+test_expect_success 'add and replace one of many entries' '
+	setup_many &&
+	git config --add section.key bar &&
+	check_regex section.key "b.*r" bar &&
+	git config section.key beer "b.*r" &&
+	check_regex section.key "b.*r" beer
+'
+
+test_expect_success 'replace many entries' '
+	setup_many &&
+	git config --replace-all section.key bar &&
+	check section.key bar
+'
+
+test_expect_success 'unset many entries' '
+	setup_many &&
+	git config --unset-all section.key &&
+	test_must_fail git config section.key
+'
+
 test_done
-- 
1.8.5.rc0.346.g150976e
