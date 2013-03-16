From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] upload-pack: drop lookup-before-parse optimization
Date: Sat, 16 Mar 2013 06:25:25 -0400
Message-ID: <20130316102525.GA29533@sigill.intra.peff.net>
References: <20130316102428.GA29358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 16 11:26:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGoJH-0003gl-9E
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 11:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab3CPKZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 06:25:29 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53467 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587Ab3CPKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 06:25:28 -0400
Received: (qmail 887 invoked by uid 107); 16 Mar 2013 10:27:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 06:27:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 06:25:25 -0400
Content-Disposition: inline
In-Reply-To: <20130316102428.GA29358@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218295>

When we receive a "have" line from the client, we want to
load the object pointed to by the sha1. However, we are
careful to do:

  o = lookup_object(sha1);
  if (!o || !o->parsed)
	  o = parse_object(sha1);

to avoid loading the object from disk if we have already
seen it.  However, since ccdc603 (parse_object: try internal
cache before reading object db), parse_object already does
this optimization internally. We can just call parse_object
directly.

Signed-off-by: Jeff King <peff@peff.net>
---
 upload-pack.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 30146a0..6bf81aa 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -325,9 +325,7 @@ static int got_sha1(char *hex, unsigned char *sha1)
 	if (!has_sha1_file(sha1))
 		return -1;
 
-	o = lookup_object(sha1);
-	if (!(o && o->parsed))
-		o = parse_object(sha1);
+	o = parse_object(sha1);
 	if (!o)
 		die("oops (%s)", sha1_to_hex(sha1));
 	if (o->type == OBJ_COMMIT) {
-- 
1.8.2.rc2.7.gef06216
