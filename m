From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] cat-file: split batch_one_object into two stages
Date: Mon, 22 Jun 2015 06:45:41 -0400
Message-ID: <20150622104540.GF14475@peff.net>
References: <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zEZ-0006D9-VJ
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933277AbbFVKpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:45:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:49786 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933230AbbFVKpn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:45:43 -0400
Received: (qmail 17412 invoked by uid 102); 22 Jun 2015 10:45:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:45:43 -0500
Received: (qmail 7579 invoked by uid 107); 22 Jun 2015 10:45:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:45:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:45:41 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272329>

There are really two things going on in this function:

  1. We convert the name we got on stdin to a sha1.

  2. We look up and print information on the sha1.

Let's split out the second half so that we can call it
separately.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 7d99c15..499ccda 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -251,10 +251,31 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
 	}
 }
 
+static void batch_object_write(const char *obj_name, struct batch_options *opt,
+			       struct expand_data *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
+		printf("%s missing\n", obj_name);
+		fflush(stdout);
+		return;
+	}
+
+	strbuf_expand(&buf, opt->format, expand_format, data);
+	strbuf_addch(&buf, '\n');
+	batch_write(opt, buf.buf, buf.len);
+	strbuf_release(&buf);
+
+	if (opt->print_contents) {
+		print_object_or_die(opt, data);
+		batch_write(opt, "\n", 1);
+	}
+}
+
 static void batch_one_object(const char *obj_name, struct batch_options *opt,
 			     struct expand_data *data)
 {
-	struct strbuf buf = STRBUF_INIT;
 	struct object_context ctx;
 	int flags = opt->follow_symlinks ? GET_SHA1_FOLLOW_SYMLINKS : 0;
 	enum follow_symlinks_result result;
@@ -294,21 +315,7 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 		return;
 	}
 
-	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
-		printf("%s missing\n", obj_name);
-		fflush(stdout);
-		return;
-	}
-
-	strbuf_expand(&buf, opt->format, expand_format, data);
-	strbuf_addch(&buf, '\n');
-	batch_write(opt, buf.buf, buf.len);
-	strbuf_release(&buf);
-
-	if (opt->print_contents) {
-		print_object_or_die(opt, data);
-		batch_write(opt, "\n", 1);
-	}
+	batch_object_write(obj_name, opt, data);
 }
 
 static int batch_objects(struct batch_options *opt)
-- 
2.4.4.719.g3984bc6
