From: Jeff King <peff@peff.net>
Subject: [PATCH 05/16] apply: use skip_prefix instead of raw addition
Date: Wed, 18 Jun 2014 15:45:34 -0400
Message-ID: <20140618194534.GE22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:45:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLnh-00019R-72
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754666AbaFRTph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:45:37 -0400
Received: from cloud.peff.net ([50.56.180.127]:46945 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754256AbaFRTpg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:45:36 -0400
Received: (qmail 30113 invoked by uid 102); 18 Jun 2014 19:45:36 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:45:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:45:34 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252037>

A submodule diff generally has content like:

  -Subproject commit [0-9a-f]{40}
  +Subproject commit [0-9a-f]{40}

When we are using "git apply --index" with a submodule, we
first apply the textual diff, and then parse that result to
figure out the new sha1.

If the diff has bogus input like:

  -Subproject commit 1234567890123456789012345678901234567890
  +bogus

we will parse the "bogus" portion. Our parser assumes that
the buffer starts with "Subproject commit", and blindly
skips past it using strlen(). This can cause us to read
random memory after the buffer.

This problem was unlikely to have come up in practice (since
it requires a malformed diff), and even when it did, we
likely noticed the problem anyway as the next operation was
to call get_sha1_hex on the random memory.

However, we can easily fix it by using skip_prefix to notice
the parsing error.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/apply.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 9c5724e..bc924ab 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3847,9 +3847,10 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = namelen;
 	if (S_ISGITLINK(mode)) {
-		const char *s = buf;
+		const char *s;
 
-		if (get_sha1_hex(s + strlen("Subproject commit "), ce->sha1))
+		if (!skip_prefix(buf, "Subproject commit ", &s) ||
+		    get_sha1_hex(s, ce->sha1))
 			die(_("corrupt patch for submodule %s"), path);
 	} else {
 		if (!cached) {
-- 
2.0.0.566.gfe3e6b2
