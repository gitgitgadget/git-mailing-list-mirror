From: Jeff King <peff@peff.net>
Subject: [PATCH 09/67] fsck: use strbuf to generate alternate directories
Date: Tue, 15 Sep 2015 11:26:53 -0400
Message-ID: <20150915152653.GI29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 17:27:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbs8L-0001q4-2I
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 17:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbbIOP04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 11:26:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:59291 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752316AbbIOP0z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 11:26:55 -0400
Received: (qmail 11232 invoked by uid 102); 15 Sep 2015 15:26:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 10:26:55 -0500
Received: (qmail 6870 invoked by uid 107); 15 Sep 2015 15:27:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:27:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 11:26:53 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277910>

When fsck-ing alternates, we make a copy of the alternate
directory in a fixed PATH_MAX buffer. We memcpy directly,
without any check whether we are overflowing the buffer.
This is OK if PATH_MAX is a true representation of the
maximum path on the system, because any path here will have
already been vetted by the alternates subsystem. But that is
not true on every system, so we should be more careful.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 46c7235..a019f4a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -683,11 +683,12 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 		prepare_alt_odb();
 		for (alt = alt_odb_list; alt; alt = alt->next) {
-			char namebuf[PATH_MAX];
-			int namelen = alt->name - alt->base;
-			memcpy(namebuf, alt->base, namelen);
-			namebuf[namelen - 1] = 0;
-			fsck_object_dir(namebuf);
+			/* directory name, minus trailing slash */
+			size_t namelen = alt->name - alt->base - 1;
+			struct strbuf name = STRBUF_INIT;
+			strbuf_add(&name, alt->base, namelen);
+			fsck_object_dir(name.buf);
+			strbuf_release(&name);
 		}
 	}
 
-- 
2.6.0.rc2.408.ga2926b9
