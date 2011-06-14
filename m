From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] archive: factor out write phase of tar format
Date: Tue, 14 Jun 2011 14:17:33 -0400
Message-ID: <20110614181732.GA31635@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 20:17:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWYBJ-0006qX-OQ
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 20:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab1FNSRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 14:17:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37644
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768Ab1FNSRf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 14:17:35 -0400
Received: (qmail 28972 invoked by uid 107); 14 Jun 2011 18:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 14:17:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 14:17:33 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175785>

The code to output the tar format for git-archive always
assumes we are writing directly to stdout. Let's factor out
that bit of code so that we can put an in-process gzip
filter in place.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index cee06ce..b1aea87 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -10,6 +10,7 @@
 
 static char block[BLOCKSIZE];
 static unsigned long offset;
+static void (*output)(const char *buf, unsigned long size);
 
 static int tar_umask = 002;
 
@@ -17,7 +18,7 @@ static int tar_umask = 002;
 static void write_if_needed(void)
 {
 	if (offset == BLOCKSIZE) {
-		write_or_die(1, block, BLOCKSIZE);
+		output(block, BLOCKSIZE);
 		offset = 0;
 	}
 }
@@ -42,7 +43,7 @@ static void write_blocked(const void *data, unsigned long size)
 		write_if_needed();
 	}
 	while (size >= BLOCKSIZE) {
-		write_or_die(1, buf, BLOCKSIZE);
+		output(buf, BLOCKSIZE);
 		size -= BLOCKSIZE;
 		buf += BLOCKSIZE;
 	}
@@ -66,10 +67,10 @@ static void write_trailer(void)
 {
 	int tail = BLOCKSIZE - offset;
 	memset(block + offset, 0, tail);
-	write_or_die(1, block, BLOCKSIZE);
+	output(block, BLOCKSIZE);
 	if (tail < 2 * RECORDSIZE) {
 		memset(block, 0, offset);
-		write_or_die(1, block, BLOCKSIZE);
+		output(block, BLOCKSIZE);
 	}
 }
 
@@ -234,7 +235,7 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-int write_tar_archive(struct archiver_args *args)
+static int write_tar_archive_internal(struct archiver_args *args)
 {
 	int err = 0;
 
@@ -248,3 +249,14 @@ int write_tar_archive(struct archiver_args *args)
 		write_trailer();
 	return err;
 }
+
+static void output_write(const char *buf, unsigned long len)
+{
+	write_or_die(1, buf, len);
+}
+
+int write_tar_archive(struct archiver_args *args)
+{
+	output = output_write;
+	return write_tar_archive_internal(args);
+}
-- 
1.7.6.rc1.37.g6d4ed.dirty
