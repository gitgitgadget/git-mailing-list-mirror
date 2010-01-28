From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] fix parsing of @{-1}@{u} combination
Date: Thu, 28 Jan 2010 04:52:22 -0500
Message-ID: <20100128095222.GB14253@coredump.intra.peff.net>
References: <20100128094446.GA14244@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 10:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaR3C-0003RZ-6i
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 10:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491Ab0A1Jw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 04:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754272Ab0A1Jw2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 04:52:28 -0500
Received: from peff.net ([208.65.91.99]:42058 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753177Ab0A1Jw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 04:52:28 -0500
Received: (qmail 20820 invoked by uid 107); 28 Jan 2010 09:52:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 Jan 2010 04:52:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jan 2010 04:52:22 -0500
Content-Disposition: inline
In-Reply-To: <20100128094446.GA14244@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138238>

Previously interpret_branch_name would see @{-1} and stop
parsing, leaving the @{u} as cruft that provoked an error.
Instead, we should recurse if there is more to parse.

Signed-off-by: Jeff King <peff@peff.net>
---
A straight repost of the previous "how about this" patch, but marking
successful tests.

 sha1_name.c                |   24 ++++++++++++++++++++++--
 t/t1508-at-combinations.sh |    4 ++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index c7f1510..00fc415 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -881,8 +881,28 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 
 	if (!len)
 		return len; /* syntax Ok, not enough switches */
-	if (0 < len)
-		return len; /* consumed from the front */
+	if (0 < len && len == namelen)
+		return len; /* consumed all */
+	else if (0 < len) {
+		/* we have extra data, which might need further processing */
+		struct strbuf tmp = STRBUF_INIT;
+		int used = buf->len;
+		int ret;
+
+		strbuf_add(buf, name + len, namelen - len);
+		ret = interpret_branch_name(buf->buf, &tmp);
+		/* that data was not interpreted, remove our cruft */
+		if (ret < 0) {
+			strbuf_setlen(buf, used);
+			return len;
+		}
+		strbuf_reset(buf);
+		strbuf_addbuf(buf, &tmp);
+		strbuf_release(&tmp);
+		/* tweak for size of {-N} versus expanded ref name */
+		return ret - used + len;
+	}
+
 	cp = strchr(name, '@');
 	if (!cp)
 		return -1;
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index 59f0463..2a46af2 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -43,8 +43,8 @@ check "@{-1}" old-two
 check "@{-1}@{1}" old-one
 check "@{u}" upstream-two
 check "@{u}@{1}" upstream-one
-fail check "@{-1}@{u}" master-two
-fail check "@{-1}@{u}@{1}" master-one
+check "@{-1}@{u}" master-two
+check "@{-1}@{u}@{1}" master-one
 fail nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
-- 
1.7.0.rc0.41.g538720
