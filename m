From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] drop some obsolete "x = x" compiler warning hacks
Date: Thu, 21 Mar 2013 07:10:28 -0400
Message-ID: <20130321111028.GC18819@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 12:11:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIdOl-0006ZY-A2
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 12:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796Ab3CULKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 07:10:37 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33667 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756104Ab3CULKf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 07:10:35 -0400
Received: (qmail 20801 invoked by uid 107); 21 Mar 2013 11:12:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 07:12:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 07:10:28 -0400
Content-Disposition: inline
In-Reply-To: <20130321110338.GA18552@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218710>

In cases where the setting and access of a variable are
protected by the same conditional flag, older versions of
gcc would generate a "might be used unitialized" warning. We
silence the warning by initializing the variable to itself,
a hack that gcc recognizes.

Modern versions of gcc are smart enough to get this right,
going back to at least version 4.3.5. gcc 4.1 does get it
wrong in both cases, but is sufficiently old that we
probably don't need to care about it anymore.

Signed-off-by: Jeff King <peff@peff.net>
---
gcc 4.2 is conspicuously missing because no current Debian system even
has a backwards-compatibility package for it, making it harder to test.
And 4.3 was old enough for me to say "I do not care if you can run with
-Wall -Werror or not", let alone 4.2.

 builtin/cat-file.c | 2 +-
 fast-import.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 00528dd..ad29000 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -193,7 +193,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	unsigned char sha1[20];
 	enum object_type type = 0;
 	unsigned long size;
-	void *contents = contents;
+	void *contents;
 
 	if (!obj_name)
 	   return 1;
diff --git a/fast-import.c b/fast-import.c
index 583a439..e12a8b8 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2434,7 +2434,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	struct branch *s;
 	unsigned char sha1[20], commit_sha1[20];
 	char path[60];
-- 
1.8.2.rc2.8.g2161951
