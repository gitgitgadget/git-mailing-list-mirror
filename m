X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-mv: search more precisely for source directory in index
Date: Sun, 3 Dec 2006 20:42:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612032036030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061203135725.GA7971@procyon.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 3 Dec 2006 19:42:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061203135725.GA7971@procyon.home>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33133>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqxEk-0007tq-JU for gcvg-git@gmane.org; Sun, 03 Dec
 2006 20:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760042AbWLCTmv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 14:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760043AbWLCTmv
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 14:42:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:48526 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1760042AbWLCTmv (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 14:42:51 -0500
Received: (qmail invoked by alias); 03 Dec 2006 19:42:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp044) with SMTP; 03 Dec 2006 20:42:49 +0100
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org


A move of a directory should find the entries in the index by
searching for the name _including_ the slash. Otherwise, the
directory can be shadowed by a file when it matches the prefix
and is lexicographically smaller, e.g. "ab.c" shadows "ab/".

Noticed by Sergey Vlasov.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Good catch. Thanks!

 builtin-mv.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 54dd3bf..d14a4a7 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -146,21 +146,24 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				&& lstat(dst, &st) == 0)
 			bad = "cannot move directory over file";
 		else if (src_is_dir) {
+			const char *src_w_slash = add_slash(src);
+			int len_w_slash = length + 1;
 			int first, last;
 
 			modes[i] = WORKING_DIRECTORY;
 
-			first = cache_name_pos(src, length);
+			first = cache_name_pos(src_w_slash, len_w_slash);
 			if (first >= 0)
-				die ("Huh? %s/ is in index?", src);
+				die ("Huh? %.*s is in index?",
+						len_w_slash, src_w_slash);
 
 			first = -1 - first;
 			for (last = first; last < active_nr; last++) {
 				const char *path = active_cache[last]->name;
-				if (strncmp(path, src, length)
-						|| path[length] != '/')
+				if (strncmp(path, src_w_slash, len_w_slash))
 					break;
 			}
+			free((char *)src_w_slash);
 
 			if (last - first < 1)
 				bad = "source directory is empty";
-- 
1.4.4.1.g317bd
