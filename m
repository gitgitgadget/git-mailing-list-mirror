From: newren@gmail.com
Subject: [PATCH 5/7] fast-export: Add a --tag-of-filtered-object option for newly dangling tags
Date: Fri, 19 Jun 2009 22:37:01 -0600
Message-ID: <1245472623-28103-6-git-send-email-newren@gmail.com>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
Cc: Johannes.Schindelin@gmx.de, kusambite@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 20 06:39:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHsMk-0004Gg-LR
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 06:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbZFTEjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbZFTEjc
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 00:39:32 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:7578 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbZFTEjb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 00:39:31 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1018242wfd.4
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 21:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=448QOgOFY9Rcq8BCkoB/VicfUgMAj1YxS8TaVSR4hFA=;
        b=DNJtVkZzd54LpPrFI4I/3b6JbTcPbhxpPmMMIA9eaEF5OzdEm5sMlbJ8OtT/mv7EW3
         SQ2DZ5J1+rBSeMEEsem4GhQ5YG76nykgplcZEUucgetO96/7p0rxdjaNmiBm/kgL0jOd
         ikZ8hcawYF37+Wtcd08M5sU241CutFI5gIs/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OoN9HIwq5CSBij4bgeswoPUDyPZsxOdC9Nr38e0SdxWADFl0Zb0MV4RLGMr88ZCIvz
         7CcgdCATSr5nEhPJxqem7W6EgnUW65QS+tM4HZs+2M/izBlMV8qDkJH4RggPr344/xkF
         pWDYhvsRioFHpkD+ACzkB6kb/9U6Lkk2N9imM=
Received: by 10.142.155.8 with SMTP id c8mr1602713wfe.324.1245472774493;
        Fri, 19 Jun 2009 21:39:34 -0700 (PDT)
Received: from localhost.localdomain (c-68-35-108-93.hsd1.nm.comcast.net [68.35.108.93])
        by mx.google.com with ESMTPS id 22sm39467wfi.32.2009.06.19.21.39.32
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Jun 2009 21:39:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.323.gfb84f
In-Reply-To: <1245472623-28103-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121925>

From: Elijah Newren <newren@gmail.com>

When providing a list of paths to limit what is exported, the object that
a tag points to can be filtered out entirely.  This new switch allows
the user to specify what should happen to the tag in such a case.  The
default action, 'abort' will exit with an error message.  With 'drop', the
tag will simply be omitted from the output.  With 'rewrite', if the object
tagged was a commit, the tag will be modified to tag an ancestor of the
removed commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
I had a hard time coming up with a decent option name.  If anyone has a
better suggestion for the name, I'm all ears.

To see a case where this bug is triggered, run
  git fast-export --signed-tag=strip v1.6.3.2 -- COPYING
in git.git and note that the tag that is output points to 'mark :0' (a
non-existent mark), which will cause fast-import to crash.

 Documentation/git-fast-export.txt |   11 ++++++
 builtin-fast-export.c             |   64 +++++++++++++++++++++++++++++++++---
 revision.c                        |   10 +-----
 revision.h                        |    8 +++++
 4 files changed, 79 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 0c9eb56..194abde 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -36,6 +36,17 @@ when encountering a signed tag.  With 'strip', the tags will be made
 unsigned, with 'verbatim', they will be silently exported
 and with 'warn', they will be exported, but you will see a warning.
 
+--tag-of-filtered-object=(abort|drop|rewrite)::
+	Specify how to handle tags whose tagged objectis filtered out.
+	Since revisions and files to export can be limited by path,
+	tagged objects may be filtered completely.
++
+When asking to 'abort' (which is the default), this program will die
+when encountering such a tag.  With 'drop' it will omit such tags from
+the output.  With 'rewrite', if the tagged object is a commit, it will
+rewrite the tag to tag an ancestor commit (via parent rewriting; see
+linkgit:git-rev-list[1])
+
 -M::
 -C::
 	Perform move and/or copy detection, as described in the
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index b60a97e..917ac05 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -23,7 +23,8 @@ static const char *fast_export_usage[] = {
 };
 
 static int progress;
-static enum { VERBATIM, WARN, STRIP, ABORT } signed_tag_mode = ABORT;
+static enum { ABORT, VERBATIM, WARN, STRIP } signed_tag_mode = ABORT;
+static enum { ERROR, DROP, REWRITE } tag_of_filtered_mode = ABORT;
 static int fake_missing_tagger;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
@@ -42,6 +43,20 @@ static int parse_opt_signed_tag_mode(const struct option *opt,
 	return 0;
 }
 
+static int parse_opt_tag_of_filtered_mode(const struct option *opt,
+					  const char *arg, int unset)
+{
+	if (unset || !strcmp(arg, "abort"))
+		tag_of_filtered_mode = ABORT;
+	else if (!strcmp(arg, "drop"))
+		tag_of_filtered_mode = DROP;
+	else if (!strcmp(arg, "rewrite"))
+		tag_of_filtered_mode = REWRITE;
+	else
+		return error("Unknown tag-of-filtered mode: %s", arg);
+	return 0;
+}
+
 static struct decoration idnums;
 static uint32_t last_idnum;
 
@@ -282,13 +297,14 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs)
 	}
 }
 
-static void handle_tag(const char *name, struct tag *tag)
+static void handle_tag(const char *name, struct tag *tag, struct rev_info *revs)
 {
 	unsigned long size;
 	enum object_type type;
 	char *buf;
 	const char *tagger, *tagger_end, *message;
 	size_t message_size = 0;
+	struct commit *commit;
 
 	buf = read_sha1_file(tag->object.sha1, &type, &size);
 	if (!buf)
@@ -333,10 +349,42 @@ static void handle_tag(const char *name, struct tag *tag)
 			}
 	}
 
+	/* handle tag->tagged having been filtered out due to paths specified */
+	struct object * tagged = tag->tagged;
+	int tagged_mark = get_object_mark(tagged);
+	if (!tagged_mark) {
+		switch(tag_of_filtered_mode) {
+		case ABORT:
+			die ("Tag %s tags unexported commit; use "
+			     "--tag-of-filtered-object=<mode> to handle it.",
+			     sha1_to_hex(tag->object.sha1));
+		case DROP:
+			/* Ignore this tag altogether */
+			return;
+				/* fallthru */
+		case REWRITE:
+			if (tagged->type != OBJ_COMMIT) {
+				die ("Tag %s tags unexported commit; use "
+				     "--tag-of-filtered-object=<mode> to handle it.",
+				     sha1_to_hex(tag->object.sha1));
+			}
+			commit = (struct commit *)tagged;
+			switch (rewrite_one_commit(revs, &commit)) {
+			case rewrite_one_ok:
+				tagged_mark = get_object_mark(&commit->object);
+				break;
+			case rewrite_one_noparents:
+			case rewrite_one_error:
+				die ("Can't find replacement commit for tag %s\n",
+				     sha1_to_hex(tag->object.sha1));
+			}
+		}
+	}
+
 	if (!prefixcmp(name, "refs/tags/"))
 		name += 10;
 	printf("tag %s\nfrom :%d\n%.*s%sdata %d\n%.*s\n",
-	       name, get_object_mark(tag->tagged),
+	       name, tagged_mark,
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
@@ -399,7 +447,8 @@ static void get_tags_and_duplicates(struct object_array *pending,
 	}
 }
 
-static void handle_tags_and_duplicates(struct string_list *extra_refs)
+static void handle_tags_and_duplicates(struct string_list *extra_refs,
+				       struct rev_info *revs)
 {
 	struct commit *commit;
 	int i;
@@ -415,7 +464,7 @@ static void handle_tags_and_duplicates(struct string_list *extra_refs)
 				/* Ignore this tag altogether */
 				return;
 			}
-			handle_tag(name, tag);
+			handle_tag(name, tag, revs);
 			break;
 		case OBJ_COMMIT:
 			/* create refs pointing to already seen commits */
@@ -504,6 +553,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, "mode",
 			     "select handling of signed tags",
 			     parse_opt_signed_tag_mode),
+		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, "mode",
+			     "select handling of tags that tag filtered objects",
+			     parse_opt_tag_of_filtered_mode),
 		OPT_STRING(0, "export-marks", &export_filename, "FILE",
 			     "Dump marks to this file"),
 		OPT_STRING(0, "import-marks", &import_filename, "FILE",
@@ -551,7 +603,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	handle_tags_and_duplicates(&extra_refs);
+	handle_tags_and_duplicates(&extra_refs, &revs);
 
 	if (export_filename)
 		export_marks(export_filename);
diff --git a/revision.c b/revision.c
index bf58448..5ed2841 100644
--- a/revision.c
+++ b/revision.c
@@ -1601,13 +1601,7 @@ int prepare_revision_walk(struct rev_info *revs)
 	return 0;
 }
 
-enum rewrite_result {
-	rewrite_one_ok,
-	rewrite_one_noparents,
-	rewrite_one_error,
-};
-
-static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
+enum rewrite_result rewrite_one_commit(struct rev_info *revs, struct commit **pp)
 {
 	struct commit_list *cache = NULL;
 
@@ -1633,7 +1627,7 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
 	struct commit_list **pp = &commit->parents;
 	while (*pp) {
 		struct commit_list *parent = *pp;
-		switch (rewrite_one(revs, &parent->item)) {
+		switch (rewrite_one_commit(revs, &parent->item)) {
 		case rewrite_one_ok:
 			break;
 		case rewrite_one_noparents:
diff --git a/revision.h b/revision.h
index 227164c..6bf5b9e 100644
--- a/revision.h
+++ b/revision.h
@@ -158,6 +158,14 @@ extern void add_pending_object(struct rev_info *revs, struct object *obj, const
 
 extern void add_head_to_pending(struct rev_info *);
 
+enum rewrite_result {
+	rewrite_one_ok,
+	rewrite_one_noparents,
+	rewrite_one_error,
+};
+
+extern enum rewrite_result rewrite_one_commit(struct rev_info *revs, struct commit **pp);
+
 enum commit_action {
 	commit_ignore,
 	commit_show,
-- 
1.6.3.2.323.gfb84f
