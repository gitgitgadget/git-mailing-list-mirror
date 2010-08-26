From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 8/8] tree-diff.c: Avoid recomputing interesting-ness for subtrees when possible
Date: Thu, 26 Aug 2010 00:21:51 -0600
Message-ID: <1282803711-10253-9-git-send-email-newren@gmail.com>
References: <1282803711-10253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 08:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVpX-0002cj-CF
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab0HZGUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:43 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37378 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab0HZGUl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:41 -0400
Received: by gyd8 with SMTP id 8so525054gyd.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=c9dRpzystzMpnFAU1kehiqwc7bUChFgOrMn62n1qLSo=;
        b=R4MiMuODE/9DpYr8WnpMIJOWNef9DDeO7F4mFwy/8YbG+KAr0L11J2m1gGpT9qImts
         JIpxmS3Jpoqx7AZmf4QXfV/9vjtYvAjZgCHYpcoOR6c1u0md/Tn6v79fXSL2S450eQkK
         g0guv3YcTCBhYeZuJA4V5uy5wZyiBeEgHUSOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h2ouWFWGhjPM868bgKk+WMrymz6llObLsaTUFwkh30Dfu2D3N7E7UeC7KGSxDdDyXh
         VG0bTX7BUl4xY53srCqEhrEfX5vM6kmM9D0pPL0Cy1X3FG9zXvqU/SjUi675uTRTqyoH
         Eea8gYVDUgL3ESvOfrdGEAuz1/+hyEbWA4JVk=
Received: by 10.150.68.4 with SMTP id q4mr9661538yba.261.1282803640561;
        Wed, 25 Aug 2010 23:20:40 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154525>

Weather balloon patch.  Doesn't seem to help much in benchmarks, and after
many runs I think it might occasionally hurt slightly.  It ought to help
in the case of a ginormous tree that is really deep with few entries per
tree, but that case seems kind of contrived.

Kind of makes the code look icky too.

---
No signed-off-by, since I'm not sold on this patch and am somewhat leaning
against it.  It would need a better commit message anyway.  :-)

 tree-diff.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index d976bdf..ecae15e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -25,9 +25,9 @@ static char *malloc_fullname(const char *base, int baselen, const char *path, in
 }
 
 static void show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc,
-		       const char *base, int baselen);
+		       const char *base, int baselen, int all_interesting);
 
-static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const char *base, int baselen, struct diff_options *opt)
+static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const char *base, int baselen, struct diff_options *opt, int all_t1_interesting, int all_t2_interesting)
 {
 	unsigned mode1, mode2;
 	const char *path1, *path2;
@@ -42,11 +42,11 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	pathlen2 = tree_entry_len(path2, sha2);
 	cmp = base_name_compare(path1, pathlen1, mode1, path2, pathlen2, mode2);
 	if (cmp < 0) {
-		show_entry(opt, "-", t1, base, baselen);
+		show_entry(opt, "-", t1, base, baselen, all_t1_interesting);
 		return -1;
 	}
 	if (cmp > 0) {
-		show_entry(opt, "+", t2, base, baselen);
+		show_entry(opt, "+", t2, base, baselen, all_t2_interesting);
 		return 1;
 	}
 	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
@@ -57,8 +57,8 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 	 * file, we need to consider it a remove and an add.
 	 */
 	if (S_ISDIR(mode1) != S_ISDIR(mode2)) {
-		show_entry(opt, "-", t1, base, baselen);
-		show_entry(opt, "+", t2, base, baselen);
+		show_entry(opt, "-", t1, base, baselen, all_t1_interesting);
+		show_entry(opt, "+", t2, base, baselen, all_t2_interesting);
 		return 0;
 	}
 
@@ -199,9 +199,8 @@ int tree_entry_interesting(struct tree_desc *desc, const char *base, int baselen
 }
 
 /* A whole sub-tree went away or appeared */
-static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base, int baselen)
+static void show_tree(struct diff_options *opt, const char *prefix, struct tree_desc *desc, const char *base, int baselen, int all_interesting)
 {
-	int all_interesting = 0;
 	while (desc->size) {
 		int show;
 
@@ -216,14 +215,14 @@ static void show_tree(struct diff_options *opt, const char *prefix, struct tree_
 		if (show < 0)
 			break;
 		if (show)
-			show_entry(opt, prefix, desc, base, baselen);
+			show_entry(opt, prefix, desc, base, baselen, all_interesting);
 		update_tree_entry(desc);
 	}
 }
 
 /* A file entry went away or appeared */
 static void show_entry(struct diff_options *opt, const char *prefix, struct tree_desc *desc,
-		       const char *base, int baselen)
+		       const char *base, int baselen, int all_interesting)
 {
 	unsigned mode;
 	const char *path;
@@ -248,7 +247,7 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 		}
 
 		init_tree_desc(&inner, tree, size);
-		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen);
+		show_tree(opt, prefix, &inner, newbase, baselen + 1 + pathlen, all_interesting);
 
 		free(tree);
 		free(newbase);
@@ -297,16 +296,18 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 		if (!t1->size) {
 			if (!t2->size)
 				break;
-			show_entry(opt, "+", t2, base, baselen);
+			show_entry(opt, "+", t2, base, baselen, all_t2_interesting);
 			update_tree_entry(t2);
 			continue;
 		}
 		if (!t2->size) {
-			show_entry(opt, "-", t1, base, baselen);
+			show_entry(opt, "-", t1, base, baselen, all_t1_interesting);
 			update_tree_entry(t1);
 			continue;
 		}
-		switch (compare_tree_entry(t1, t2, base, baselen, opt)) {
+		switch (compare_tree_entry(t1, t2, base, baselen, opt,
+					   all_t1_interesting,
+					   all_t2_interesting)) {
 		case -1:
 			update_tree_entry(t1);
 			continue;
-- 
1.7.2.2.45.ga60f
