From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 13/13] remote: new show output style for push refspecs
Date: Mon, 23 Feb 2009 01:29:01 -0500
Message-ID: <1100286055de1ac271e8e5c060405fd358dab601.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULR-00072Y-6G
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbZBWG3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbZBWG3m
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:42 -0500
Received: from yw-out-2324.google.com ([74.125.46.31]:10242 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZBWG3f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:35 -0500
Received: by yw-out-2324.google.com with SMTP id 5so749066ywh.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Hob04GBDGAJ+Vxftn60aqjV3259rlh7CanO9L3v7HT8=;
        b=OTU/vCO8Lidm0TGfS1Sr1PxS2SNeeHwtgk+O0+mUQPzWjTd/35JnEbN088jzthRadP
         Hx26TiAZAhgL95fPaK/Zkl3PywIlgofQWzCU9wBqk5BbcLiaBSFAy86wvhu/Z6mVvbLw
         djyx1A0lTx8kIvw+feIEi47HumSI6AkmpGGMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BN0F0t2VGi0icykcZyNT+WN8B6isJV4b40qeFYw0nv/UKfPf+yix+TuJJ6IyUk63sB
         UkslVQWMHdfRFe01JzJEeXpv0TKmcmoS5OnbAblBjuli0/AmElKebp47x1ZXUdWJO2f1
         xfaaPARIldvFq2cNWgVxASoMlPQg8fKYR1OwA=
Received: by 10.100.14.10 with SMTP id 10mr3524261ann.119.1235370574959;
        Sun, 22 Feb 2009 22:29:34 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id c1sm11698316ana.40.2009.02.22.22.29.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:34 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111100>

The existing output of "git remote show <remote>" with respect to push
ref specs is basically just to show the raw refspec. This patch teaches
the command to interpret the refspecs and show how each branch will be
pushed to the destination. The output gives the user an idea of what
"git push" should do if it is run w/o any arguments.

Example new output:

1a. Typical output with no push refspec (i.e. matching branches only)

$ git remote show origin
* remote origin
  [...]
  Local refs configured for 'git push':
    master pushes to master (up to date)
    next   pushes to next   (local out of date)

1b. Same as above, w/o querying the remote:

$ git remote show origin -n
* remote origin
  [...]
  Local ref configured for 'git push' (status not queried):
    (matching) pushes to (matching)

2a. With a forcing refspec (+), and a new topic
    (something like push = refs/heads/*:refs/heads/*):

$ git remote show origin
* remote origin
  [...]
  Local refs configured for 'git push':
    master     pushes to master    (fast forwardable)
    new-topic  pushes to new-topic (create)
    next       pushes to next      (local out of date)
    pu         forces to pu        (up to date)

2b. Same as above, w/o querying the remote

$ git remote show origin -n
* remote origin
  [...]
  Local refs configured for 'git push' (status not queried):
    master     pushes to master
    new-topic  pushes to new-topic
    next       pushes to next
    pu         forces to pu

3. With a remote configured as a mirror:

* remote backup
  [...]
  Local refs will be mirrored by 'git push'

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
After spending quite a long time standing in the paint aisle looking
at all the different colors, this is my favorite.

You might like a different color paint. For example, an obvious choice
might seem to be single character status fields a-la ls-files. But that
would sacrifice clarity (IMO) as the user then has to go lookup what the
values mean in a man page, and in any case wouldn't be' consistent with
the rest of the new "show" output.

Also, "forces to" may sound a little funny, but I think it is obvious
what it means and lines up more nicely than "force pushes" or any other
choice I considered.

Anyway, I built this new shed, so I get to pick the color. (And
hopefully no one blows it up w/a stick of dynamite) :-)

 builtin-remote.c  |  201 ++++++++++++++++++++++++++++++++++++++++++++++++----
 t/t5505-remote.sh |   57 +++++++++------
 2 files changed, 219 insertions(+), 39 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 327667a..ac49219 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -21,6 +21,7 @@ static const char * const builtin_remote_usage[] = {
 
 #define GET_REF_STATES (1<<0)
 #define GET_HEAD_NAMES (1<<1)
+#define GET_PUSH_REF_STATES (1<<2)
 
 static int verbose;
 
@@ -220,7 +221,7 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct string_list new, stale, tracked, heads;
+	struct string_list new, stale, tracked, push, heads;
 	int queried;
 };
 
@@ -275,6 +276,112 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	return 0;
 }
 
+struct push_info {
+	char *dest;
+	int forced;
+	enum {
+		PUSH_STATUS_CREATE = 0,
+		PUSH_STATUS_DELETE,
+		PUSH_STATUS_UPTODATE,
+		PUSH_STATUS_FASTFORWARD,
+		PUSH_STATUS_OUTOFDATE,
+		PUSH_STATUS_NOTQUERIED,
+	} status;
+};
+
+static int get_push_ref_states(const struct ref *remote_refs,
+	struct ref_states *states)
+{
+	struct remote *remote = states->remote;
+	struct ref *ref, *local_refs, *push_map, **push_tail;
+	if (remote->mirror)
+		return 0;
+
+	local_refs = get_local_heads();
+	ref = push_map = copy_ref_list(remote_refs);
+	while (ref->next)
+		ref = ref->next;
+	push_tail = &ref->next;
+
+	match_refs(local_refs, push_map, &push_tail, remote->push_refspec_nr,
+		   remote->push_refspec, MATCH_REFS_NONE);
+
+	states->push.strdup_strings = 1;
+	for (ref = push_map; ref; ref = ref->next) {
+		struct string_list_item *item;
+		struct push_info *info;
+
+		if (!ref->peer_ref)
+			continue;
+		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
+
+		item = string_list_append(abbrev_branch(ref->peer_ref->name),
+					  &states->push);
+		item->util = xcalloc(sizeof(struct push_info), 1);
+		info = item->util;
+		info->forced = ref->force;
+		info->dest = xstrdup(abbrev_branch(ref->name));
+
+		if (is_null_sha1(ref->new_sha1)) {
+			info->status = PUSH_STATUS_DELETE;
+		} else if (!hashcmp(ref->old_sha1, ref->new_sha1))
+			info->status = PUSH_STATUS_UPTODATE;
+		else if (is_null_sha1(ref->old_sha1))
+			info->status = PUSH_STATUS_CREATE;
+		else if (has_sha1_file(ref->old_sha1) &&
+			 ref_newer(ref->new_sha1, ref->old_sha1))
+			info->status = PUSH_STATUS_FASTFORWARD;
+		else
+			info->status = PUSH_STATUS_OUTOFDATE;
+		// ref->peer_ref = NULL; /* local ref which is freed below */
+	}
+	free_refs(local_refs);
+	free_refs(push_map);
+	return 0;
+}
+
+static int get_push_ref_states_noquery(struct ref_states *states)
+{
+	int i;
+	struct remote *remote = states->remote;
+	struct string_list_item *item;
+	struct push_info *info;
+
+	if (remote->mirror)
+		return 0;
+
+	states->push.strdup_strings = 1;
+	if (!remote->push_refspec_nr) {
+		item = string_list_append("(matching)", &states->push);
+		info = item->util = xcalloc(sizeof(struct push_info), 1);
+		info->status = PUSH_STATUS_NOTQUERIED;
+		info->dest = xstrdup(item->string);
+	}
+	for (i = 0; i < remote->push_refspec_nr; i++) {
+		struct refspec *spec = remote->push + i;
+		char buf[PATH_MAX];
+		if (spec->matching)
+			item = string_list_append("(matching)", &states->push);
+		else if (spec->pattern) {
+			snprintf(buf, (sizeof(buf)), "%s*", spec->src);
+			item = string_list_append(buf, &states->push);
+			snprintf(buf, (sizeof(buf)), "%s*", spec->dst);
+		} else if (strlen(spec->src))
+			item = string_list_append(spec->src, &states->push);
+		else
+			item = string_list_append("(delete)", &states->push);
+
+		info = item->util = xcalloc(sizeof(struct push_info), 1);
+		info->forced = spec->force;
+		info->status = PUSH_STATUS_NOTQUERIED;
+		if (spec->pattern)
+			info->dest = xstrdup(buf);
+		else
+			info->dest = xstrdup(spec->dst ? spec->dst : item->string);
+	}
+	return 0;
+}
+
 static int get_head_names(const struct ref *remote_refs,
 	const char *remote_name, struct ref_states *states)
 {
@@ -645,12 +752,20 @@ static int rm(int argc, const char **argv)
 	return result;
 }
 
+void clear_push_info(void *util, const char *string)
+{
+	struct push_info *info = util;
+	free(info->dest);
+	free(info);
+}
+
 static void free_remote_ref_states(struct ref_states *states)
 {
 	string_list_clear(&states->new, 0);
 	string_list_clear(&states->stale, 0);
 	string_list_clear(&states->tracked, 0);
 	string_list_clear(&states->heads, 0);
+	string_list_clear_func(&states->push, clear_push_info);
 }
 
 static int append_ref_to_tracked_list(const char *refname,
@@ -693,9 +808,12 @@ static int get_remote_ref_states(const char *name,
 			get_ref_states(remote_refs, states);
 		if (query & GET_HEAD_NAMES)
 			get_head_names(remote_refs, name, states);
+		if (query & GET_PUSH_REF_STATES)
+			get_push_ref_states(remote_refs, states);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
+		get_push_ref_states_noquery(states);
 	}
 	return 0;
 }
@@ -703,7 +821,7 @@ static int get_remote_ref_states(const char *name,
 struct show_info {
 	struct string_list *list;
 	struct ref_states *states;
-	int width;
+	int width, width2;
 	int any_rebase;
 };
 
@@ -798,6 +916,58 @@ int show_local_info_item(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
+int add_push_to_show_info(struct string_list_item *push_item, void *cb_data)
+{
+	struct show_info *show_info = cb_data;
+	struct push_info *push_info = push_item->util;
+	struct string_list_item *item;
+	int n;
+	if ((n = strlen(push_item->string)) > show_info->width)
+		show_info->width = n;
+	if ((n = strlen(push_info->dest)) > show_info->width2)
+		show_info->width2 = n;
+	item = string_list_append(push_item->string, show_info->list);
+	item->util = push_item->util;
+	return 0;
+}
+
+int show_push_info_item(struct string_list_item *item, void *cb_data)
+{
+	struct show_info *show_info = cb_data;
+	struct push_info *push_info = item->util;
+	char *src = item->string, *status = NULL;
+
+	switch (push_info->status) {
+	case PUSH_STATUS_CREATE:
+		status = "create";
+		break;
+	case PUSH_STATUS_DELETE:
+		status = "delete";
+		src = "(none)";
+		break;
+	case PUSH_STATUS_UPTODATE:
+		status = "up to date";
+		break;
+	case PUSH_STATUS_FASTFORWARD:
+		status = "fast forwardable";
+		break;
+	case PUSH_STATUS_OUTOFDATE:
+		status = "local out of date";
+		break;
+	case PUSH_STATUS_NOTQUERIED:
+		break;
+	}
+	if (status)
+		printf("    %-*s %s to %-*s (%s)\n", show_info->width, src,
+			push_info->forced ? "forces" : "pushes",
+			show_info->width2, push_info->dest, status);
+	else
+		printf("    %-*s %s to %s\n", show_info->width, src,
+			push_info->forced ? "forces" : "pushes",
+			push_info->dest);
+	return 0;
+}
+
 static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0, query_flag = 0;
@@ -816,7 +986,7 @@ static int show(int argc, const char **argv)
 		return show_all();
 
 	if (!no_query)
-		query_flag = (GET_REF_STATES | GET_HEAD_NAMES);
+		query_flag = (GET_REF_STATES | GET_HEAD_NAMES | GET_PUSH_REF_STATES);
 
 	memset(&states, 0, sizeof(states));
 	memset(&info, 0, sizeof(info));
@@ -866,19 +1036,18 @@ static int show(int argc, const char **argv)
 		string_list_clear(info.list, 0);
 
 		/* git push info */
-		if (states.remote->push_refspec_nr) {
-			printf("  Local branch%s pushed with 'git push'\n",
-				states.remote->push_refspec_nr > 1 ?
-					"es" : "");
-			for (i = 0; i < states.remote->push_refspec_nr; i++) {
-				struct refspec *spec = states.remote->push + i;
-				printf("    %s%s%s%s\n",
-				       spec->force ? "+" : "",
-				       abbrev_branch(spec->src),
-				       spec->dst ? ":" : "",
-				       spec->dst ? abbrev_branch(spec->dst) : "");
-			}
-		}
+		if (states.remote->mirror)
+			printf("  Local refs will be mirrored by 'git push'\n");
+
+		info.width = info.width2 = 0;
+		for_each_string_list(add_push_to_show_info, &states.push, &info);
+		sort_string_list(info.list);
+		if (info.list->nr)
+			printf("  Local ref%s configured for 'git push'%s:\n",
+				info.list->nr > 1 ? "s" : "",
+				no_query ? " (status not queried)" : "");
+		for_each_string_list(show_push_info_item, info.list, &info);
+		string_list_clear(info.list, 0);
 
 		free_remote_ref_states(&states);
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 6dd971e..95012e7 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -141,42 +141,51 @@ cat > test/expect << EOF
     master new (next fetch will store in remotes/origin)
     side   tracked
   Local branches configured for 'git pull':
-    foo    rebases onto remote master
-    master  merges with remote master
-    oct     merges with remote topic-a
-               and with remote topic-b
-               and with remote topic-c
-  Local branches pushed with 'git push'
-    master:upstream
-    +refs/tags/lastbackup
+    ahead    merges with remote master
+    master   merges with remote master
+    octopus  merges with remote topic-a
+                and with remote topic-b
+                and with remote topic-c
+    rebase  rebases onto remote master
+  Local refs configured for 'git push':
+    master pushes to master   (local out of date)
+    master pushes to upstream (create)
 * remote two
   URL: ../two
   HEAD branch (remote HEAD is ambiguous, may be one of the following):
     another
     master
+  Local refs configured for 'git push':
+    ahead  forces to master  (fast forwardable)
+    master pushes to another (up to date)
 EOF
 
 test_expect_success 'show' '
 	(cd test &&
-	 git config --add remote.origin.fetch \
-		refs/heads/master:refs/heads/upstream &&
+	 git config --add remote.origin.fetch refs/heads/master:refs/heads/upstream &&
 	 git fetch &&
-	 git branch --track oct origin/master &&
-	 git branch --track foo origin/master &&
+	 git checkout -b ahead origin/master &&
+	 echo 1 >> file &&
+	 test_tick &&
+	 git commit -m update file &&
+	 git checkout master &&
+	 git branch --track octopus origin/master &&
+	 git branch --track rebase origin/master &&
 	 git branch -d -r origin/master &&
 	 git config --add remote.two.url ../two &&
-	 git config branch.foo.rebase true &&
-	 git config branch.oct.merge "topic-a topic-b topic-c" &&
+	 git config branch.rebase.rebase true &&
+	 git config branch.octopus.merge "topic-a topic-b topic-c" &&
 	 (cd ../one &&
 	  echo 1 > file &&
 	  test_tick &&
 	  git commit -m update file) &&
-	 git config remote.origin.push \
-		refs/heads/master:refs/heads/upstream &&
-	 git config --add remote.origin.push \
-		+refs/tags/lastbackup &&
+	 git config --add remote.origin.push : &&
+	 git config --add remote.origin.push refs/heads/master:refs/heads/upstream &&
+	 git config --add remote.origin.push +refs/tags/lastbackup &&
+	 git config --add remote.two.push +refs/heads/ahead:refs/heads/master &&
+	 git config --add remote.two.push refs/heads/master:refs/heads/another &&
 	 git remote show origin two > output &&
-	 git branch -d foo oct &&
+	 git branch -d rebase octopus &&
 	 test_cmp expect output)
 '
 
@@ -187,11 +196,13 @@ cat > test/expect << EOF
   Remote branches: (status not queried)
     master
     side
-  Local branch configured for 'git pull':
+  Local branches configured for 'git pull':
+    ahead  merges with remote master
     master merges with remote master
-  Local branches pushed with 'git push'
-    master:upstream
-    +refs/tags/lastbackup
+  Local refs configured for 'git push' (status not queried):
+    (matching)           pushes to (matching)
+    refs/heads/master    pushes to refs/heads/upstream
+    refs/tags/lastbackup forces to refs/tags/lastbackup
 EOF
 
 test_expect_success 'show -n' '
-- 
1.6.2.rc1.223.gfed32
