From: Antoine Queru <Antoine.Queru@grenoble-inp.org>
Subject: [RFC/PATCH] push: deny policy to prevent pushes to unwanted remotes.
Date: Sat,  4 Jun 2016 16:51:01 +0200
Message-ID: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org>
Cc: william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, larsxschneider@gmail.com,
	rsbecker@nexbridge.com, aaron@schrab.com,
	Matthieu.Moy@grenoble-inp.fr, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 16:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9D2S-0007Io-8i
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 16:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbcFDO6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 10:58:44 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:50147 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbcFDO6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 10:58:41 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jun 2016 10:58:40 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id B157F256B;
	Sat,  4 Jun 2016 16:51:11 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1i6-amWudOyn; Sat,  4 Jun 2016 16:51:11 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 94A0E2560;
	Sat,  4 Jun 2016 16:51:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8D7DC2077;
	Sat,  4 Jun 2016 16:51:11 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ju9T99D_4vHh; Sat,  4 Jun 2016 16:51:11 +0200 (CEST)
Received: from quetutemobile.grenet.fr (eduroam-008231.grenet.fr [130.190.8.231])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4F72E2064;
	Sat,  4 Jun 2016 16:51:11 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.625.g2f87638.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296445>

Currently, a user wanting to prevent accidental pushes to the wrong
remote has to create a pre-push hook.  The feature offers a
configuration to allow users to prevent accidental pushes to the wrong
remote. The user may define a list of whitelisted remotes, a list of
blacklisted remotes and a default policy ("allow" or "deny"). A push
is denied if the remote is explicitely blacklisted or if it isn't
whitelisted and the default policy is "deny".

This feature is intended as a safety net more than a real security,
the user will always be able to modify the config if he wants to. It
is here for him to consciously restrict his push possibilities. For
example, it may be useful for an unexperimented user fearing to push
to the wrong remote, or for companies wanting to avoid unintentionnal
leaking of private code on public repositories.

By default the whitelist/blacklist feature is disabled since the
default policy is "allow".

Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.org>
Signed-off-by: Francois Beutin <francois.beutin@grenoble-inp.org>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---

Changes since v1 :
Scheme handled.
Documentation fixed and moved.
Option "-no-verify" added to dismiss this process.

Right now, one function "longest_prefix_size" is pretty awful because
url_normalize treat local path with "file://..." as an url but not
local path without this prefix. So a local path and a repo without
scheme are seen likewise. Forbid local path without "file://.." could
make the code easier and faster. What do you think ?

User, password and port are not treated. Should it be ?

 Documentation/config.txt            |  17 ++++++
 Documentation/urls-remotes.txt      |  55 ++++++++++++++++++
 builtin/push.c                      | 110 ++++++++++++++++++++++++++++++++++--
 t/t5544-push-whitelist-blacklist.sh |  51 +++++++++++++++++
 4 files changed, 228 insertions(+), 5 deletions(-)
 create mode 100755 t/t5544-push-whitelist-blacklist.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 53f00db..7fe88f5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2517,6 +2517,23 @@ remote.pushDefault::
 	`branch.<name>.remote` for all branches, and is overridden by
 	`branch.<name>.pushRemote` for specific branches.
 
+remote.pushBlacklist::
+	The list of remotes the user is forbidden to push to.
+	See linkgit:git-push[1]
+
+remote.pushWhitelist::
+	The list of remotes the user is allowed to push to.
+	See linkgit:git-push[1]
+
+remote.pushDefaultPolicy::
+	Can be set to either 'allow' or 'deny', defines the policy to
+	adopt when the user tries to push to a remote not in the
+	whitelist or the blacklist. Defaults to 'allow'.
+
+remote.pushDenyMessage::
+	The message printed when pushing to a forbidden remote.
+	Defaults to "Pushing to this remote has been forbidden".
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index bd184cd..705914d 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -89,6 +89,61 @@ git push uses:
 	HEAD:refs/heads/<head>
 ------------
 
+Denying pushes to the wrong remotes
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If you fear accidental pushes to the wrong remotes, you can use the
+blacklist/whitelist feature. The goal is to catch pushes to unwanted
+remotes before they happen.
+
+The simplest way to forbid pushes to a remote is to add its url in the
+config file under the 'remote.pushBlacklist' variable.  A more
+restrictive way is to change 'remote.pushDefaultPolicy' to 'deny',
+thus denying pushes to every remote not whitelisted. You can then add
+the right remotes under 'remote.pushWhitelist'.
+
+You can also configure more advanced acceptation/denial behavior
+following this rule: the more the url in the config prefixes the asked
+url the more priority it has.
+
+For example, if we set up the configuration variables like this:
+
+-------------------------------
+git config --add remote.pushBlacklist repository.com
+git config --add remote.pushWhitelist repository.com/Special_Folder
+-------------------------------
+
+Pushes like this  will be accepted:
+-------------------------------
+git push repository.com/Special_Path/*
+-------------------------------
+
+While this one for example will be denied:
+-------------------------------
+git push repository.com/Other_Path/
+-------------------------------
+
+Remember to use '--add' with 'git config' to add more than one
+'remote.pushBlacklist'.
+
+Specific schemes can also be denied. For example :
+
+-------------------------------
+git config --add remote.pushBlacklist http://repo.com
+-------------------------------
+
+By doing so, only pushes to repo.com using 'http' will be denied,
+whereas other will be allowed, like 'https'. If you want to deny
+all pushes to a certain repo, don't put scheme at the beginning.
+
+Additionally, you can configure the message printed when a push is
+denied with the 'remote.pushDenyMessage' configuration variable.
+
+You can dismiss this process by using '--no-verify'.
+
+An error will be raised if the url is blacklisted and whitelisted at
+the same time.
+
 
 
 
diff --git a/builtin/push.c b/builtin/push.c
index 4e9e4db..bf20257 100644
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
@@ -353,6 +355,101 @@ static int push_with_options(struct transport *transport, int flags)
 	return 1;
 }
 
+static void check_length_prefix(const int whitelist,
+				const int blacklist,
+				const char *repo,
+				const char *deny_message,
+				const char *default_policy)
+{
+	if (whitelist < blacklist)
+		die(_("%s"), deny_message);
+	if (whitelist == blacklist) {
+		if (whitelist)
+			die(_("%s cannot be whitelisted and blacklisted"
+			      "at the same time"), repo);
+		if (!strcmp(default_policy, "deny"))
+			die(_("%s"), deny_message);
+		if (strcmp(default_policy, "allow"))
+			die(_("Unrecognized value for remote.pushDefaultPolicy,"
+			      "should be 'allow' or 'deny'"));
+	}
+
+}
+
+static void find_longest_prefix(const char *str, const char *pre, int *max)
+{
+	if (starts_with(str, pre)) {
+		int tmp = strlen(pre);
+		if (*max < tmp)
+			*max = tmp;
+	}
+}
+
+/*
+ *NEEDSWORK: Ugly because file://... is recognized as an url, and we
+ *may want to compare it to local path without this scheme. Forcing
+ *the user to put file:// before every local path would make the code
+ *easier and avoid confusion with a distant repo like 'github.com'
+ *which is not an url.
+ */
+static int longest_prefix_size(const char* target_str,
+				const struct string_list *list)
+{
+	struct string_list_item *curr_item;
+	struct url_info target_url;
+	int max_size = 0;
+	if (!list)
+		return 0;
+
+	skip_prefix(target_str, "file://", &target_str);
+	url_normalize(target_str, &target_url);
+
+	for_each_string_list_item(curr_item, list) {
+		struct url_info curr_url;
+		const char *curr_str = curr_item->string;
+		skip_prefix(curr_str, "file://", &curr_str);
+		url_normalize(curr_str, &curr_url);
+		if (target_url.url &&
+		    curr_url.url &&
+		    target_url.scheme_len == curr_url.scheme_len &&
+		    !strncmp(target_url.url,curr_url.url,curr_url.scheme_len))
+			find_longest_prefix(target_url.url + target_url.host_off,
+					    curr_url.url + curr_url.host_off,
+					    &max_size);
+		else if (target_url.url && !curr_url.url)
+			find_longest_prefix(target_url.url + target_url.host_off,
+					    curr_str,
+					    &max_size);
+
+		else if(!target_url.url && !curr_url.url)
+			find_longest_prefix(target_str, curr_str, &max_size);
+	}
+	return max_size;
+}
+
+static void block_unauthorized_url(const char *repo)
+{
+	struct url_info target_url;
+	const char *default_policy, *deny_message;
+	const struct string_list *whitelist, *blacklist;
+	int whitelist_size, blacklist_size;
+
+	url_normalize(repo, &target_url);
+
+	if (git_config_get_value("remote.pushDefaultPolicy", &default_policy))
+		default_policy = "allow";
+	if (git_config_get_value("remote.pushDenyMessage", &deny_message))
+		deny_message = "Pushing to this remote using this protocol is forbidden";
+
+	whitelist = git_config_get_value_multi("remote.pushWhitelist");
+	blacklist = git_config_get_value_multi("remote.pushBlacklist");
+
+	whitelist_size = longest_prefix_size(repo, whitelist);
+	blacklist_size = longest_prefix_size(repo, blacklist);
+
+	check_length_prefix(whitelist_size, blacklist_size, repo, deny_message, default_policy);
+}
+
 static int do_push(const char *repo, int flags)
 {
 	int i, errs;
@@ -404,15 +501,18 @@ static int do_push(const char *repo, int flags)
 	url_nr = push_url_of_remote(remote, &url);
 	if (url_nr) {
 		for (i = 0; i < url_nr; i++) {
-			struct transport *transport =
-				transport_get(remote, url[i]);
+			struct transport *transport;
+			if (!(flags & TRANSPORT_PUSH_NO_HOOK))
+				block_unauthorized_url(url[i]);
+			transport = transport_get(remote, url[i]);
 			if (push_with_options(transport, flags))
 				errs++;
 		}
 	} else {
-		struct transport *transport =
-			transport_get(remote, NULL);
-
+		struct transport *transport;
+		if (!(flags & TRANSPORT_PUSH_NO_HOOK))
+			block_unauthorized_url(remote->url[0]);
+		transport = transport_get(remote, NULL);
 		if (push_with_options(transport, flags))
 			errs++;
 	}
diff --git a/t/t5544-push-whitelist-blacklist.sh b/t/t5544-push-whitelist-blacklist.sh
new file mode 100755
index 0000000..8f9f056
--- /dev/null
+++ b/t/t5544-push-whitelist-blacklist.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description='blacklist for push'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	git init --bare blacklist/ &&
+	git init --bare whitelist/ &&
+	git init --bare blacklist/allow &&
+	test_commit commit &&
+	echo "fatal: Pushing to this remote using this protocol is forbidden" > forbidden
+'
+
+test_expect_success 'basic case' '
+	git config --add remote.pushBlacklist http://blacklist.com &&
+	test_must_fail git push http://blacklist.com HEAD 2> result &&
+	test_cmp result forbidden
+'
+
+test_expect_success 'no scheme and no path' '
+	git config remote.pushBlacklist blacklist.com &&
+	test_must_fail git push http://blacklist.com/foo HEAD 2> result &&
+	test_cmp result forbidden
+'
+
+test_expect_success 'local path' '
+	git config remote.pushBlacklist blacklist &&
+	test_must_fail git push blacklist HEAD 2> result &&
+	test_cmp result forbidden
+'
+
+test_expect_success 'local path with file://' '
+	git config remote.pushBlacklist file://blacklist &&
+	test_must_fail git push blacklist HEAD 2> result &&
+	test_cmp result forbidden
+'
+test_expect_success 'only one scheme allowed' '
+	git config remote.pushDefaultPolicy deny &&
+	git config remote.pushWhitelist http://blacklist.com &&
+	test_must_fail git push https://blacklist.com HEAD 2> result &&
+	test_cmp result forbidden
+'
+
+test_expect_success 'denied repo in allowed repo' '
+	git config remote.pushBlacklist blacklist &&
+	git config --add remote.pushWhitelist blacklist/allow &&
+	git push blacklist/allow HEAD
+'
+
+test_done
-- 
2.8.2.625.g2f87638.dirty
