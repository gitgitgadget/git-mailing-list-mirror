From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] config: arbitrary number of matches for --unset and --replace-all
Date: Thu, 14 Nov 2013 08:50:43 +0100
Message-ID: <9bc62ec0072a0513865f39ba287819dd0d9d606d.1384415180.git.tr@thomasrast.ch>
References: <CAPig+cQZo0R3q=J2BygTfdJ1uuiT1HPDCjTxt8mykxOXM1uf2Q@mail.gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jess Hottenstein <jess.hottenstein@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 08:51:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgrhg-0002we-Gu
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 08:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab3KNHvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 02:51:00 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:33794 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232Ab3KNHu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 02:50:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 07D664D6560;
	Thu, 14 Nov 2013 08:50:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id kVZRXbUoQPSo; Thu, 14 Nov 2013 08:50:44 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 22EF54D6414;
	Thu, 14 Nov 2013 08:50:44 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc1.353.g06ba152
In-Reply-To: <CAPig+cQZo0R3q=J2BygTfdJ1uuiT1HPDCjTxt8mykxOXM1uf2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237814>

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

Eric Sunshine wrote:
> On Wed, Nov 13, 2013 at 5:19 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> > +setup_many() {
[...]
> > +       cat >5to1 <<EOF
> 
> Broken &&-chain.

Oops, thanks for catching.


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
index 46103a1..c2706ea 100755
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
+	cat >5to1 <<EOF &&
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
1.8.5.rc1.353.g06ba152
