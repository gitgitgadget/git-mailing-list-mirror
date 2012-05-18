From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive: simplify refname handling
Date: Fri, 18 May 2012 07:15:17 +0200
Message-ID: <4FB5DAE5.6020307@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 18 07:15:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVFXD-0005QP-Sf
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 07:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759951Ab2ERFPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 01:15:21 -0400
Received: from india601.server4you.de ([85.25.151.105]:60858 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab2ERFPU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 01:15:20 -0400
Received: from [192.168.2.105] (p4FFD9588.dip.t-dialin.net [79.253.149.136])
	by india601.server4you.de (Postfix) with ESMTPSA id E43692F806F;
	Fri, 18 May 2012 07:15:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197938>

There is no need to build a copy of the relevant part of the string just
to make sure we have a NUL-terminated string.  We can simply pass the
length of the interesting part to dwim_ref() instead.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive.c |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/archive.c b/archive.c
index cd083ea..ecc1ff0 100644
--- a/archive.c
+++ b/archive.c
@@ -254,18 +254,11 @@ static void parse_treeish_arg(const char **argv,
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote) {
 		char *ref = NULL;
-		const char *refname, *colon = NULL;
-
-		colon = strchr(name, ':');
-		if (colon)
-			refname = xstrndup(name, colon - name);
-		else
-			refname = name;
-
-		if (!dwim_ref(refname, strlen(refname), sha1, &ref))
-			die("no such ref: %s", refname);
-		if (refname != name)
-			free((void *)refname);
+		const char *colon = strchr(name, ':');
+		size_t refnamelen = colon ? colon - name : strlen(name);
+
+		if (!dwim_ref(name, refnamelen, sha1, &ref))
+			die("no such ref: %.*s", refnamelen, name);
 		free(ref);
 	}
 
-- 
1.7.10.2
