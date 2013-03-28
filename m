From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/6] remote.c: introduce remote.pushdefault
Date: Thu, 28 Mar 2013 18:56:41 +0530
Message-ID: <1364477202-5742-6-git-send-email-artagnon@gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:26:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCqO-0003hF-Hg
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab3C1NZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:25:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:57161 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121Ab3C1NZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:25:42 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo1so1958587pbc.19
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=icC4irPg16311b43vH3CdSCOpul5EoFLOA2Z73hmFn4=;
        b=XebNmoxRckGXzYWBtH7ZAs2Vp3yiOgE0Lo52Yir2zF5X4r72G/elqypxO08gTqjqUM
         bwC46NkUYrO/OaSLfUMt3lZjyK4byGhd143DGnz+6d2UPB/7zispGX3XSyGUfbpbL+EJ
         78QiIMr4RTdmwPJup3i1VGiL+D0JmUW8BddyujhJUAJdyyk0XZBLRsJ7CGZE0dYAwj5n
         36vvD1FpOrvf7LZLI3mr/46kh0OMCNoIvo7MqY22Q7IUfH93QHvxQhfUeQNOwIaQsp+U
         i+tI05hdva08n/ZBTnFH3KSJ7uIWTa8wMcksb4EmwYjZQDJrIM9EXbn+8T3i5bVTzopH
         7GMQ==
X-Received: by 10.66.221.226 with SMTP id qh2mr35944975pac.62.1364477141417;
        Thu, 28 Mar 2013 06:25:41 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id tm1sm25586603pbc.11.2013.03.28.06.25.38
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:25:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g3797f84
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219393>

This new configuration variable defines the default remote to push to,
and overrides `branch.<name>.remote` for all branches.  It is useful
in the typical triangular-workflow setup, where the remote you're
fetching from is different from the remote you're pushing to.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt | 13 ++++++++++---
 remote.c                 |  7 +++++++
 t/t5516-fetch-push.sh    | 12 ++++++++++++
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c1f435f..dd78171 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -727,9 +727,12 @@ branch.autosetuprebase::
 	This option defaults to never.
 
 branch.<name>.remote::
-	When in branch <name>, it tells 'git fetch' and 'git push' which
-	remote to fetch from/push to.  It defaults to `origin` if no remote is
-	configured. `origin` is also used if you are not on any branch.
+	When on branch <name>, it tells 'git fetch' and 'git push'
+	which remote to fetch from/push to.  The remote to push to
+	may be overridden with `remote.pushdefault` (for all branches).
+	If no remote is configured, or if you are not on any branch,
+	it defaults to `origin` for fetching and `remote.pushdefault`
+	for pushing.
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
@@ -1898,6 +1901,10 @@ receive.updateserverinfo::
 	If set to true, git-receive-pack will run git-update-server-info
 	after receiving data from git-push and updating refs.
 
+remote.pushdefault::
+	The remote to push to by default.  Overrides
+	`branch.<name>.remote` for all branches.
+
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
 	linkgit:git-push[1].
diff --git a/remote.c b/remote.c
index b733aec..49c4b8b 100644
--- a/remote.c
+++ b/remote.c
@@ -389,9 +389,16 @@ static int handle_config(const char *key, const char *value, void *cb)
 			add_instead_of(rewrite, xstrdup(value));
 		}
 	}
+
 	if (prefixcmp(key,  "remote."))
 		return 0;
 	name = key + 7;
+
+	/* Handle remote.* variables */
+	if (!strcmp(name, "pushdefault"))
+		return git_config_string(&pushremote_name, key, value);
+
+	/* Handle remote.<name>.* variables */
 	if (*name == '/') {
 		warning("Config remote shorthand cannot begin with '/': %s",
 			name);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 94e0189..ac1ec9d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -520,6 +520,18 @@ test_expect_success 'push with config remote.*.push = HEAD' '
 git config --remove-section remote.there
 git config --remove-section branch.master
 
+test_expect_success 'push with remote.pushdefault' '
+	mk_test up_repo heads/frotz &&
+	mk_test down_repo heads/master &&
+	test_config remote.up.url up_repo &&
+	test_config remote.down.url down_repo &&
+	test_config branch.master.remote up &&
+	test_config remote.pushdefault down &&
+	git push &&
+	test_must_fail check_push_result up_repo $the_commit heads/master &&
+	check_push_result down_repo $the_commit heads/master
+'
+
 test_expect_success 'push with config remote.*.pushurl' '
 
 	mk_test testrepo heads/master &&
-- 
1.8.2.141.g3797f84
