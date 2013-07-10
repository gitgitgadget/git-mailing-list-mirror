From: Jeff King <peff@peff.net>
Subject: [PATCH 04/10] cat-file: teach --batch to stream blob objects
Date: Wed, 10 Jul 2013 07:38:24 -0400
Message-ID: <20130710113824.GD21963@sigill.intra.peff.net>
References: <20130710113447.GA20113@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 10 13:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwsjC-0003Yl-Be
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 13:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab3GJLia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 07:38:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:47766 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754320Ab3GJLi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 07:38:29 -0400
Received: (qmail 25070 invoked by uid 102); 10 Jul 2013 11:39:45 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 10 Jul 2013 06:39:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jul 2013 07:38:24 -0400
Content-Disposition: inline
In-Reply-To: <20130710113447.GA20113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230045>

The regular "git cat-file -p" and "git cat-file blob" code
paths already learned to stream large blobs. Let's do the
same here.

Note that this means we look up the type and size before
making a decision of whether to load the object into memory
or stream (just like the "-p" code path does). That can lead
to extra work, but it should be dwarfed by the cost of
actually accessing the object itself. In my measurements,
there was a 1-2% slowdown when using "--batch" on a large
number of objects.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 045cee7..70dd8c8 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -117,12 +117,36 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	return 0;
 }
 
+static void print_object_or_die(int fd, const unsigned char *sha1,
+				enum object_type type, unsigned long size)
+{
+	if (type == OBJ_BLOB) {
+		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
+			die("unable to stream %s to stdout", sha1_to_hex(sha1));
+	}
+	else {
+		enum object_type rtype;
+		unsigned long rsize;
+		void *contents;
+
+		contents = read_sha1_file(sha1, &rtype, &rsize);
+		if (!contents)
+			die("object %s disappeared", sha1_to_hex(sha1));
+		if (rtype != type)
+			die("object %s changed type!?", sha1_to_hex(sha1));
+		if (rsize != size)
+			die("object %s change size!?", sha1_to_hex(sha1));
+
+		write_or_die(fd, contents, size);
+		free(contents);
+	}
+}
+
 static int batch_one_object(const char *obj_name, int print_contents)
 {
 	unsigned char sha1[20];
 	enum object_type type = 0;
 	unsigned long size;
-	void *contents = NULL;
 
 	if (!obj_name)
 	   return 1;
@@ -133,16 +157,10 @@ static int batch_one_object(const char *obj_name, int print_contents)
 		return 0;
 	}
 
-	if (print_contents == BATCH)
-		contents = read_sha1_file(sha1, &type, &size);
-	else
-		type = sha1_object_info(sha1, &size);
-
+	type = sha1_object_info(sha1, &size);
 	if (type <= 0) {
 		printf("%s missing\n", obj_name);
 		fflush(stdout);
-		if (print_contents == BATCH)
-			free(contents);
 		return 0;
 	}
 
@@ -150,12 +168,9 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	fflush(stdout);
 
 	if (print_contents == BATCH) {
-		write_or_die(1, contents, size);
-		printf("\n");
-		fflush(stdout);
-		free(contents);
+		print_object_or_die(1, sha1, type, size);
+		write_or_die(1, "\n", 1);
 	}
-
 	return 0;
 }
 
-- 
1.8.3.rc3.24.gec82cb9
