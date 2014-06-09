From: Jeff King <peff@peff.net>
Subject: [PATCH 13/15] commit-slab: provide a static initializer
Date: Mon, 9 Jun 2014 14:15:12 -0400
Message-ID: <20140609181512.GM20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:15:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu46I-0001fd-JV
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbaFISPP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:15:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:40404 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753748AbaFISPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:15:13 -0400
Received: (qmail 16121 invoked by uid 102); 9 Jun 2014 18:15:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:15:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:15:12 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251099>

Callers currently must use init_foo_slab() at runtime before
accessing a slab. For global slabs, it's much nicer if we
can initialize them in BSS, so that each user does not have
to add code to check-and-initialize.

Signed-off-by: Jeff King <peff@peff.net>
---
The calling convention is kind of weird. It goes:

  struct foo_slab foo = COMMIT_SLAB_INIT(1, foo);

We need to know the size of the slab's element-type in the initializer
(and we grab it from sizeof(**foo.slab).  Another option would be:

  struct foo_slab foo = COMMIT_SLAB_INIT(1, void *);

which is simpler, but requires the user to repeat the type of the slab
(and if they get it wrong, bad things happen).

Yet another option would be to simply let a zero-initialized slab be
acceptable, and have slab_at check whether "stride" is initialized (and
if not, init to 1).

 commit-slab.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/commit-slab.h b/commit-slab.h
index cc114b5..375c9c7 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -117,4 +117,16 @@ static int stat_ ##slabname## realloc
  * catch because GCC silently parses it by default.
  */
 
+/*
+ * Statically initialize a commit slab named "var". Note that this
+ * evaluates "stride" multiple times! Example:
+ *
+ *   struct indegree indegrees = COMMIT_SLAB_INIT(1, indegrees);
+ *
+ */
+#define COMMIT_SLAB_INIT(stride, var) { \
+	COMMIT_SLAB_SIZE / sizeof(**((var).slab)) / (stride), \
+	(stride), 0, NULL \
+}
+
 #endif /* COMMIT_SLAB_H */
-- 
2.0.0.729.g520999f
