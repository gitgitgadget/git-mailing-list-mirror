Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74704C433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5502065F
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgGPMZQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:25:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:59038 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727990AbgGPMZQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 08:25:16 -0400
Received: (qmail 23358 invoked by uid 109); 16 Jul 2020 12:25:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 12:25:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23468 invoked by uid 111); 16 Jul 2020 12:25:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 08:25:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 08:25:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with
 extensions
Message-ID: <20200716122513.GA1050962@coredump.intra.peff.net>
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
 <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
 <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
 <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
 <xmqqpn8wkben.fsf@gitster.c.googlers.com>
 <20200716062054.GA3242764@google.com>
 <20200716062818.GC3242764@google.com>
 <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
 <20200716110007.GD376357@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716110007.GD376357@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 07:00:08AM -0400, Jeff King wrote:

> > > To avoid mistakes, continue to forbid repository format upgrades in v0
> > > repositories with an unrecognized extension.  This way, a v0 user
> > > using a misspelled extension field gets a chance to correct the
> > > mistake before updating to the less forgiving v1 format.
> > 
> > This needs to be managed carefully.  When the next extension is
> > added to the codebase, that extension may be "known" to Git, but I
> > do not think it is a good idea to honor it in v0 repository, or
> > allow upgrading v0 repository to v1 with such an extension that
> > weren't "known" to Git.  For example, a topic in flight adds
> > objectformat extension and I do not think it should be honored in v0
> > repository.
> > 
> > Having said that, the approach is OK for now at the tip of tonight's
> > master, but the point is "known" vs "unknown" must be fixed right
> > with some means.  E.g. tell people to throw the "new" extensions to
> > the list of "unknown extensions" in check_repo_format() when they
> > add new ones, or something.
> 
> Yeah, I agree with this line of reasoning. I'd prefer to see it
> addressed now, so that we don't have to remember to do anything later.
> I.e., for this patch to put the existing known extensions into the
> "good" list for v0, locking it into place forever, and leaving the
> objectformat topic with nothing particular it needs to do.
> 
> But in the name of -rc1 expediency, I'm also OK moving forward with this
> for now.

Hmm, this is actually a bit trickier than I expected because of the way
the code is written. It's much easier to complain about extensions in a
v0 repository than it is to ignore them. But I'm not sure if that isn't
the right way to go anyway.

The patch I came up with is below (and goes on top of Jonathan's). Even
if we decide this is the right direction, it can definitely happen
post-v2.28.

-- >8 --
Subject: verify_repository_format(): complain about new extensions in v0 repo

We made the mistake in the past of respecting extensions.* even when the
repository format version was set to 0. This is bad because forgetting
to bump the repository version means that older versions of Git (which
do not know about our extensions) won't complain. I.e., it's not a
problem in itself, but it means your repository is in a state which does
not give you the protection you think you're getting from older
versions.

For compatibility reasons, we are stuck with that decision for existing
extensions. However, we'd prefer not to extend the damage further. We
can do that by catching any newly-added extensions and complaining about
the repository format.

Note that this is a pretty heavy hammer: we'll refuse to work with the
repository at all. A lesser option would be to ignore (possibly with a
warning) any new extensions. But because of the way the extensions are
handled, that puts the burden on each new extension that is added to
remember to "undo" itself (because they are handled before we know
for sure whether we are in a v1 repo or not, since we don't insist on a
particular ordering of config entries).

So one option would be to rewrite that handling to record any new
extensions (and their values) during the config parse, and then only
after proceed to handle new ones only if we're in a v1 repository. But
I'm not sure if it's worth the trouble:

  - ignoring extensions is likely to end up with broken results anyway
    (e.g., ignoring a proposed objectformat extension means parsing any
    object data is likely to encounter errors)

  - this is a sign that whatever tool wrote the extension field is
    broken. We may be better off notifying immediately and forcefully so
    that such tools don't even appear to work accidentally.

The only downside is that fixing the istuation is a little tricky,
because programs like "git config" won't want to work with the
repository. But:

  git config --file=.git/config core.repositoryformatversion 1

should still suffice.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h                 |  2 +
 setup.c                 | 96 ++++++++++++++++++++++++++++++++++-------
 t/t1302-repo-version.sh |  3 ++
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index 654426460c..0290849c19 100644
--- a/cache.h
+++ b/cache.h
@@ -1044,6 +1044,7 @@ struct repository_format {
 	int hash_algo;
 	char *work_tree;
 	struct string_list unknown_extensions;
+	struct string_list v1_only_extensions;
 };
 
 /*
@@ -1057,6 +1058,7 @@ struct repository_format {
 	.is_bare = -1, \
 	.hash_algo = GIT_HASH_SHA1, \
 	.unknown_extensions = STRING_LIST_INIT_DUP, \
+	.v1_only_extensions = STRING_LIST_INIT_DUP, \
 }
 
 /*
diff --git a/setup.c b/setup.c
index 3a81307602..c1480b2b60 100644
--- a/setup.c
+++ b/setup.c
@@ -447,6 +447,54 @@ static int read_worktree_config(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
+enum extension_result {
+	EXTENSION_ERROR = -1, /* compatible with error(), etc */
+	EXTENSION_UNKNOWN = 0,
+	EXTENSION_OK = 1
+};
+
+/*
+ * Do not add new extensions to this function. It handles extensions which are
+ * respected even in v0-format repositories for historical compatibility.
+ */
+enum extension_result handle_extension_v0(const char *var,
+					  const char *value,
+					  const char *ext,
+					  struct repository_format *data)
+{
+		if (!strcmp(ext, "noop")) {
+			return EXTENSION_OK;
+		} else if (!strcmp(ext, "preciousobjects")) {
+			data->precious_objects = git_config_bool(var, value);
+			return EXTENSION_OK;
+		} else if (!strcmp(ext, "partialclone")) {
+			if (!value)
+				return config_error_nonbool(var);
+			data->partial_clone = xstrdup(value);
+			return EXTENSION_OK;
+		} else if (!strcmp(ext, "worktreeconfig")) {
+			data->worktree_config = git_config_bool(var, value);
+			return EXTENSION_OK;
+		}
+
+		return EXTENSION_UNKNOWN;
+}
+
+/*
+ * Record any new extensions in this function.
+ */
+enum extension_result handle_extension(const char *var,
+				       const char *value,
+				       const char *ext,
+				       struct repository_format *data)
+{
+	if (!strcmp(ext, "noop-v1")) {
+		return EXTENSION_OK;
+	}
+
+	return EXTENSION_UNKNOWN;
+}
+
 static int check_repo_format(const char *var, const char *value, void *vdata)
 {
 	struct repository_format *data = vdata;
@@ -455,23 +503,25 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
-		/*
-		 * record any known extensions here; otherwise,
-		 * we fall through to recording it as unknown, and
-		 * check_repository_format will complain
-		 */
-		if (!strcmp(ext, "noop"))
-			;
-		else if (!strcmp(ext, "preciousobjects"))
-			data->precious_objects = git_config_bool(var, value);
-		else if (!strcmp(ext, "partialclone")) {
-			if (!value)
-				return config_error_nonbool(var);
-			data->partial_clone = xstrdup(value);
-		} else if (!strcmp(ext, "worktreeconfig"))
-			data->worktree_config = git_config_bool(var, value);
-		else
+		switch (handle_extension_v0(var, value, ext, data)) {
+		case EXTENSION_ERROR:
+			return -1;
+		case EXTENSION_OK:
+			return 0;
+		case EXTENSION_UNKNOWN:
+			break;
+		}
+
+		switch (handle_extension(var, value, ext, data)) {
+		case EXTENSION_ERROR:
+			return -1;
+		case EXTENSION_OK:
+			string_list_append(&data->v1_only_extensions, ext);
+			return 0;
+		case EXTENSION_UNKNOWN:
 			string_list_append(&data->unknown_extensions, ext);
+			return 0;
+		}
 	}
 
 	return read_worktree_config(var, value, vdata);
@@ -510,6 +560,7 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	set_repository_format_partial_clone(candidate->partial_clone);
 	repository_format_worktree_config = candidate->worktree_config;
 	string_list_clear(&candidate->unknown_extensions, 0);
+	string_list_clear(&candidate->v1_only_extensions, 0);
 
 	if (repository_format_worktree_config) {
 		/*
@@ -588,6 +639,7 @@ int read_repository_format(struct repository_format *format, const char *path)
 void clear_repository_format(struct repository_format *format)
 {
 	string_list_clear(&format->unknown_extensions, 0);
+	string_list_clear(&format->v1_only_extensions, 0);
 	free(format->work_tree);
 	free(format->partial_clone);
 	init_repository_format(format);
@@ -613,6 +665,18 @@ int verify_repository_format(const struct repository_format *format,
 		return -1;
 	}
 
+	if (format->version == 0 && format->v1_only_extensions.nr) {
+		int i;
+
+		strbuf_addstr(err,
+			      _("repo version is 0, but v1-only extensions found:"));
+
+		for (i = 0; i < format->v1_only_extensions.nr; i++)
+			strbuf_addf(err, "\n\t%s",
+				    format->v1_only_extensions.items[i].string);
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index d60c042ce8..0acabb6d11 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -87,6 +87,9 @@ allow 1
 allow 1 noop
 abort 1 no-such-extension
 allow 0 no-such-extension
+allow 0 noop
+abort 0 noop-v1
+allow 1 noop-v1
 EOF
 
 test_expect_success 'precious-objects allowed' '
-- 
2.28.0.rc0.424.g7d08728e23

