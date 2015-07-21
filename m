From: David Turner <dturner@twopensource.com>
Subject: [PATCH v10 6/7] update-ref and tag: add --create-reflog arg
Date: Tue, 21 Jul 2015 17:04:55 -0400
Message-ID: <1437512696-14672-6-git-send-email-dturner@twopensource.com>
References: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhaggerty@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Jul 21 23:05:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHejC-0001c2-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933551AbbGUVFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:05:25 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33033 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933098AbbGUVFP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:05:15 -0400
Received: by qged69 with SMTP id d69so64940366qge.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ghyLDTO+3tp9Igt7D+CnEYYAwm5pk2UcLd8pquQw9Kw=;
        b=k4Tt1ymYG94MRcgPDKg9mGu/i1u9I8sTuD+WBQJys26Vg2rChQp9ZVclmTO/dbTCQl
         ZJN1g/DYs7Lu0DtEK5WRe1Drzmv9YJBOCOnuu2wqdhD+csYKVFqZ56NA/C31S+IYU0dv
         34ummml6yCD8OHYp+6p0jDnyh23wf68P6gmvYMOsBC2G6uMHKpHymrsY9hOfflDOEk89
         LXv+voLCrefLDTEJz4bSUWVQfecuAaeVKB3EKzusGqlyr7omfV/A9+czzkawN4zr3hmx
         1oMVwgwR0gdhCjDoq3xUSVKVpHhmFuOiQwYQEP0XiF4SERCjEPAXXwnwf1dpJ+KyXHUM
         DmYQ==
X-Gm-Message-State: ALoCoQnsSR31jUEMm5HJ2qy9oL8jV28syz7vHERto26KJo6ipcYMF6ZnMs0tBbXqHmWJHELRv9GC
X-Received: by 10.55.52.12 with SMTP id b12mr58231028qka.22.1437512714179;
        Tue, 21 Jul 2015 14:05:14 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x137sm13430413qkx.28.2015.07.21.14.05.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jul 2015 14:05:13 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274423>

Allow the creation of a ref (e.g. stash) with a reflog already in
place. For most refs (e.g. those under refs/heads), this happens
automatically, but for others, we need this option.

Currently, git does this by pre-creating the reflog, but alternate ref
backends might store reflogs somewhere other than .git/logs.  Code
that now directly manipulates .git/logs should instead use git
plumbing commands.

I also added --create-reflog to git tag, just for completeness.

In a moment, we will use this argument to make git stash work with
alternate ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/git-tag.txt        |  5 ++++-
 Documentation/git-update-ref.txt |  5 ++++-
 builtin/tag.c                    |  5 ++++-
 builtin/update-ref.c             | 14 +++++++++++---
 t/t1400-update-ref.sh            | 38 ++++++++++++++++++++++++++++++++++++++
 t/t7004-tag.sh                   | 14 +++++++++++++-
 6 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 034d10d..2312980 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [<pattern>...]
+	[--column[=<options>] | --no-column] [--create-reflog] [<pattern>...]
 	[<pattern>...]
 'git tag' -v <tagname>...
 
@@ -143,6 +143,9 @@ This option is only applicable when listing tags without annotation lines.
 	all, 'whitespace' removes just leading/trailing whitespace lines and
 	'strip' removes both whitespace and commentary.
 
+--create-reflog::
+	Create a reflog for the tag.
+
 <tagname>::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index c8f5ae5..969bfab 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
+'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] [--create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
 
 DESCRIPTION
 -----------
@@ -67,6 +67,9 @@ performs all modifications together.  Specify commands of the form:
 	verify SP <ref> [SP <oldvalue>] LF
 	option SP <opt> LF
 
+With `--create-reflog`, update-ref will create a reflog for each ref
+even if one would not ordinarily be created.
+
 Quote fields containing whitespace as if they were strings in C source
 code; i.e., surrounded by double-quotes and with backslash escapes.
 Use 40 "0" characters or the empty string to specify a zero value.  To
diff --git a/builtin/tag.c b/builtin/tag.c
index 5f6cdc5..cccca99 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -579,6 +579,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
 	int annotate = 0, force = 0, lines = -1;
+	int create_reflog = 0;
 	int cmdmode = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
@@ -605,6 +606,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
+		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create_reflog")),
 
 		OPT_GROUP(N_("Tag listing options")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
@@ -733,7 +735,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
-				   0, NULL, &err) ||
+				   create_reflog ? REF_FORCE_CREATE_REFLOG : 0,
+				   NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 	ref_transaction_free(transaction);
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6763cf1..04dd00f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -14,6 +14,7 @@ static const char * const git_update_ref_usage[] = {
 
 static char line_termination = '\n';
 static int update_flags;
+static unsigned create_reflog_flag;
 static const char *msg;
 
 /*
@@ -200,7 +201,8 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 
 	if (ref_transaction_update(transaction, refname,
 				   new_sha1, have_old ? old_sha1 : NULL,
-				   update_flags, msg, &err))
+				   update_flags | create_reflog_flag,
+				   msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -231,7 +233,8 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
 		die("create %s: extra input: %s", refname, next);
 
 	if (ref_transaction_create(transaction, refname, new_sha1,
-				   update_flags, msg, &err))
+				   update_flags | create_reflog_flag,
+				   msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
@@ -354,6 +357,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
 	unsigned int flags = 0;
+	int create_reflog = 0;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -361,6 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 					N_("update <refname> not the one it points to")),
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
+		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create_reflog")),
 		OPT_END(),
 	};
 
@@ -370,6 +375,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (msg && !*msg)
 		die("Refusing to perform update with empty message.");
 
+	create_reflog_flag = create_reflog ? REF_FORCE_CREATE_REFLOG : 0;
+
 	if (read_stdin) {
 		struct strbuf err = STRBUF_INIT;
 		struct ref_transaction *transaction;
@@ -431,5 +438,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 				  flags);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
-				  flags, UPDATE_REFS_DIE_ON_ERR);
+				  flags | create_reflog_flag,
+				  UPDATE_REFS_DIE_ON_ERR);
 }
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d787bf5..9d21c19 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -23,6 +23,7 @@ test_expect_success setup '
 m=refs/heads/master
 n_dir=refs/heads/gu
 n=$n_dir/fixes
+outside=foo
 
 test_expect_success \
 	"create $m" \
@@ -74,6 +75,24 @@ test_expect_success "delete $m (by HEAD)" '
 '
 rm -f .git/$m
 
+test_expect_success 'update-ref does not create reflogs by default' '
+	test_when_finished "git update-ref -d $outside" &&
+	git update-ref $outside $A &&
+	git rev-parse $A >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	test_must_fail git reflog exists $outside
+'
+
+test_expect_success 'update-ref creates reflogs with --create-reflog' '
+	test_when_finished "git update-ref -d $outside" &&
+	git update-ref --create-reflog $outside $A &&
+	git rev-parse $A >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	git reflog exists $outside
+'
+
 test_expect_success \
 	"create $m (by HEAD)" \
 	"git update-ref HEAD $A &&
@@ -472,6 +491,25 @@ test_expect_success 'stdin create ref works' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stdin does not create reflogs by default' '
+	test_when_finished "git update-ref -d $outside" &&
+	echo "create $outside $m" >stdin &&
+	git update-ref --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	test_must_fail git reflog exists $outside
+'
+
+test_expect_success 'stdin creates reflogs with --create-reflog' '
+	echo "create $outside $m" >stdin &&
+	git update-ref --create-reflog --stdin <stdin &&
+	git rev-parse $m >expect &&
+	git rev-parse $outside >actual &&
+	test_cmp expect actual &&
+	git reflog exists $outside
+'
+
 test_expect_success 'stdin succeeds with quoted argument' '
 	git update-ref -d $a &&
 	echo "create $a \"$m\"" >stdin &&
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index d1ff5c9..d31788c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -51,7 +51,19 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
 	echo foo >foo &&
 	git add foo &&
 	git commit -m Foo &&
-	git tag mytag
+	git tag mytag &&
+	test_must_fail git reflog exists refs/tags/mytag
+'
+
+test_expect_success 'creating a tag with --create-reflog should create reflog' '
+	test_when_finished "git tag -d tag_with_reflog" &&
+	git tag --create-reflog tag_with_reflog &&
+	git reflog exists refs/tags/tag_with_reflog
+'
+
+test_expect_success '--create-reflog does not create reflog on failure' '
+	test_must_fail git tag --create-reflog mytag &&
+	test_must_fail git reflog exists refs/tags/mytag
 '
 
 test_expect_success 'listing all tags if one exists should succeed' '
-- 
2.0.4.315.gad8727a-twtrsrc
