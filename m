From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH 2/2] conversion of lonely cr chars in autocrlf
Date: Wed, 6 May 2009 17:10:18 +0200
Message-ID: <20090506151018.GB2974@macbook.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 17:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ilU-0005NA-Pv
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 17:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760409AbZEFPKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 11:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760150AbZEFPKU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 11:10:20 -0400
Received: from darksea.de ([83.133.111.250]:51663 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760295AbZEFPKT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 11:10:19 -0400
Received: (qmail 28822 invoked from network); 6 May 2009 17:10:08 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 6 May 2009 17:10:08 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118347>

This is was marked as crazy stuff but certainly done by our
developers in an 10 year old rcs like repository

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
This belongs to an conversion effort of quite matured repositories. I
do not know how many programs still write CR's as their line endings but
there certainly are/were some.

Anybody interested in that crazy stuff?

 convert.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/convert.c b/convert.c
index 0ced471..7164f09 100644
--- a/convert.c
+++ b/convert.c
@@ -133,14 +133,6 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 
 	if (action == CRLF_GUESS) {
 		/*
-		 * We're currently not going to even try to convert stuff
-		 * that has bare CR characters. Does anybody do that crazy
-		 * stuff?
-		 */
-		if (stats.cr != stats.crlf)
-			return 0;
-
-		/*
 		 * And add some heuristics for binary vs text, of course...
 		 */
 		if (is_binary(len, &stats))
@@ -158,15 +150,22 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		strbuf_grow(buf, len - buf->len);
 	dst = buf->buf;
 	if (action == CRLF_GUESS) {
-		/*
-		 * If we guessed, we already know we rejected a file with
-		 * lone CR, and we can strip a CR without looking at what
-		 * follow it.
-		 */
 		do {
 			unsigned char c = *src++;
-			if (c != '\r')
+			if (c != '\r') {
+				/* if its not cr copy this char */
 				*dst++ = c;
+				continue;
+			}
+			if (c == '\r' && (1 < len && *src == '\n')) {
+				/* if its \r\n skip this char */
+				continue;
+			}
+			if (c == '\r' && !(1 < len && *src == '\n')) {
+				/* if its a lonely cr substitute it */
+				*dst++ = '\n';
+			}
+
 		} while (--len);
 	} else {
 		do {
-- 
1.6.2.1.423.g442d
