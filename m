From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] cat-file: pass expand_data to print_object_or_die
Date: Wed, 11 Dec 2013 19:56:45 +0800
Message-ID: <20131211115642.GA10594@sigill.intra.peff.net>
References: <20131211115458.GA10561@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 12:57:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiPU-0004In-7E
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab3LKL44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:56:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:34806 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751215Ab3LKL44 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:56:56 -0500
Received: (qmail 11050 invoked by uid 102); 11 Dec 2013 11:56:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (123.127.199.235)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Dec 2013 05:56:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Dec 2013 19:56:45 +0800
Content-Disposition: inline
In-Reply-To: <20131211115458.GA10561@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239192>

We currently individually pass the sha1, type, and size
fields calculated by sha1_object_info. However, if we pass
the whole struct, the called function can make more
intelligent decisions about which fields were actualled
filled by sha1_object_info.

As a side effect, we can rename the local variables in the
function to "type" and "size", since the names are no longer
taken.

There should be no functional change to this patch.

Signed-off-by: Jeff King <peff@peff.net>
---
I split this out mostly to keep the noise out of the follow-on diff.

 builtin/cat-file.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..1434afb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -193,25 +193,26 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 	return end - start + 1;
 }
 
-static void print_object_or_die(int fd, const unsigned char *sha1,
-				enum object_type type, unsigned long size)
+static void print_object_or_die(int fd, struct expand_data *data)
 {
-	if (type == OBJ_BLOB) {
+	const unsigned char *sha1 = data->sha1;
+
+	if (data->type == OBJ_BLOB) {
 		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
 			die("unable to stream %s to stdout", sha1_to_hex(sha1));
 	}
 	else {
-		enum object_type rtype;
-		unsigned long rsize;
+		enum object_type type;
+		unsigned long size;
 		void *contents;
 
-		contents = read_sha1_file(sha1, &rtype, &rsize);
+		contents = read_sha1_file(sha1, &type, &size);
 		if (!contents)
 			die("object %s disappeared", sha1_to_hex(sha1));
-		if (rtype != type)
+		if (type != data->type)
 			die("object %s changed type!?", sha1_to_hex(sha1));
-		if (rsize != size)
-			die("object %s change size!?", sha1_to_hex(sha1));
+		if (size != data->size)
+			die("object %s changed size!?", sha1_to_hex(sha1));
 
 		write_or_die(fd, contents, size);
 		free(contents);
@@ -250,7 +251,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 	strbuf_release(&buf);
 
 	if (opt->print_contents) {
-		print_object_or_die(1, data->sha1, data->type, data->size);
+		print_object_or_die(1, data);
 		write_or_die(1, "\n", 1);
 	}
 	return 0;
-- 
1.8.5.524.g6743da6
