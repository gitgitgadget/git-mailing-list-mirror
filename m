From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 1/4] remote: minor code cleanups in preparation for changing "show" output
Date: Thu, 19 Feb 2009 00:14:28 -0500
Message-ID: <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 06:16:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La1Gj-0005K5-Su
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 06:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbZBSFOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 00:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbZBSFOl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 00:14:41 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:11557 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbZBSFOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 00:14:38 -0500
Received: by el-out-1112.google.com with SMTP id b25so136026elf.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 21:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1z/0wwtmC4B+Lv70oZyx3wABqfeIXqYSOD6f1pvoPqM=;
        b=A00rYBDsWtnqqhdT76yyAdIPwaNv8TQfzuoUd1yk8lb+N8Ai/7sLVOrcOCU8OirdjM
         Rr8MXNwvy529I34V2EGJ7Jhuxkzd2v1wpg/wdtZ9M7JoebRwTf09N1Zft7X0aX0IxZIf
         mRScOBiAtICZimtjaMNlCWGBSP0A7xbAKEkXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=dLM5lMBjGJphp0O5uedxjUynCxoG7fdzxslxcMRO0OPV/uhwjHEY7vACGb62uRqmYG
         REZo6LYz7aW93Z2HIscZTxVLccgsANGtAY7ObKAruoYw/35IfLreXjGRTuWyQvSBrla0
         IA+G/7Rz+97XeKPpkJNQDCM3oAV0tLAvve5vs=
Received: by 10.151.143.3 with SMTP id v3mr581961ybn.246.1235020476419;
        Wed, 18 Feb 2009 21:14:36 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id n29sm2021073elf.10.2009.02.18.21.14.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 21:14:35 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.218.g1b4fab
In-Reply-To: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110622>

* Rename char *remote to remote_name to distinguish it clearly from the
  struct remote pointer, also named remote.

* There is no need to call sort_string_list() on branch_list, as its
  items are added to it via string_list_insert() which maintains its
  order.

* Sort states->new and states->tracked so that we can use binary search
  string_list_has_string() on them instead of less efficient linear
  unsorted_string_list_has_string. This alters the output of "remote
  show" slightly, so update the tests to match.

* Simplify get_ref_states(); nothing is using the pointer to states that
  is being copied into util.

* Have get_remote_ref_states() populate states->tracked even when it is
  not querying the remote so that this need not be done by the caller.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I added a function prototype for get_remote_ref_states() so I didn't
need to move its location in this diff, which kept the diff cleaner.
The next patch then moves the function and gets rid of the prototype.

 builtin-remote.c  |   45 ++++++++++++++++++++++-----------------------
 t/t5505-remote.sh |    2 +-
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d6958d4..ea5e808 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -23,6 +23,9 @@ static int verbose;
 
 static int show_all(void);
 
+static int append_ref_to_tracked_list(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data);
+
 static inline int postfixcmp(const char *string, const char *postfix)
 {
 	int len1 = strlen(string), len2 = strlen(postfix);
@@ -144,7 +147,7 @@ static int add(int argc, const char **argv)
 }
 
 struct branch_info {
-	char *remote;
+	char *remote_name;
 	struct string_list merge;
 };
 
@@ -183,9 +186,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			item->util = xcalloc(sizeof(struct branch_info), 1);
 		info = item->util;
 		if (type == REMOTE) {
-			if (info->remote)
+			if (info->remote_name)
 				warning("more than one branch.%s", key);
-			info->remote = xstrdup(value);
+			info->remote_name = xstrdup(value);
 		} else {
 			char *space = strchr(value, ' ');
 			value = abbrev_branch(value);
@@ -207,7 +210,6 @@ static void read_branches(void)
 	if (branch_list.nr)
 		return;
 	git_config(config_read_branches, NULL);
-	sort_string_list(&branch_list);
 }
 
 struct ref_states {
@@ -228,10 +230,8 @@ static int handle_one_branch(const char *refname,
 		const char *name = abbrev_branch(refspec.src);
 		/* symbolic refs pointing nowhere were handled already */
 		if ((flags & REF_ISSYMREF) ||
-				unsorted_string_list_has_string(&states->tracked,
-					name) ||
-				unsorted_string_list_has_string(&states->new,
-					name))
+		    string_list_has_string(&states->tracked, name) ||
+		    string_list_has_string(&states->new, name))
 			return 0;
 		item = string_list_append(name, &states->stale);
 		item->util = xstrdup(refname);
@@ -251,21 +251,16 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 
 	states->new.strdup_strings = states->tracked.strdup_strings = 1;
 	for (ref = fetch_map; ref; ref = ref->next) {
-		struct string_list *target = &states->tracked;
 		unsigned char sha1[20];
-		void *util = NULL;
-
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
-			target = &states->new;
-		else {
-			target = &states->tracked;
-			if (hashcmp(sha1, ref->new_sha1))
-				util = &states;
-		}
-		string_list_append(abbrev_branch(ref->name), target)->util = util;
+			string_list_append(abbrev_branch(ref->name), &states->new);
+		else
+			string_list_append(abbrev_branch(ref->name), &states->tracked);
 	}
 	free_refs(fetch_map);
 
+	sort_string_list(&states->new);
+	sort_string_list(&states->tracked);
 	for_each_ref(handle_one_branch, states);
 	sort_string_list(&states->stale);
 
@@ -490,7 +485,7 @@ static int mv(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, rename.old)) {
+		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			if (git_config_set(buf.buf, rename.new)) {
@@ -600,7 +595,7 @@ static int rm(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, remote->name)) {
+		if (info->remote_name && !strcmp(info->remote_name, remote->name)) {
 			const char *keys[] = { "remote", "merge", NULL }, **k;
 			for (k = keys; *k; k++) {
 				strbuf_reset(&buf);
@@ -685,6 +680,9 @@ static int get_remote_ref_states(const char *name,
 
 		get_head_names(ref, name, states);
 		get_ref_states(ref, states);
+	} else {
+		for_each_ref(append_ref_to_tracked_list, states);
+		sort_string_list(&states->tracked);
 	}
 
 	return 0;
@@ -696,6 +694,9 @@ static int append_ref_to_tracked_list(const char *refname,
 	struct ref_states *states = cb_data;
 	struct refspec refspec;
 
+	if (flags & REF_ISSYMREF)
+		return 0;
+
 	memset(&refspec, 0, sizeof(refspec));
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec))
@@ -743,7 +744,7 @@ static int show(int argc, const char **argv)
 			struct branch_info *info = branch->util;
 			int j;
 
-			if (!info->merge.nr || strcmp(*argv, info->remote))
+			if (!info->merge.nr || strcmp(*argv, info->remote_name))
 				continue;
 			printf("  Remote branch%s merged with 'git pull' "
 				"while on branch %s\n   ",
@@ -762,8 +763,6 @@ static int show(int argc, const char **argv)
 				"prune')", &states.stale, "");
 		}
 
-		if (no_query)
-			for_each_ref(append_ref_to_tracked_list, &states);
 		show_list("  Tracked remote branch%s", &states.tracked, "");
 
 		if (states.remote->push_refspec_nr) {
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 104433d..fdc4a29 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -142,8 +142,8 @@ cat > test/expect << EOF
   New remote branch (next fetch will store in remotes/origin)
     master
   Tracked remote branches
-    side
     master
+    side
   Local branches pushed with 'git push'
     master:upstream
     +refs/tags/lastbackup
-- 
1.6.2.rc1.218.g1b4fab
