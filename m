From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: [PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Mon, 30 May 2016 12:45:01 +0200
Message-ID: <20160530104501.4402-1-antoine.queru@ensimag.grenoble-inp.fr>
Cc: william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, larsxschneider@gmail.com,
	rsbecker@nexbridge.com, aaron@schrab.com, gitster@pobox.com,
	Matthieu.Moy@grenoble-inp.fr, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 12:45:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7KhA-0003PR-U1
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 12:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754704AbcE3KpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 06:45:11 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:57071 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754249AbcE3KpK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 06:45:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 0A2402483;
	Mon, 30 May 2016 12:45:08 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zZuQni6oThsM; Mon, 30 May 2016 12:45:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E0ECC247F;
	Mon, 30 May 2016 12:45:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id DACC42077;
	Mon, 30 May 2016 12:45:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PU7hBedRl6SL; Mon, 30 May 2016 12:45:07 +0200 (CEST)
Received: from quetutemobile.grenet.fr (eduroam-032133.grenet.fr [130.190.32.133])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id B72B02066;
	Mon, 30 May 2016 12:45:07 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.627.gd450e06.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295878>

Currently, a user wanting to prevent accidental pushes to the wrong remote
has to create a pre-push hook.
The feature offers a configuration to allow users to prevent accidental pushes
to the wrong remote. The user may define a list of whitelisted remotes, a list
of blacklisted remotes and a default policy ("allow" or "deny"). A push
is denied if the remote is explicitely blacklisted or if it isn't
whitelisted and the default policy is "deny".

This feature is intended as a safety net more than a real security, the user
will always be able to modify the config if he wants to. It is here for him to
consciously restrict his push possibilities. For example, it may be useful
for an unexperimented user fearing to push to the wrong remote, or for
companies wanting to avoid unintentionnal leaking of private code on public
repositories.

By default the whitelist/blacklist feature is disabled since the default policy
is "allow".

Signed-off-by: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Signed-off-by: Francois Beutin <francois.beutin@ensimag.grenoble-inp.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
This is the first implementation of the feature proposed in SoCG 2016.
The conversation about it can be found here:
http://thread.gmane.org/gmane.comp.version-control.git/295166
and http://thread.gmane.org/gmane.comp.version-control.git/289749.
We have included in cc all the participants in the previous conversation.
 Documentation/config.txt            | 17 +++++++
 Documentation/git-push.txt          | 32 +++++++++++++
 builtin/push.c                      | 75 ++++++++++++++++++++++++++++---
 t/t5544-push-whitelist-blacklist.sh | 90 +++++++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+), 5 deletions(-)
 create mode 100755 t/t5544-push-whitelist-blacklist.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53f00db..1478ce3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,6 +2517,23 @@ remote.pushDefault::
 	`branch.<name>.remote` for all branches, and is overridden by
 	`branch.<name>.pushRemote` for specific branches.
 
+remote.pushBlacklisted::
+	The list of remotes the user is forbidden to push to.
+	See linkgit:git-push[1]
+
+remote.pushWhitelisted::
+	The list of remotes the user is allowed to push to.
+	See linkgit:git-push[1]
+
+remote.pushDefaultPolicy::
+	Can be set to either 'allow' or 'deny', defines the policy to adopt
+	when the user tries to push to a remote not in the whitelist or 
+	the blacklist. Defaults to 'allow'.
+
+remote.pushDenyMessage::
+	The message printed when pushing to a forbidden remote.
+	Defaults to "Pushing to this remote has been forbidden".
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index cf6ee4a..644bfde 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -368,6 +368,38 @@ reason::
 	refs, no explanation is needed. For a failed ref, the reason for
 	failure is described.
 
+
+Note about denying pushes to the wrong remotes
+----------------------------------------------
+
+If you fear accidental pushes to the wrong remotes, you can use the
+blacklist/whitelist feature. The goal is to catch pushes to unwanted
+remotes before they happen.
+
+The simplest way to forbid pushes to a remote is to add its url in the
+config file under the 'remote.pushBlacklisted' variable.
+A more restrictive way is to change 'remote.pushDefaultPolicy' to 'deny',
+thus denying pushes to every remote not whitelisted. You can then add
+the right remotes under 'remote.pushWhitelisted'.
+
+You can also configure more advanced acceptation/denial behavior following
+this rule: the more the url in the config prefixes the asked url the more
+priority it has.
+
+For example, if we set up the configuration variables like this:
+	git config --add remote.pushBlacklisted repository.com
+	git config --add remote.pushWhitelisted repository.com/Special_Folder
+Any push of this form will be accepted:
+	git push repository.com/Special_Folder/foo
+While those ones for example will be denied:
+	git push repository.com/Normal_Folder/bar
+
+Additionally, you can configure the message printed when a push is denied
+with the 'remote.pushDenyMessage' configuration variable.
+
+An error will be raised if the url is blacklisted and whitelisted at the same.
+
+
 Note about fast-forwards
 ------------------------
 
diff --git a/builtin/push.c b/builtin/push.c
index 4e9e4db..0aa1f7d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -11,6 +11,8 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
+#include "urlmatch.h"
+#include "url.h"
 
 static const char * const push_usage[] = {
 	N_("git push [<options>] [<repository> [<refspec>...]]"),
@@ -353,6 +355,68 @@ static int push_with_options(struct transport *transport, int flags)
 	return 1;
 }
 
+/* 
+ * TODO: the shorter scp-like syntax for the SSH protocol isn't recognize
+ * with url_normalize
+ */
+static const char *string_url_normalize(const char *repo_name)
+{
+	if (starts_with(repo_name, "file://"))
+		return repo_name + 7;
+	if (is_url(repo_name)) {
+		struct url_info url_infos;
+		url_normalize(repo_name, &url_infos);
+		return url_infos.url + url_infos.host_off;
+	}
+	return repo_name;
+}
+
+static int longest_prefix_size(const char *repo_to_push, const struct string_list *list)
+{
+	struct string_list_item *item_curr;
+	int max_size = 0;
+	if (!list)
+		return 0;
+	for_each_string_list_item(item_curr, list) {
+		const char *repo_curr = string_url_normalize(item_curr->string);
+		if (starts_with(repo_to_push, repo_curr) &&
+		    max_size < strlen(repo_curr)){
+			max_size = strlen(repo_curr);
+			if (strlen(repo_to_push) == max_size)
+				break;
+		}
+	}
+	return max_size;
+}
+
+static void block_unauthorized_url(const char *repo)
+{
+	const char *default_policy, *deny_message;
+	const struct string_list *whitelist, *blacklist;
+	int whitelist_match_size, blacklist_match_size;
+	const char* repo_normalize = string_url_normalize(repo);
+	if (git_config_get_value("remote.pushDefaultPolicy", &default_policy))
+		default_policy = "allow";
+	if (git_config_get_value("remote.pushDenyMessage", &deny_message))
+		deny_message = "Pushing to this remote is forbidden";
+	whitelist = git_config_get_value_multi("remote.pushWhitelisted");
+	blacklist = git_config_get_value_multi("remote.pushBlacklisted");
+
+	whitelist_match_size = longest_prefix_size(repo_normalize, whitelist);
+	blacklist_match_size = longest_prefix_size(repo_normalize, blacklist);
+
+	if (whitelist_match_size < blacklist_match_size)
+		die(_("%s"), deny_message);
+	if (whitelist_match_size == blacklist_match_size) {
+		if (whitelist_match_size)
+			die(_("%s cannot be whitelisted and blacklisted at the same time"), repo);
+		if (!strcmp(default_policy, "deny"))
+			die(_("%s"), deny_message);
+		if (strcmp(default_policy, "allow"))
+			die(_("Unrecognized value for remote.pushDefaultPolicy, should be 'allow' or 'deny'"));
+	}
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -404,15 +468,16 @@ static int do_push(const char *repo, int flags)
 	url_nr = push_url_of_remote(remote, &url);
 	if (url_nr) {
 		for (i = 0; i < url_nr; i++) {
-			struct transport *transport =
-				transport_get(remote, url[i]);
+			struct transport *transport;
+			block_unauthorized_url(url[i]);
+			transport = transport_get(remote, url[i]);
 			if (push_with_options(transport, flags))
 				errs++;
 		}
 	} else {
-		struct transport *transport =
-			transport_get(remote, NULL);
-
+		struct transport *transport;
+		block_unauthorized_url(remote->url[0]);
+		transport = transport_get(remote, NULL);
 		if (push_with_options(transport, flags))
 			errs++;
 	}
diff --git a/t/t5544-push-whitelist-blacklist.sh b/t/t5544-push-whitelist-blacklist.sh
new file mode 100755
index 0000000..e0683d6
--- /dev/null
+++ b/t/t5544-push-whitelist-blacklist.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+
+test_description='push allowed/denied depending on config options'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit commit &&
+	git init --bare wlisted1 &&
+	git init --bare wlisted1/folder &&
+	git init --bare wlisted1/folder/blistedfolder &&
+	git init --bare wlisted1/folder/blistedfolder/folder &&
+	git init --bare wlisted2 &&
+	git init --bare blisted1 &&
+	git init --bare blisted1/folder &&
+	git init --bare blisted2 &&
+	git init --bare untracked &&
+	git init --bare repo &&
+	git remote add wlisted wlisted1 &&
+	git remote add wlisted2 wlisted2 &&
+	git remote add blisted blisted1 &&
+	git remote add blisted2 blisted2 &&
+	git remote add repo repo &&
+	git config --add remote.pushWhitelisted wlisted1 &&
+	git config --add remote.pushWhitelisted wlisted2 &&
+	git config --add remote.pushWhitelisted repo &&
+	git config --add remote.pushBlacklisted blisted1 &&
+	git config --add remote.pushBlacklisted blisted2 &&
+	git config --add remote.pushBlacklisted repo &&
+	git config --add remote.pushBlacklisted wlisted1/folder/blistedfolder
+'
+
+test_expect_success 'whitelist/blacklist with default pushDefaultPolicy' '
+	git push wlisted1 HEAD &&
+	git push wlisted2 HEAD &&
+	test_must_fail git push blisted1 HEAD &&
+	test_must_fail git push blisted2 HEAD &&
+	git push untracked HEAD
+'
+
+test_expect_success 'whitelist/blacklist with allow pushDefaultPolicy' '
+	test_config remote.pushDefaultPolicy allow &&
+	git push wlisted1 HEAD &&
+	git push wlisted2 HEAD &&
+	test_must_fail git push blisted1 HEAD &&
+	test_must_fail git push blisted2 HEAD &&
+	git push untracked HEAD
+'
+
+test_expect_success 'whitelist/blacklist with deny pushDefaultPolicy' '
+	test_config remote.pushDefaultPolicy deny &&
+	git push wlisted1 HEAD &&
+	git push wlisted2 HEAD &&
+	test_must_fail git push blisted1 HEAD &&
+	test_must_fail git push blisted2 HEAD &&
+	test_must_fail git push untracked HEAD
+'
+
+test_expect_success 'remote is whitelisted and blacklisted at the same time exception' '
+	test_must_fail git push repo HEAD 2> result &&
+	echo "fatal: repo cannot be whitelisted and blacklisted at the same time" > expected &&
+	test_cmp result expected
+'
+
+test_expect_success 'remote rejected default message' '
+	test_must_fail git push blisted1 HEAD 2> result &&
+	echo "fatal: Pushing to this remote is forbidden" > expected &&
+	test_cmp result expected
+'
+
+test_expect_success 'remote rejected custom message' '
+	test_config remote.pushDenyMessage "denied" &&
+	test_must_fail git push blisted1 HEAD 2> result &&
+	echo "fatal: denied" > expected &&
+	test_cmp result expected
+'
+
+test_expect_success 'push accepted/rejected depending on config precision' '
+	test_config remote.pushDefaultPolicy deny &&
+	git push wlisted1/folder HEAD &&
+	test_must_fail git push blisted1/folder HEAD &&
+	test_must_fail git push wlisted1/folder/blistedfolder/folder HEAD
+'
+
+test_expect_success 'unsetup' '
+	test_unconfig remote.pushBlackListed &&
+	test_unconfig remote.pushWhiteListed
+'
+
+test_done
-- 
2.8.2.627.gd450e06.dirty
