From: Jeff King <peff@peff.net>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 14:25:33 -0400
Message-ID: <20120322182533.GA20360@sigill.intra.peff.net>
References: <4F69AD3C.4070203@ericsson.com>
 <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com>
 <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:25:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAmhh-0004U1-2V
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875Ab2CVSZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:25:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56798
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992Ab2CVSZf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:25:35 -0400
Received: (qmail 3277 invoked by uid 107); 22 Mar 2012 18:25:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 14:25:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 14:25:33 -0400
Content-Disposition: inline
In-Reply-To: <20120322175952.GA13069@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193674>

On Thu, Mar 22, 2012 at 01:59:53PM -0400, Jeff King wrote:

> > Yeah, thanks for digging up the old thread. I was looking at the patch to
> > merge-recursive from Dscho on that thread and I think it identified the
> > place that needs patching correctly. I was on a tablet, without the access
> > to the surrounding code outside the patch context, so I do not know if the
> > logic to detect the pure-rename of an empty file in the patch was correct,
> > or the patch still applies to the current codebase, though.
> 
> It's easy to apply the patch manually, and I have written a test.
> However, it seems to cause lots of other parts of t6022 to fail. I'll
> try to dig up the cause.

Found it. The diff code is very smart about doing as little work as
possible. For a raw diff (i.e., not patch), we can often get away with
not loading the blob at all, and therefore have no idea what the size
is. The inexact rename code may load it, of course, but any file which
is an exact rename will have a "0" size, also.

We can get around it by just checking for the empty-blob sha1. The patch
below should do the right thing, and passes the whole test suite.

---
diff --git a/cache.h b/cache.h
index e5e1aa4..61671b6 100644
--- a/cache.h
+++ b/cache.h
@@ -708,6 +708,8 @@ static inline void hashclr(unsigned char *hash)
 #define EMPTY_TREE_SHA1_BIN \
 	 ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)
 
+int is_empty_blob_sha1(const unsigned char *sha1);
+
 int git_mkstemp(char *path, size_t n, const char *template);
 
 int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);
diff --git a/merge-recursive.c b/merge-recursive.c
index 6479a60..ed4ff16 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -502,7 +502,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		struct string_list_item *item;
 		struct rename *re;
 		struct diff_filepair *pair = diff_queued_diff.queue[i];
-		if (pair->status != 'R') {
+		if (pair->status != 'R' || is_empty_blob_sha1(pair->one->sha1)) {
 			diff_free_filepair(pair);
 			continue;
 		}
diff --git a/read-cache.c b/read-cache.c
index 274e54b..dfabad0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -157,7 +157,7 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int is_empty_blob_sha1(const unsigned char *sha1)
+int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	static const unsigned char empty_blob_sha1[20] = {
 		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 9d8584e..1104249 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -884,4 +884,20 @@ test_expect_success 'no spurious "refusing to lose untracked" message' '
 	! grep "refusing to lose untracked file" errors.txt
 '
 
+test_expect_success 'do not follow renames for empty files' '
+	git checkout -f -b empty-base &&
+	>empty1 &&
+	git add empty1 &&
+	git commit -m base &&
+	echo content >empty1 &&
+	git add empty1 &&
+	git commit -m fill &&
+	git checkout -b empty-topic HEAD^ &&
+	git mv empty1 empty2 &&
+	git commit -m rename &&
+	test_must_fail git merge empty-base &&
+	>expect &&
+	test_cmp expect empty2
+'
+
 test_done
