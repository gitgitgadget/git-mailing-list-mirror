From: Jeff King <peff@peff.net>
Subject: [PATCH 15/17] commit-slab: provide a static initializer
Date: Tue, 10 Jun 2014 17:42:51 -0400
Message-ID: <20140610214251.GO19147@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:42:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTom-00072e-Ng
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbaFJVmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:42:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:41436 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753230AbaFJVmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:42:52 -0400
Received: (qmail 19964 invoked by uid 102); 10 Jun 2014 21:42:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:42:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:42:51 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251259>

Callers currently must use init_foo_slab() at runtime before
accessing a slab. For global slabs, it's much nicer if we
can initialize them in BSS, so that each user does not have
to add code to check-and-initialize.

Signed-off-by: Jeff King <peff@peff.net>
---
There was no comment on this one in v1. I'd be curious if anyone has
comments on what I wrote in:

  http://article.gmane.org/gmane.comp.version-control.git/251099

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
