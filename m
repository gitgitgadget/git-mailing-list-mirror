Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B2BC433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F400F610E6
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 20:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbhJEUiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 16:38:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:33352 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230027AbhJEUh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 16:37:59 -0400
Received: (qmail 17633 invoked by uid 109); 5 Oct 2021 20:36:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 05 Oct 2021 20:36:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6508 invoked by uid 111); 5 Oct 2021 20:36:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 05 Oct 2021 16:36:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 5 Oct 2021 16:36:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/5] cat-file: disable refs/replace with --batch-all-objects
Message-ID: <YVy3N7ZX+s6Mi93y@coredump.intra.peff.net>
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we're enumerating all objects in the object database, it doesn't
make sense to respect refs/replace. The point of this option is to
enumerate all of the objects in the database at a low level. By
definition we'd already show the replacement object's contents (under
its real oid), and showing those contents under another oid is almost
certainly working against what the user is trying to do.

Note that you could make the same argument for something like:

  git show-index <foo.idx |
  awk '{print $2}' |
  git cat-file --batch

but there we can't know in cat-file exactly what the user intended,
because we don't know the source of the input. They could be trying to
do low-level debugging, or they could be doing something more high-level
(e.g., imagine a porcelain built around cat-file for its object
accesses). So in those cases, we'll have to rely on the user specifying
"git --no-replace-objects" to tell us what to do.

One _could_ make an argument that "cat-file --batch" is sufficiently
low-level plumbing that it should not respect replace-objects at all
(and the caller should do any replacement if they want it).  But we have
been doing so for some time. The history is a little tangled:

  - looking back as far as v1.6.6, we would not respect replace refs for
    --batch-check, but would for --batch (because the former used
    sha1_object_info(), and the replace mechanism only affected actual
    object reads)

  - this discrepancy was made even weirder by 98e2092b50 (cat-file:
    teach --batch to stream blob objects, 2013-07-10), where we always
    output the header using the --batch-check code, and then printed the
    object separately. This could lead to "cat-file --batch" dying (when
    it notices the size or type changed for a non-blob object) or even
    producing bogus output (in streaming mode, we didn't notice that we
    wrote the wrong number of bytes).

  - that persisted until 1f7117ef7a (sha1_file: perform object
    replacement in sha1_object_info_extended(), 2013-12-11), which then
    respected replace refs for both forms.

So it has worked reliably this way for over 7 years, and we should make
sure it continues to do so. That could also be an argument that
--batch-all-objects should not change behavior (which this patch is
doing), but I really consider the current behavior to be an unintended
bug. It's a side effect of how the code is implemented (feeding the oids
back into oid_object_info() rather than looking at what we found while
reading the loose and packed object storage).

The implementation is straight-forward: we just disable the global
read_replace_refs flag when we're in --batch-all-objects mode. It would
perhaps be a little cleaner to change the flag we pass to
oid_object_info_extended(), but that's not enough. We also read objects
via read_object_file() and stream_blob_to_fd(). The former could switch
to its _extended() form, but the streaming code has no mechanism for
disabling replace refs. Setting the global flag works, and as a bonus,
it's impossible to have any "oops, we're sometimes replacing the object
and sometimes not" bugs in the output (like the ones caused by
98e2092b50 above).

The tests here cover the regular-input and --batch-all-objects cases,
for both --batch-check and --batch. There is a test in t6050 that covers
the regular-input case with --batch already, but this new one goes much
further in actually verifying the output (plus covering --batch-check
explicitly). This is perhaps a little overkill and the tests would be
simpler just covering --batch-check, but I wanted to make sure we're
checking that --batch output is consistent between the header and the
content. The global-flag technique used here makes that easy to get
right, but this is future-proofing us against regressions.

Signed-off-by: Jeff King <peff@peff.net>
---
Reading between the lines, you might guess that I also introduced a
"whoops, our size/content do not match" bug while trying the other
approach. ;)

 Documentation/git-cat-file.txt |  3 +-
 builtin/cat-file.c             |  2 ++
 t/t1006-cat-file.sh            | 66 ++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 6467707c6e..27b27e2b30 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -96,7 +96,8 @@ OPTIONS
 	any alternate object stores (not just reachable objects).
 	Requires `--batch` or `--batch-check` be specified. By default,
 	the objects are visited in order sorted by their hashes; see
-	also `--unordered` below.
+	also `--unordered` below. Objects are presented as-is, without
+	respecting the "replace" mechanism of linkgit:git-replace[1].
 
 --buffer::
 	Normally batch output is flushed after each object is output, so
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 243fe6844b..b713be545e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -529,6 +529,8 @@ static int batch_objects(struct batch_options *opt)
 		if (has_promisor_remote())
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
 
+		read_replace_refs = 0;
+
 		cb.opt = opt;
 		cb.expand = &data;
 		cb.scratch = &output;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index c77db35728..4a753705ec 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -617,4 +617,70 @@ test_expect_success 'cat-file --batch="batman" with --batch-all-objects will wor
 	cmp expect actual
 '
 
+test_expect_success 'set up replacement object' '
+	orig=$(git rev-parse HEAD) &&
+	git cat-file commit $orig >orig &&
+	{
+		cat orig &&
+		echo extra
+	} >fake &&
+	fake=$(git hash-object -t commit -w fake) &&
+	orig_size=$(git cat-file -s $orig) &&
+	fake_size=$(git cat-file -s $fake) &&
+	git replace $orig $fake
+'
+
+test_expect_success 'cat-file --batch respects replace objects' '
+	git cat-file --batch >actual <<-EOF &&
+	$orig
+	EOF
+	{
+		echo "$orig commit $fake_size" &&
+		cat fake &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cat-file --batch-check respects replace objects' '
+	git cat-file --batch-check >actual <<-EOF &&
+	$orig
+	EOF
+	echo "$orig commit $fake_size" >expect &&
+	test_cmp expect actual
+'
+
+# Pull the entry for object with oid "$1" out of the output of
+# "cat-file --batch", including its object content (which requires
+# parsing and reading a set amount of bytes, hence perl).
+extract_batch_output () {
+    perl -ne '
+	BEGIN { $oid = shift }
+	if (/^$oid \S+ (\d+)$/) {
+	    print;
+	    read STDIN, my $buf, $1;
+	    print $buf;
+	    print "\n";
+	}
+    ' "$@"
+}
+
+test_expect_success 'cat-file --batch-all-objects --batch ignores replace' '
+	git cat-file --batch-all-objects --batch >actual.raw &&
+	extract_batch_output $orig <actual.raw >actual &&
+	{
+		echo "$orig commit $orig_size" &&
+		cat orig &&
+		echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cat-file --batch-all-objects --batch-check ignores replace' '
+	git cat-file --batch-all-objects --batch-check >actual.raw &&
+	grep ^$orig actual.raw >actual &&
+	echo "$orig commit $orig_size" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.33.0.1231.g45ae28b974

