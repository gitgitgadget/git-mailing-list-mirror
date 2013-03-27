From: Hans Brigman <hbrigman@openspan.com>
Subject: [PATCH v2] config: Consistent call style to gpg settings
Date: Wed, 27 Mar 2013 12:19:08 -0500
Message-ID: <8C726954D36902459248B0627BF2E66F45D70C3FCE@AUSP01VMBX10.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"peff@peff.net" <peff@peff.net>,
	Jacob Sarvis <jsarvis@openspan.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 18:20:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKu1Z-00056R-RL
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 18:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271Ab3C0RUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 13:20:03 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.195]:29593 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750941Ab3C0RUC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 13:20:02 -0400
Received: from [216.82.242.99:57849] by server-3.bemta-8.messagelabs.com id 79/93-22382-14A23515; Wed, 27 Mar 2013 17:20:01 +0000
X-Env-Sender: hbrigman@openspan.com
X-Msg-Ref: server-11.tower-131.messagelabs.com!1364404780!22683508!28
X-Originating-IP: [216.166.12.72]
X-StarScan-Received: 
X-StarScan-Version: 6.8.6.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4294 invoked from network); 27 Mar 2013 17:20:00 -0000
Received: from out001.collaborationhost.net (HELO out001.collaborationhost.net) (216.166.12.72)
  by server-11.tower-131.messagelabs.com with RC4-SHA encrypted SMTP; 27 Mar 2013 17:20:00 -0000
Received: from AUSP01VMBX10.collaborationhost.net ([10.2.8.162]) by
 AUSP01MHUB50.collaborationhost.net ([10.2.10.3]) with mapi; Wed, 27 Mar 2013
 12:19:52 -0500
Thread-Topic: [PATCH v2] config: Consistent call style to gpg settings
Thread-Index: Ac4rDmFlU5HZ05vTTlqAymueK/j7/g==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219285>

From: Jacob Sarvis <jsarvis@openspan.com>

Calling style for passing settings to git_gpg_config is inconsistent
between commit-tree, commit, log, merge, tag, and verify-tag.

Consolidate style of calling git_gpg_config.

Signed-off-by: Jacob Sarvis <jsarvis@openspan.com>
Signed-off-by: Hans Brigman <hbrigman@openspan.com>
---
 builtin/commit-tree.c | 2 +-
 builtin/log.c         | 9 +++++++--
 builtin/merge.c       | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index eac901a..2e2b8d0 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -28,7 +28,7 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 
 static int commit_tree_config(const char *var, const char *value, void *cb)
 {
-	int status = git_gpg_config(var, value, NULL);
+	int status = git_gpg_config(var, value, cb);
 	if (status)
 		return status;
 	return git_default_config(var, value, cb);
diff --git a/builtin/log.c b/builtin/log.c
index 31f5a9e..7f02af7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -339,6 +339,8 @@ static int cmd_log_walk(struct rev_info *rev)
 
 static int git_log_config(const char *var, const char *value, void *cb)
 {
+	int status;
+
 	if (!strcmp(var, "format.pretty"))
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
@@ -365,8 +367,11 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		use_mailmap_config = git_config_bool(var, value);
 		return 0;
 	}
-	if (git_gpg_config(var, value, cb) < 0)
-		return -1;
+	
+	status = git_gpg_config(var, value, cb);
+	if (status)
+		return status;
+	
 	if (grep_config(var, value, cb) < 0)
 		return -1;
 	return git_diff_ui_config(var, value, cb);
diff --git a/builtin/merge.c b/builtin/merge.c
index 7c8922c..6c03eb8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -580,7 +580,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	status = fmt_merge_msg_config(k, v, cb);
 	if (status)
 		return status;
-	status = git_gpg_config(k, v, NULL);
+	status = git_gpg_config(k, v, cb);
 	if (status)
 		return status;
 	return git_diff_ui_config(k, v, cb);
-- 
1.7.11.msysgit.0


Hans Brigman <hbrigman@openspan.com> writes:

> From: Jacob Sarvis <jsarvis@openspan.com>
>
> config: Consistent call style to gpg settings
>
> Calling style for passing settings to git_gpg_config is inconsistent 
> between commit-tree, commit, merge, tag, and verify-tag.
>
> Consolidate style of calling git_gpg_config.
>
> Signed-off-by: Hans Brigman <hbrigman@openspan.com>

Exactly the same comments as the review for the other patch apply here.

> ---
> builtin/commit-tree.c |  5 ++---
> builtin/commit.c      |  6 ++----
> builtin/merge.c       | 12 ++++--------
> builtin/tag.c         |  5 ++---
> builtin/verify-tag.c  |  5 ++---
> 5 files changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c index 
> eac901a..45e0152 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -28,9 +28,8 @@ static void new_parent(struct commit *parent, struct 
> commit_list **parents_p)  static int commit_tree_config(const char 
> *var, const char *value, void *cb) {
> -              int status = git_gpg_config(var, value, NULL);
> -              if (status)
> -                              return status;
> +             if (git_gpg_config(var, value, cb) < 0)
> +                             return -1;
>                return git_default_config(var, value, cb); }

Earlier, we always returned what the underlying helper returned, but in this version, we ignore error return values from git_gpg_config() but honor error return values from git_default_config().

This is making things worse, no?
