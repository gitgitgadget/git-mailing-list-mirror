From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 17/21] builtin-remote: teach show to display remote HEAD
Date: Wed, 25 Feb 2009 03:32:24 -0500
Message-ID: <7c45b430bb59a98a3bb0d7554e67ee549653ec30.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:36:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFFB-0000Xo-FN
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760178AbZBYIdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759862AbZBYIdX
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:23 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:34634 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbZBYIdM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:33:12 -0500
Received: by yw-out-2324.google.com with SMTP id 5so1288303ywh.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=qMc0tnTVTfgws4x7VjgDrmqrCe5t3e3zmiqy8G0L/v8=;
        b=oKQkKSkaj2ne4KhItWne1l7SmdCO1hMeVXjHo/jXjIM6fmVvSbYTx89UpckRoz9RrA
         NQ4qo4PHeJpK6x+vNUTrkUD2dmmBBxl5TwYNgiQnwlf+96lnMXjLTI3bdS/Q1FacmDa0
         0xKfKPDFPUcq/MXz5o3pRvjXPw8v+ChJAa83o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sEHpOvraNachZFOhmDVWk6ssFPJQcYexqIDiPDBL9RVxyzvBKFYIpARp+GZ8Hxn5ak
         0OJbvijHho2ng+cii4ydRQhuuH2DIRmOuE7HsSCczWppChEQudpCICvreOQX/oArNtCk
         3OeRFG6fAu9og2qmSpWVVOjHtsTk2ucTudd+s=
Received: by 10.100.96.10 with SMTP id t10mr885424anb.32.1235550789564;
        Wed, 25 Feb 2009 00:33:09 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b29sm13012300ana.31.2009.02.25.00.33.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:33:09 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111410>

This is in preparation for teaching remote how to set
refs/remotes/<remote>/HEAD to match what HEAD is set to at <remote>, but
is useful in its own right.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c  |   54 ++++++++++++++++++++++++++++++++++++++++++++++++----
 t/t5505-remote.sh |   12 +++++++++-
 2 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 963be6d..4543cf0 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -18,6 +18,9 @@ static const char * const builtin_remote_usage[] = {
 	NULL
 };
 
+#define GET_REF_STATES (1<<0)
+#define GET_HEAD_NAMES (1<<1)
+
 static int verbose;
 
 static int show_all(void);
@@ -210,7 +213,7 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct string_list new, stale, tracked;
+	struct string_list new, stale, tracked, heads;
 };
 
 static int handle_one_branch(const char *refname,
@@ -264,6 +267,28 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 	return 0;
 }
 
+static int get_head_names(const struct ref *remote_refs, struct ref_states *states)
+{
+	struct ref *ref, *matches;
+	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
+	struct refspec refspec;
+
+	refspec.force = 0;
+	refspec.pattern = 1;
+	refspec.src = refspec.dst = "refs/heads/";
+	states->heads.strdup_strings = 1;
+	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
+	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
+				    fetch_map, 1);
+	for(ref = matches; ref; ref = ref->next)
+		string_list_append(abbrev_branch(ref->name), &states->heads);
+
+	free_refs(fetch_map);
+	free_refs(matches);
+
+	return 0;
+}
+
 struct known_remote {
 	struct known_remote *next;
 	struct remote *remote;
@@ -630,6 +655,7 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear(&states->new, 0);
 	string_list_clear(&states->stale, 0);
 	string_list_clear(&states->tracked, 0);
+	string_list_clear(&states->heads, 0);
 }
 
 static int append_ref_to_tracked_list(const char *refname,
@@ -668,7 +694,10 @@ static int get_remote_ref_states(const char *name,
 		remote_refs = transport_get_remote_refs(transport);
 		transport_disconnect(transport);
 
-		get_ref_states(remote_refs, states);
+		if (query & GET_REF_STATES)
+			get_ref_states(remote_refs, states);
+		if (query & GET_HEAD_NAMES)
+			get_head_names(remote_refs, states);
 	} else {
 		for_each_ref(append_ref_to_tracked_list, states);
 		sort_string_list(&states->tracked);
@@ -679,7 +708,7 @@ static int get_remote_ref_states(const char *name,
 
 static int show(int argc, const char **argv)
 {
-	int no_query = 0, result = 0;
+	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
 		OPT_GROUP("show specific options"),
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
@@ -692,15 +721,30 @@ static int show(int argc, const char **argv)
 	if (argc < 1)
 		return show_all();
 
+	if (!no_query)
+		query_flag = (GET_REF_STATES | GET_HEAD_NAMES);
+
 	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, !no_query);
+		get_remote_ref_states(*argv, &states, query_flag);
 
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
 				states.remote->url[0] : "(no URL)");
+		if (no_query)
+			printf("  HEAD branch: (not queried)\n");
+		else if (!states.heads.nr)
+			printf("  HEAD branch: (unknown)\n");
+		else if (states.heads.nr == 1)
+			printf("  HEAD branch: %s\n", states.heads.items[0].string);
+		else {
+			printf("  HEAD branch (remote HEAD is ambiguous,"
+			       " may be one of the following):\n");
+			for (i = 0; i < states.heads.nr; i++)
+				printf("    %s\n", states.heads.items[i].string);
+		}
 
 		for (i = 0; i < branch_list.nr; i++) {
 			struct string_list_item *branch = branch_list.items + i;
@@ -772,7 +816,7 @@ static int prune(int argc, const char **argv)
 	for (; argc; argc--, argv++) {
 		int i;
 
-		get_remote_ref_states(*argv, &states, 1);
+		get_remote_ref_states(*argv, &states, GET_REF_STATES);
 
 		if (states.stale.nr) {
 			printf("Pruning %s\n", *argv);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index a13d4b6..91525c3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -136,6 +136,7 @@ EOF
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one
+  HEAD branch: master
   Remote branch merged with 'git pull' while on branch master
     master
   New remote branch (next fetch will store in remotes/origin)
@@ -146,6 +147,11 @@ cat > test/expect << EOF
   Local branches pushed with 'git push'
     master:upstream
     +refs/tags/lastbackup
+* remote two
+  URL: ../two
+  HEAD branch (remote HEAD is ambiguous, may be one of the following):
+    another
+    master
 EOF
 
 test_expect_success 'show' '
@@ -154,6 +160,7 @@ test_expect_success 'show' '
 		refs/heads/master:refs/heads/upstream &&
 	 git fetch &&
 	 git branch -d -r origin/master &&
+	 git config --add remote.two.url ../two &&
 	 (cd ../one &&
 	  echo 1 > file &&
 	  test_tick &&
@@ -162,13 +169,14 @@ test_expect_success 'show' '
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
@@ -343,7 +351,7 @@ test_expect_success '"remote show" does not show symbolic refs' '
 	git clone one three &&
 	(cd three &&
 	 git remote show origin > output &&
-	 ! grep HEAD < output &&
+	 ! grep "^ *HEAD$" < output &&
 	 ! grep -i stale < output)
 
 '
-- 
1.6.2.rc1.291.g83eb
