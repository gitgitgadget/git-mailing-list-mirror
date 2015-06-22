From: Jeff King <peff@peff.net>
Subject: [PATCH 5/7] cat-file: stop returning value from batch_one_object
Date: Mon, 22 Jun 2015 06:45:33 -0400
Message-ID: <20150622104533.GE14475@peff.net>
References: <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:45:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zES-0006Ac-7w
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754470AbbFVKph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:45:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:49781 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754351AbbFVKpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:45:35 -0400
Received: (qmail 17400 invoked by uid 102); 22 Jun 2015 10:45:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:45:36 -0500
Received: (qmail 7561 invoked by uid 107); 22 Jun 2015 10:45:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:45:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:45:33 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272328>

If batch_one_object returns an error code, we stop reading
input.  However, it will only do so if we feed it NULL,
which cannot happen; we give it the "buf" member of a
strbuf, which is always non-NULL.

We did originally stop on other errors (like a missing
object), but this was changed in 3c076db (cat-file --batch /
--batch-check: do not exit if hashes are missing,
2008-06-09). These days we keep going for any per-object
error (and print "missing" when necessary).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 741e100..7d99c15 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -251,17 +251,14 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
-static int batch_one_object(const char *obj_name, struct batch_options *opt,
-			    struct expand_data *data)
+static void batch_one_object(const char *obj_name, struct batch_options *opt,
+			     struct expand_data *data)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct object_context ctx;
 	int flags = opt->follow_symlinks ? GET_SHA1_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
 
-	if (!obj_name)
-	   return 1;
-
 	result = get_sha1_with_context(obj_name, flags, data->sha1, &ctx);
 	if (result != FOUND) {
 		switch (result) {
@@ -286,7 +283,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 			break;
 		}
 		fflush(stdout);
-		return 0;
+		return;
 	}
 
 	if (ctx.mode == 0) {
@@ -294,13 +291,13 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 		       (uintmax_t)ctx.symlink_path.len,
 		       ctx.symlink_path.buf);
 		fflush(stdout);
-		return 0;
+		return;
 	}
 
 	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
-		return 0;
+		return;
 	}
 
 	strbuf_expand(&buf, opt->format, expand_format, data);
@@ -312,7 +309,6 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 		print_object_or_die(opt, data);
 		batch_write(opt, "\n", 1);
 	}
-	return 0;
 }
 
 static int batch_objects(struct batch_options *opt)
@@ -367,9 +363,7 @@ static int batch_objects(struct batch_options *opt)
 			data.rest = p;
 		}
 
-		retval = batch_one_object(buf.buf, opt, &data);
-		if (retval)
-			break;
+		batch_one_object(buf.buf, opt, &data);
 	}
 
 	strbuf_release(&buf);
-- 
2.4.4.719.g3984bc6
