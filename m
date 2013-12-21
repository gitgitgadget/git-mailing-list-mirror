From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] cat-file: provide %(deltabase) batch format
Date: Sat, 21 Dec 2013 09:25:22 -0500
Message-ID: <20131221142522.GB29679@sigill.intra.peff.net>
References: <20131221142336.GA28649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuNUe-00075a-7F
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867Ab3LUOZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:25:24 -0500
Received: from cloud.peff.net ([50.56.180.127]:48540 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754262Ab3LUOZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:25:24 -0500
Received: (qmail 9631 invoked by uid 102); 21 Dec 2013 14:25:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:25:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:25:22 -0500
Content-Disposition: inline
In-Reply-To: <20131221142336.GA28649@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239622>

It can be useful for debugging or analysis to see which
objects are stored as delta bases on top of others. This
information is available by running `git verify-pack`, but
that is extremely expensive (and is harder than necessary to
parse).

Instead, let's make it available as a cat-file query format,
which makes it fast and simple to get the bases for a subset
of the objects.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt | 12 +++++++++---
 builtin/cat-file.c             |  6 ++++++
 t/t1006-cat-file.sh            | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 322f5ed..f6a16f4 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -109,6 +109,11 @@ newline. The available atoms are:
 	The size, in bytes, that the object takes up on disk. See the
 	note about on-disk sizes in the `CAVEATS` section below.
 
+`deltabase`::
+	If the object is stored as a delta on-disk, this expands to the
+	40-hex sha1 of the delta base object. Otherwise, expands to the
+	null sha1 (40 zeroes). See `CAVEATS` below.
+
 `rest`::
 	If this atom is used in the output string, input lines are split
 	at the first whitespace boundary. All characters before that
@@ -152,10 +157,11 @@ should be taken in drawing conclusions about which refs or objects are
 responsible for disk usage. The size of a packed non-delta object may be
 much larger than the size of objects which delta against it, but the
 choice of which object is the base and which is the delta is arbitrary
-and is subject to change during a repack. Note also that multiple copies
-of an object may be present in the object database; in this case, it is
-undefined which copy's size will be reported.
+and is subject to change during a repack.
 
+Note also that multiple copies of an object may be present in the object
+database; in this case, it is undefined which copy's size or delta base
+will be reported.
 
 GIT
 ---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..2e0af2e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -118,6 +118,7 @@ struct expand_data {
 	unsigned long size;
 	unsigned long disk_size;
 	const char *rest;
+	unsigned char delta_base_sha1[20];
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -174,6 +175,11 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			data->split_on_whitespace = 1;
 		else if (data->rest)
 			strbuf_addstr(sb, data->rest);
+	} else if (is_atom("deltabase", atom, len)) {
+		if (data->mark_query)
+			data->info.delta_base_sha1 = data->delta_base_sha1;
+		else
+			strbuf_addstr(sb, sha1_to_hex(data->delta_base_sha1));
 	} else
 		die("unknown format element: %.*s", len, atom);
 }
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8a1bc5c..633dc82 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -240,4 +240,38 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
     "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
 '
 
+test_expect_success 'setup blobs which are likely to delta' '
+	test-genrandom foo 10240 >foo &&
+	{ cat foo; echo plus; } >foo-plus &&
+	git add foo foo-plus &&
+	git commit -m foo &&
+	cat >blobs <<-\EOF
+	HEAD:foo
+	HEAD:foo-plus
+	EOF
+'
+
+test_expect_success 'confirm that neither loose blob is a delta' '
+	cat >expect <<-EOF
+	$_z40
+	$_z40
+	EOF
+	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
+	test_cmp expect actual
+'
+
+# To avoid relying too much on the current delta heuristics,
+# we will check only that one of the two objects is a delta
+# against the other, but not the order. We can do so by just
+# asking for the base of both, and checking whether either
+# sha1 appears in the output.
+test_expect_success '%(deltabase) reports packed delta bases' '
+	git repack -ad &&
+	git cat-file --batch-check="%(deltabase)" <blobs >actual &&
+	{
+		grep "$(git rev-parse HEAD:foo)" actual ||
+		grep "$(git rev-parse HEAD:foo-plus)" actual
+	}
+'
+
 test_done
-- 
1.8.5.1.399.g900e7cd
