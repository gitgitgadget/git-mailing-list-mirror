From: Joey Hess <joey@kitenet.net>
Subject: [PATCH 3/3] add tweak-fetch hook
Date: Thu, 29 Dec 2011 21:07:20 -0400
Message-ID: <1325207240-22622-4-git-send-email-joey@kitenet.net>
References: <1325207240-22622-1-git-send-email-joey@kitenet.net>
Cc: Joey Hess <joey@kitenet.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 30 03:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgSF2-00089c-QT
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 03:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab1L3Caj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 21:30:39 -0500
Received: from wren.kitenet.net ([80.68.85.49]:54717 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab1L3CaI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 21:30:08 -0500
Received: from gnu.kitenet.net (dialup-4.153.83.252.Dial1.Atlanta1.Level3.net [4.153.83.252])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 94B861180FF;
	Thu, 29 Dec 2011 21:30:03 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 2401A46967; Thu, 29 Dec 2011 20:08:13 -0500 (EST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1325207240-22622-1-git-send-email-joey@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187793>

The tweak-fetch hook is fed lines on stdin for all refs that were fetched,
and outputs on stdout possibly modified lines. Its output is parsed and
used when git fetch updates the remote tracking refs, records the entries
in FETCH_HEAD, and produces its report.

This is implemented using the new run_hook_complex API.

Signed-off-by: Joey Hess <joey@kitenet.net>
---
 Documentation/githooks.txt |   29 +++++++++
 builtin/fetch.c            |  144 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 172 insertions(+), 1 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 28edefa..bea450a 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -162,6 +162,35 @@ This hook can be used to perform repository validity checks, auto-display
 differences from the previous HEAD if different, or set working dir metadata
 properties.
 
+tweak-fetch
+~~~~~~~~~~~
+
+This hook is invoked by 'git fetch' (commonly called by 'git pull'), after
+refs have been fetched from the remote repository. It is not executed, if
+nothing was fetched.
+
+The output of the hook is used to update the remote-tracking branches, and
+`.git/FETCH_HEAD`, in preparation for for a later merge operation done by
+'git merge'.
+
+It takes no arguments, but is fed a line of the following format on
+its standard input for each ref that was fetched.
+
+  <sha1> SP not-for-merge|merge SP <remote-refname> SP <local-refname> LF
+
+Where the "not-for-merge" flag indicates the ref is not to be merged into the
+current branch, and the "merge" flag indicates that 'git merge' should
+later merge it. The `<remote-refname>` is the remote's name for the ref
+that was fetched, and `<local-refname>` is a name of a remote-tracking branch,
+like "refs/remotes/origin/master", or can be empty if the fetched ref is not
+being stored in a local refname.
+
+The hook must consume all of its standard input, and output back lines
+of the same format. It can modify its input as desired, including
+adding or removing lines, updating the sha1 (i.e. re-point the
+remote-tracking branch), changing the merge flag, and changing the
+`<local-refname>` (i.e. use different remote-tracking branch).
+
 post-merge
 ~~~~~~~~~~
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a48358a..80178d0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -103,6 +103,148 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
+struct strbuf *tweak_fetch_hook_generator(struct hook *hook)
+{
+	struct ref *ref;
+	struct strbuf *buf = xmalloc(sizeof(struct strbuf));
+
+	strbuf_init(buf, 128);
+	for (ref = hook->data; ref; ref = ref->next)
+		strbuf_addf(buf, "%s %s %s %s\n",
+			sha1_to_hex(ref->old_sha1),
+			ref->merge ? "merge" : "not-for-merge",
+			ref->name ? ref->name : "",
+			ref->peer_ref && ref->peer_ref->name ?
+				ref->peer_ref->name : "");
+	return buf;
+}
+
+static struct ref *parse_tweak_fetch_hook_line(char *l, 
+		struct string_list *existing_refs, struct hook *hook)
+{
+	struct ref *ref = NULL, *peer_ref = NULL;
+	struct string_list_item *peer_item = NULL;
+	char *p, *words[4];
+	char *problem;
+	int i;
+
+	for (i = 0 ; i <= ARRAY_SIZE(words) - 1; i++) {
+		p = strchr(l, ' ');
+		words[i] = l;
+		if (!p)
+			break;
+		p[0] = '\0';
+		l = p+1;
+	}
+	if (i != ARRAY_SIZE(words) - 1) {
+		problem = "wrong number of words";
+		goto unparsable;
+	}
+
+	ref = alloc_ref(words[2]);
+	peer_ref = ref->peer_ref = alloc_ref(words[3]);
+	ref->peer_ref->force = 1;
+
+	if (get_sha1_hex(words[0], ref->old_sha1)) {
+		problem = "bad sha1";
+		goto unparsable;
+	}
+
+	if (!strcmp(words[1], "merge")) {
+		ref->merge = 1;
+	}
+	else if (strcmp(words[1], "not-for-merge")) {
+		problem = "bad merge flag";
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
+			hook->name, problem);
+	free(ref);
+	free(peer_ref);
+	return NULL;
+}
+
+int tweak_fetch_hook_reader(int handle, struct hook *hook)
+{
+	FILE *f;
+	struct strbuf buf;
+	struct string_list existing_refs = STRING_LIST_INIT_NODUP;
+	struct ref *old_refs, *ref, *prevref = NULL;
+	int res = 0;
+
+	f = fdopen(handle, "r");
+	if (f == NULL)
+		return 1;
+
+	old_refs = hook->data;
+	hook->data = NULL;
+
+	strbuf_init(&buf, 128);
+	for_each_ref(add_existing, &existing_refs);
+
+	while (strbuf_getline(&buf, f, '\n') != EOF) {
+		char *l = strbuf_detach(&buf, NULL);
+		ref = parse_tweak_fetch_hook_line(l, &existing_refs, hook);
+		if (ref) {
+			if (prevref) {
+				prevref->next = ref;
+				prevref = ref;
+			} else {
+				hook->data = prevref = ref;
+			}
+		} else {
+			res = 1;
+		}
+		free(l);
+	}
+
+	string_list_clear(&existing_refs, 0);
+	strbuf_release(&buf);
+	fclose(f);
+
+	if (res)
+		hook->data = old_refs;
+	else
+		free_refs(old_refs);
+
+	return res;
+}
+
+/*
+ * The tweak-fetch hook is fed lines of the form:
+ * <sha1> SP <not-for-merge|merge> SP <remote-refname> SP <local-refname> LF
+ * And should output rewritten lines of the same form, which are used
+ * to generate a tweaked set of fetched_refs.
+ */
+static struct ref *run_tweak_fetch_hook(struct ref *fetched_refs)
+{
+	struct hook hook;
+
+	if (! fetched_refs)
+		return fetched_refs;
+
+	memset(&hook, 0, sizeof(hook));
+	hook.name = "tweak-fetch";
+	hook.generator = tweak_fetch_hook_generator;
+	hook.feeder = feed_hook_in_full;
+	hook.reader = tweak_fetch_hook_reader;
+	hook.data = fetched_refs;
+
+	if (run_hook_complex(&hook)) {
+		warning("%s hook failed, ignoring its output", hook.name);
+	}
+
+	return hook.data;
+}
+
 static void unlock_pack(void)
 {
 	if (transport)
@@ -529,7 +671,7 @@ static struct refs_result fetch_refs(struct transport *transport,
 	if (res.status)
 		res.status = transport_fetch_refs(transport, ref_map);
 	if (!res.status) {
-		res.new_refs = ref_map;
+		res.new_refs = run_tweak_fetch_hook(ref_map);
 
 		res.status |= store_updated_refs(transport->url,
 				transport->remote->name,
-- 
1.7.7.3
