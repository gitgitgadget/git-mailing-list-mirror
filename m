From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 05/23] builtin-remote: better handling of multiple remote HEADs
Date: Tue, 24 Feb 2009 04:50:53 -0500
Message-ID: <f72afb9f451172b8dd9f074143e64f4d5544b808.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzu-0002Ej-7z
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbZBXJvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755925AbZBXJve
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:34 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:15777 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902AbZBXJva (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:30 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005621yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=X8cmKhDeMKEBS+jEqFjZ+TIIFWagheSsOS7BBwAvQBo=;
        b=SsmJfjElAYeFUgv24OdiolA//E8eeBt/afjlZ8DUYNdy1MFufhBiem0WDjYhEVYZYd
         3tPmXlK8kD5QK1os3K36UAyei8/cG0Ldxc+ovxX6S717pHcec0gW5scMSGDHC4ph0YM9
         exH/SseCDNxFIbsv3GYOT5KtSxduXfiFbcP+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OAYIaCxB7AUB2t/wadxsemVtRUzCjlSKW2a5hxcQsg79XlFAoH0SgYSk9Im6T2TxDW
         2o8Z5E4+xCruHUmGdPyUh6YARkzzxNz/UqBlZ14ffS2XuoQEO5F8Lk7p2TbpZdDdLeku
         Nj7xOg96X++zW8Ok80hzSi23UFT8MfmE5+k5A=
Received: by 10.100.110.16 with SMTP id i16mr5427911anc.116.1235469087086;
        Tue, 24 Feb 2009 01:51:27 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d29sm9072664and.54.2009.02.24.01.51.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:26 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111259>

It is not currently possible to determine the remote HEAD unambiguously
when multiple remote branches share the same SHA1 as the remote HEAD.

In this situation, git remote set-head --auto should not try to guess
which HEAD the user wants. This patch causes set-head to provide a
useful error instead:

$ git remote set-head origin --auto
error: Multiple remote HEAD branches. Please choose one explicitly with:
  git remote set-head origin another
  git remote set-head origin master

Also, the output of git remote show now shows the multiple HEADs:

$ git remote show origin
* remote origin
  URL: ...
  HEAD branches:
    another
    master

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-clone.c   |    2 +-
 builtin-remote.c  |   56 +++++++++++++++++++++++++++++++++++------------------
 remote.c          |   28 ++++++++++++++++++-------
 remote.h          |    6 ++++-
 t/t5505-remote.sh |   51 ++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 112 insertions(+), 31 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index d179d1c..d57818c 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -510,7 +510,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		mapped_refs = write_remote_refs(refs, &refspec, reflog_msg.buf);
 
 		head_points_at = guess_remote_head(refs, mapped_refs,
-						   &remote_head);
+						   &remote_head, NULL);
 	}
 	else {
 		warning("You appear to have cloned an empty repository.");
diff --git a/builtin-remote.c b/builtin-remote.c
index fcb166b..608c0f3 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -212,8 +212,7 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct string_list new, stale, tracked;
-	char *head_name;
+	struct string_list new, stale, tracked, heads;
 };
 
 static int handle_one_branch(const char *refname,
@@ -273,24 +272,26 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 	return 0;
 }
 
-static char *get_head_name(const struct ref *refs)
+static int get_head_names(const struct ref *refs,
+	const char *remote_name, struct ref_states *states)
 {
-	const struct ref *head_points_at;
-	struct ref *mapped_refs = NULL;
-	struct ref **tail = &mapped_refs;
+	struct ref *ref, *matches = NULL;
+	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
 	struct refspec refspec;
 
 	refspec.force = 0;
 	refspec.pattern = 1;
 	refspec.src = refspec.dst = "refs/heads/";
+	states->heads.strdup_strings = 1;
+	get_fetch_map(refs, &refspec, &fetch_map_tail, 0);
+	guess_remote_head(refs, fetch_map, NULL, &matches);
+	for(ref = matches; ref; ref = ref->next)
+		string_list_append(abbrev_branch(ref->name), &states->heads);
 
-	get_fetch_map(refs, &refspec, &tail, 0);
-
-	head_points_at = guess_remote_head(refs, mapped_refs, NULL);
-	if (head_points_at)
-		return xstrdup(abbrev_branch(head_points_at->name));
+	free_refs(fetch_map);
+	free_refs(matches);
 
-	return NULL;
+	return 0;
 }
 
 struct known_remote {
@@ -659,7 +660,7 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->new, 0);
 	string_list_clear(&states->stale, 0);
 	string_list_clear(&states->tracked, 0);
-	free(states->head_name);
+	string_list_clear(&states->heads, 0);
 }
 
 static int get_remote_ref_states(const char *name,
@@ -681,7 +682,7 @@ static int get_remote_ref_states(const char *name,
 		ref = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
 
-		states->head_name = get_head_name(ref);
+		get_head_names(ref, name, states);
 		get_ref_states(ref, states);
 	}
 
@@ -726,9 +727,15 @@ static int show(int argc, const char **argv)
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
 				states.remote->url[0] : "(no URL)");
-		if (!no_query)
-			printf("  HEAD: %s\n", states.head_name ?
-				states.head_name : "(unknown)");
+		if (no_query)
+			printf("  HEAD branch: (not queried)\n");
+		else if (!states.heads.nr)
+			printf("  HEAD branch: (unknown)\n");
+		else if (states.heads.nr == 1)
+			printf("  HEAD branch: %s\n",
+				states.heads.items[0].string);
+		else
+			show_list("  HEAD branch%s:", &states.heads, "");
 
 		for (i = 0; i < branch_list.nr; i++) {
 			struct string_list_item *branch = branch_list.items + i;
@@ -780,7 +787,7 @@ static int show(int argc, const char **argv)
 
 static int set_head(int argc, const char **argv)
 {
-	int opt_a = 0, opt_d = 0, result = 0;
+	int i, opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	char *head_name = NULL;
 
@@ -802,7 +809,16 @@ static int set_head(int argc, const char **argv)
 		struct ref_states states;
 		memset(&states, 0, sizeof(states));
 		get_remote_ref_states(argv[0], &states, 1);
-		head_name = xstrdup(states.head_name);
+		if (!states.heads.nr)
+			result |= error("Cannot determine remote HEAD");
+		else if (states.heads.nr > 1) {
+			result |= error("Multiple remote HEAD branches. "
+					"Please choose one explicitly with:");
+			for (i = 0; i < states.heads.nr; i++)
+				fprintf(stderr, "  git remote set-head %s %s\n",
+					argv[0], states.heads.items[i].string);
+		} else
+			head_name = xstrdup(states.heads.items[0].string);
 		free_remote_ref_states(&states);
 	} else if (opt_d && !opt_a && argc == 1) {
 		if (delete_ref(buf.buf, NULL, REF_NODEREF))
@@ -818,6 +834,8 @@ static int set_head(int argc, const char **argv)
 			result |= error("Not a valid ref: %s", buf2.buf);
 		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
 			result |= error("Could not setup %s", buf.buf);
+		if (opt_a)
+			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
 	}
 
diff --git a/remote.c b/remote.c
index 447f091..6385a22 100644
--- a/remote.c
+++ b/remote.c
@@ -1379,18 +1379,23 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 
 const struct ref *guess_remote_head(const struct ref *refs,
 				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p)
+				    const struct ref **remote_head_p,
+				    struct ref **all_matches_p)
 {
 	const struct ref *remote_head = NULL;
 	const struct ref *remote_master = NULL;
+	const struct ref *ret = NULL;
 	const struct ref *r;
+	struct ref **tail = all_matches_p;
+
 	for (r = refs; r; r = r->next)
 		if (!strcmp(r->name, "HEAD"))
 			remote_head = r;
 
-	for (r = mapped_refs; r; r = r->next)
-		if (!strcmp(r->name, "refs/heads/master"))
-			remote_master = r;
+	if (!all_matches_p)
+		for (r = mapped_refs; r; r = r->next)
+			if (!strcmp(r->name, "refs/heads/master"))
+				remote_master = r;
 
 	if (remote_head_p)
 		*remote_head_p = remote_head;
@@ -1407,9 +1412,16 @@ const struct ref *guess_remote_head(const struct ref *refs,
 	/* Look for another ref that points there */
 	for (r = mapped_refs; r; r = r->next)
 		if (r != remote_head &&
-		    !hashcmp(r->old_sha1, remote_head->old_sha1))
-			return r;
+		    !hashcmp(r->old_sha1, remote_head->old_sha1)) {
+			struct ref *cpy;
+			if (!ret)
+				ret = r;
+			if (!all_matches_p)
+				break;
+			*tail = cpy = copy_ref(r);
+			cpy->peer_ref = NULL;
+			tail = &cpy->next;
+		}
 
-	/* Nothing is the same */
-	return NULL;
+	return ret;
 }
diff --git a/remote.h b/remote.h
index cabb14a..8409d42 100644
--- a/remote.h
+++ b/remote.h
@@ -141,9 +141,13 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb);
  * Look in refs for HEAD. Then look for a matching SHA1 in mapped_refs,
  * first checking if refs/heads/master matches. Return NULL if nothing matches
  * or if there is no HEAD in refs. remote_head_p is assigned HEAD if not NULL.
+ * If all_matches_p is NULL, return after the first possible match. Otherwise
+ * all_matches_p is set to a ref list of each branch head with the same SHA1 as
+ * HEAD.
  */
 const struct ref *guess_remote_head(const struct ref *refs,
 				    const struct ref *mapped_refs,
-				    const struct ref **remote_head_p);
+				    const struct ref **remote_head_p,
+				    struct ref **all_matches_p);
 
 #endif
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 826d0c3..9ea923b 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -136,7 +136,7 @@ EOF
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
-  HEAD: master
+  HEAD branch: master
   Remote branch merged with 'git pull' while on branch master
     master
   New remote branch (next fetch will store in remotes/origin)
@@ -147,6 +147,11 @@ cat > test/expect << EOF
   Local branches pushed with 'git push'
     master:upstream
     +refs/tags/lastbackup
+* remote two
+  URL: ../two
+  HEAD branches:
+    another
+    master
 EOF
 
 test_expect_success 'show' '
@@ -155,6 +160,7 @@ test_expect_success 'show' '
 		refs/heads/master:refs/heads/upstream &&
 	 git fetch &&
 	 git branch -d -r origin/master &&
+	 git config --add remote.two.url ../two &&
 	 (cd ../one &&
 	  echo 1 > file &&
 	  test_tick &&
@@ -163,13 +169,14 @@ test_expect_success 'show' '
 		refs/heads/master:refs/heads/upstream &&
 	 git config --add remote.origin.push \
 		+refs/tags/lastbackup &&
-	 git remote show origin > output &&
+	 git remote show origin two > output &&
 	 test_cmp expect output)
 '
 
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
+  HEAD branch: (not queried)
   Remote branch merged with 'git pull' while on branch master
     master
   Tracked remote branches
@@ -198,6 +205,46 @@ test_expect_success 'prune' '
 	 test_must_fail git rev-parse refs/remotes/origin/side)
 '
 
+test_expect_success 'set-head --delete' '
+	(cd test &&
+	 git symbolic-ref refs/remotes/origin/HEAD &&
+	 git remote set-head --delete origin &&
+	 test_must_fail git symbolic-ref refs/remotes/origin/HEAD)
+'
+
+test_expect_success 'set-head --auto' '
+	(cd test &&
+	 git remote set-head --auto origin &&
+	 echo refs/remotes/origin/master >expect &&
+	 git symbolic-ref refs/remotes/origin/HEAD >output &&
+	 test_cmp expect output
+	)
+'
+
+cat >test/expect <<EOF
+error: Multiple remote HEAD branches. Please choose one explicitly with:
+  git remote set-head two another
+  git remote set-head two master
+EOF
+
+test_expect_success 'set-head --auto fails w/multiple HEADs' '
+	(cd test &&
+	 test_must_fail git remote set-head --auto two >output 2>&1 &&
+	test_cmp expect output)
+'
+
+cat >test/expect <<EOF
+refs/remotes/origin/side2
+EOF
+
+test_expect_success 'set-head explicit' '
+	(cd test &&
+	 git remote set-head origin side2 &&
+	 git symbolic-ref refs/remotes/origin/HEAD >output &&
+	 git remote set-head origin master &&
+	 test_cmp expect output)
+'
+
 cat > test/expect << EOF
 Pruning origin
 URL: $(pwd)/one
-- 
1.6.2.rc1.291.g83eb
