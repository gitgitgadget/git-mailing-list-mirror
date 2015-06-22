From: Jeff King <peff@peff.net>
Subject: [PATCH 8/7] cat-file: sort and de-dup output of --batch-all-objects
Date: Mon, 22 Jun 2015 07:06:32 -0400
Message-ID: <20150622110632.GA26436@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <20150622083822.GB12259@peff.net>
 <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 13:06:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zYm-0006bt-9Z
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 13:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbbFVLGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 07:06:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:49797 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752356AbbFVLGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 07:06:34 -0400
Received: (qmail 18336 invoked by uid 102); 22 Jun 2015 11:06:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:06:35 -0500
Received: (qmail 7679 invoked by uid 107); 22 Jun 2015 11:06:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 07:06:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 07:06:32 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272331>

On Mon, Jun 22, 2015 at 06:33:21AM -0400, Jeff King wrote:

> By the way, in addition to not showing objects in order,
> list-all-objects (and my cat-file option) may show duplicates. Do we
> want to "sort -u" for the user? It might be nice for them to always get
> a de-duped and sorted list. Aside from the CPU cost of sorting, it does
> mean we'll allocate ~80MB for the kernel to store the sha1s. I guess
> that's not too much when you are talking about the kernel repo. I took
> the coward's way out and just mentioned the limitation in the
> documentation, but I'm happy to be persuaded.

The patch below does the sort/de-dup. I'd probably just squash it into
patch 7, though.

I did have one additional thought, though. We are treating this as two
separate operations: "what are the sha1s in the repo" and "show me
information about this sha1". But by integrating with cat-file, we could
actually show information not just about a particular sha1, but about a
particular on-disk object.

E.g., if there are duplicates of a particular object, some formatters
like "%(objectsize:disk)" and "%(deltabase)" pick one arbitrarily to
show. I don't know if anybody actually cares about that in practice, but
if we show duplicates, we could give the accurate information for each
instance (and in fact we could give other information like loose vs
packed, which file contains the object, etc).

I tend to think that the lack of de-duping is sufficiently confusing
that it should be the default, and we can always add a "no really, show
me the duplicates" option later. It is not as simple as skipping the
de-dup step. We'd have to actually avoid calling sha1_object_info, and
use the information found in the loose/pack traversal (which would in
turn require exposing the low-level bits of sha1_object_info).

-- >8 --
Subject: cat-file: sort and de-dup output of --batch-all-objects

The sorting we could probably live without, but printing
duplicates is just a hassle for the user, who must then
de-dup themselves (or risk a wrong answer if they are doing
something like counting objects with a particular property).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt |  3 +--
 builtin/cat-file.c             | 22 +++++++++++++++-------
 t/t1006-cat-file.sh            |  3 +--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 6831b08..3105fc0 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -74,8 +74,7 @@ OPTIONS
 	requested batch operation on all objects in the repository and
 	any alternate object stores (not just reachable objects).
 	Requires `--batch` or `--batch-check` be specified. Note that
-	the order of the objects is unspecified, and there may be
-	duplicate entries.
+	the objects are visited in order sorted by their hashes.
 
 --buffer::
 	Normally batch output is flushed after each object is output, so
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 95604c4..07baad1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -9,6 +9,7 @@
 #include "userdiff.h"
 #include "streaming.h"
 #include "tree-walk.h"
+#include "sha1-array.h"
 
 struct batch_options {
 	int enabled;
@@ -324,19 +325,19 @@ struct object_cb_data {
 	struct expand_data *expand;
 };
 
-static int batch_object_cb(const unsigned char *sha1,
-			   struct object_cb_data *data)
+static void batch_object_cb(const unsigned char sha1[20], void *vdata)
 {
+	struct object_cb_data *data = vdata;
 	hashcpy(data->expand->sha1, sha1);
 	batch_object_write(NULL, data->opt, data->expand);
-	return 0;
 }
 
 static int batch_loose_object(const unsigned char *sha1,
 			      const char *path,
 			      void *data)
 {
-	return batch_object_cb(sha1, data);
+	sha1_array_append(data, sha1);
+	return 0;
 }
 
 static int batch_packed_object(const unsigned char *sha1,
@@ -344,7 +345,8 @@ static int batch_packed_object(const unsigned char *sha1,
 			       uint32_t pos,
 			       void *data)
 {
-	return batch_object_cb(sha1, data);
+	sha1_array_append(data, sha1);
+	return 0;
 }
 
 static int batch_objects(struct batch_options *opt)
@@ -375,11 +377,17 @@ static int batch_objects(struct batch_options *opt)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
+		struct sha1_array sa = SHA1_ARRAY_INIT;
 		struct object_cb_data cb;
+
+		for_each_loose_object(batch_loose_object, &sa, 0);
+		for_each_packed_object(batch_packed_object, &sa, 0);
+
 		cb.opt = opt;
 		cb.expand = &data;
-		for_each_loose_object(batch_loose_object, &cb, 0);
-		for_each_packed_object(batch_packed_object, &cb, 0);
+		sha1_array_for_each_unique(&sa, batch_object_cb, &cb);
+
+		sha1_array_clear(&sa);
 		return 0;
 	}
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 2b4220a..18dbdc8 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -569,8 +569,7 @@ test_expect_success 'cat-file --batch-all-objects shows all objects' '
 	) >>expect.unsorted &&
 	sort <expect.unsorted >expect &&
 	git -C all-two cat-file --batch-all-objects \
-				--batch-check="%(objectname)" >actual.unsorted &&
-	sort <actual.unsorted >actual &&
+				--batch-check="%(objectname)" >actual &&
 	test_cmp expect actual
 '
 
-- 
2.4.4.719.g3984bc6
