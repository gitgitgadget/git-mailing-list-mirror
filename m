Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438CC20282
	for <e@80x24.org>; Fri, 23 Jun 2017 13:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbdFWNwe (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 09:52:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:25977 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751287AbdFWNwd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 09:52:33 -0400
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2017 06:52:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,378,1493708400"; 
   d="scan'208";a="984432211"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.177.230])
  by orsmga003.jf.intel.com with ESMTP; 23 Jun 2017 06:52:32 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [RFC PATCH] proposal for refs/tracking/* hierarchy
Date:   Fri, 23 Jun 2017 06:52:30 -0700
Message-Id: <20170623135230.10534-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.13.0.615.gb09ed6e59a40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Historically, git has tracked the status of remote branches (heads) in
refs/remotes/<name>/*. This is necessary and useful as it allows users
to track the difference between their local work and the last known
status of the remote work.

Unfortunately this hierarchy is limited in that it only tracks branches.
Additionally, it is not feasible to extend it directly, because the
layout would become ambiguous. For example, if a user happened to have
a local branch named "notes" it could be confusing if you tried to add
"refs/remotes/origin/notes/<remote notes refs" as this would collide
with the already existing refs/remotes/origin/notes branch that existed.

Instead, lets add support for a new refs/tracking/* hierarchy which is
laid out in such a way to avoid this inconsistency. All refs in
"refs/tracking/<remote>/*" will include the complete ref, such that
dropping the "tracking/<remote>" part will give the exact ref name as it
is found in the upstream. Thus, we can track any ref here by simply
fetching it into refs/tracking/<remote>/*.

Add support to tell a new remote to start tracking remote hierarchies
via "--follow" which will track all refs under that section, ie:

git remote add --follow notes origin <url> will cause

+refs/notes/*:refs/tracking/origin/notes/* to be added as a fetch
refspec for this remote.

This ensures that any future refs which want a method of sharing the
current remote status separate from local status could use
refs/tracking

A long term goal might be to deprecate refs/remotes/ in favor of
refs/tracking (possibly adding in magic to convert refs/remotes directly
into refs/tracking so that old stuff still works?).

Things not yet thought through:

1) maybe we should create a configurable default so that some known set
   of default refs get pulled (ie: notes, grafts, replace, etc?)
   Possibly with some sort of easy way to add or subtract from the list
   in config...

2) so far, there's no work done to figure out how to remove
   refs/tracking when a remote is dropped. I *think* we can just delete
   all refs under refs/tracking/<name> but I'm not completely certain

3) adding magic to complete refs under tracking, such as for git-notes
   or similar may wish to understand shorthand for referencing the
   remote version of notes

4) adding support for clone.. (this is weird because git-clone and
   git-remote don't both use the same flow for setup.. oops??)

5) tests, documentation etc. (This is primarily an RFC, with the goal of
   providing a known location for remote references such as notes to
   reside)

6) we probably want to enable notes and grafts and other similar things
   to use the remote tracking data if its available.

7) what about tags? Currently we fetch all tags into refs/tags directly,
   which is a bit awkward, if for example you create a local tag and
   a remote creates a tag with the same name, you simply don't get that
   new version. This is good, but now you have no idea how to tell if
   your tags are out of date or not. refs/tracking can partially resolve
   this since remote tags will always be "exactly" what the remote has.
   Unfortunately, I don't know how we'd resolve them into local tags...

Probably other things missing too...

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/remote.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index f1a88fe26589..dffe3892be11 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -122,6 +122,16 @@ static void add_branch(const char *key, const char *branchname,
 	git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static void add_tracking(const char *key, const char *namespace,
+			 const char *remotename, struct strbuf *tmp)
+{
+	strbuf_reset(tmp);
+	strbuf_addch(tmp, '+');
+	strbuf_addf(tmp, "refs/%s/*:refs/tracking/%s/%s/*",
+		    namespace, remotename, namespace);
+	git_config_set_multivar(key, tmp->buf, "^$", 0);
+}
+
 static const char mirror_advice[] =
 N_("--mirror is dangerous and deprecated; please\n"
    "\t use --mirror=fetch or --mirror=push instead");
@@ -149,6 +159,7 @@ static int add(int argc, const char **argv)
 	int fetch = 0, fetch_tags = TAGS_DEFAULT;
 	unsigned mirror = MIRROR_NONE;
 	struct string_list track = STRING_LIST_INIT_NODUP;
+	struct string_list follow = STRING_LIST_INIT_NODUP;
 	const char *master = NULL;
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
@@ -164,6 +175,8 @@ static int add(int argc, const char **argv)
 			    N_("or do not fetch any tag at all (--no-tags)"), TAGS_UNSET),
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
 				N_("branch(es) to track")),
+		OPT_STRING_LIST(0, "follow", &follow, N_("namespace"),
+				N_("refs namespaces to follow in refs/tracking")),
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
 		{ OPTION_CALLBACK, 0, "mirror", &mirror, N_("push|fetch"),
 			N_("set up remote as a mirror to push to or fetch from"),
@@ -207,6 +220,11 @@ static int add(int argc, const char **argv)
 		}
 	}
 
+	for (i = 0; i < follow.nr; i++) {
+		add_tracking(buf.buf, follow.items[i].string,
+			     name, &buf2);
+	}
+
 	if (mirror & MIRROR_PUSH) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.mirror", name);
-- 
2.13.0.615.gb09ed6e59a40

