From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] replace: use argv_array in export_object
Date: Tue, 24 Jun 2014 05:46:05 -0400
Message-ID: <20140624094605.GC14514@sigill.intra.peff.net>
References: <20140624094217.GA14216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:46:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzNIr-0000Eg-2l
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 11:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbaFXJqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 05:46:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:50136 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751818AbaFXJqH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 05:46:07 -0400
Received: (qmail 16536 invoked by uid 102); 24 Jun 2014 09:46:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jun 2014 04:46:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2014 05:46:05 -0400
Content-Disposition: inline
In-Reply-To: <20140624094217.GA14216@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252393>

This is a little more verbose, but will make it easier to
make parts of our command-line conditional (without
resorting to magic numbers or lots of NULLs to get an
appropriately sized argv array).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/replace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index eb1d2ec..2584170 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -193,15 +193,17 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
  */
 static void export_object(const unsigned char *sha1, const char *filename)
 {
-	const char *argv[] = { "--no-replace-objects", "cat-file", "-p", NULL, NULL };
-	struct child_process cmd = { argv };
+	struct child_process cmd = { NULL };
 	int fd;
 
 	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
 		die_errno("unable to open %s for writing", filename);
 
-	argv[3] = sha1_to_hex(sha1);
+	argv_array_push(&cmd.args, "--no-replace-objects");
+	argv_array_push(&cmd.args, "cat-file");
+	argv_array_push(&cmd.args, "-p");
+	argv_array_push(&cmd.args, sha1_to_hex(sha1));
 	cmd.git_cmd = 1;
 	cmd.out = fd;
 
-- 
2.0.0.566.gfe3e6b2
