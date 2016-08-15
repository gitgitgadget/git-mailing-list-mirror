Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4010C1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 21:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbcHOVxv (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:51 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35253 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbcHOVxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:49 -0400
Received: by mail-pa0-f51.google.com with SMTP id i5so19506655pat.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6b+SD6hS9nyzD/bT06qsYr2tiClXOkyhdk0JKghfAQM=;
        b=o6kIqrtNX3d2wiWZcT3LdUtD6cvFxnhPeR3m+p6shlz8NLH/GV1/XgT7y/cAFgsosw
         Q2uwicd65R1DunvRumnWGTHatMyG+S5QnWYxpyTqwh6QWehCdI9HKap/nhb57BwOmrw3
         YnrYTp1NnHxxORhQPP8fqKMVjVlCrpRbGN0EjJSUFGqbQksluAsaObY8a4jvbbFtO9Kq
         1j/vnQqjPLdHBfvZhJkmCWRjVxzjs/c8OCgc6GnJ6Wdzv8rUgeo6+jpKtCU8e4iO2Y1E
         WCvNfgJ7FCRDjZOrA4L+/Oy6gueVlbZMqgJ6dsJuJ33cT878yZ4sywUqrd/DKMrLTTXR
         Q59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6b+SD6hS9nyzD/bT06qsYr2tiClXOkyhdk0JKghfAQM=;
        b=DYcvNpmtfCSxn4ooHju8IWZuqlSUFStOrHYBmX/ULSCUPe605bjjMhxucmRw9YJr+s
         1ErL3H8JpEpKjy2RQsChiGTF7ePhNJlYbKbNpnZ8YZlWEMW1zcuhtBq9nZzZKoifDrhx
         2XXq9PUVNbTgPu2cpKgiYy8Bg3z5NA0v4Zy1ecPGGAsFAIcUZ/QsTGVRhOtALD3vAr3S
         VfflCnLXxKVpyoYgyoaVpTqqSMyk88XFcfeTI3AqCwc/qZDTcF4K3FsWDmJ9VlYz4L5z
         tP76sSu2QLKR6inKSHbYlI6+fO+H753rZW/pPQch7kKlrPXkMJI4SvNxpO7klhW87YAR
         c70A==
X-Gm-Message-State: AEkoouskYxXUviKz0DSPpQ5akJKu+L0JR4rFiiFMuKzaJoGGpPoN2TwYyezq1XVI+lIk7G/L
X-Received: by 10.66.189.199 with SMTP id gk7mr58904926pac.158.1471298028936;
        Mon, 15 Aug 2016 14:53:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id h66sm33657273pfe.58.2016.08.15.14.53.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:48 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 5/8] clone: factor out checking for an alternate path
Date:	Mon, 15 Aug 2016 14:53:24 -0700
Message-Id: <20160815215327.15682-6-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815215327.15682-1-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In a later patch we want to determine if a path is suitable as an
alternate from other commands than builtin/clone. Move the checking
functionality of `add_one_reference` to `compute_alternate_path` that is
defined in cache.h.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clone.c | 43 +++++++-------------------------
 cache.h         |  1 +
 sha1_file.c     | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 34 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f044a8c..4cd3a66 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -282,44 +282,19 @@ static void strip_trailing_slashes(char *dir)
 
 static int add_one_reference(struct string_list_item *item, void *cb_data)
 {
-	char *ref_git;
-	const char *repo;
-	struct strbuf alternate = STRBUF_INIT;
-
-	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
-	ref_git = xstrdup(real_path(item->string));
-
-	repo = read_gitfile(ref_git);
-	if (!repo)
-		repo = read_gitfile(mkpath("%s/.git", ref_git));
-	if (repo) {
-		free(ref_git);
-		ref_git = xstrdup(repo);
-	}
-
-	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
-		char *ref_git_git = mkpathdup("%s/.git", ref_git);
-		free(ref_git);
-		ref_git = ref_git_git;
-	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
-		struct strbuf sb = STRBUF_INIT;
-		if (get_common_dir(&sb, ref_git))
-			die(_("reference repository '%s' as a linked checkout is not supported yet."),
-			    item->string);
-		die(_("reference repository '%s' is not a local repository."),
-		    item->string);
-	}
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
+	char *ref_git = compute_alternate_path(item->string, &err);
 
-	if (!access(mkpath("%s/shallow", ref_git), F_OK))
-		die(_("reference repository '%s' is shallow"), item->string);
+	if (!ref_git)
+		die("%s", err.buf);
 
-	if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
-		die(_("reference repository '%s' is grafted"), item->string);
+	strbuf_addf(&sb, "%s/objects", ref_git);
+	add_to_alternates_file(sb.buf);
 
-	strbuf_addf(&alternate, "%s/objects", ref_git);
-	add_to_alternates_file(alternate.buf);
-	strbuf_release(&alternate);
 	free(ref_git);
+	strbuf_release(&err);
+	strbuf_release(&sb);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index b5f76a4..1087dca 100644
--- a/cache.h
+++ b/cache.h
@@ -1342,6 +1342,7 @@ extern struct alternate_object_database {
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void read_info_alternates(const char * relative_base, int depth);
+extern char *compute_alternate_path(const char *path, struct strbuf *err);
 extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
diff --git a/sha1_file.c b/sha1_file.c
index cb571ac..0fe5aa3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -425,6 +425,82 @@ void add_to_alternates_file(const char *reference)
 	free(alts);
 }
 
+/*
+ * Compute the exact path an alternate is at and returns it. In case of
+ * error NULL is returned and the human readable error is added to `err`
+ * `path` may be relative and should point to $GITDIR.
+ * `err` must not be null.
+ */
+char *compute_alternate_path(const char *path, struct strbuf *err)
+{
+	char *ref_git = NULL;
+	const char *repo, *ref_git_s;
+	int seen_error = 0;
+
+	ref_git_s = real_path_if_valid(path);
+	if (!ref_git_s) {
+		seen_error = 1;
+		strbuf_addf(err, _("path '%s' does not exist"), path);
+		goto out;
+	} else
+		/*
+		 * Beware: read_gitfile(), real_path() and mkpath()
+		 * return static buffer
+		 */
+		ref_git = xstrdup(ref_git_s);
+
+	repo = read_gitfile(ref_git);
+	if (!repo)
+		repo = read_gitfile(mkpath("%s/.git", ref_git));
+	if (repo) {
+		free(ref_git);
+		ref_git = xstrdup(repo);
+	}
+
+	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
+		char *ref_git_git = mkpathdup("%s/.git", ref_git);
+		free(ref_git);
+		ref_git = ref_git_git;
+	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
+		struct strbuf sb = STRBUF_INIT;
+		seen_error = 1;
+		if (get_common_dir(&sb, ref_git)) {
+			strbuf_addf(err,
+				    _("reference repository '%s' as a linked "
+				      "checkout is not supported yet."),
+				    path);
+			goto out;
+		}
+
+		strbuf_addf(err, _("reference repository '%s' is not a "
+					"local repository."), path);
+		goto out;
+	}
+
+	if (!access(mkpath("%s/shallow", ref_git), F_OK)) {
+		strbuf_addf(err, _("reference repository '%s' is shallow"),
+			    path);
+		seen_error = 1;
+		goto out;
+	}
+
+	if (!access(mkpath("%s/info/grafts", ref_git), F_OK)) {
+		strbuf_addf(err,
+			    _("reference repository '%s' is grafted"),
+			    path);
+		seen_error = 1;
+		goto out;
+	}
+
+out:
+	if (seen_error) {
+		free(ref_git);
+		ref_git = NULL;
+	}
+
+	return ref_git;
+}
+
 int foreach_alt_odb(alt_odb_fn fn, void *cb)
 {
 	struct alternate_object_database *ent;
-- 
2.9.2.730.g525ad04.dirty

