From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Sun, 13 Sep 2015 12:53:50 +0530
Message-ID: <1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 09:24:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb1du-0002uR-7B
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 09:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbbIMHX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 03:23:58 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33164 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbbIMHX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 03:23:56 -0400
Received: by pacex6 with SMTP id ex6so113668244pac.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 00:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgYFv/N3eGt1pbt4p4Y7YSidtVWeAgldLLI3O6zN1UU=;
        b=x3ZHvQjIqpNu8iw6LRO41w/i3QN3UCn+5vBF7nSpdrV2E1hz9RfbGIJ6VOck8+Qkz+
         CRxM1BdFVwGXZCq/1giox6DHKWzQ+3eIqJQWoYcRmj6kGrEh4AA9sdrROn3vOuVssQDM
         poQbaWYYyCBJeHKlK9l6zGFiqnkp9Y1TfgLwOO6yoNerzH2+Iz/2z5FCr4QCiXbzyHBS
         g0F9t/rVJD+zBh95z+8e2wucIZj/MUaErexWDy07ATa3KOANByhWCDTtiYau3XxxmHaf
         eG/U26DhjbAxQrEZX2jBbBPbsk0fXfVh+MTMp86UN3/ZJSGpr0qh2b2eogmZY22Wnquw
         Ohxw==
X-Received: by 10.67.2.98 with SMTP id bn2mr19263629pad.20.1442129035144;
        Sun, 13 Sep 2015 00:23:55 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id g5sm7688014pat.21.2015.09.13.00.23.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Sep 2015 00:23:54 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277763>

Remove show_detached() and make detached HEAD to be rolled into
regular ref_list by adding REF_DETACHED_HEAD as a kind of branch and
supporting the same in append_ref(). This eliminates the need for an
extra function and helps in easier porting of branch.c to use
ref-filter APIs.

Before show_detached() used to check if the HEAD branch satisfies the
'--contains' option, now that is taken care by append_ref().

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 68 +++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 193296a..6ba7a3f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -30,6 +30,7 @@ static const char * const builtin_branch_usage[] = {
 
 #define REF_LOCAL_BRANCH    0x01
 #define REF_REMOTE_BRANCH   0x02
+#define REF_DETACHED_HEAD   0x04
 
 static const char *head;
 static unsigned char head_sha1[20];
@@ -352,8 +353,12 @@ static int append_ref(const char *refname, const struct object_id *oid, int flag
 			break;
 		}
 	}
-	if (ARRAY_SIZE(ref_kind) <= i)
-		return 0;
+	if (ARRAY_SIZE(ref_kind) <= i) {
+		if (!strcmp(refname, "HEAD"))
+			kind = REF_DETACHED_HEAD;
+		else
+			return 0;
+	}
 
 	/* Don't add types the caller doesn't want */
 	if ((kind & ref_list->kinds) == 0)
@@ -535,6 +540,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	int color;
 	struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
 	const char *prefix = "";
+	const char *desc = item->name;
+	char *to_free = NULL;
 
 	if (item->ignore)
 		return;
@@ -547,6 +554,10 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = BRANCH_COLOR_REMOTE;
 		prefix = remote_prefix;
 		break;
+	case REF_DETACHED_HEAD:
+		color = BRANCH_COLOR_CURRENT;
+		desc = to_free = get_head_description();
+		break;
 	default:
 		color = BRANCH_COLOR_PLAIN;
 		break;
@@ -558,7 +569,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = BRANCH_COLOR_CURRENT;
 	}
 
-	strbuf_addf(&name, "%s%s", prefix, item->name);
+	strbuf_addf(&name, "%s%s", prefix, desc);
 	if (verbose) {
 		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
@@ -581,6 +592,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 	strbuf_release(&name);
 	strbuf_release(&out);
+	free(to_free);
 }
 
 static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
@@ -601,25 +613,9 @@ static int calc_maxwidth(struct ref_list *refs, int remote_bonus)
 	return max;
 }
 
-static void show_detached(struct ref_list *ref_list, int maxwidth)
-{
-	struct commit *head_commit = lookup_commit_reference_gently(head_sha1, 1);
-
-	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
-		struct ref_item item;
-		item.name = get_head_description();
-		item.kind = REF_LOCAL_BRANCH;
-		item.dest = NULL;
-		item.commit = head_commit;
-		item.ignore = 0;
-		print_ref_item(&item, maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
-		free(item.name);
-	}
-}
-
 static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
 {
-	int i;
+	int i, index;
 	struct append_ref_cb cb;
 	struct ref_list ref_list;
 	int maxwidth = 0;
@@ -643,7 +639,14 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	cb.ref_list = &ref_list;
 	cb.pattern = pattern;
 	cb.ret = 0;
+	/*
+	 * First we obtain all regular branch refs and if the HEAD is
+	 * detached then we insert that ref to the end of the ref_fist
+	 * so that it can be printed and removed first.
+	 */
 	for_each_rawref(append_ref, &cb);
+	if (detached)
+		head_ref(append_ref, &cb);
 	/*
 	 * The following implementation is currently duplicated in ref-filter. It
 	 * will eventually be removed when we port branch.c to use ref-filter APIs.
@@ -679,15 +682,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	if (verbose)
 		maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
 
-	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
+	index = ref_list.index;
+
+	/* Print detached HEAD before sorting and printing the rest */
+	if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
+	    !strcmp(ref_list.list[index - 1].name, head)) {
+		print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
+			       1, remote_prefix);
+		index -= 1;
+	}
 
-	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && match_patterns(pattern, "HEAD"))
-		show_detached(&ref_list, maxwidth);
+	qsort(ref_list.list, index, sizeof(struct ref_item), ref_cmp);
 
-	for (i = 0; i < ref_list.index; i++) {
-		int current = !detached &&
-			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
+	for (i = 0; i < index; i++) {
+		int current = !detached && (ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
 		print_ref_item(&ref_list.list[i], maxwidth, verbose,
 			       abbrev, current, remote_prefix);
@@ -914,7 +922,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, kinds, quiet);
 	} else if (list) {
-		int ret = print_ref_list(kinds, detached, verbose, abbrev,
+		int ret;
+		/*  git branch --local also shows HEAD when it is detached */
+		if (kinds & REF_LOCAL_BRANCH)
+			kinds |= REF_DETACHED_HEAD;
+		ret = print_ref_list(kinds, detached, verbose, abbrev,
 					 with_commit, argv);
 		print_columns(&output, colopts, NULL);
 		string_list_clear(&output, 0);
-- 
2.5.1
