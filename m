From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] format_config: don't init strbuf
Date: Thu, 20 Aug 2015 10:46:04 -0400
Message-ID: <20150820144604.GA11913@sigill.intra.peff.net>
References: <20150820144504.GA22935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 16:53:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSRDm-0004Tz-37
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 16:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbbHTOxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 10:53:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:47561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753443AbbHTOqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 10:46:07 -0400
Received: (qmail 3315 invoked by uid 102); 20 Aug 2015 14:46:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 09:46:06 -0500
Received: (qmail 23743 invoked by uid 107); 20 Aug 2015 14:46:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 10:46:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Aug 2015 10:46:04 -0400
Content-Disposition: inline
In-Reply-To: <20150820144504.GA22935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276246>

It's unusual for a function which writes to a passed-in
strbuf to call strbuf_init; that will throw away anything
already there, leaking memory. In this case, there are
exactly two callers; one relies on this initialization and
the other passes in an already-initialized buffer.

There's no leak, as the initialized buffer doesn't have
anything in it. But let's bump the strbuf_init out to the
one caller who needs it, making format_config more
idiomatic.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 810e104..91aa56f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -108,8 +108,6 @@ struct strbuf_list {
 
 static int format_config(struct strbuf *buf, const char *key_, const char *value_)
 {
-	strbuf_init(buf, 0);
-
 	if (show_keys)
 		strbuf_addstr(buf, key_);
 	if (!omit_values) {
@@ -166,6 +164,7 @@ static int collect_config(const char *key_, const char *value_, void *cb)
 		return 0;
 
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
+	strbuf_init(&values->items[values->nr], 0);
 
 	return format_config(&values->items[values->nr++], key_, value_);
 }
-- 
2.5.0.680.g69e7703
