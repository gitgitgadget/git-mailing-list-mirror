From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Introduce diff_filespec_is_binary()
Date: Fri, 06 Jul 2007 01:37:43 -0700
Message-ID: <7vejjmexm0.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
	<7vlkdve93o.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707051223520.9789@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:37:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6jK0-0005Ye-Ol
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 10:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbXGFIhq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 04:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbXGFIhp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 04:37:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:62281 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbXGFIho (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 04:37:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070706083744.XUAY1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 6 Jul 2007 04:37:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id L8dj1X00J1kojtg0000000; Fri, 06 Jul 2007 04:37:44 -0400
In-Reply-To: <Pine.LNX.4.64.0707051223520.9789@racer.site> (Johannes
	Schindelin's message of "Thu, 5 Jul 2007 12:25:36 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51733>

This replaces an explicit initialization of filespec->is_binary
field used for rename/break followed by direct access to that
field with a wrapper function that lazily iniaitlizes and
accesses the field.  We would add more attribute accesses for
the use of diff routines, and it would be better to make this
abstraction earlier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

 > It is quite cute to hide this in the funcname patch...

 So this is the proper refactoring _before_ any of your topics.

 diff.c           |   71 +++++++++++++++++++++++++++--------------------------
 diffcore-delta.c |    2 +-
 diffcore.h       |    2 +
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/diff.c b/diff.c
index 1958970..16ea710 100644
--- a/diff.c
+++ b/diff.c
@@ -1102,30 +1102,45 @@ static void setup_diff_attr_check(struct git_attr_check *check)
 {
 	static struct git_attr *attr_diff;
 
-	if (!attr_diff)
+	if (!attr_diff) {
 		attr_diff = git_attr("diff", 4);
-	check->attr = attr_diff;
+	}
+	check[0].attr = attr_diff;
 }
 
-static int file_is_binary(struct diff_filespec *one)
+static void diff_filespec_check_attr(struct diff_filespec *one)
 {
-	struct git_attr_check attr_diff_check;
+	struct git_attr_check attr_diff_check[1];
 
-	setup_diff_attr_check(&attr_diff_check);
-	if (!git_checkattr(one->path, 1, &attr_diff_check)) {
-		const char *value = attr_diff_check.value;
+	if (one->checked_attr)
+		return;
+
+	setup_diff_attr_check(attr_diff_check);
+	one->is_binary = 0;
+
+	if (!git_checkattr(one->path, ARRAY_SIZE(attr_diff_check), attr_diff_check)) {
+		const char *value;
+
+		/* binaryness */
+		value = attr_diff_check[0].value;
 		if (ATTR_TRUE(value))
-			return 0;
+			;
 		else if (ATTR_FALSE(value))
-			return 1;
+			one->is_binary = 1;
 	}
 
-	if (!one->data) {
-		if (!DIFF_FILE_VALID(one))
-			return 0;
+	if (!one->data && DIFF_FILE_VALID(one))
 		diff_populate_filespec(one, 0);
-	}
-	return buffer_is_binary(one->data, one->size);
+
+	if (one->data)
+		one->is_binary = buffer_is_binary(one->data, one->size);
+
+}
+
+int diff_filespec_is_binary(struct diff_filespec *one)
+{
+	diff_filespec_check_attr(one);
+	return one->is_binary;
 }
 
 static void builtin_diff(const char *name_a,
@@ -1182,7 +1197,8 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (!o->text && (file_is_binary(one) || file_is_binary(two))) {
+	if (!o->text &&
+	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
@@ -1260,7 +1276,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (file_is_binary(one) || file_is_binary(two)) {
+	if (diff_filespec_is_binary(one) || diff_filespec_is_binary(two)) {
 		data->is_binary = 1;
 		data->added = mf2.size;
 		data->deleted = mf1.size;
@@ -1302,7 +1318,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (file_is_binary(two))
+	if (diff_filespec_is_binary(two))
 		goto free_and_return;
 	else {
 		/* Crazy xdl interfaces.. */
@@ -1880,8 +1896,8 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 
 		if (o->binary) {
 			mmfile_t mf;
-			if ((!fill_mmfile(&mf, one) && file_is_binary(one)) ||
-			    (!fill_mmfile(&mf, two) && file_is_binary(two)))
+			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
+			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
 				abbrev = 40;
 		}
 		len += snprintf(msg + len, sizeof(msg) - len,
@@ -2783,7 +2799,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 			return error("unable to read files to diff");
 
 		/* Maybe hash p->two? into the patch id? */
-		if (file_is_binary(p->two))
+		if (diff_filespec_is_binary(p->two))
 			continue;
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
@@ -3011,21 +3027,6 @@ void diffcore_std(struct diff_options *options)
 	if (options->quiet)
 		return;
 
-	/*
-	 * break/rename count similarity differently depending on
-	 * the binary-ness.
-	 */
-	if ((options->break_opt != -1) || (options->detect_rename)) {
-		struct diff_queue_struct *q = &diff_queued_diff;
-		int i;
-
-		for (i = 0; i < q->nr; i++) {
-			struct diff_filepair *p = q->queue[i];
-			p->one->is_binary = file_is_binary(p->one);
-			p->two->is_binary = file_is_binary(p->two);
-		}
-	}
-
 	if (options->break_opt != -1)
 		diffcore_break(options->break_opt);
 	if (options->detect_rename)
diff --git a/diffcore-delta.c b/diffcore-delta.c
index a038b16..d9729e5 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -129,7 +129,7 @@ static struct spanhash_top *hash_chars(struct diff_filespec *one)
 	struct spanhash_top *hash;
 	unsigned char *buf = one->data;
 	unsigned int sz = one->size;
-	int is_text = !one->is_binary;
+	int is_text = !diff_filespec_is_binary(one);
 
 	i = INITIAL_HASH_SIZE;
 	hash = xmalloc(sizeof(*hash) + sizeof(struct spanhash) * (1<<i));
diff --git a/diffcore.h b/diffcore.h
index 0c8abb5..dcab7e2 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -37,6 +37,7 @@ struct diff_filespec {
 #define DIFF_FILE_VALID(spec) (((spec)->mode) != 0)
 	unsigned should_free : 1; /* data should be free()'ed */
 	unsigned should_munmap : 1; /* data should be munmap()'ed */
+	unsigned checked_attr : 1;
 	unsigned is_binary : 1; /* data should be considered "binary" */
 };
 
@@ -46,6 +47,7 @@ extern void fill_filespec(struct diff_filespec *, const unsigned char *,
 
 extern int diff_populate_filespec(struct diff_filespec *, int);
 extern void diff_free_filespec_data(struct diff_filespec *);
+extern int diff_filespec_is_binary(struct diff_filespec *);
 
 struct diff_filepair {
 	struct diff_filespec *one;
-- 
1.5.3.rc0.822.g38609
