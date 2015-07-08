From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 7/8] update-ref and tag: add --create-reflog arg
Date: Tue,  7 Jul 2015 20:56:02 -0400
Message-ID: <1436316963-25520-7-git-send-email-dturner@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 08 02:56:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdfU-0007J3-0z
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbbGHA4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:56:52 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35072 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241AbbGHA4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:56:24 -0400
Received: by qget71 with SMTP id t71so93020523qge.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7qexMCyPuy1KjrHrxGFDFVcXig7tn3TdnmEpGNFxG4=;
        b=lIZ0Dyyu1zx62Zfh25wUp1NTMmo6q82bGmbrutZx1kcmcMKjMLnxVciHZb94yHGQv6
         Nii5WHrLSyuQETF/ZfM1gf5Gfj/FZotUXfEe4Mu1ASzElNGkTQQdTwJ7I5e3y84v/fzg
         upxknex8i64B39573qH4S2UQe0MP7ua7sdSFdGF9xwEX26GM9sfCnZ/O1b9oygYbAVX9
         D3u0ESLHdlhuKPs6X32yqWZTrG/P1HZGszZ58GwElX7VTpeJ/rpKqzOXYN3Fda7ViIrm
         hkdd0K5EvyTVrEtP6d+h4tTFTVV902vgMfbMC/LvzUqwUUWpzE543qTuFKCp1+rCnITW
         fcGw==
X-Gm-Message-State: ALoCoQmLHZjytN5n0nL2Wwf0Y2KmMBSyQErOfC4T46RdF2UNHj+WS6BsQUECULQ0ZYlgiWoLOR7U
X-Received: by 10.140.33.227 with SMTP id j90mr11689064qgj.6.1436316983708;
        Tue, 07 Jul 2015 17:56:23 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z135sm278447qhd.29.2015.07.07.17.56.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 17:56:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273629>

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
 builtin/tag.c                    |  5 +++++
 builtin/update-ref.c             | 17 +++++++++++++++--
 t/t1400-update-ref.sh            | 38 ++++++++++++++++++++++++++++++++++++++
 t/t7004-tag.sh                   |  9 ++++++++-
 6 files changed, 74 insertions(+), 5 deletions(-)

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
index 5f6cdc5..896f434 100644
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
@@ -730,6 +732,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (annotate)
 		create_tag(object, tag, &buf, &opt, prev, object);
 
+	if (create_reflog && safe_create_reflog(ref.buf, &err, 1))
+		die("failed to create reflog for %s: %s", ref.buf, err.buf);
+
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref.buf, object, prev,
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6763cf1..d570e5e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -14,6 +14,7 @@ static const char * const git_update_ref_usage[] = {
 
 static char line_termination = '\n';
 static int update_flags;
+int create_reflog;
 static const char *msg;
 
 /*
@@ -198,6 +199,9 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
+	if (create_reflog && safe_create_reflog(refname, &err, 1))
+		die("failed to create reflog for %s: %s", refname, err.buf);
+
 	if (ref_transaction_update(transaction, refname,
 				   new_sha1, have_old ? old_sha1 : NULL,
 				   update_flags, msg, &err))
@@ -230,6 +234,9 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
+	if (create_reflog && safe_create_reflog(refname, &err, 1))
+		die("failed to create reflog for %s: %s", refname, err.buf);
+
 	if (ref_transaction_create(transaction, refname, new_sha1,
 				   update_flags, msg, &err))
 		die("%s", err.buf);
@@ -361,6 +368,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 					N_("update <refname> not the one it points to")),
 		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
 		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
+		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create_reflog")),
 		OPT_END(),
 	};
 
@@ -421,7 +429,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 
 	if (no_deref)
 		flags = REF_NODEREF;
-	if (delete)
+	if (delete) {
 		/*
 		 * For purposes of backwards compatibility, we treat
 		 * NULL_SHA1 as "don't care" here:
@@ -429,7 +437,12 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		return delete_ref(refname,
 				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
 				  flags);
-	else
+	} else {
+		struct strbuf err = STRBUF_INIT;
+		if (create_reflog && safe_create_reflog(refname, &err, 1))
+			die("failed to create reflog for %s: %s", refname, err.buf);
+
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  flags, UPDATE_REFS_DIE_ON_ERR);
+	}
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
index d1ff5c9..426d285 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -51,7 +51,14 @@ test_expect_success 'creating a tag using default HEAD should succeed' '
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
 '
 
 test_expect_success 'listing all tags if one exists should succeed' '
-- 
2.0.5.499.g01f6352.dirty-twtrsrc
