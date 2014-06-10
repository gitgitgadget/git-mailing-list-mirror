From: Jeff King <peff@peff.net>
Subject: [PATCH 03/17] alloc: include any-object allocations in alloc_report
Date: Tue, 10 Jun 2014 17:38:47 -0400
Message-ID: <20140610213847.GC19147@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:38:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTkr-0003ht-85
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbaFJVit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:38:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:41360 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753209AbaFJVis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:38:48 -0400
Received: (qmail 19392 invoked by uid 102); 10 Jun 2014 21:38:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:38:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:38:47 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251246>

When 2c1cbec (Use proper object allocators for unknown
object nodes too, 2007-04-16), added a special "any_object"
allocator, it never taught alloc_report to report on it. To
do so we need to add an extra type argument to the REPORT
macro, as that commit did for DEFINE_ALLOCATOR.

Signed-off-by: Jeff King <peff@peff.net>
---
 alloc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/alloc.c b/alloc.c
index f3ee745..38ff7e7 100644
--- a/alloc.c
+++ b/alloc.c
@@ -57,13 +57,14 @@ static void report(const char *name, unsigned int count, size_t size)
 			name, count, (uintmax_t) size);
 }
 
-#define REPORT(name)	\
-    report(#name, name##_allocs, name##_allocs * sizeof(struct name) >> 10)
+#define REPORT(name, type)	\
+    report(#name, name##_allocs, name##_allocs * sizeof(type) >> 10)
 
 void alloc_report(void)
 {
-	REPORT(blob);
-	REPORT(tree);
-	REPORT(commit);
-	REPORT(tag);
+	REPORT(blob, struct blob);
+	REPORT(tree, struct tree);
+	REPORT(commit, struct commit);
+	REPORT(tag, struct tag);
+	REPORT(object, union any_object);
 }
-- 
2.0.0.729.g520999f
