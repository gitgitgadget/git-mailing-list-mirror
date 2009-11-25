From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 2/4] fetch: try mirrors if selected
Date: Wed, 25 Nov 2009 23:06:55 +1300
Message-ID: <1259143617-26580-3-git-send-email-sam@vilain.net>
References: <1259143617-26580-1-git-send-email-sam@vilain.net>
 <1259143617-26580-2-git-send-email-sam@vilain.net>
Cc: Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 11:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDF3i-0006j3-0M
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:25:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934241AbZKYKYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758580AbZKYKYp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:24:45 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51586 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758447AbZKYKYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:24:37 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id EFF8721C3A8; Wed, 25 Nov 2009 23:07:18 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id A0B2521C39A;
	Wed, 25 Nov 2009 23:06:59 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NDEmF-0006vO-Ox; Wed, 25 Nov 2009 23:07:11 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1259143617-26580-2-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133630>

If configured and selected, the mirrors are tried in turn until one
succeeds, re-writing the refs to a refs/mirrors/<remote>/<hostname>/ space.
No refs from the mirrors are ever written to the real refs/heads or
refs/tags spaces, but their being available locally will speed up fetching
from the real remote if they are more up to date than the local version.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 builtin-fetch.c         |  161 ++++++++++++++++++++++++++++++++++++++++++++--
 remote.c                |   14 ++++-
 remote.h                |    1 +
 t/t5560-mirror-fetch.sh |   46 +++++++++++++
 transport.c             |   41 ++++++++++++
 transport.h             |    5 ++
 6 files changed, 260 insertions(+), 8 deletions(-)
 create mode 100644 t/t5560-mirror-fetch.sh

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 209f502..b3b8766 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -45,8 +45,8 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
-	OPT_BOOLEAN('M', "mirror", &use_mirror,
-		    "use mirror if available"),
+	OPT_SET_INT('M', "use-mirror", &use_mirror,
+		    "use mirror if available", 1),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
 	OPT_END()
@@ -109,6 +109,109 @@ static void find_non_local_tags(struct transport *transport,
 			struct ref **head,
 			struct ref ***tail);
 
+char* get_url_hostname(const char *url)
+{
+	char *scratch = xstrdup(url);
+	char *host = strstr(url, "://");
+	char c;
+	char *end, *rh;
+	if (host) {
+		host += 3;
+		c = '/';
+	}
+	else {
+		host = scratch;
+		c = ':';
+	}
+
+	if (host[0] == '[') {
+		end = strchr(host + 1, ']');
+		if (end) {
+			*end = 0;
+			host++;
+		}
+	}
+	else {
+		end = strchr(host, c);
+		if (end && !has_dos_drive_prefix(url) ) {
+			*end = 0;
+		}
+		else {
+			host = "localhost";
+		}
+	}
+	rh = xstrdup(host);
+	free(scratch);
+	return rh;
+}
+
+const char *mirror_ref(const char* remote_name, const char* mirror_hostname,
+		       const char* refname)
+{
+	int has_refs, new_sz;
+	char *rv, *dst;
+
+	// *rs[i] = *refspec[i];  ?
+	has_refs = ( strstr(refname, "refs/") == refname );
+	/* "refs/"(0 or 5) "mirrors/"(8) remote "/"(1) hostname "/"(1) */
+	new_sz = (has_refs ? 0 : 5) + 8
+		+ strlen(remote_name) + 1
+		+ strlen(mirror_hostname) + 1
+		+ strlen(refname) + 1;
+	rv = xmalloc( new_sz );
+	strcpy(rv, "refs/mirrors/");
+	dst = rv + 13;
+	strcpy(dst, remote_name);
+	dst += strlen(remote_name);
+	*dst++ = '/';
+	strcpy(dst, mirror_hostname);
+	dst += strlen(mirror_hostname);
+	*dst++ = '/';
+	strcpy(dst, refname+(has_refs?5:0));
+	return rv;
+}
+
+struct ref *mirror_refmap(struct transport* transport,
+			  struct ref* ref_map)
+{
+	struct ref *rm, *mirror_refmap, *last, *rv, *peer_ref;
+
+	const char* remote_name = transport->remote->name;
+	const char* mirror_hostname = get_url_hostname(transport->url);
+	int c = 0;
+
+	last = NULL;
+	rv = NULL;
+	for (rm = ref_map; rm; rm = rm->next) {
+		const char *new_dst;
+
+		// skip refs we already have locally, to avoid ref churn
+		if (has_sha1_file(rm->old_sha1))
+			continue;
+
+		mirror_refmap = alloc_ref(rm->name);
+		mirror_refmap->remote_status = rm->remote_status;
+		hashcpy(mirror_refmap->old_sha1, rm->old_sha1);
+		hashcpy(mirror_refmap->new_sha1, rm->new_sha1);
+
+		if (last)
+			last->next = mirror_refmap;
+		else
+			rv = mirror_refmap;
+		c++;
+
+		new_dst = mirror_ref(remote_name, mirror_hostname, rm->name);
+
+		peer_ref = alloc_ref(new_dst);
+		mirror_refmap->peer_ref = peer_ref;
+		peer_ref->force = 1;
+		last = mirror_refmap;
+	}
+
+	return rv;
+}
+
+
 static struct ref *get_ref_map(struct transport *transport,
 			       struct refspec *refs, int ref_count, int tags,
 			       int *autotags)
@@ -165,10 +268,14 @@ static struct ref *get_ref_map(struct transport *transport,
 	if (tags == TAGS_DEFAULT && *autotags)
 		find_non_local_tags(transport, &ref_map, &tail);
 	ref_remove_duplicates(ref_map);
+	if (strcmp(transport->url, transport->remote->url[0]) != 0) {
+		return mirror_refmap(transport, ref_map);
+	}
 
 	return ref_map;
 }
 
+
 #define STORE_REF_ERROR_OTHER 1
 #define STORE_REF_ERROR_DF_CONFLICT 2
 
@@ -638,6 +745,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+
 	if (!update_head_ok)
 		check_not_current_branch(ref_map);
 
@@ -688,13 +796,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	int i;
 	static const char **refs = NULL;
 	int ref_nr = 0;
-	int exit_code;
+	int exit_code = 0;
+	int urls_remaining = 1;
+	struct transport *real_transport = NULL;
+	const char *mirror = NULL;
+	struct refspec *refspec;
 
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
 	for (i = 1; i < argc; i++)
 		strbuf_addf(&default_rla, " %s", argv[i]);
 
+	use_mirror = -1;
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
@@ -706,6 +819,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!remote)
 		die("Where do you want to fetch from today?");
 
+	if (use_mirror == -1) {
+		use_mirror = remote->use_mirror ? 1 : 0;
+	}
+
 	transport = transport_get(remote, remote->url[0]);
 	if (verbosity >= 2)
 		transport->verbose = 1;
@@ -742,9 +859,39 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	sigchain_push_common(unlock_pack_on_signal);
 	atexit(unlock_pack);
-	exit_code = do_fetch(transport,
-			parse_fetch_refspec(ref_nr, refs), ref_nr);
-	transport_disconnect(transport);
-	transport = NULL;
+	refspec = parse_fetch_refspec(ref_nr, refs);
+	if (use_mirror) {
+		real_transport = transport;
+		urls_remaining = remote->mirror_url_nr + 1;
+	}
+	while (urls_remaining) {
+		if (use_mirror && (urls_remaining > 1) ) {
+			transport = transport_next_mirror(real_transport, mirror);
+			mirror = transport->url;
+			warning("trying mirror: %s", mirror);
+			// real_transport may not have these options - re-set them.
+			if (upload_pack)
+				set_option(TRANS_OPT_UPLOADPACK, upload_pack);
+			if (keep)
+				set_option(TRANS_OPT_KEEP, "yes");
+			if (depth)
+				set_option(TRANS_OPT_DEPTH, depth);
+
+		}
+		exit_code = do_fetch(transport, refspec, ref_nr);
+		transport_disconnect(transport);
+		transport = NULL;
+		urls_remaining--;
+		if (use_mirror) {
+			if (!exit_code && urls_remaining >= 1) {
+				warning("successful fetch from mirror");
+				urls_remaining = 1;
+			}
+			if (urls_remaining == 1) {
+				transport = real_transport;
+				warning("trying master: %s", transport->url);
+			}
+		}
+	}
 	return exit_code;
 }
diff --git a/remote.c b/remote.c
index 65df03d..5f08e10 100644
--- a/remote.c
+++ b/remote.c
@@ -139,8 +139,9 @@ static struct remote *make_remote(const char *name, int len)
 	for (i = 0; i < remotes_nr; i++) {
 		if (len ? (!strncmp(name, remotes[i]->name, len) &&
 			   !remotes[i]->name[len]) :
-		    !strcmp(name, remotes[i]->name))
+		    !strcmp(name, remotes[i]->name)) {
 			return remotes[i];
+		}
 	}
 
 	ret = xcalloc(1, sizeof(struct remote));
@@ -683,6 +684,7 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
 
+
 static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
@@ -786,6 +788,16 @@ int remote_has_url(struct remote *remote, const char *url)
 	return 0;
 }
 
+int remote_mirror_idx(struct remote *remote, const char *mirror_url)
+{
+	int i;
+	for (i = 0; i < remote->mirror_url_nr; i++) {
+		if (!strcmp(remote->mirror_url[i], mirror_url))
+			return i;
+	}
+	return -1;
+}
+
 static int match_name_with_pattern(const char *key, const char *name,
 				   const char *value, char **result)
 {
diff --git a/remote.h b/remote.h
index c720b9a..da208ff 100644
--- a/remote.h
+++ b/remote.h
@@ -61,6 +61,7 @@ typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
 
 int remote_has_url(struct remote *remote, const char *url);
+int remote_mirror_idx(struct remote *remote, const char *mirror_url);
 
 struct refspec {
 	unsigned force : 1;
diff --git a/t/t5560-mirror-fetch.sh b/t/t5560-mirror-fetch.sh
new file mode 100644
index 0000000..940dc0e
--- /dev/null
+++ b/t/t5560-mirror-fetch.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Sam Vilain
+#
+
+test_description='mirror fetch test'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo >file master initial &&
+	git add file &&
+	git commit -a -m "Master initial" &&
+	git clone . master &&
+	git clone master mirror &&
+	cd master &&
+	echo >file master update &&
+	git commit -a -m "Master update" &&
+	cd .. &&
+	mkdir clone &&
+	cd clone &&
+	git init &&
+	git remote add origin ../master &&
+	git config remote.origin.mirror-url ../mirror
+'
+
+# in later iterations we'll expect these mirror tracking refs to be
+# cleaned up once they are confirmed reachable from the master, but
+# for now they leave a sufficient breadcrumb of the operation
+
+test_expect_success 'fetch using mirror - explicit' '
+	git fetch --use-mirror origin refs/heads/*:refs/remotes/origin/* &&
+	git rev-parse refs/mirrors/origin/localhost/heads/master
+'
+
+test_expect_success 'fetch using mirror - default' '
+	cd .. &&
+	mkdir clone2 &&
+	cd clone2 &&
+	git init &&
+	git remote add origin ../master &&
+	git config remote.origin.mirror-url ../mirror
+	git fetch --use-mirror &&
+	git rev-parse refs/mirrors/origin/localhost/heads/master
+'
+test_done
diff --git a/transport.c b/transport.c
index 644a30a..0dc0185 100644
--- a/transport.c
+++ b/transport.c
@@ -859,6 +859,47 @@ struct transport *transport_get(struct remote *remote, const char *url)
 	return ret;
 }
 
+struct transport *transport_next_mirror(struct transport *transport,
+					const char *last_mirror)
+{
+	struct transport *ret;
+	struct remote* remote = transport->remote;
+	int mirror_idx = -1;
+	const char* url;
+
+	if (!last_mirror) {
+		if (remote->preferred_mirror) {
+			mirror_idx = remote_mirror_idx(
+				remote,
+				remote->preferred_mirror
+				);
+			if (mirror_idx == -1) {
+				warning("preferred mirror '%s' not listed "
+					"in remote.%s.mirror-url",
+					remote->preferred_mirror,
+					remote->name);
+			}
+		}
+		else {
+			mirror_idx = 0;
+		}
+	}
+	else {
+		mirror_idx = remote_mirror_idx(remote, last_mirror) + 1;
+		// caller must check that we are not looping indefinitely
+		mirror_idx %= remote->mirror_url_nr;
+	}
+
+	url = remote->mirror_url[mirror_idx];
+	ret = transport_get(remote, url);
+
+	// copy settings - caller must re-set options
+	ret->verbose = transport->verbose;
+	ret->progress = transport->progress;
+
+	return ret;
+}
+
 int transport_set_option(struct transport *transport,
 			 const char *name, const char *value)
 {
diff --git a/transport.h b/transport.h
index c14da6f..9890157 100644
--- a/transport.h
+++ b/transport.h
@@ -41,6 +41,9 @@ struct transport {
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
 
+/* Returns a transport for a mirror */
+struct transport *transport_next_mirror(struct transport *transport, const char *last_mirror);
+
 /* Transport options which apply to git:// and scp-style URLs */
 
 /* The program to use on the remote side to send a pack */
@@ -78,6 +81,8 @@ int transport_fetch_refs(struct transport *transport, const struct ref *refs);
 void transport_unlock_pack(struct transport *transport);
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
+struct refspec *mirror_refspec(struct transport* transport,
+			       struct refspec *refspec, int refspec_nr);
 
 /* Transport methods defined outside transport.c */
 int transport_helper_init(struct transport *transport, const char *name);
-- 
1.6.3.3
