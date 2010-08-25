From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/7] diff_tree(): Skip skip_uninteresting() when all remaining paths interesting
Date: Tue, 24 Aug 2010 20:53:13 -0600
Message-ID: <1282704795-29661-6-git-send-email-newren@gmail.com>
References: <1282704795-29661-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo66N-0008G6-Of
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414Ab0HYCwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 22:52:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58223 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756482Ab0HYCwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:52:01 -0400
Received: by vws3 with SMTP id 3so180998vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wuNZEf1jyT6/bnEK4Msox4cuyT35fECUPMEA7zfzeHU=;
        b=q+++n/AASI4yhBBkLNjYOVZ4qCHfKa18QrqpeWn7gAVJJByRMw3a8/dURat8pK9muK
         25TeVjEi3sWNJPtX9+v3DdvryxllPPM6PbHfFF0UytubMqHtiBwfEvEaq6cSRyCwfDtl
         obyyECYl/dJiT7oy3I/aAOJWt5JtvGjblXOWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uQ5o+B9wnijrlet+gKKbKxWRWIJVj1C8aH35QF/ICsCV9syKLCtqEqDo859D7Mybj+
         gacTKGWqXrLhoNPA81bi4hQvnNUc/IWt5TsqKJSyct3kCKhE2jGFmXxBIduE1ccGz0kq
         7JL1hryyN9qj2u7BAeyQewVpBCEHa5ooCQ6i0=
Received: by 10.220.74.82 with SMTP id t18mr4965942vcj.26.1282704715794;
        Tue, 24 Aug 2010 19:51:55 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id v11sm577473vbb.3.2010.08.24.19.51.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:51:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.39.gf7e23
In-Reply-To: <1282704795-29661-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154400>

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
index a740a9c..292cb6b 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -257,19 +257,12 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
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
@@ -284,14 +277,20 @@ static void skip_uninteresting(struct tree_desc *t, const char *base, int basele
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
1.7.2.2.39.gf7e23
