From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pack-refs: write peeled entry for non-tags
Date: Sat, 16 Mar 2013 05:01:03 -0400
Message-ID: <20130316090103.GA26855@sigill.intra.peff.net>
References: <20130316090018.GA26708@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 10:01:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGmzg-0004At-Hi
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 10:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182Ab3CPJBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 05:01:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53386 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab3CPJBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 05:01:07 -0400
Received: (qmail 32718 invoked by uid 107); 16 Mar 2013 09:02:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 05:02:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 05:01:03 -0400
Content-Disposition: inline
In-Reply-To: <20130316090018.GA26708@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218289>

When we pack an annotated tag ref, we write not only the
sha1 of the tag object along with the ref, but also the sha1
obtained by peeling the tag. This lets readers of the
pack-refs file know the peeled value without having to
actually load the object, speeding up upload-pack's ref
advertisement.

The writer marks a packed-refs file with peeled refs using
the "peeled" trait at the top of the file. When the reader
sees this trait, it knows that each ref is either followed
by its peeled value, or it is not an annotated tag.

However, there is a mismatch between the assumptions of the
reader and writer. The writer will only peel refs under
refs/tags, but the reader does not know this; it will assume
a ref without a peeled value must not be a tag object. Thus
an annotated tag object placed outside of the refs/tags
hierarchy will not have its peeled value printed by
upload-pack.

The simplest way to fix this is to start writing peel values
for all refs. This matches what the reader expects for both
new and old versions of git.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-refs.c         | 16 ++++++++--------
 t/t3211-peel-ref.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 8 deletions(-)
 create mode 100755 t/t3211-peel-ref.sh

diff --git a/pack-refs.c b/pack-refs.c
index f09a054..10832d7 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -27,6 +27,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 			  int flags, void *cb_data)
 {
 	struct pack_refs_cb_data *cb = cb_data;
+	struct object *o;
 	int is_tag_ref;
 
 	/* Do not pack the symbolic refs */
@@ -39,14 +40,13 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 		return 0;
 
 	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
-	if (is_tag_ref) {
-		struct object *o = parse_object(sha1);
-		if (o->type == OBJ_TAG) {
-			o = deref_tag(o, path, 0);
-			if (o)
-				fprintf(cb->refs_file, "^%s\n",
-					sha1_to_hex(o->sha1));
-		}
+
+	o = parse_object(sha1);
+	if (o->type == OBJ_TAG) {
+		o = deref_tag(o, path, 0);
+		if (o)
+			fprintf(cb->refs_file, "^%s\n",
+				sha1_to_hex(o->sha1));
 	}
 
 	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
new file mode 100755
index 0000000..dd5b48b
--- /dev/null
+++ b/t/t3211-peel-ref.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='tests for the peel_ref optimization of packed-refs'
+. ./test-lib.sh
+
+test_expect_success 'create annotated tag in refs/tags' '
+	test_commit base &&
+	git tag -m annotated foo
+'
+
+test_expect_success 'create annotated tag outside of refs/tags' '
+	git update-ref refs/outside/foo refs/tags/foo
+'
+
+# This matches show-ref's output
+print_ref() {
+	echo "`git rev-parse "$1"` $1"
+}
+
+test_expect_success 'set up expected show-ref output' '
+	{
+		print_ref "refs/heads/master" &&
+		print_ref "refs/outside/foo" &&
+		print_ref "refs/outside/foo^{}" &&
+		print_ref "refs/tags/base" &&
+		print_ref "refs/tags/foo" &&
+		print_ref "refs/tags/foo^{}"
+	} >expect
+'
+
+test_expect_success 'refs are peeled outside of refs/tags (loose)' '
+	git show-ref -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'refs are peeled outside of refs/tags (packed)' '
+	git pack-refs --all &&
+	git show-ref -d >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.2.rc2.7.gef06216
