From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Fix "git log --parent -m" from emitting duplicated parent info
Date: Sun, 8 Jul 2007 16:37:50 +0200
Message-ID: <e5bfff550707080737j56c161bdrf0c079b61877085b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 16:37:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Xtb-0003sq-Pf
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 16:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbXGHOhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 10:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbXGHOhw
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 10:37:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:16801 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbXGHOhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 10:37:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1038502wah
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 07:37:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=rpIokudTOoYA74b7mfMWsHf3fIeAi0oR175hE/TU/QjUgOMImDWSbvaCiHtf4W3a8s3tXUJAW4hL7nZnbvsiL9wBGNXusQvee2MHv1DDpfxStl9i/gcl6yJq8aPO4TYNENLH+z2dOfWwWa0De+F9IWU1oxjaTxLGY38ps0pIhoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YvrJHYR4S0it3YLmLj0fBZDoYgEnCKmYjoxelg2riEF3QVq4nFYQn1T1if8PZM6dX/P7rjVdccqnBuoQ/9BaSoVFwIAvBgIfvHUnco8F21yeh+rCWiii9M5leqv074h/nuMgGHEgjYZhyj21Vfz0WjgZqlW0CuA9i4Rz6pEo7mk=
Received: by 10.114.149.2 with SMTP id w2mr2308666wad.1183905470463;
        Sun, 08 Jul 2007 07:37:50 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 8 Jul 2007 07:37:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51886>

Without this patch in case of a merge, duplicated parents are
omitted in first line output, but still listed in following
parents information.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

Following the hint of someone I submit this patch.

Please take it as a wish of not reverting the patch ;-)


 log-tree.c |   25 +++++++++++++++++--------
 revision.h |    1 +
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 24aea6b..e5d40fe 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -6,11 +6,11 @@

  struct decoration name_decoration = { "object names" };

-static void clear_tmp_mark(struct commit_list *p)
+static void clear_flag(struct commit_list *p, unsigned int flag)
 {
 	while (p) {
  		struct commit *c = p->item;
-		c->object.flags &= ~TMP_MARK;
+		c->object.flags &= ~flag;
 		p = p->next;
 	}
 }
@@ -23,7 +23,7 @@ static void show_parents(
 	 * be used locally, but the user should clean
 	 * things up after it is done with them.
 	 */
-	clear_tmp_mark(commit->parents);
+	clear_flag(commit->parents, TMP_MARK);
 	for (p = commit->parents; p ; p = p->next) {
  		struct commit *parent = p->item;
 		if (parent->object.flags & TMP_MARK)
@@ -31,7 +31,7 @@ static void show_parents(struct
  		printf(" %s", diff_unique_abbrev(parent->object.sha1, abbrev));
 		parent->object.flags |= TMP_MARK;
 	}
-	clear_tmp_mark(commit->parents);
+	clear_flag(commit->parents, TMP_MARK);
 }

  static void show_decorations(struct commit *commit)
@@ -391,16 +391,24 @@ static int log_tree_diff(
 		/* If we show individual diffs, show the parent info */
 		log->parent = parents->item;
 	}
-
 	showed_log = 0;
+	clear_flag(parents, TMP_MARK_2);
+
 	for (;;) {
  		struct commit *parent = parents->item;

-		diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
-		log_tree_diff_flush(opt);
+		/* TMP_MARK_2 is a general purpose flag that can
+		 * be used locally nested with TMP_MARK, but the user
+		 * should clean things up after it is done with them.
+		*/
+		if (!opt->parents || !(parent->object.flags & TMP_MARK_2)) {

-		showed_log |= !opt->loginfo;
+			diff_tree_sha1(parent->object.sha1, sha1, "", &opt->diffopt);
+			log_tree_diff_flush(opt); // will use TMP_MARK

+			showed_log |= !opt->loginfo;
+			parent->object.flags |= TMP_MARK_2;
+		}
 		/* Set up the log info for the next parent, if any.. */
 		parents = parents->next;
 		if (!parents)
@@ -408,6 +416,7 @@ static int log_tree_diff(
 		log->parent = parents->item;
  		opt->loginfo = log;
 	}
+	clear_flag(parents, TMP_MARK_2);
 	return showed_log;
 }

diff --git a/revision.h b/revision.h
index f46b4d5..403507f 100644
--- a/revision.h
+++ b/revision.h
@@ -10,6 +10,7 @@
 #define CHILD_SHOWN	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
+#define TMP_MARK_2	(1u<<9) /* for isolated cases; clean after use */

  struct rev_info;
  struct log_info;
-- 
1.5.3.rc0.65.g39a4d-dirty
