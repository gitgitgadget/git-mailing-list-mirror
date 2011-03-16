From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] branch: split off function that writes tracking info and
 commit subject
Date: Wed, 16 Mar 2011 02:10:14 -0500
Message-ID: <20110316071014.GG5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 08:10:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzksD-0008Jf-JD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab1CPHKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:10:21 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34111 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710Ab1CPHKT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:10:19 -0400
Received: by yxs7 with SMTP id 7so544878yxs.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+6bHJ34oiubDIZUJAjOjHWj9CNbKR9DeKenVsdmfMGg=;
        b=Mhq3Mmd8YEqA4PnK6ER9WnuCgZ3rC0yoLzgyYaJWC7dL9pjH6IhbcZ2/PVFEY52Mtn
         5vsy6PUC1tAEJpsU87S4YIZmQh4FE/7zG2jGCGakeQHU2unOc2oavQnUW0gFB+Oc6K+r
         BHfDQtftP5Mevvh8VQmUNZ08bkhuF5AWie0Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mfvLGq4XchyYRenryS1VrUVETGPWttgZw2Q8RAkv5Khy+yXXzGr0opsp/OZbX/q1w2
         oDJY+5nHEzz4qOiDASwWKszoCKki+utP1QuT0Ptb/M2BpfwEq3JLcBFZau0XqUK+64OT
         sfv2Z+cSYU640VzcM+DZItlLjWqxoehxrEKV0=
Received: by 10.150.74.2 with SMTP id w2mr557859yba.346.1300259418782;
        Wed, 16 Mar 2011 00:10:18 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id f2sm562208ybh.19.2011.03.16.00.10.16
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:10:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169114>

Introduce a add_verbose_info function that takes care of adding

 - an abbreviated object name;
 - a summary of the form [ahead x, behind y] of the relationship
   to the corresponding upstream branch;
 - a one line commit subject

for the tip commit of a branch, for use in "git branch -v" output.

No functional change intended.  This just unindents the code a little
and makes it easier to skip on first reading.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c |   48 +++++++++++++++++++++++++++---------------------
 1 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index fe8f2fc..b9ba011 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -390,6 +390,30 @@ static int matches_merge_filter(struct commit *commit)
 	return (is_merged == (merge_filter == SHOW_MERGED));
 }
 
+static void add_verbose_info(struct strbuf *out, struct ref_item *item,
+			     int verbose, int abbrev)
+{
+	struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
+	const char *sub = " **** invalid ref ****";
+	struct commit *commit = item->commit;
+
+	if (commit && !parse_commit(commit)) {
+		struct pretty_print_context ctx = {0};
+		pretty_print_commit(CMIT_FMT_ONELINE, commit,
+				    &subject, &ctx);
+		sub = subject.buf;
+	}
+
+	if (item->kind == REF_LOCAL_BRANCH)
+		fill_tracking_info(&stat, item->name, verbose > 1);
+
+	strbuf_addf(out, " %s %s%s",
+		find_unique_abbrev(item->commit->object.sha1, abbrev),
+		stat.buf, sub);
+	strbuf_release(&stat);
+	strbuf_release(&subject);
+}
+
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 			   int abbrev, int current, char *prefix)
 {
@@ -430,27 +454,9 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 	if (item->dest)
 		strbuf_addf(&out, " -> %s", item->dest);
-	else if (verbose) {
-		struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
-		const char *sub = " **** invalid ref ****";
-
-		commit = item->commit;
-		if (commit && !parse_commit(commit)) {
-			struct pretty_print_context ctx = {0};
-			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					    &subject, &ctx);
-			sub = subject.buf;
-		}
-
-		if (item->kind == REF_LOCAL_BRANCH)
-			fill_tracking_info(&stat, item->name, verbose > 1);
-
-		strbuf_addf(&out, " %s %s%s",
-			find_unique_abbrev(item->commit->object.sha1, abbrev),
-			stat.buf, sub);
-		strbuf_release(&stat);
-		strbuf_release(&subject);
-	}
+	else if (verbose)
+		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
+		add_verbose_info(&out, item, verbose, abbrev);
 	printf("%s\n", out.buf);
 	strbuf_release(&name);
 	strbuf_release(&out);
-- 
1.7.4.1
