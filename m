From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] builtin-branch: improve output when displaying remote branches
Date: Fri, 13 Feb 2009 00:34:31 -0500
Message-ID: <1234503271-78569-1-git-send-email-jaysoffian@gmail.com>
References: <7vhc30qki2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 06:36:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXqid-000307-Ku
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 06:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbZBMFeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 00:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbZBMFeh
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 00:34:37 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:9925 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbZBMFeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 00:34:36 -0500
Received: by yw-out-2324.google.com with SMTP id 5so573614ywh.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 21:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KbfHI96/haAewOaBQ1xGFY0ebva0Dz0RXnrwdUx/X4c=;
        b=BBKR0QMnBKye8IT28Hn2tILBHbRMMhNv1PmAsQ8ogmr2FNAKgRpYuyO6/C+B8FLjBe
         x/Y3Wp3Eo9YHZ719PTPbvaEGl1EiO2ywDF912aSjeeNxBgyxUt9NXSPcWGijZErYCDzs
         P/53M/g9zzMHs2BplGJs53qZwNkAAOuMaJCfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=s0a7Ax94K748RIJ84AOAWKsWt/F81Zz0y+Hf/4QXLRPOkS4UxtCAERCGk+4q4Nf+mq
         ZJiTLhvEp1t9ws+uDnMwoqUPxyarSgEWZXdWM4HkZhWytdbx4DJNjPumodZ5VzEYASib
         On6xceEMmoxi5k4CnIq9IfUaOKWRZUR8jx+6w=
Received: by 10.100.165.5 with SMTP id n5mr2344047ane.69.1234503274754;
        Thu, 12 Feb 2009 21:34:34 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c40sm1330473anc.28.2009.02.12.21.34.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 21:34:33 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc0.209.g7c178
In-Reply-To: <7vhc30qki2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109706>

When encountering a symref (typically refs/remotes/<remote>/HEAD),
display the ref target.

When displaying local and remote branches, prefix the remote branch
names with "remotes/" to make the remote branches clear from the local
branches. If displaying only the remote branches, the prefix is not
shown since it would be redundant.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Changes from v1:

 * I now resolve any symref that I encounter, not just HEAD. As long as it's a
   valid symref, we show what it points to. If the target points into the same
   namespace as the source (refs/heads/ or refs/remotes/), then we strip the
   prefix, otherwise we display the complete target path. So if someone has
   done something silly like having a refs/remotes/frotz/blarg that points to
   refs/heads/blam, then we show it as:

   frotz/blarg -> refs/heads/blam

   But in the typical case of refs/remotes/origin/HEAD, it just looks like:

   origin/HEAD -> origin/master

 * I decided to leave the "origin" (or whatever...) prefix on the target since
   I think it is clearer.

 * I rewrote print_ref_item() to use a strbuf for generating the output -- the
   code is clearer that way w/all the output permutations now.
   
Here's some sample output:

$ git branch 
  foo -> master
* master
  rather-long-branch-name

$ git branch -v
  foo                     -> master
* master                  51cecb2 initial
  rather-long-branch-name 51cecb2 initial

$ git branch -v --no-abbrev
  foo                     -> master
* master                  51cecb2dbb1a1902bb4df79b543c8f951ee59d83 initial
  rather-long-branch-name 51cecb2dbb1a1902bb4df79b543c8f951ee59d83 initial

$ git branch -r
  frotz/HEAD -> frotz/master
  frotz/master
  origin/HEAD -> origin/master
  origin/WTF -> refs/heads/master
  origin/master

$ git branch -a
  foo -> master
* master
  rather-long-branch-name
  remotes/frotz/HEAD -> frotz/master
  remotes/frotz/master
  remotes/origin/HEAD -> origin/master
  remotes/origin/WTF -> refs/heads/master
  remotes/origin/master

$ git branch -rv
  frotz/HEAD    -> frotz/master
  frotz/master  e1d8130 added file2
  origin/HEAD   -> origin/master
  origin/WTF    -> refs/heads/master
  origin/master e1d8130 added file2

$ git branch -av
  foo                     -> master
* master                  51cecb2 initial
  rather-long-branch-name 51cecb2 initial
  remotes/frotz/HEAD      -> frotz/master
  remotes/frotz/master    e1d8130 added file2
  remotes/origin/HEAD     -> origin/master
  remotes/origin/WTF      -> refs/heads/master
  remotes/origin/master   e1d8130 added file2

In the case of verbose output, I did play with making the arrow the same width
as the commit id (which means accounting for abbrev=<n> and --no-abbrev
btw...), but it really didn't look any better IMO.

 builtin-branch.c |   80 +++++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 56a1971..4154ad2 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -181,7 +181,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 
 struct ref_item {
 	char *name;
-	unsigned int kind;
+	char *dest;
+	unsigned int kind, len;
 	struct commit *commit;
 };
 
@@ -193,21 +194,37 @@ struct ref_list {
 	int kinds;
 };
 
+static char *resolve_symref(const char *src, const char *prefix)
+{
+	unsigned char sha1[20];
+	int flag;
+	const char *dst, *cp;
+	dst = resolve_ref(src, sha1, 0, &flag);
+	if (!(dst && (flag & REF_ISSYMREF)))
+		return NULL;
+	if (prefix && !prefixcmp(dst, prefix))
+		return xstrdup(skip_prefix(dst, prefix));
+	else
+		return xstrdup(dst);
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
 	struct ref_item *newitem;
 	struct commit *commit;
 	int kind;
-	int len;
+	const char *prefix, *orig_refname = refname;
 
 	/* Detect kind */
 	if (!prefixcmp(refname, "refs/heads/")) {
 		kind = REF_LOCAL_BRANCH;
 		refname += 11;
+		prefix = "refs/heads/";
 	} else if (!prefixcmp(refname, "refs/remotes/")) {
 		kind = REF_REMOTE_BRANCH;
 		refname += 13;
+		prefix = "refs/remotes/";
 	} else
 		return 0;
 
@@ -239,9 +256,14 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	newitem->name = xstrdup(refname);
 	newitem->kind = kind;
 	newitem->commit = commit;
-	len = strlen(newitem->name);
-	if (len > ref_list->maxwidth)
-		ref_list->maxwidth = len;
+	newitem->len = strlen(refname);
+	newitem->dest = resolve_symref(orig_refname, prefix);
+	/* adjust for "remotes/" */
+	if (newitem->kind == REF_REMOTE_BRANCH &&
+	    ref_list->kinds != REF_REMOTE_BRANCH)
+		newitem->len += 8;
+	if (newitem->len > ref_list->maxwidth)
+		ref_list->maxwidth = newitem->len;
 
 	return 0;
 }
@@ -250,8 +272,10 @@ static void free_ref_list(struct ref_list *ref_list)
 {
 	int i;
 
-	for (i = 0; i < ref_list->index; i++)
+	for (i = 0; i < ref_list->index; i++) {
 		free(ref_list->list[i].name);
+		free(ref_list->list[i].dest);
+	}
 	free(ref_list->list);
 }
 
@@ -292,11 +316,12 @@ static int matches_merge_filter(struct commit *commit)
 }
 
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current)
+			   int abbrev, int current, char *prefix)
 {
 	char c;
 	int color;
 	struct commit *commit = item->commit;
+	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 
 	if (!matches_merge_filter(commit))
 		return;
@@ -319,7 +344,18 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = COLOR_BRANCH_CURRENT;
 	}
 
-	if (verbose) {
+	strbuf_addf(&name, "%s%s", prefix, item->name);
+	if (verbose)
+		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
+			    maxwidth, name.buf,
+			    branch_get_color(COLOR_BRANCH_RESET));
+	else
+		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
+			    name.buf, branch_get_color(COLOR_BRANCH_RESET));
+
+	if (item->dest)
+		strbuf_addf(&out, " -> %s", item->dest);
+	else if (verbose) {
 		struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
 		const char *sub = " **** invalid ref ****";
 
@@ -333,28 +369,25 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		if (item->kind == REF_LOCAL_BRANCH)
 			fill_tracking_info(&stat, item->name);
 
-		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
-		       maxwidth, item->name,
-		       branch_get_color(COLOR_BRANCH_RESET),
-		       find_unique_abbrev(item->commit->object.sha1, abbrev),
-		       stat.buf, sub);
+		strbuf_addf(&out, " %s %s%s",
+			find_unique_abbrev(item->commit->object.sha1, abbrev),
+			stat.buf, sub);
 		strbuf_release(&stat);
 		strbuf_release(&subject);
-	} else {
-		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
-		       branch_get_color(COLOR_BRANCH_RESET));
 	}
+	printf("%s\n", out.buf);
+	strbuf_release(&name);
+	strbuf_release(&out);
 }
 
 static int calc_maxwidth(struct ref_list *refs)
 {
-	int i, l, w = 0;
+	int i, w = 0;
 	for (i = 0; i < refs->index; i++) {
 		if (!matches_merge_filter(refs->list[i].commit))
 			continue;
-		l = strlen(refs->list[i].name);
-		if (l > w)
-			w = l;
+		if (refs->list[i].len > w)
+			w = refs->list[i].len;
 	}
 	return w;
 }
@@ -394,7 +427,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		item.commit = head_commit;
 		if (strlen(item.name) > ref_list.maxwidth)
 			ref_list.maxwidth = strlen(item.name);
-		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
+		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1, "");
 		free(item.name);
 	}
 
@@ -402,8 +435,11 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		int current = !detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
+		char *prefix = (kinds != REF_REMOTE_BRANCH &&
+				ref_list.list[i].kind == REF_REMOTE_BRANCH)
+				? "remotes/" : "";
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
-			       abbrev, current);
+			       abbrev, current, prefix);
 	}
 
 	free_ref_list(&ref_list);
-- 
1.6.2.rc0.209.g7c178
