From: Tom Grennan <tmgrennan@gmail.com>
Subject: [PATCHv3 4/5] branch --exclude option
Date: Tue, 21 Feb 2012 17:28:49 -0800
Message-ID: <1329874130-16818-5-git-send-email-tmgrennan@gmail.com>
References: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, jasampler@gmail.com,
	pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 02:29:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S011H-0004IQ-IL
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 02:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753792Ab2BVB3O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 20:29:14 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49052 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab2BVB3J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 20:29:09 -0500
Received: by mail-qw0-f46.google.com with SMTP id c10so4979488qad.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 17:29:09 -0800 (PST)
Received-SPF: pass (google.com: domain of tmgrennan@gmail.com designates 10.229.102.148 as permitted sender) client-ip=10.229.102.148;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tmgrennan@gmail.com designates 10.229.102.148 as permitted sender) smtp.mail=tmgrennan@gmail.com; dkim=pass header.i=tmgrennan@gmail.com
Received: from mr.google.com ([10.229.102.148])
        by 10.229.102.148 with SMTP id g20mr17967694qco.124.1329874149323 (num_hops = 1);
        Tue, 21 Feb 2012 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=MsrBonBKbHG7wg67QggeBLFER2EMZ9sXr8zZnOM3V/c=;
        b=vfEw/HLceym7z+XG2DIPlBiwbbNwZp+ImzBzc4p4fXEG7CupfCGAVQPEywCrS4v97q
         hmsVdSgP+vKSlEaV3gk3rSfxyL8Y6rX3axJIkMILAgibID+z7p4i0l/1nmItVaEpPB1W
         R8Q1c969e480OVss9BQW1Z5I66qi7YCTAeQbk=
Received: by 10.229.102.148 with SMTP id g20mr15263726qco.124.1329874149155;
        Tue, 21 Feb 2012 17:29:09 -0800 (PST)
Received: from tgrennan-laptop.lab.redback.com ([129.192.185.163])
        by mx.google.com with ESMTPS id n8sm2148026qan.12.2012.02.21.17.29.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 17:29:08 -0800 (PST)
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1329874130-16818-1-git-send-email-tmgrennan@gmail.com>
In-Reply-To: <20120211190856.GB4903@tgrennan-laptop>
References: <20120211190856.GB4903@tgrennan-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191214>

Example,
  $ ./git-branch -r --exclude \*HEAD
  origin/maint
  origin/master
  origin/next
  origin/pu
  origin/todo

Signed-off-by: Tom Grennan <tmgrennan@gmail.com>
---
 Documentation/git-branch.txt |    7 ++++++-
 builtin/branch.c             |   18 +++++++++++++-----
 t/t3200-branch.sh            |   23 +++++++++++++++++++++++
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 0427e80..ef08872 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=<length> | --no-abbrev]]
-	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
+	[(--merged | --no-merged | --contains) [<commit>]]
+	[--exclude <pattern>] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
@@ -166,6 +167,10 @@ start-point is either a local or remote-tracking branch.
 --contains <commit>::
 	Only list branches which contain the specified commit.
 
+--exclude <pattern>::
+	Don't list branches matching the given pattern.  This has
+	precedence over other match pattern arguments.
+
 --merged [<commit>]::
 	Only list branches whose tips are reachable from the
 	specified commit (HEAD if not specified).
diff --git a/builtin/branch.c b/builtin/branch.c
index e46ed58..ec06f66 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -243,6 +243,7 @@ struct ref_list {
 	int index, alloc, maxwidth, verbose, abbrev;
 	struct ref_item *list;
 	struct commit_list *with_commit;
+	struct string_list *exclude;
 	int kinds;
 };
 
@@ -300,7 +301,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
-	if (!match_pattern(refname, cb->pattern, NULL, 0))
+	if (!match_pattern(refname, cb->pattern, ref_list->exclude, 0))
 		return 0;
 
 	commit = NULL;
@@ -498,7 +499,10 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit, const char **pattern)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev,
+			  struct commit_list *with_commit,
+			  struct string_list *exclude,
+			  const char **pattern)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -509,6 +513,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	ref_list.verbose = verbose;
 	ref_list.abbrev = abbrev;
 	ref_list.with_commit = with_commit;
+	ref_list.exclude = exclude;
 	if (merge_filter != NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
@@ -530,7 +535,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
-	if (detached && match_pattern("HEAD", pattern, NULL, 0))
+	if (detached && match_pattern("HEAD", pattern, exclude, 0))
 		show_detached(&ref_list);
 
 	for (i = 0; i < ref_list.index; i++) {
@@ -665,7 +670,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
-
+	struct string_list exclude = STRING_LIST_INIT_NODUP;
 	struct option options[] = {
 		OPT_GROUP("Generic options"),
 		OPT__VERBOSE(&verbose,
@@ -689,6 +694,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t) "HEAD",
 		},
+		OPT_CALLBACK(0, "exclude", &exclude, "pattern",
+			     "ignorepattern matching branches",
+			     parse_opt_string_list),
 		OPT__ABBREV(&abbrev),
 
 		OPT_GROUP("Specific git-branch actions:"),
@@ -753,7 +761,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev,
-				      with_commit, argv);
+				      with_commit, &exclude, argv);
 	else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index dd1aceb..8144bc8 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -160,6 +160,29 @@ test_expect_success 'git branch --list -d t should fail' '
 	test_path_is_missing .git/refs/heads/t
 '
 
+>expect
+test_expect_success \
+	'git branch --list --exclude "t*" "t*" should be empty' '
+	git branch ta &&
+	git branch tb &&
+	git branch --list --exclude "t*" "t*" > actual &&
+	cmp expect actual
+'
+
+cat >expect <<EOF
+  ta
+EOF
+test_expect_success \
+	'git branch --list --exclude "tb" "t*" should be "ta"' '
+	git branch --list --exclude "tb" "t*" > actual &&
+	cmp expect actual
+'
+
+test_expect_success \
+	'git branch -d ta tb should succeed' '
+	git branch -d ta tb
+'
+
 mv .git/config .git/config-saved
 
 test_expect_success 'git branch -m q q2 without config should succeed' '
-- 
1.7.8
