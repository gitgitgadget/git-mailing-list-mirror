Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 773E720188
	for <e@80x24.org>; Sun, 14 May 2017 03:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758902AbdENDRJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:17:09 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36724 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758758AbdENDQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:27 -0400
Received: by mail-oi0-f65.google.com with SMTP id w138so14313766oiw.3
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=91Fori1jBYTSEPRgHrxBoCL/FxbXXViV2IMAqIk1VO8=;
        b=mXZV/93Og/S67RwxAM2GhST4kk3Qtm8XSvPPdrpKlriXiJBRebLiJjD/N28Tv7t/Om
         eXkvZCpYWyC/EBQYnXRQ87qdPTsfHNS0pLVp84m4+j7CqzQiU4NCPkKM4jU7gpgktF3p
         +HmtfrWEP8yMPj6OlD1J3NW3N+anvNQykgj+UdH5i2olgFRVyIWV296Dynuktl0f/sMh
         w22Uz96HOqKXnGH4+7+G4p/lDhrqWPLYL6apMIVlcJ6gCOijexZM+8Y0Xt+4HkmW8EC+
         94ngLQwXUdMa6WUdSoyl2miHK/bTY2BpWQPZwfkQKdXjjAApkZixFVerlVu86a+tJD8A
         a+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=91Fori1jBYTSEPRgHrxBoCL/FxbXXViV2IMAqIk1VO8=;
        b=t7KOmtIzQ+MjKcTXM9NsrL61KC9TIjX8DQrFw6Q0EB7qEA097FZklz9HONqNV6gRxw
         c3aGy+u934DSBVr1OETDxKfYphQLC+LFFjZtJBaZ4cZmTDO+vmRxR0llBcp95in8ecDv
         RHrmfWShQG7L6TJvKXKUGx/TD2N8Q7kSWJ+KxI3kNp8cTzMEnXonYi+uZAGel/w/PgZ+
         36n110h0q2I7sSDwiAt6IwLSFgT1AasZYRYIuyq8Z1wgMh1Xt6g5bXcvJg0qASR4Qtif
         1e1+X9u8Etkddfh8OL8zwleVNCv1xzT1gxUb1MJZQe/YEqdd6elcTgGN35mKveCXNY4a
         TUvQ==
X-Gm-Message-State: AODbwcBhB1ywB0f2pqGAbtiM2wEXhSJZgFnOjO5h2sCYEZ0V5XcQn8aC
        5PWsT8Oh/EXTJA==
X-Received: by 10.157.68.224 with SMTP id p32mr6146324otg.19.1494731786395;
        Sat, 13 May 2017 20:16:26 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:25 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 16/22] blame: rework methods that determine 'final' commit
Date:   Sat, 13 May 2017 22:15:07 -0500
Message-Id: <20170514031513.9042-17-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Either prepare_initial or prepare_final is used to determine which
commit is marked as 'final'. Call the underlying methods directly to
make this more clear.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 94c9ded..3d85f62 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2297,14 +2297,8 @@ static struct commit *find_single_final(struct rev_info *revs,
 	return found;
 }
 
-static char *prepare_final(struct blame_scoreboard *sb)
-{
-	const char *name;
-	sb->final = find_single_final(sb->revs, &name);
-	return xstrdup_or_null(name);
-}
-
-static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
+static struct commit *dwim_reverse_initial(struct rev_info *revs,
+					   const char **name_p)
 {
 	/*
 	 * DWIM "git blame --reverse ONE -- PATH" as
@@ -2315,11 +2309,11 @@ static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
 	struct commit *head_commit;
 	unsigned char head_sha1[20];
 
-	if (sb->revs->pending.nr != 1)
+	if (revs->pending.nr != 1)
 		return NULL;
 
 	/* Is that sole rev a committish? */
-	obj = sb->revs->pending.objects[0].item;
+	obj = revs->pending.objects[0].item;
 	obj = deref_tag(obj, NULL, 0);
 	if (obj->type != OBJ_COMMIT)
 		return NULL;
@@ -2333,17 +2327,19 @@ static const char *dwim_reverse_initial(struct blame_scoreboard *sb)
 
 	/* Turn "ONE" into "ONE..HEAD" then */
 	obj->flags |= UNINTERESTING;
-	add_pending_object(sb->revs, &head_commit->object, "HEAD");
+	add_pending_object(revs, &head_commit->object, "HEAD");
 
-	sb->final = (struct commit *)obj;
-	return sb->revs->pending.objects[0].name;
+	if (name_p)
+		*name_p = revs->pending.objects[0].name;
+	return (struct commit *)obj;
 }
 
-static char *prepare_initial(struct blame_scoreboard *sb)
+static struct commit *find_single_initial(struct rev_info *revs,
+					  const char **name_p)
 {
 	int i;
 	const char *final_commit_name = NULL;
-	struct rev_info *revs = sb->revs;
+	struct commit *found = NULL;
 
 	/*
 	 * There must be one and only one negative commit, and it must be
@@ -2356,19 +2352,22 @@ static char *prepare_initial(struct blame_scoreboard *sb)
 		obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
-		if (sb->final)
+		if (found)
 			die("More than one commit to dig up from, %s and %s?",
 			    revs->pending.objects[i].name,
 			    final_commit_name);
-		sb->final = (struct commit *) obj;
+		found = (struct commit *) obj;
 		final_commit_name = revs->pending.objects[i].name;
 	}
 
 	if (!final_commit_name)
-		final_commit_name = dwim_reverse_initial(sb);
+		found = dwim_reverse_initial(revs, &final_commit_name);
 	if (!final_commit_name)
 		die("No commit to dig up from?");
-	return xstrdup(final_commit_name);
+
+	if (name_p)
+		*name_p = final_commit_name;
+	return found;
 }
 
 static int blame_copy_callback(const struct option *option, const char *arg, int unset)
@@ -2412,7 +2411,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct blame_origin *o;
 	struct blame_entry *ent = NULL;
 	long dashdash_pos, lno;
-	char *final_commit_name = NULL;
+	const char *final_commit_name = NULL;
 	enum object_type type;
 	struct commit *final_commit = NULL;
 	struct progress_info pi = { NULL, 0 };
@@ -2621,14 +2620,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
+
 	if (!reverse) {
-		final_commit_name = prepare_final(&sb);
+		sb.final = find_single_final(&revs, &final_commit_name);
 		sb.commits.compare = compare_commits_by_commit_date;
 	}
 	else if (contents_from)
 		die(_("--contents and --reverse do not blend well."));
 	else {
-		final_commit_name = prepare_initial(&sb);
+		sb.final = find_single_initial(&revs, &final_commit_name);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
 		if (revs.first_parent_only)
 			revs.children.name = NULL;
@@ -2783,10 +2783,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	if (!incremental)
 		setup_pager();
-
-	free(final_commit_name);
-
-	if (incremental)
+	else
 		return 0;
 
 	blame_sort_final(&sb);
-- 
2.9.3

