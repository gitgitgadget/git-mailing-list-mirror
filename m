From: Samuel Tardieu <sam@rfc1149.net>
Subject: [v3 PATCH 1/2] Honor "tagopt = --tags" configuration option
Date: Tue, 20 Apr 2010 01:31:25 +0200
Message-ID: <20100419233125.3631.97051.stgit@localhost.localdomain>
References: <20100419233026.3631.67086.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 20 01:31:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O40RH-0006Pb-94
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 01:31:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab0DSXb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 19:31:27 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:36920 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140Ab0DSXb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 19:31:27 -0400
Received: from localhost.localdomain (unknown [192.168.9.2])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id C221E6541
	for <git@vger.kernel.org>; Tue, 20 Apr 2010 01:31:25 +0200 (CEST)
In-Reply-To: <20100419233026.3631.67086.stgit@localhost.localdomain>
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145342>

If the "tagopt = --tags" option of a remote is set, all tags
will be fetched as in "git fetch --tags".

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 Documentation/config.txt      |    4 +++-
 contrib/examples/git-fetch.sh |    4 +++-
 remote.c                      |    2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f45ae9c..8e7fd88 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1587,7 +1587,9 @@ remote.<name>.uploadpack::
 
 remote.<name>.tagopt::
 	Setting this value to \--no-tags disables automatic tag following when
-	fetching from remote <name>
+	fetching from remote <name>. Setting it to \--tags will fetch every
+	tag from remote <name>, even if they are not reachable from remote
+	branch heads.
 
 remote.<name>.vcs::
 	Setting this to a value <vcs> will cause git to interact with
diff --git a/contrib/examples/git-fetch.sh b/contrib/examples/git-fetch.sh
index e44af2c..a314273 100755
--- a/contrib/examples/git-fetch.sh
+++ b/contrib/examples/git-fetch.sh
@@ -127,10 +127,12 @@ then
 	orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
 fi
 
-# Allow --notags from remote.$1.tagopt
+# Allow --tags/--notags from remote.$1.tagopt
 case "$tags$no_tags" in
 '')
 	case "$(git config --get "remote.$1.tagopt")" in
+	--tags)
+		tags=t ;;
 	--no-tags)
 		no_tags=t ;;
 	esac
diff --git a/remote.c b/remote.c
index c70181c..0f073e0 100644
--- a/remote.c
+++ b/remote.c
@@ -443,6 +443,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	} else if (!strcmp(subkey, ".tagopt")) {
 		if (!strcmp(value, "--no-tags"))
 			remote->fetch_tags = -1;
+		else if (!strcmp(value, "--tags"))
+			remote->fetch_tags = 2;
 	} else if (!strcmp(subkey, ".proxy")) {
 		return git_config_string((const char **)&remote->http_proxy,
 					 key, value);
