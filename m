Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C85B41FC44
	for <e@80x24.org>; Mon,  8 May 2017 18:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbdEHSoC (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 14:44:02 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34773 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdEHSoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 14:44:01 -0400
Received: by mail-pf0-f175.google.com with SMTP id e64so37214650pfd.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FmK4y/qUhemamRvmEooFfzO3YDTMUIjaJYyMUAxfDHc=;
        b=czf6KjOflZmBfmWbaLupL1jPm8fLE264/G/b4ffWp99+0t+hn3a9Xb0Z51OxMhyD+O
         o+sBLLT1VyfxhbiL9A0dp4iJTUWwwL0k1WZ862vuM0qfraB5fFNdGAAI/41RBQcnXXDa
         oYfoUT0ZxiMkIlXob2T1mohGRttah5pK+uQ4dT0luKWFpRWVyDxILomF2VGtFy39kxa8
         M5bei+MyIwKBUYI1CC8X6kFjozgDW4nJ18LD2j0yRJYwPw5JeG1mbZmB+PDFkdxWu38G
         gxK4k/CqGTGNJQTKlXhde/hEY3EbuF73TJSU3s0bG3Pz8uLDrrKyA5ymY5/Hedmu/7pW
         wdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FmK4y/qUhemamRvmEooFfzO3YDTMUIjaJYyMUAxfDHc=;
        b=m0QruJPlQ9LNE/A42FBebCf777b40BmbzNoxo1wBgBb9vju6YS0022b1BsxO9uUTNf
         WO9UlYZOfzPKps30+Z6wofHo7Je3wP+x3Df4GIdLtIjqTmBouwfb6gs37qGHd4W9esD8
         nsP4sXrrbp80vCAGJf5TW/ZVl2WBve3skEL8cLnZ3LITxajpxOBGH5ee+izjqF5l5jXw
         JrlmB3Og6SB+dZjr0WV34CAabInPjC6T3xcch/4L7gBmz07U4piiJYhoijjIRCgnDvqo
         A5HgZxQt+FWp8Rt/98nASvGIkjckV8bZhqB/tpODWWV7+SqDI+MeisgmcKgqtirk+1TI
         LMBQ==
X-Gm-Message-State: AODbwcDbbuu/6iUlUr/tcucC+Ixb+8KUmMAFMLCIK9u1FK4I8e/GSjpF
        8j7VZgaowykEMpL+
X-Received: by 10.84.214.144 with SMTP id j16mr3978657pli.133.1494269040296;
        Mon, 08 May 2017 11:44:00 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c9bd:4e86:a0ec:f358])
        by smtp.gmail.com with ESMTPSA id t19sm17099626pfg.31.2017.05.08.11.43.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 11:43:59 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH] diff.c: Fix whitespace issues due to a mismerge(?)
Date:   Mon,  8 May 2017 11:43:54 -0700
Message-Id: <20170508184354.31671-1-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc2.17.g46b64dc68a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Re-indent lines, as they were off by one.
When a line was not indented (as you would expect from function defintions)
we had a stray whitespace preceding the line.
Indented lines have a stray white space after the indentation by tabs,
before the actual text, i.e.

<TAB><WS>if (...)
<TAB><TAB><WS>...

It looks like all these lines were introduced by one of the conflict chunks
in 4af9a7d344 (Merge branch 'bc/object-id', 2016-09-19). Viewing that
commit in gitk, the indentation seems fine, i.e. there is just one
whitespace in front of the lines, as you would expect from a formatted
patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

 Junio, 
 I do not think it is worth to apply this patch on its own,
 but maybe it is worth to investigate your setup? (Assuming it is
 git that did the merge, we may have a bug in whitespacing and
 merge conflicts.)
 
 Thanks,
 Stefan

 apply.c | 310 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 155 insertions(+), 155 deletions(-)

diff --git a/apply.c b/apply.c
index e6dbab26ad..be340991d7 100644
--- a/apply.c
+++ b/apply.c
@@ -4098,172 +4098,172 @@ static int build_fake_ancestor(struct apply_state *state, struct patch *list)
 	 return 0;
  }
 
- static void stat_patch_list(struct apply_state *state, struct patch *patch)
- {
-	 int files, adds, dels;
-
-	 for (files = adds = dels = 0 ; patch ; patch = patch->next) {
-		 files++;
-		 adds += patch->lines_added;
-		 dels += patch->lines_deleted;
-		 show_stats(state, patch);
-	 }
-
-	 print_stat_summary(stdout, files, adds, dels);
- }
+static void stat_patch_list(struct apply_state *state, struct patch *patch)
+{
+	int files, adds, dels;
 
- static void numstat_patch_list(struct apply_state *state,
+	for (files = adds = dels = 0 ; patch ; patch = patch->next) {
+		files++;
+		adds += patch->lines_added;
+		dels += patch->lines_deleted;
+		show_stats(state, patch);
+	}
+
+	print_stat_summary(stdout, files, adds, dels);
+}
+
+static void numstat_patch_list(struct apply_state *state,
 				struct patch *patch)
- {
-	 for ( ; patch; patch = patch->next) {
-		 const char *name;
-		 name = patch->new_name ? patch->new_name : patch->old_name;
-		 if (patch->is_binary)
-			 printf("-\t-\t");
-		 else
-			 printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
-		 write_name_quoted(name, stdout, state->line_termination);
-	 }
- }
+{
+	for ( ; patch; patch = patch->next) {
+		const char *name;
+		name = patch->new_name ? patch->new_name : patch->old_name;
+		if (patch->is_binary)
+			printf("-\t-\t");
+		else
+			printf("%d\t%d\t", patch->lines_added, patch->lines_deleted);
+		write_name_quoted(name, stdout, state->line_termination);
+	}
+}
 
- static void show_file_mode_name(const char *newdelete, unsigned int mode, const char *name)
- {
-	 if (mode)
-		 printf(" %s mode %06o %s\n", newdelete, mode, name);
+static void show_file_mode_name(const char *newdelete, unsigned int mode, const char *name)
+{
+	if (mode)
+		printf(" %s mode %06o %s\n", newdelete, mode, name);
 	 else
-		 printf(" %s %s\n", newdelete, name);
- }
+		printf(" %s %s\n", newdelete, name);
+}
 
- static void show_mode_change(struct patch *p, int show_name)
- {
-	 if (p->old_mode && p->new_mode && p->old_mode != p->new_mode) {
-		 if (show_name)
-			 printf(" mode change %06o => %06o %s\n",
+static void show_mode_change(struct patch *p, int show_name)
+{
+	if (p->old_mode && p->new_mode && p->old_mode != p->new_mode) {
+		if (show_name)
+			printf(" mode change %06o => %06o %s\n",
 				p->old_mode, p->new_mode, p->new_name);
-		 else
-			 printf(" mode change %06o => %06o\n",
-				p->old_mode, p->new_mode);
-	 }
- }
+		else
+			printf(" mode change %06o => %06o\n",
+			       p->old_mode, p->new_mode);
+	}
+}
 
- static void show_rename_copy(struct patch *p)
- {
-	 const char *renamecopy = p->is_rename ? "rename" : "copy";
-	 const char *old, *new;
-
-	 /* Find common prefix */
-	 old = p->old_name;
-	 new = p->new_name;
-	 while (1) {
-		 const char *slash_old, *slash_new;
-		 slash_old = strchr(old, '/');
-		 slash_new = strchr(new, '/');
-		 if (!slash_old ||
-		     !slash_new ||
-		     slash_old - old != slash_new - new ||
-		     memcmp(old, new, slash_new - new))
-			 break;
-		 old = slash_old + 1;
-		 new = slash_new + 1;
-	 }
-	 /* p->old_name thru old is the common prefix, and old and new
-	  * through the end of names are renames
-	  */
-	 if (old != p->old_name)
-		 printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
-			(int)(old - p->old_name), p->old_name,
-			old, new, p->score);
-	 else
-		 printf(" %s %s => %s (%d%%)\n", renamecopy,
-			p->old_name, p->new_name, p->score);
-	 show_mode_change(p, 0);
- }
+static void show_rename_copy(struct patch *p)
+{
+	const char *renamecopy = p->is_rename ? "rename" : "copy";
+	const char *old, *new;
 
- static void summary_patch_list(struct patch *patch)
- {
-	 struct patch *p;
-
-	 for (p = patch; p; p = p->next) {
-		 if (p->is_new)
-			 show_file_mode_name("create", p->new_mode, p->new_name);
-		 else if (p->is_delete)
-			 show_file_mode_name("delete", p->old_mode, p->old_name);
-		 else {
-			 if (p->is_rename || p->is_copy)
-				 show_rename_copy(p);
-			 else {
-				 if (p->score) {
-					 printf(" rewrite %s (%d%%)\n",
-						p->new_name, p->score);
-					 show_mode_change(p, 0);
-				 }
-				 else
-					 show_mode_change(p, 1);
-			 }
-		 }
-	 }
- }
+	/* Find common prefix */
+	old = p->old_name;
+	new = p->new_name;
+	while (1) {
+		const char *slash_old, *slash_new;
+		slash_old = strchr(old, '/');
+		slash_new = strchr(new, '/');
+		if (!slash_old ||
+		    !slash_new ||
+		    slash_old - old != slash_new - new ||
+		    memcmp(old, new, slash_new - new))
+			break;
+		old = slash_old + 1;
+		new = slash_new + 1;
+	}
+	/* p->old_name thru old is the common prefix, and old and new
+	 * through the end of names are renames
+	 */
+	if (old != p->old_name)
+		printf(" %s %.*s{%s => %s} (%d%%)\n", renamecopy,
+		       (int)(old - p->old_name), p->old_name,
+		       old, new, p->score);
+	else
+		printf(" %s %s => %s (%d%%)\n", renamecopy,
+		       p->old_name, p->new_name, p->score);
+	show_mode_change(p, 0);
+}
 
- static void patch_stats(struct apply_state *state, struct patch *patch)
- {
-	 int lines = patch->lines_added + patch->lines_deleted;
-
-	 if (lines > state->max_change)
-		 state->max_change = lines;
-	 if (patch->old_name) {
-		 int len = quote_c_style(patch->old_name, NULL, NULL, 0);
-		 if (!len)
-			 len = strlen(patch->old_name);
-		 if (len > state->max_len)
-			 state->max_len = len;
-	 }
-	 if (patch->new_name) {
-		 int len = quote_c_style(patch->new_name, NULL, NULL, 0);
-		 if (!len)
-			 len = strlen(patch->new_name);
-		 if (len > state->max_len)
-			 state->max_len = len;
-	 }
- }
+static void summary_patch_list(struct patch *patch)
+{
+	struct patch *p;
 
- static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
- {
-	 if (state->update_index) {
-		 if (remove_file_from_cache(patch->old_name) < 0)
-			 return error(_("unable to remove %s from index"), patch->old_name);
-	 }
-	 if (!state->cached) {
-		 if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
-			 remove_path(patch->old_name);
-		 }
-	 }
-	 return 0;
- }
+	for (p = patch; p; p = p->next) {
+		if (p->is_new)
+			show_file_mode_name("create", p->new_mode, p->new_name);
+		else if (p->is_delete)
+			show_file_mode_name("delete", p->old_mode, p->old_name);
+		else {
+			if (p->is_rename || p->is_copy)
+				show_rename_copy(p);
+			else {
+				if (p->score) {
+					printf(" rewrite %s (%d%%)\n",
+					       p->new_name, p->score);
+					show_mode_change(p, 0);
+				}
+				else
+					show_mode_change(p, 1);
+			}
+		}
+	}
+}
 
- static int add_index_file(struct apply_state *state,
-			   const char *path,
-			   unsigned mode,
-			   void *buf,
-			   unsigned long size)
- {
-	 struct stat st;
-	 struct cache_entry *ce;
-	 int namelen = strlen(path);
-	 unsigned ce_size = cache_entry_size(namelen);
-
-	 if (!state->update_index)
-		 return 0;
-
-	 ce = xcalloc(1, ce_size);
-	 memcpy(ce->name, path, namelen);
-	 ce->ce_mode = create_ce_mode(mode);
-	 ce->ce_flags = create_ce_flags(0);
-	 ce->ce_namelen = namelen;
-	 if (S_ISGITLINK(mode)) {
-		 const char *s;
-
-		 if (!skip_prefix(buf, "Subproject commit ", &s) ||
-		     get_oid_hex(s, &ce->oid)) {
+static void patch_stats(struct apply_state *state, struct patch *patch)
+{
+	int lines = patch->lines_added + patch->lines_deleted;
+
+	if (lines > state->max_change)
+		state->max_change = lines;
+	if (patch->old_name) {
+		int len = quote_c_style(patch->old_name, NULL, NULL, 0);
+		if (!len)
+			len = strlen(patch->old_name);
+		if (len > state->max_len)
+			state->max_len = len;
+	}
+	if (patch->new_name) {
+		int len = quote_c_style(patch->new_name, NULL, NULL, 0);
+		if (!len)
+			len = strlen(patch->new_name);
+		if (len > state->max_len)
+			state->max_len = len;
+	}
+}
+
+static int remove_file(struct apply_state *state, struct patch *patch, int rmdir_empty)
+{
+	if (state->update_index) {
+		if (remove_file_from_cache(patch->old_name) < 0)
+			return error(_("unable to remove %s from index"), patch->old_name);
+	}
+	if (!state->cached) {
+		if (!remove_or_warn(patch->old_mode, patch->old_name) && rmdir_empty) {
+			remove_path(patch->old_name);
+		}
+	}
+	return 0;
+}
+
+static int add_index_file(struct apply_state *state,
+			  const char *path,
+			  unsigned mode,
+			  void *buf,
+			  unsigned long size)
+{
+	struct stat st;
+	struct cache_entry *ce;
+	int namelen = strlen(path);
+	unsigned ce_size = cache_entry_size(namelen);
+
+	if (!state->update_index)
+		return 0;
+
+	ce = xcalloc(1, ce_size);
+	memcpy(ce->name, path, namelen);
+	ce->ce_mode = create_ce_mode(mode);
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = namelen;
+	if (S_ISGITLINK(mode)) {
+		const char *s;
+
+		if (!skip_prefix(buf, "Subproject commit ", &s) ||
+		    get_oid_hex(s, &ce->oid)) {
 			free(ce);
 			return error(_("corrupt patch for submodule %s"), path);
 		}
-- 
2.13.0.rc2.17.g46b64dc68a

