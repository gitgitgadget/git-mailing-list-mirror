From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 3/3] push: add remote.*.pushHeadOnly configuration
Date: Mon, 20 Jul 2009 13:58:14 +0200
Message-ID: <1248091094-31485-4-git-send-email-bonzini@gnu.org>
References: <1248091094-31485-1-git-send-email-bonzini@gnu.org>
Cc: gitster@pobox.com
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 13:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrVz-0003gb-WC
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbZGTL62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbZGTL62
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:58:28 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45710 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752961AbZGTL6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:58:25 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSrVg-0001v6-Sj; Mon, 20 Jul 2009 07:58:25 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248091094-31485-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123594>

This patch adds a remote.*.pushHeadOnly configuration that automatically
enables (when possible) the --current option to git push.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/config.txt |    6 ++++++
 builtin-push.c           |    2 ++
 remote.c                 |    2 ++
 remote.h                 |    1 +
 t/t5516-fetch-push.sh    |   16 +++++++++++++++-
 5 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cb6832b..4ab5593 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1359,6 +1359,12 @@ remote.<name>.uploadpack::
 	The default program to execute on the remote side when fetching.  See
 	option \--upload-pack of linkgit:git-fetch-pack[1].
 
+remote.<name>.pushHeadOnly::
+	If true, whenever `git push` is invoked without a refspec and
+	it will try pushing to this remote, `git push` will automatically
+	behave as if the `\--current` option was given on the command line.
+	In other words, only the current branch is pushed to the remote.
+
 remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
 	fetching from remote <name>
diff --git a/builtin-push.c b/builtin-push.c
index 71d94a5..8d5b054 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -109,6 +109,8 @@ static int do_push(const char *repo, int flags)
 
 	if (remote->mirror)
 		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+	if (remote->push_head_only && !refspec_nr)
+		flags |= TRANSPORT_PUSH_CURRENT;
 
 	if ((flags & TRANSPORT_PUSH_ALL) && refspec) {
 		if (!strcmp(*refspec, "refs/tags/*"))
diff --git a/remote.c b/remote.c
index b5bf9a6..d46dc0d 100644
--- a/remote.c
+++ b/remote.c
@@ -379,6 +379,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 		remote->mirror = git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipdefaultupdate"))
 		remote->skip_default_update = git_config_bool(key, value);
+	else if (!strcmp(subkey, ".pushheadonly"))
+		remote->push_head_only = git_config_bool(key, value);
 
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
diff --git a/remote.h b/remote.h
index 8e5d5b4..b1e3e99 100644
--- a/remote.h
+++ b/remote.h
@@ -36,6 +36,7 @@ struct remote {
 	 * 2 to always fetch tags
 	 */
 	int fetch_tags;
+	int push_head_only;
 	int skip_default_update;
 	int mirror;
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index a480cb2..9d61ba0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -631,9 +631,23 @@ test_expect_success 'push --current respects configuration' '
 	git config remote.bremote.push refs/heads/master:refs/heads/master2 &&
 	git push --current bremote &&
 	test $(git rev-parse master) = $(cd b.git && git rev-parse master2)
+'
+
+test_expect_success 'remote.*.pushHeadOnly respects configuration' '
+	echo xx > b &&
+	git commit -mmaster3 b &&
+	git config remote.bremote.pushHeadOnly true &&
 	git checkout branch &&
-	git push --current bremote 2>&1 | grep "Everything up-to-date" &&
+	git push bremote &&
+	test $(git rev-parse master^) = $(cd b.git && git rev-parse master) &&
 	test $(git rev-parse branch^) = $(cd b.git && git rev-parse branch)
 '
 
+test_expect_success 'remote.*.pushHeadOnly works' '
+	git config --unset remote.bremote.push &&
+	git push bremote &&
+	test $(git rev-parse master^) = $(cd b.git && git rev-parse master) &&
+	test $(git rev-parse branch) = $(cd b.git && git rev-parse branch)
+'
+
 test_done
-- 
1.6.4.rc1.10.g26dbf.dirty
