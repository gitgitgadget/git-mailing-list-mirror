From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Another memory overrun in http-push.c
Date: Thu, 1 Mar 2007 19:09:12 +0300
Message-ID: <20070301160911.GU57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 17:09:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMnqK-0001eY-0F
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 17:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965304AbXCAQJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 11:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbXCAQJT
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 11:09:19 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:60409 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965304AbXCAQJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 11:09:18 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMnqH-000HDb-8z for git@vger.kernel.org; Thu, 01 Mar 2007 19:09:17 +0300
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_20
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41102>

Me again ;))

Spotted another memory overrun in the http-push.c. In principle,
it is the read-only overrun, but it provokes the coredump on my
system.  The problem is that strlcpy(dst, src, size) returns the
length of the 'src' and demands it to be NULL-terminated (see
'man strlcpy' and http://www.gratisoft.us/todd/papers/strlcpy.html).
It is not the case for the xml_cdata and possibly other places. So
I've just replaced strlcpy with memcpy + zero termination all over
the http-push.c. The patch is below.

--- http-push.c.orig	Thu Mar  1 18:48:19 2007
+++ http-push.c	Thu Mar  1 18:55:24 2007
@@ -1271,7 +1271,9 @@
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
 	free(ctx->cdata);
 	ctx->cdata = xmalloc(len + 1);
-	strlcpy(ctx->cdata, s, len + 1);
+	/* NB: 's' is not null-terminated, can not use strlcpy here */
+	memcpy(ctx->cdata, s, len);
+	ctx->cdata[len] = '\0';
 }
 
 static struct remote_lock *lock_remote(const char *path, long timeout)
@@ -1473,7 +1475,8 @@
 		return;
 	path += 8;
 	obj_hex = xmalloc(strlen(path));
-	strlcpy(obj_hex, path, 3);
+	/* NB: path is not null-terminated, can not use strlcpy here */
+	memcpy(obj_hex, path, 2);
 	strcpy(obj_hex + 2, path + 3);
 	one_remote_object(obj_hex);
 	free(obj_hex);
@@ -2170,7 +2173,8 @@
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
 	if (!strncmp((char *)buffer.buffer, "ref: ", 5)) {
 		*symref = xmalloc(buffer.posn - 5);
-		strlcpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 5);
+		memcpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 6);
+		(*symref)[buffer.posn - 6] = '\0';
 	} else {
 		get_sha1_hex(buffer.buffer, sha1);
 	}

memcpy(obj_hex, path, 2) is not followed by zero-termination since
it will be done by the strcpy that is following.

This cured my git-http-push and let it do all PROPFINDS on the rather
large repository (175 Mb). Now I have only one SEGV that is happening
inside the libcurl both in http-push.c and http-fetch.c. Already
talking to CURL people and trying to write the clear testcase for
the problem.
-- 
Eygene
