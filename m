From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] get_urlmatch: avoid useless strbuf write
Date: Thu, 20 Aug 2015 10:49:45 -0400
Message-ID: <20150820144945.GC11913@sigill.intra.peff.net>
References: <20150820144504.GA22935@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 20 16:49:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSRA9-00022Y-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 16:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbbHTOtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 10:49:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:47573 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753021AbbHTOts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 10:49:48 -0400
Received: (qmail 3506 invoked by uid 102); 20 Aug 2015 14:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 09:49:47 -0500
Received: (qmail 23768 invoked by uid 107); 20 Aug 2015 14:49:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 10:49:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Aug 2015 10:49:45 -0400
Content-Disposition: inline
In-Reply-To: <20150820144504.GA22935@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276245>

We create a strbuf only to insert a single string, pass the
resulting buffer to a function (which does not modify the
string), and then free it. We can just pass the original
string instead.

Signed-off-by: Jeff King <peff@peff.net>
---
I keep staring at this thinking I missed something, but I think this is
an equivalent transformation. I wonder if the original meant to modify
the key in some way, but I don't see how or why.

 builtin/config.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 04befce..71acc44 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -425,14 +425,11 @@ static int get_urlmatch(const char *var, const char *url)
 
 	for_each_string_list_item(item, &values) {
 		struct urlmatch_current_candidate_value *matched = item->util;
-		struct strbuf key = STRBUF_INIT;
 		struct strbuf buf = STRBUF_INIT;
 
-		strbuf_addstr(&key, item->string);
-		format_config(&buf, key.buf,
+		format_config(&buf, item->string,
 			      matched->value_is_null ? NULL : matched->value.buf);
 		fwrite(buf.buf, 1, buf.len, stdout);
-		strbuf_release(&key);
 		strbuf_release(&buf);
 
 		strbuf_release(&matched->value);
-- 
2.5.0.680.g69e7703
