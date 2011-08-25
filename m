From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/5] branch: restructure -v vs. -vv
Date: Thu, 25 Aug 2011 10:30:21 +0200
Message-ID: <f471a616e4f08e729384138d8cb8afff4e9dbcbf.1314259226.git.git@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 10:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwVL2-0000B1-Dz
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1HYIao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:30:44 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:56144 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752886Ab1HYIaf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 04:30:35 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 857E620C65;
	Thu, 25 Aug 2011 04:30:34 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 25 Aug 2011 04:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=A2
	ANjD2fhizZJJDYVUE3rxEbnL8=; b=mhQWqRICBjJGU8b7XHuxeEoV4cFLueO466
	sDJlyp/ViT19YBT2mWefc/Ou2JAb05IMMZ9Fp+2lX/h/FnXAfQ4mRPijJ0wJnp6f
	+F3gMmVuRdapmqDMGDyh9zhQjN9jxvNE0rqBw64i7Of994LdT68xBBp1cPHwit9r
	fKwG8ax2Q=
X-Sasl-enc: cTVgAQeWG/X7aKiyVjJUEC/RZa9zXx/btnRITsil26PI 1314261034
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 067A3901ED5;
	Thu, 25 Aug 2011 04:30:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E5607E0.1050300@drmicha.warpmail.net>
In-Reply-To: <cover.1314259226.git.git@drmicha.warpmail.net>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180072>

ahead/behind info is expensive, upstream name info cheap. Therefore,
make -v output the upstream branch name and -vv add the ahead/behind
info.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    4 ++--
 builtin/branch.c             |   34 ++++++++++++++++------------------
 t/t6040-tracking-info.sh     |    8 ++++----
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 789ff02..59d729a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -115,8 +115,8 @@ OPTIONS
 -v::
 --verbose::
 	Show sha1 and commit subject line for each head, along with
-	relationship to upstream branch (if any). If given twice, print
-	the name of the upstream branch, as well.
+	the name of the upstream branch (if any). If given twice, print
+	the relationship to the upstream branch (ahead/behind), as well.
 	`--list` is implied by all verbosity options.
 
 --abbrev=<length>::
diff --git a/builtin/branch.c b/builtin/branch.c
index aed0aca..21ef5fc 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -359,29 +359,27 @@ static int ref_cmp(const void *r1, const void *r2)
 }
 
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
-		int show_upstream_ref)
+		int verbose)
 {
 	int ours, theirs;
 	struct branch *branch = branch_get(branch_name);
 
-	if (!stat_tracking_info(branch, &ours, &theirs)) {
-		if (branch && branch->merge && branch->merge[0]->dst &&
-		    show_upstream_ref)
-			strbuf_addf(stat, "[%s] ",
-			    shorten_unambiguous_ref(branch->merge[0]->dst, 0));
+	/* verbose >= 1 */
+	if (!(branch && branch->merge && branch->merge[0]->dst))
 		return;
-	}
-
 	strbuf_addch(stat, '[');
-	if (show_upstream_ref)
-		strbuf_addf(stat, "%s: ",
-			shorten_unambiguous_ref(branch->merge[0]->dst, 0));
-	if (!ours)
-		strbuf_addf(stat, _("behind %d] "), theirs);
-	else if (!theirs)
-		strbuf_addf(stat, _("ahead %d] "), ours);
-	else
-		strbuf_addf(stat, _("ahead %d, behind %d] "), ours, theirs);
+	strbuf_addstr(stat, shorten_unambiguous_ref(branch->merge[0]->dst, 0));
+
+	if (verbose >= 2 && stat_tracking_info(branch, &ours, &theirs)) {
+		strbuf_addstr(stat, ": ");
+		if (!ours)
+			strbuf_addf(stat, _("behind %d"), theirs);
+		else if (!theirs)
+			strbuf_addf(stat, _("ahead %d"), ours);
+		else
+			strbuf_addf(stat, _("ahead %d, behind %d"), ours, theirs);
+	}
+	strbuf_addstr(stat, "] ");
 }
 
 static int matches_merge_filter(struct commit *commit)
@@ -408,7 +406,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 	}
 
 	if (item->kind == REF_LOCAL_BRANCH)
-		fill_tracking_info(&stat, item->name, verbose > 1);
+		fill_tracking_info(&stat, item->name, verbose);
 
 	strbuf_addf(out, " %s %s%s",
 		find_unique_abbrev(item->commit->object.sha1, abbrev),
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 19272bc..9539882 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -36,10 +36,10 @@ test_expect_success setup '
 
 script='s/^..\(b.\)[	 0-9a-f]*\[\([^]]*\)\].*/\1 \2/p'
 cat >expect <<\EOF
-b1 ahead 1, behind 1
-b2 ahead 1, behind 1
-b3 behind 1
-b4 ahead 2
+b1 origin/master
+b2 origin/master
+b3 origin/master
+b4 origin/master
 EOF
 
 test_expect_success 'branch -v' '
-- 
1.7.6.845.gc3c05
