From: Sam Vilain <sam@vilain.net>
Subject: [PATCH 1/4] remote: allow mirroring to be specified, and document settings
Date: Wed, 25 Nov 2009 23:06:54 +1300
Message-ID: <1259143617-26580-2-git-send-email-sam@vilain.net>
References: <1259143617-26580-1-git-send-email-sam@vilain.net>
Cc: Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 11:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDF3i-0006j3-RN
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758601AbZKYKYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758447AbZKYKYq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:24:46 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51585 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758348AbZKYKYh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:24:37 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id CEDFD21C44B; Wed, 25 Nov 2009 23:07:16 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from denix (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 76B2D21C38B;
	Wed, 25 Nov 2009 23:06:56 +1300 (NZDT)
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by denix with esmtp (Exim 4.69)
	(envelope-from <sam@vilain.net>)
	id 1NDEmC-0006vO-CZ; Wed, 25 Nov 2009 23:07:08 +1300
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1259143617-26580-1-git-send-email-sam@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133629>

Add a per-remote setting that can list alternate URLs that the same
repository (or a close fork) can be found, a fetch command-line
switch, a config flag to enable it by default, and finally a method
for selecting a default mirror.

If the preferred mirror does not exist in the list of mirrors it is
considered invalid, in preparation for the time when the mirror list
can be supplied or added to by the upload-pack protocol response.

Signed-off-by: Sam Vilain <sam@vilain.net>
---
 Documentation/config.txt        |   13 +++++++++++++
 Documentation/fetch-options.txt |   24 ++++++++++++++++++++++++
 builtin-fetch.c                 |    4 +++-
 remote.c                        |   17 +++++++++++++++++
 remote.h                        |    6 ++++++
 5 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1e2120..edde0e4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1375,6 +1375,19 @@ remote.<name>.url::
 remote.<name>.pushurl::
 	The push URL of a remote repository.  See linkgit:git-push[1].
 
+remote.<name>.mirror-url::
+	An alternate URL which should have many similar refs to the
+	real remote at least most of the time.  This option can be
+	specified multiple times.  See linkgit:git-fetch[1].
+
+remote.<name>.use-mirror::
+	Prefer to contact mirrors first (boolean).  See
+	linkgit:git-fetch[1].
+
+remote.<name>.preferred-mirror::
+	Specify which mirror to try first (full URL).  May be updated
+	by user interaction during 'fetch'.  See linkgit:git-fetch[1].
+
 remote.<name>.proxy::
 	For remotes that require curl (http, https and ftp), the URL to
 	the proxy to use for that remote.  Set to the empty string to
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 2886874..8f07a56 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -62,6 +62,30 @@ ifndef::git-pull[]
 	Pass --quiet to git-fetch-pack and silence any other internally
 	used git commands.
 
+-M::
+--use-mirror::
+	Try to use a configured mirror for the bulk of the transfer
+	rather than the main upstream.  See gitlink:git-config[1] for
+	the appropriate options to set.
++
+The preferred mirror (or the first if no preferred URL is defined) is
+first contacted and fetched from, and any refs it presents which match
+the source <refspec> (including the rules for fetching tags) are saved
+under `refs/mirrors/`<remote>`/hostname`.  If there is a network
+timeout, or the user interrupts the fetch process, the next mirror
+will be tried.
++
+Once the fetch from the mirror is complete, the central host is
+contacted and fetched from.  If the mirror was correct and up to date,
+then no more data will be required from the central host.  At this
+point, all of the refs under `refs/mirrors/`<remote> which are
+reachable from the real `refs/remotes/`<remote> tracking branches will
+be removed.  Extra refs which were not present on the real source will
+be left behind so they are not fetched again the next time around.
++
+This can be made the default for a remote using the
+`remote.`<remote>.`use-mirror` configuration option.
+
 -v::
 --verbose::
 	Be verbose.
diff --git a/builtin-fetch.c b/builtin-fetch.c
index a35a6f8..209f502 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -23,7 +23,7 @@ enum {
 	TAGS_SET = 2
 };
 
-static int append, force, keep, update_head_ok, verbosity;
+static int append, force, keep, update_head_ok, verbosity, use_mirror;
 static int tags = TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -45,6 +45,8 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
+	OPT_BOOLEAN('M', "mirror", &use_mirror,
+		    "use mirror if available"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
 	OPT_END()
diff --git a/remote.c b/remote.c
index 73d33f2..65df03d 100644
--- a/remote.c
+++ b/remote.c
@@ -111,6 +111,13 @@ static void add_pushurl(struct remote *remote, const char *pushurl)
 	remote->pushurl[remote->pushurl_nr++] = pushurl;
 }
 
+static void add_mirror_url(struct remote *remote, const char *mirror_url)
+{
+	ALLOC_GROW(remote->mirror_url, remote->mirror_url_nr + 1,
+		   remote->mirror_url_alloc);
+	remote->mirror_url[remote->mirror_url_nr++] = mirror_url;
+}
+
 static void add_pushurl_alias(struct remote *remote, const char *url)
 {
 	const char *pushurl = alias_url(url, &rewrites_push);
@@ -407,6 +414,16 @@ static int handle_config(const char *key, const char *value, void *cb)
 		if (git_config_string(&v, key, value))
 			return -1;
 		add_pushurl(remote, v);
+	} else if (!strcmp(subkey, ".mirror-url")) {
+		const char *v;
+		if (git_config_string(&v, key, value))
+			return -1;
+		add_mirror_url(remote, v);
+	} else if (!strcmp(subkey, ".use-mirror")) {
+		remote->use_mirror = git_config_bool(key, value);
+	} else if (!strcmp(subkey, ".preferred-mirror")) {
+		if (git_config_string(&remote->preferred_mirror, key, value))
+			return -1;
 	} else if (!strcmp(subkey, ".push")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/remote.h b/remote.h
index 5db8420..c720b9a 100644
--- a/remote.h
+++ b/remote.h
@@ -19,6 +19,12 @@ struct remote {
 	int pushurl_nr;
 	int pushurl_alloc;
 
+	const char **mirror_url;
+	int mirror_url_nr;
+	int mirror_url_alloc;
+	int use_mirror;
+	const char *preferred_mirror;
+
 	const char **push_refspec;
 	struct refspec *push;
 	int push_refspec_nr;
-- 
1.6.3.3
