From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH v3 1/5] attr.c: avoid inappropriate access to strbuf "buf" member
Date: Thu,  6 Oct 2011 13:22:21 -0500
Message-ID: <U4wiHVyDLLG1PhI-8iY3YpRCHWWi1IE65h4oZsMtte9f21i1djIDHGQtHssxat_eXec7H3Qbo4MfDoWvguInipQUJgljvIPZw-HcavAqSnyX27VBdUvY8BvWiIBaYW193fZG_SNtSjg@cipher.nrlssc.navy.mil>
References: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, peff@peff.net, j.sixt@viscovery.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 06 20:23:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsbS-0002jW-4y
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 20:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758879Ab1JFSXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 14:23:00 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:45181 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754435Ab1JFSW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 14:22:57 -0400
Received: by mail3.nrlssc.navy.mil id p96IMmLW031876; Thu, 6 Oct 2011 13:22:48 -0500
In-Reply-To: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 06 Oct 2011 18:22:48.0631 (UTC) FILETIME=[F39F1470:01CC8454]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183008>

From: Brandon Casey <drafnel@gmail.com>

This code sequence performs a strcpy into the buf member of a strbuf
struct.  The strcpy may move the position of the terminating nul of the
string and effectively change the length of string so that it does not
match the len member of the strbuf struct.

Currently, this sequence works since the strbuf was given a hint when it
was initialized to allocate enough space to accomodate the string that will
be strcpy'ed, but this is an implementation detail of strbufs, not a
guarantee.

So, lets rework this sequence so that the strbuf is only manipulated by
strbuf functions, and direct modification of its "buf" member is not
necessary.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 attr.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/attr.c b/attr.c
index 33cb4e4..fe38fcc 100644
--- a/attr.c
+++ b/attr.c
@@ -552,7 +552,6 @@ static void prepare_attr_stack(const char *path)
 {
 	struct attr_stack *elem, *info;
 	int dirlen, len;
-	struct strbuf pathbuf;
 	const char *cp;
 
 	cp = strrchr(path, '/');
@@ -561,8 +560,6 @@ static void prepare_attr_stack(const char *path)
 	else
 		dirlen = cp - path;
 
-	strbuf_init(&pathbuf, dirlen+2+strlen(GITATTRIBUTES_FILE));
-
 	/*
 	 * At the bottom of the attribute stack is the built-in
 	 * set of attribute definitions, followed by the contents
@@ -607,27 +604,28 @@ static void prepare_attr_stack(const char *path)
 	 * Read from parent directories and push them down
 	 */
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-		while (1) {
-			char *cp;
+		struct strbuf pathbuf = STRBUF_INIT;
 
+		while (1) {
 			len = strlen(attr_stack->origin);
 			if (dirlen <= len)
 				break;
-			strbuf_reset(&pathbuf);
-			strbuf_add(&pathbuf, path, dirlen);
+			cp = memchr(path + len + 1, '/', dirlen - len - 1);
+			if (!cp)
+				cp = path + dirlen;
+			strbuf_add(&pathbuf, path, cp - path);
 			strbuf_addch(&pathbuf, '/');
-			cp = strchr(pathbuf.buf + len + 1, '/');
-			strcpy(cp + 1, GITATTRIBUTES_FILE);
+			strbuf_addstr(&pathbuf, GITATTRIBUTES_FILE);
 			elem = read_attr(pathbuf.buf, 0);
-			*cp = '\0';
-			elem->origin = strdup(pathbuf.buf);
+			strbuf_setlen(&pathbuf, cp - path);
+			elem->origin = strbuf_detach(&pathbuf, NULL);
 			elem->prev = attr_stack;
 			attr_stack = elem;
 			debug_push(elem);
 		}
-	}
 
-	strbuf_release(&pathbuf);
+		strbuf_release(&pathbuf);
+	}
 
 	/*
 	 * Finally push the "info" one at the top of the stack.
-- 
1.7.7
