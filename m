From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/5] trailer: display a trailer without its trailing newline
Date: Fri, 07 Nov 2014 19:50:49 +0100
Message-ID: <20141107185053.16854.84253.chriscool@tuxfamily.org>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 19:51:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmodM-0006PK-5q
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 19:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbaKGSvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 13:51:41 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:49658 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752524AbaKGSv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 13:51:28 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 0638463;
	Fri,  7 Nov 2014 19:51:26 +0100 (CET)
X-git-sha1: ce9cab824b8582cba5625bdf2437eb5b485b741c 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141107184148.16854.63825.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trailers passed to the parse_trailer() function have
a trailing newline. When erroring out, we should display
the invalid trailer properly, that means without any
trailing newline.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 761b763..f4d51ba 100644
--- a/trailer.c
+++ b/trailer.c
@@ -583,8 +583,12 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
 	strbuf_addch(&seps, '=');
 	len = strcspn(trailer, seps.buf);
 	strbuf_release(&seps);
-	if (len == 0)
-		return error(_("empty trailer token in trailer '%s'"), trailer);
+	if (len == 0) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, trailer);
+		strbuf_rtrim(&sb);
+		return error(_("empty trailer token in trailer '%s'"), sb.buf);
+	}
 	if (len < strlen(trailer)) {
 		strbuf_add(tok, trailer, len);
 		strbuf_trim(tok);
-- 
2.1.2.555.gfbecd99
