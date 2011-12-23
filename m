From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pretty: allow "max-size" magic for all placeholders
Date: Fri, 23 Dec 2011 05:36:39 -0500
Message-ID: <20111223103639.GB28036@sigill.intra.peff.net>
References: <20111223100957.GA1247@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: nathan.panike@gmail.com
X-From: git-owner@vger.kernel.org Fri Dec 23 11:36:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re2Uk-0003XN-Dg
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 11:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632Ab1LWKgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 05:36:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51730
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756551Ab1LWKgn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 05:36:43 -0500
Received: (qmail 32394 invoked by uid 107); 23 Dec 2011 10:43:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 Dec 2011 05:43:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Dec 2011 05:36:39 -0500
Content-Disposition: inline
In-Reply-To: <20111223100957.GA1247@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187626>

You can now truncate a given placeholder to no more than a
certain number of characters with something like "%30s".

Signed-off-by: Jeff King <peff@peff.net>
---
This just uses the made-up "%30s" syntax, but you could easily tweak it
to handle "%.30s" or whatever.

 pretty.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index 7b4d098..06d96a7 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1019,6 +1019,7 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 {
 	int consumed;
 	int magic_len = 0;
+	int max_len = 0;
 	size_t orig_len;
 	enum {
 		NO_MAGIC,
@@ -1045,9 +1046,22 @@ static size_t format_commit_item(struct strbuf *sb, const char *placeholder,
 		placeholder++;
 	}
 
+	if (isdigit(placeholder[0])) {
+		char *end;
+		max_len = strtoul(placeholder, &end, 10);
+		magic_len += (end - placeholder);
+		placeholder = end;
+	}
+
 	orig_len = sb->len;
 	consumed = format_commit_one(sb, placeholder, context);
 
+	if (max_len) {
+		size_t end = orig_len + max_len;
+		if (end < sb->len)
+			strbuf_setlen(sb, end);
+	}
+
 	if ((orig_len == sb->len) && magic == DEL_LF_BEFORE_EMPTY) {
 		while (sb->len && sb->buf[sb->len - 1] == '\n')
 			strbuf_setlen(sb, sb->len - 1);
-- 
1.7.8.1.3.gba11d
