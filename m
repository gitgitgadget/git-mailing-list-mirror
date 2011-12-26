From: Joey Hess <joey@kitenet.net>
Subject: [PATCH] add post-fetch hook
Date: Sun, 25 Dec 2011 22:31:54 -0400
Message-ID: <20111226023154.GA3243@gnu.kitenet.net>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 26 03:32:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rf0MZ-0003Jg-Dj
	for gcvg-git-2@lo.gmane.org; Mon, 26 Dec 2011 03:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601Ab1LZCcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 21:32:07 -0500
Received: from wren.kitenet.net ([80.68.85.49]:34922 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558Ab1LZCcF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 21:32:05 -0500
Received: from gnu.kitenet.net (dialup-4.152.246.12.Dial1.Atlanta1.Level3.net [4.152.246.12])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 8ACCD1180BA;
	Sun, 25 Dec 2011 21:32:00 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 0B0534499E; Sun, 25 Dec 2011 21:31:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsjk99exw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187691>

The post-fetch hook is fed lines on stdin for all refs that were fetched, and
outputs on stdout possibly modified lines. Its output is parsed and used
when git fetch updates the remote tracking refs, records the entries in
FETCH_HEAD, and produces its report.

---

Not quite ready to sign off on this yet, but it does work.
Comments and code review appreciated.

Demo:

joey@gnu:~/tmp/demo>cat .git/hooks/post-fetch
#!/bin/sh
# Rename branches, and block all tags.
sed 's!foo!bar!g' | grep -v refs/tags/
joey@gnu:~/tmp/demo>chmod +x .git/hooks/post-fetch
joey@gnu:~/tmp/demo>git pull
From /home/joey/tmp/a
 * [new branch]      bar        -> origin/bar
Already up-to-date.
joey@gnu:~/tmp/demo>chmod -x .git/hooks/post-fetch
joey@gnu:~/tmp/demo>git pull
From /home/joey/tmp/a
 * [new branch]      foo        -> origin/foo
 * [new tag]         v1.0       -> v1.0
Already up-to-date.
joey@gnu:~/tmp/demo>chmod +x .git/hooks/post-fetch
joey@gnu:~/tmp/demo>git remote update --prune
Fetching origin
 x [deleted]         (none)     -> origin/foo


 Documentation/githooks.txt |   29 ++++++
 builtin/fetch.c            |  228 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 238 insertions(+), 19 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 28edefa..9c2b6bf 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -162,6 +162,35 @@ This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
 
+post-fetch
+~~~~~~~~~~
+
+This hook is invoked by 'git fetch' (commonly called by 'git pull'), after
+refs have been fetched from the remote repository. It is not executed, if
+nothing was fetched.
+
+It takes no arguments, but is fed a line of the following format on
+its standard input for each ref that was fetched.
+
+  <sha1> SP not-for-merge|merge SP <remote-refname> SP <local-refname> LF
+
+Where the "not-for-merge" flag indicates the ref is not to be merged into the
+current branch, and the "merge" flag indicates that 'git merge' should
+later merge it. The `<remote-refname>` is the remote's name for the ref
+that was pulled, and `<local-refname>` is a name of a remote-tracking branch,
+like "refs/remotes/origin/master", or can be empty if the fetched ref is not
+being stored in a local refname.
+
+The hook must consume all of its standard input, and output back lines
+of the same format. It can modify its input as desired, including
+adding or removing lines, updating the sha1 (i.e. re-point the
+remote-tracking branch), changing the merge flag, and changing the
+`<local-refname>` (i.e. use different remote-tracking branch).
+
+The output of the hook is used to update the remote-tracking branches, and
+`.git/FETCH_HEAD`, in preparation for for a later merge operation done by
+'git merge'.
+
 post-merge
 ~~~~~~~~~~
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..aa401b2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -89,6 +89,188 @@ static struct option builtin_fetch_options[] = {
 	OPT_END()
 };
 
+static int add_existing(const char *refname, const unsigned char *sha1,
+			int flag, void *cbdata)
+{
+	struct string_list *list = (struct string_list *)cbdata;
+	struct string_list_item *item = string_list_insert(list, refname);
+	item->util = (void *)sha1;
+	return 0;
+}
+	
+static const char post_fetch_hook[] = "post-fetch";
+struct ref *post_fetch_hook_refs;
+
+int feed_post_fetch_hook (int in, int out, void *data)
+{
+	struct ref *ref;
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
+	for (ref = post_fetch_hook_refs; ref; ref = ref->next) {
+		strbuf_addstr(&buf, sha1_to_hex(ref->old_sha1));
+		strbuf_addch(&buf, ' ');
+		strbuf_addstr(&buf, ref->merge ? "merge" : "not-for-merge");
+		strbuf_addch(&buf, ' ');
+		if (ref->name)
+			strbuf_addstr(&buf, ref->name);
+		strbuf_addch(&buf, ' ');
+		if (ref->peer_ref && ref->peer_ref->name)
+			strbuf_addstr(&buf, ref->peer_ref->name);
+		strbuf_addch(&buf, '\n');
+	}
+
+	ret = write_in_full(out, buf.buf, buf.len) != buf.len;
+	if (ret)
+		warning("%s hook failed to consume all its input",
+				post_fetch_hook);
+	close(out);
+	strbuf_release(&buf);
+	return ret;
+}
+	
+struct ref *parse_post_fetch_hook_line (char *l, 
+		struct string_list *existing_refs)
+{
+	struct ref *ref = NULL, *peer_ref = NULL;
+	struct string_list_item *peer_item = NULL;
+	char *words[4];
+	int i, word=0;
+	char *problem;
+
+	for (i=0; l[i]; i++) {
+		if (isspace(l[i])) {
+			l[i]='\0';
+			words[word]=l;
+			l+=i+1;
+			i=0;
+			word++;
+			if (word > 3) {
+				problem="too many words";
+				goto unparsable;
+			}
+		}
+	}
+	if (word < 3) {
+		problem="not enough words";
+		goto unparsable;
+	}
+	
+	ref = alloc_ref(words[2]);
+	peer_ref = ref->peer_ref = alloc_ref(l);
+	ref->peer_ref->force=1;
+
+	if (get_sha1_hex(words[0], ref->old_sha1)) {
+		problem="bad sha1";
+		goto unparsable;
+	}
+
+	if (strcmp(words[1], "merge") == 0) {
+		ref->merge=1;
+	}
+	else if (strcmp(words[1], "not-for-merge") != 0) {
+		problem="bad merge flag";
+		goto unparsable;
+	}
+
+	peer_item = string_list_lookup(existing_refs, peer_ref->name);
+	if (peer_item)
+		hashcpy(peer_ref->old_sha1, peer_item->util);
+
+	return ref;
+
+ unparsable:
+	warning("%s hook output a wrongly formed line: %s",
+			post_fetch_hook, problem);
+	free(ref);
+	free(peer_ref);
+	return NULL;
+}
+
+/* The hook is fed lines of the form:
+ * <sha1> SP <not-for-merge|merge> SP <remote-refname> SP <local-refname> LF
+ * And should output rewritten lines of the same form.
+ */
+struct ref *run_post_fetch_hook (struct ref *fetched_refs)
+{
+	struct ref *new_refs = NULL;
+	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	struct child_process hook;
+	struct async async;
+	const char *argv[2];
+	FILE *f;
+	struct strbuf buf;
+	struct ref *ref, *prevref=NULL;
+	int ok = 1;
+
+	if (! fetched_refs)
+		return fetched_refs;
+
+	argv[0] = git_path("hooks/%s", post_fetch_hook);
+	if (access(argv[0], X_OK) < 0)
+		return fetched_refs;
+	argv[1] = NULL;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.argv = argv;
+	hook.in = -1;
+	hook.out = -1;
+	if (start_command(&hook) != 0)
+		return fetched_refs;
+
+	/* Use an async writer to feed the hook process.
+	 * This allows the hook to read and write a line at
+	 * a time without blocking. */
+	memset(&async, 0, sizeof(async));
+	async.proc = feed_post_fetch_hook;
+	post_fetch_hook_refs = fetched_refs;
+	async.out = hook.in;
+	if (start_async(&async))
+		goto failed_hook;
+
+	for_each_ref(add_existing, &existing_refs);
+
+	f = fdopen(hook.out, "r");
+	if (f == NULL)
+		goto failed_hook;
+	strbuf_init(&buf, 128);
+	while (strbuf_getline(&buf, f, '\n') != EOF) {
+		char *l = strbuf_detach(&buf, NULL);
+		ref = parse_post_fetch_hook_line(l, &existing_refs);
+		if (ref) {
+			if (prevref) {
+				prevref->next=ref;
+				prevref=ref;
+			}
+			else {
+				new_refs = prevref = ref;
+			}
+		}
+		else {
+			ok = 0; /* ignore the other output */
+		}
+		free(l);
+	}
+	strbuf_release(&buf);
+	fclose(f);
+
+	if (finish_async(&async))
+		goto failed_hook;
+	finish_command(&hook);
+
+	if (! ok)
+		return fetched_refs;
+	/* The new_refs are returned, to be used in place of fetched_refs,
+	 * so it is not needed anymore and can be freed here. */
+	free_refs(fetched_refs);
+	return new_refs;
+
+failed_hook:
+	close(hook.out);
+	finish_command(&hook);
+	return fetched_refs;
+}
+
 static void unlock_pack(void)
 {
 	if (transport)
@@ -507,17 +689,30 @@ static int quickfetch(struct ref *ref_map)
 	return check_everything_connected(iterate_ref_map, 1, &rm);
 }
 
-static int fetch_refs(struct transport *transport, struct ref *ref_map)
+struct fetch_refs_result {
+	struct ref *new_refs;
+	int status;
+};
+
+static struct fetch_refs_result fetch_refs(struct transport *transport,
+		struct ref *ref_map)
 {
-	int ret = quickfetch(ref_map);
-	if (ret)
-		ret = transport_fetch_refs(transport, ref_map);
-	if (!ret)
-		ret |= store_updated_refs(transport->url,
+	struct fetch_refs_result res;
+	res.status = quickfetch(ref_map);
+	if (res.status)
+		res.status = transport_fetch_refs(transport, ref_map);
+	if (!res.status) {
+		res.new_refs = run_post_fetch_hook(ref_map);
+
+		res.status |= store_updated_refs(transport->url,
 				transport->remote->name,
-				ref_map);
+				res.new_refs);
+	}
+	else {
+		res.new_refs = ref_map;
+	}
 	transport_unlock_pack(transport);
-	return ret;
+	return res;
 }
 
 static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
@@ -542,15 +737,6 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
 	return result;
 }
 
-static int add_existing(const char *refname, const unsigned char *sha1,
-			int flag, void *cbdata)
-{
-	struct string_list *list = (struct string_list *)cbdata;
-	struct string_list_item *item = string_list_insert(list, refname);
-	item->util = (void *)sha1;
-	return 0;
-}
-
 static int will_fetch(struct ref **head, const unsigned char *sha1)
 {
 	struct ref *rm = *head;
@@ -673,6 +859,7 @@ static int do_fetch(struct transport *transport,
 	struct string_list_item *peer_item = NULL;
 	struct ref *ref_map;
 	struct ref *rm;
+	struct fetch_refs_result res;
 	int autotags = (transport->remote->fetch_tags == 1);
 
 	for_each_ref(add_existing, &existing_refs);
@@ -710,7 +897,9 @@ static int do_fetch(struct transport *transport,
 
 	if (tags == TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
-	if (fetch_refs(transport, ref_map)) {
+	res = fetch_refs(transport, ref_map);
+	ref_map = res.new_refs;
+	if (res.status) {
 		free_refs(ref_map);
 		return 1;
 	}
@@ -750,7 +939,8 @@ static int do_fetch(struct transport *transport,
 		if (ref_map) {
 			transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
-			fetch_refs(transport, ref_map);
+			res = fetch_refs(transport, ref_map);
+			ref_map = res.new_refs;
 		}
 		free_refs(ref_map);
 	}

-- 
1.7.7.3
