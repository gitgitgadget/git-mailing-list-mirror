From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 6/8] diff_tree(): Skip skip_uninteresting() when all remaining paths interesting
Date: Thu, 26 Aug 2010 00:21:49 -0600
Message-ID: <1282803711-10253-7-git-send-email-newren@gmail.com>
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
	id 1OoVpW-0002cj-Rv
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 08:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab0HZGUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 02:20:39 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47237 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433Ab0HZGUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 02:20:35 -0400
Received: by mail-yw0-f46.google.com with SMTP id 1so200832ywh.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 23:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=d8MOCoZuU7MZ4EGaA414zwXg6bWdmXLO06qriITO0sg=;
        b=gti2xiLzFA62a1pTjnXDjS6qSXp/sFcN7iX+J6vHWtocbVzhGh+EfLXz1R92K4smhn
         KTmh0/s+Lz+U2Ui8NjcCUv1gDOjAuKZqifO/mTkH5Bwh55auWLzo0Ki2X1N71/yJhCcd
         u7ukn/0UKTmZ5wsGTph1dQHLJYHI8+3apEgKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IpGeb50E3e2LZd5BgGUVrxko9gFAC8/qjm/vTMSp14vtlaIfwwvU4HRK8nixeqmG70
         QkYiMNIzIHh2FRUGXRpJ2oAGuZU4kPBeZY+Iz+P8V2QfTLh13fkNM3neIHE0xBbQUwcZ
         c3Heutb+PEyArNeRuf7TMzyMCbMMqVYKIlHsM=
Received: by 10.151.77.5 with SMTP id e5mr9958734ybl.245.1282803635629;
        Wed, 25 Aug 2010 23:20:35 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id t20sm7160156ybm.5.2010.08.25.23.20.33
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 23:20:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.45.ga60f
In-Reply-To: <1282803711-10253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154521>

In 1d848f6 (tree_entry_interesting(): allow it to say "everything is
interesting" 2007-03-21), both show_tree() and skip_uninteresting() were
modified to determine if all remaining tree entries were interesting.
However, the latter returns as soon as it finds the first interesting path,
without any way to signal to its caller (namely, diff_tree()) that all
remaining paths are interesting, making these extra checks useless.

Pass whether all remaining entries are interesting back to diff_tree(), and
whenever they are, have diff_tree() skip subsequent calls to
skip_uninteresting().

With this change, I measure speedups of 3-4% for the commands
  git rev-list --quiet HEAD -- Documentation/
  git rev-list --quiet HEAD -- t/
in git.git.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 tree-diff.c |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index bac5008..d976bdf 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -259,19 +259,12 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 	}
 }
 
-static void skip_uninteresting(struct tree_desc *t, const char *base, int baselen, struct diff_options *opt)
+static void skip_uninteresting(struct tree_desc *t, const char *base, int baselen, struct diff_options *opt, int *all_interesting)
 {
-	int all_interesting = 0;
 	while (t->size) {
-		int show;
-
-		if (all_interesting)
-			show = 1;
-		else {
-			show = tree_entry_interesting(t, base, baselen, opt);
-			if (show == 2)
-				all_interesting = 1;
-		}
+		int show = tree_entry_interesting(t, base, baselen, opt);
+		if (show == 2)
+			*all_interesting = 1;
 		if (!show) {
 			update_tree_entry(t);
 			continue;
@@ -286,14 +279,20 @@ static void skip_uninteresting(struct tree_desc *t, const char *base, int basele
 int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	int baselen = strlen(base);
+	int all_t1_interesting = 0;
+	int all_t2_interesting = 0;
 
 	for (;;) {
 		if (DIFF_OPT_TST(opt, QUICK) &&
 		    DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->nr_paths) {
-			skip_uninteresting(t1, base, baselen, opt);
-			skip_uninteresting(t2, base, baselen, opt);
+			if (!all_t1_interesting)
+				skip_uninteresting(t1, base, baselen, opt,
+						   &all_t1_interesting);
+			if (!all_t2_interesting)
+				skip_uninteresting(t2, base, baselen, opt,
+						   &all_t2_interesting);
 		}
 		if (!t1->size) {
 			if (!t2->size)
-- 
1.7.2.2.45.ga60f
