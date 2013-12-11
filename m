From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] cat-file: handle --batch format with missing type/size
Date: Wed, 11 Dec 2013 19:58:45 +0800
Message-ID: <20131211115844.GB10594@sigill.intra.peff.net>
References: <20131211115458.GA10561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 12:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiRL-0005li-PK
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702Ab3LKL6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:58:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:34812 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751546Ab3LKL6v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:58:51 -0500
Received: (qmail 11150 invoked by uid 102); 11 Dec 2013 11:58:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (123.127.199.235)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Dec 2013 05:58:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Dec 2013 19:58:45 +0800
Content-Disposition: inline
In-Reply-To: <20131211115458.GA10561@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239193>

Commit 98e2092 taught cat-file to stream blobs with --batch,
which requires that we look up the object type before
loading it into memory.  As a result, we now print the
object header from information in sha1_object_info, and the
actual contents from the read_sha1_file. We double-check
that the information we printed in the header matches the
content we are about to show.

Later, commit 93d2a60 allowed custom header lines for
--batch, and commit 5b08640 made type lookups optional. As a
result, specifying a header line without the type or size
means that we will not look up those items at all.

This causes our double-checking to erroneously die with an
error; we think the type or size has changed, when in fact
it was simply left at "0".

For the size, we can fix this by only doing the consistency
double-check when we have retrieved the size via
sha1_object_info. In the case that we have not retrieved the
value, that means we also did not print it, so there is
nothing for us to check that we are consistent with.

We could do the same for the type. However, besides our
consistency check, we also care about the type in deciding
whether to stream or not. We therefore make sure to always
trigger a type lookup when we are printing, so that even a
format without the type will stream as we would in the
normal case.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c  |  9 ++++++++-
 t/t1006-cat-file.sh | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1434afb..4af67fd 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -211,7 +211,7 @@ static void print_object_or_die(int fd, struct expand_data *data)
 			die("object %s disappeared", sha1_to_hex(sha1));
 		if (type != data->type)
 			die("object %s changed type!?", sha1_to_hex(sha1));
-		if (size != data->size)
+		if (data->info.sizep && size != data->size)
 			die("object %s changed size!?", sha1_to_hex(sha1));
 
 		write_or_die(fd, contents, size);
@@ -276,6 +276,13 @@ static int batch_objects(struct batch_options *opt)
 	data.mark_query = 0;
 
 	/*
+	 * If we are printing out the object, then always fill in the type,
+	 * since we will want to decide whether or not to stream.
+	 */
+	if (opt->print_contents)
+		data.info.typep = &data.type;
+
+	/*
 	 * We are going to call get_sha1 on a potentially very large number of
 	 * objects. In most large cases, these will be actual object sha1s. The
 	 * cost to double-check that each one is not also a ref (just so we can
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8a1bc5c..1687098 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -85,6 +85,28 @@ $content"
 		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
 	test_cmp expect actual
     '
+
+    test -z "$content" ||
+    test_expect_success "--batch without type ($type)" '
+	{
+		echo "$size" &&
+		maybe_remove_timestamp "$content" $no_ts
+	} >expect &&
+	echo $sha1 | git cat-file --batch="%(objectsize)" >actual.full &&
+	maybe_remove_timestamp "$(cat actual.full)" $no_ts >actual &&
+	test_cmp expect actual
+    '
+
+    test -z "$content" ||
+    test_expect_success "--batch without size ($type)" '
+	{
+		echo "$type" &&
+		maybe_remove_timestamp "$content" $no_ts
+	} >expect &&
+	echo $sha1 | git cat-file --batch="%(objecttype)" >actual.full &&
+	maybe_remove_timestamp "$(cat actual.full)" $no_ts >actual &&
+	test_cmp expect actual
+    '
 }
 
 hello_content="Hello World"
-- 
1.8.5.524.g6743da6
