From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/4] attr.c: avoid inappropriate access to strbuf "buf" member
Date: Wed, 14 Sep 2011 20:59:36 -0500
Message-ID: <1316051979-19671-2-git-send-email-drafnel@gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
 <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru,
	Brandon Casey <drafnel@gmail.com>
To: peff@peff.net
X-From: git-owner@vger.kernel.org Thu Sep 15 04:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R41Fs-0007LM-1r
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 04:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab1IOCAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 22:00:39 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:37590 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1IOCAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 22:00:39 -0400
Received: by gwb17 with SMTP id 17so2704475gwb.1
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 19:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=g8sJOLLdJL8kCAjlmjYZ/BgeBbWLfCjmkUphuJ7NdlA=;
        b=YDnAV5W/NDbGiTlLO0fdnMBaH6op/KhzWQtjmC7R0KKlDbUML6UHN68MHueOYYFcl3
         rNvlBI8ICRjmKZbtkoFGnNXSW5anJSzXrWzHyPIp/omQ4kSEM2GWuxI78FlpyFIxED8y
         1lgixL2V5xYf5BBqs8Pmn+g6RnzJqu54ovuVU=
Received: by 10.236.80.74 with SMTP id j50mr2860087yhe.131.1316052038482;
        Wed, 14 Sep 2011 19:00:38 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id e61sm2291412yhm.2.2011.09.14.19.00.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Sep 2011 19:00:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1316051979-19671-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181422>

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
 attr.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/attr.c b/attr.c
index 33cb4e4..206f233 100644
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
@@ -607,27 +604,29 @@ static void prepare_attr_stack(const char *path)
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
+			strbuf_add(&pathbuf, GITATTRIBUTES_FILE,
+				strlen(GITATTRIBUTES_FILE));
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
1.7.6.2
