From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/5] trailer: display a trailer without its trailing newline
Date: Sun, 09 Nov 2014 10:23:40 +0100
Message-ID: <20141109092344.4864.55173.chriscool@tuxfamily.org>
References: <20141109092313.4864.54933.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sun Nov 09 10:27:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnOmk-0006Of-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 10:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbaKIJ1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 04:27:39 -0500
Received: from [194.158.98.14] ([194.158.98.14]:55728 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751514AbaKIJ1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 04:27:38 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 5BDC269;
	Sun,  9 Nov 2014 10:27:16 +0100 (CET)
X-git-sha1: 18abf41e1e5363a4c1729c2425a9ebb0cd651262 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20141109092313.4864.54933.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Trailers passed to the parse_trailer() function often have
a trailing newline. When erroring out, we should display
the invalid trailer properly, that means without any
trailing newline.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trailer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/trailer.c b/trailer.c
index 761b763..219a5a2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -583,8 +583,12 @@ static int parse_trailer(struct strbuf *tok, struct strbuf *val, const char *tra
 	strbuf_addch(&seps, '=');
 	len = strcspn(trailer, seps.buf);
 	strbuf_release(&seps);
-	if (len == 0)
-		return error(_("empty trailer token in trailer '%s'"), trailer);
+	if (len == 0) {
+		int l = strlen(trailer);
+		while (l > 0 && isspace(trailer[l - 1]))
+			l--;
+		return error(_("empty trailer token in trailer '%.*s'"), l, trailer);
+	}
 	if (len < strlen(trailer)) {
 		strbuf_add(tok, trailer, len);
 		strbuf_trim(tok);
-- 
2.1.2.555.gfbecd99
