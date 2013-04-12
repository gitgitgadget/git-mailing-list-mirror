From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [RFC/PATCH] push: introduce implicit push
Date: Fri, 12 Apr 2013 21:03:55 +0530
Message-ID: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 12 17:32:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQfy0-0002IM-9l
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 17:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061Ab3DLPcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 11:32:39 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:34663 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab3DLPci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 11:32:38 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so1193546dan.19
        for <git@vger.kernel.org>; Fri, 12 Apr 2013 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=fyAcN7VIZCon7S5EJt9o4xGSO+SCGlyxv+ciGQ4IiPs=;
        b=N9CaIlJt0R4mMl+iVQy3xAXjae+ARgGY7s0a/0yteoM6Xl3zozJDgPECOqIlJKQW4D
         M00+7FmgdB3OWd+pMT/6DGhV3AuMdLd93NEvoNcEbv58tBwQHkKLLcJyupdhjhFXe81u
         TrDRmHSdnroyuYO3qHmcsFkUq6bxGAWBZyQBWRM97L7wUDPwk2DZwWb4vVcMYqLzko8C
         c5dNegCXB0soek9le+eS8dFTtEv4tr4oovj3ZEcQamuanhQ2SuLeGSDN9HQSdHRPOp8z
         84i6sQTqNKz6OkghpacP3YRWzxCKrnGiHN1FAmTOq51w1k/J+seMinkNv/J57RcPhGxU
         kI4w==
X-Received: by 10.66.221.37 with SMTP id qb5mr16170967pac.75.1365780756914;
        Fri, 12 Apr 2013 08:32:36 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id dg5sm8968487pbc.29.2013.04.12.08.32.33
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 08:32:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.340.g945b0ee.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220986>

Currently, there is no way to invoke 'git push' without explicitly
specifying the destination to push to as the first argument.  When
pushing several branches, this information is often available in
branch.<name>.pushremote, falling back to branch.<name>.remote.  So,
we can use this information to create a more pleasant push experience.
You can now do:

    $ git push master next pu

If the branches master, next, and pu have different remotes, do_push()
will be executed three times on the three different remotes.

NOTE:

Pushing a non-branch ref still uses the current branch's
configuration, and this is wrong.  We need to find a way to fix
remote_get_1() without breaking existing features.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 This is a very rough patch, meant to illustrate how to build our
 implicit push feature.  I think it's a really good idea, and will
 polish the patch after I get feedback.

 builtin/push.c | 56 ++++++++++++++++++++++++++++++++++--
 remote.c       | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h       |  9 ++++++
 3 files changed, 152 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 909c34d..e8b667c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -26,6 +26,12 @@ static int refspec_nr;
 static int refspec_alloc;
 static int default_matching_used;
 
+static void reset_refspecs()
+{
+	refspec_nr = 0;
+	refspec_alloc = 0;
+}
+
 static void add_refspec(const char *ref)
 {
 	refspec_nr++;
@@ -277,6 +283,11 @@ static void advise_ref_needs_force(void)
 	advise(_(message_advice_ref_needs_force));
 }
 
+static int is_possible_refspec(const char *name) {
+	/* TODO: check that name looks like a refspec */
+	return !is_configured_remote(name) && !strstr(name, "://");
+}
+
 static int push_with_options(struct transport *transport, int flags)
 {
 	int err;
@@ -319,10 +330,9 @@ static int push_with_options(struct transport *transport, int flags)
 	return 1;
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(const char *repo, struct remote *remote, int flags)
 {
 	int i, errs;
-	struct remote *remote = pushremote_get(repo);
 	const char **url;
 	int url_nr;
 
@@ -414,6 +424,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
+	struct remote *remote;
+
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
 		OPT_STRING( 0 , "repo", &repo, N_("repository"), N_("repository")),
@@ -455,11 +467,49 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		add_refspec("refs/tags/*");
 
 	if (argc > 0) {
+		if (!strcmp(argv[0], "--") || is_possible_refspec(argv[0])) {
+			struct refspec_with_remote *refspec_remotes;
+			int i, pushtimes;
+
+			/* Attempt to fetch remotes for each refspec */
+			if (!strcmp(argv[0], "--"))
+				set_refspecs(argv + 1, argc - 1);
+			else
+				set_refspecs(argv, argc);
+			refspec_remotes = pushremote_get_for_refspec(refspec_nr,
+								refspec);
+			if (!refspec_remotes)
+				die(_("internal error: refspec_remotes() returned NULL"));
+
+			/* TODO: collect the refspecs for each
+			 * remote and batch the do_push() for
+			 * each remote
+			 */
+			for (i = 0, pushtimes = refspec_nr; i < pushtimes; i++) {
+				struct strbuf sb = STRBUF_INIT;
+
+				/* TODO: clean up this nonsense */
+				if (refspec_remotes[i].refspec->dst)
+					strbuf_addf(&sb, "%s:%s",
+						refspec_remotes[i].refspec->src,
+						refspec_remotes[i].refspec->dst);
+				else
+					strbuf_addf(&sb, "%s",
+						refspec_remotes[i].refspec->src);
+				reset_refspecs();
+				set_refspecs((const char **) &sb.buf, 1);
+				rc = do_push(NULL, refspec_remotes[i].remote, flags);
+				if (rc == -1)
+					usage_with_options(push_usage, options);
+			}
+			return rc;
+		}
 		repo = argv[0];
+		remote = pushremote_get(repo);
 		set_refspecs(argv + 1, argc - 1);
 	}
 
-	rc = do_push(repo, flags);
+	rc = do_push(repo, remote, flags);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/remote.c b/remote.c
index 68eb99b..b51ac9b 100644
--- a/remote.c
+++ b/remote.c
@@ -50,6 +50,7 @@ static int branches_nr;
 static struct branch *current_branch;
 static const char *default_remote_name;
 static const char *pushremote_name;
+static const char *pushremote_for_branch;
 static int explicit_default_remote_name;
 
 static struct rewrites rewrites;
@@ -345,6 +346,36 @@ static void read_branches_file(struct remote *remote)
 	remote->fetch_tags = 1; /* always auto-follow */
 }
 
+static int branch_config(const char *key, const char *value, void *data)
+{
+	const char *name;
+	const char *subkey;
+	struct branch *branch;
+	struct branch *this_branch;
+
+	if (!data)
+		return -1;
+	this_branch = (struct branch *) data;
+
+	if (!prefixcmp(key, "branch.")) {
+		name = key + 7;
+		subkey = strrchr(name, '.');
+		if (!subkey)
+			return 0;
+		branch = make_branch(name, subkey - name);
+		if (!strcmp(subkey, ".remote")) {
+			if (branch == this_branch &&
+				git_config_string(&pushremote_for_branch, key, value))
+				return -1;
+		} else if (!strcmp(subkey, ".pushremote")) {
+			if (branch == this_branch &&
+				git_config_string(&pushremote_for_branch, key, value))
+				return -1;
+		}
+	}
+	return 0;
+}
+
 static int handle_config(const char *key, const char *value, void *cb)
 {
 	const char *name;
@@ -682,6 +713,12 @@ static int valid_remote_nick(const char *name)
 	return !strchr(name, '/'); /* no slash */
 }
 
+int is_configured_remote(const char *name)
+{
+	read_config();
+	return valid_remote(make_remote(name, 0));
+}
+
 static struct remote *remote_get_1(const char *name, const char *pushremote_name)
 {
 	struct remote *ret;
@@ -727,6 +764,59 @@ struct remote *pushremote_get(const char *name)
 	return remote_get_1(name, pushremote_name);
 }
 
+struct refspec_with_remote *pushremote_get_for_refspec(int refspec_nr,
+						const char **refspec)
+{
+	struct refspec_with_remote *ret;
+	struct refspec *refspecs;
+	unsigned char sha1[20];
+	int i;
+
+	read_config();
+	ret = xcalloc(sizeof(struct refspec_with_remote), refspec_nr);
+	refspecs = parse_push_refspec(refspec_nr, refspec);
+
+	for (i = 0; i < refspec_nr; i++) {
+		const char *src, *dst;
+		struct remote *remote;
+
+		src = resolve_ref_unsafe(refspecs[i].src, sha1, 0, NULL);
+		if (prefixcmp(src, "refs/"))
+			src = resolve_ref_unsafe(mkpath("refs/heads/%s", src),
+						sha1, 1, NULL);
+		if (refspecs[i].dst) {
+			dst = resolve_ref_unsafe(refspecs[i].dst, sha1, 1, NULL);
+			if (prefixcmp(dst, "refs/"))
+				dst = resolve_ref_unsafe(mkpath("refs/heads/%s", dst),
+							sha1, 1, NULL);
+		}
+		if (!src || (refspecs[i].dst && !dst)) {
+			remote = pushremote_get(NULL);
+		} else {
+			struct branch *branch;
+
+			branch = make_branch(src + strlen("refs/heads/"), 0);
+			git_config(branch_config, branch);
+			if (!pushremote_for_branch)
+				die(_("Branch %s does not have a valid configured "
+						"pushremote or remote"), branch->name);
+
+			/* Prepare the remote */
+			remote = make_remote(pushremote_for_branch, 0);
+			if (!valid_remote(remote))
+				die(_("Branch %s has an invalid remote configured: %s"),
+					branch->name, remote->name);
+			remote->fetch = parse_fetch_refspec(remote->fetch_refspec_nr,
+							remote->fetch_refspec);
+			remote->push = parse_push_refspec(remote->push_refspec_nr,
+							remote->push_refspec);
+		}
+		ret[i].refspec = &refspecs[i];
+		ret[i].remote = remote;
+	}
+	return ret;
+}
+
 int remote_is_configured(const char *name)
 {
 	int i;
diff --git a/remote.h b/remote.h
index cf56724..e39cf1b 100644
--- a/remote.h
+++ b/remote.h
@@ -52,12 +52,15 @@ struct remote {
 
 struct remote *remote_get(const char *name);
 struct remote *pushremote_get(const char *name);
+struct refspec_with_remote *pushremote_get_for_refspec(int nr_refspec,
+						const char **refspec);
 int remote_is_configured(const char *name);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
 
 int remote_has_url(struct remote *remote, const char *url);
+int is_configured_remote(const char *name);
 
 struct refspec {
 	unsigned force : 1;
@@ -69,6 +72,12 @@ struct refspec {
 	char *dst;
 };
 
+struct refspec_with_remote {
+	struct refspec *refspec;
+	struct remote *remote;
+	int collected:1;
+};
+
 extern const struct refspec *tag_refspec;
 
 struct ref *alloc_ref(const char *name);
-- 
1.8.2.1.340.g945b0ee.dirty
