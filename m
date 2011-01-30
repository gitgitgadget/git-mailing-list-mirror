From: Libor Pechacek <lpechacek@suse.cz>
Subject: [PATCH v2] Disallow empty section and variable names
Date: Sun, 30 Jan 2011 21:34:45 +0100
Message-ID: <20110130203445.GA9689@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110127145253.GD6312@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 30 21:34:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjdz2-0005VW-Ef
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 21:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab1A3Uer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 15:34:47 -0500
Received: from cantor2.suse.de ([195.135.220.15]:35670 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683Ab1A3Ueq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 15:34:46 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 5E0BE8BB22
	for <git@vger.kernel.org>; Sun, 30 Jan 2011 21:34:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110127145253.GD6312@fm.suse.cz>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165700>

It is possible to break your repository config by creating an invalid key.  The
config parser in turn chokes on it.

$ git init
Initialized empty Git repository in /tmp/gittest/.git/
$ git config .foo false
$ git config .foo
fatal: bad config file line 6 in .git/config

This patch makes git-config reject keys which start or end with a dot, adds
tests for these cases and also fixes a typo in t5526-fetch-submodules, which
was exposed by the new check.

Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
---

Added tests for the cases checked, made git_config_parse_key consistently
return -2 when the key is invalid.  Applies on top "Sanity-check config
variable names".

 config.c                    |    8 +++++++-
 t/t1300-repo-config.sh      |    4 ++++
 t/t5526-fetch-submodules.sh |    2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index fde91f5..e27a39f 100644
--- a/config.c
+++ b/config.c
@@ -1120,11 +1120,17 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 * key name separated by a dot, we have to know where the dot is.
 	 */
 
-	if (last_dot == NULL) {
+	if (last_dot == NULL || *key == '.') {
 		error("key does not contain a section: %s", key);
 		return -2;
 	}
 
+	i = strlen(key);
+	if (i && key[i-1] == '.') {
+		error("key does not contain variable name: %s", key);
+		return -2;
+	}
+
 	baselen = last_dot - key;
 	if (baselen_)
 		*baselen_ = baselen;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c3d91d1..568d51d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -889,6 +889,10 @@ test_expect_success 'key sanity-checking' '
 	test_must_fail git config foo.1bar &&
 	test_must_fail git config foo."ba
 				z".bar &&
+	test_must_fail git config . &&
+	test_must_fail git config .foo &&
+	test_must_fail git config foo. &&
+	test_must_fail git config .foo. &&
 	git config foo.bar true &&
 	git config foo."ba =z".bar false
 '
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 884a5e5..7106c6c 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -124,7 +124,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
 	(
 		cd downstream &&
 		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
-		git config -f --unset .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
+		git config -f .gitmodules --unset submodule.submodule.fetchRecurseSubmodules true &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_cmp expect.out actual.out &&
-- 
1.7.4.rc3.11.g54760
