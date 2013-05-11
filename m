From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 09/10] builtin/branch.c: Refactor "remotes/" prepending to remote-tracking branches
Date: Sat, 11 May 2013 18:21:19 +0200
Message-ID: <1368289280-30337-10-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYO-0007Zt-PH
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab3EKQVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:44 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:53953 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3EKQVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:42 -0400
Received: by mail-wi0-f175.google.com with SMTP id h11so1570271wiv.8
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=m2L29vRQpFAU4pvy2Y2DF2AfxE0gOk9RKuwm2+RC2vo=;
        b=T2M1npZO37zRFJ/uQgmhfGwdLeNUaOP4m4ZiHW9wmV60GqbA3/VGNf8G/eXL5sQaHN
         FJcTXMxV7lKLpQ6pnvInqV9IrZHyPPhkVamDrFOUrue7EtlEVVH9wFbOstELfths46Js
         T5YxYU/s5AhHvf1+6Th7PJUHOODh6BvMqQsb/tImHsG1TYEMi1MFTnMq71/fTQpmhn8A
         dnYfXK57QBD1g3xQK05ewYhk9pY7EzdflPukty8yk8WNNOqqny073IBqzK7BaUmkolB2
         bf5vSIt8faaOqIvkCTHXvLq/qVP3eJgvOOQdLh464gDqeHFSOMsV06qGExBbOqeGVEC/
         dTIA==
X-Received: by 10.180.212.3 with SMTP id ng3mr9822645wic.22.1368289301278;
        Sat, 11 May 2013 09:21:41 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223989>

When running "git branch -a" (instead of "git branch -r"), we prefix the
remote-tracking branches with "remotes/" to allow the user to more easily
tell them apart from the local branches.

The code that prepended "remotes/" to remote-tracking branches was
located in print_ref_item(), while the code that adjusted the
ref_item.width (to account for the prepended "remotes/") was located in
append_ref().

This code moves the prepending of "remotes/" up into append_ref(), which
is a nice cleanup of the code, as well as a preparation for changing the
logic when remote-tracking branches start showing up in refs/peers/*.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/branch.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c8b49e3..4480be2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -384,7 +384,6 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	strbuf_addstr(&newitem->name, refname);
 	newitem->kind = kind;
 	newitem->commit = commit;
-	newitem->width = utf8_strwidth(refname);
 	strbuf_init(&newitem->dest, 0);
 	orig_refname = resolve_symref(orig_refname, prefix);
 	if (orig_refname)
@@ -392,7 +391,8 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	/* adjust for "remotes/" */
 	if (newitem->kind == REF_REMOTE_BRANCH &&
 	    ref_list->kinds != REF_REMOTE_BRANCH)
-		newitem->width += 8;
+		strbuf_insert(&newitem->name, 0, "remotes/", 8);
+	newitem->width = utf8_strwidth(newitem->name.buf);
 	if (newitem->width > ref_list->maxwidth)
 		ref_list->maxwidth = newitem->width;
 
@@ -510,12 +510,12 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 }
 
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current, char *prefix)
+			   int abbrev, int current)
 {
 	char c;
 	int color;
 	struct commit *commit = item->commit;
-	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
 
 	if (!matches_merge_filter(commit))
 		return;
@@ -538,15 +538,14 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = BRANCH_COLOR_CURRENT;
 	}
 
-	strbuf_addf(&name, "%s%s", prefix, item->name.buf);
 	if (verbose) {
-		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
+		int utf8_compensation = strlen(item->name.buf) - utf8_strwidth(item->name.buf);
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
-			    maxwidth + utf8_compensation, name.buf,
+			    maxwidth + utf8_compensation, item->name.buf,
 			    branch_get_color(BRANCH_COLOR_RESET));
 	} else
 		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
-			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
+			    item->name.buf, branch_get_color(BRANCH_COLOR_RESET));
 
 	if (item->dest.len)
 		strbuf_addf(&out, " -> %s", item->dest.buf);
@@ -559,7 +558,6 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	} else {
 		printf("%s\n", out.buf);
 	}
-	strbuf_release(&name);
 	strbuf_release(&out);
 }
 
@@ -613,7 +611,7 @@ static void show_detached(struct ref_list *ref_list)
 		item.commit = head_commit;
 		if (item.width > ref_list->maxwidth)
 			ref_list->maxwidth = item.width;
-		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
+		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1);
 		strbuf_release(&item.name);
 	}
 }
@@ -661,11 +659,8 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		int current = !detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name.buf, head);
-		char *prefix = (kinds != REF_REMOTE_BRANCH &&
-				ref_list.list[i].kind == REF_REMOTE_BRANCH)
-				? "remotes/" : "";
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
-			       abbrev, current, prefix);
+			       abbrev, current);
 	}
 
 	free_ref_list(&ref_list);
-- 
1.8.1.3.704.g33f7d4f
