From: Libor Pechacek <lpechacek@suse.cz>
Subject: [PATCH] Disallow empty section and variable names
Date: Thu, 27 Jan 2011 15:52:53 +0100
Message-ID: <20110127145253.GD6312@fm.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 27 15:53:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiTDX-0000Lu-KL
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 15:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab1A0Owy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 09:52:54 -0500
Received: from cantor.suse.de ([195.135.220.2]:36789 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab1A0Owy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 09:52:54 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5954593EE3
	for <git@vger.kernel.org>; Thu, 27 Jan 2011 15:52:53 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165581>

It is possible to break you repository config by creating an invalid config
option.  The config parser in turn chokes on it.

$ git init
Initialized empty Git repository in /tmp/gittest/.git/
$ git config .foo false
$ git config .foo
fatal: bad config file line 6 in .git/config

This patch makes git-config reject keys which start or end with a dot.  The fix
also revealed a typo in t5526-fetch-submodules, which is fixed by this patch as
well.

Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
---

Applies on top "Sanity-check config variable names".

 config.c                    |    7 ++++++-
 t/t5526-fetch-submodules.sh |    2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index c976544..81a0705 100644
--- a/config.c
+++ b/config.c
@@ -1119,7 +1119,7 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 * key name separated by a dot, we have to know where the dot is.
 	 */
 
-	if (last_dot == NULL) {
+	if (last_dot == NULL || *key == '.') {
 		error("key does not contain a section: %s", key);
 		return -2;
 	}
@@ -1156,6 +1156,11 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	if (store_key)
 		(*store_key)[i] = 0;
 
+	if (key[i-1] == '.') {
+		error("key does not contain variable name: %s", key);
+		goto out_free_ret_1;
+	}
+
 	return 0;
 
 out_free_ret_1:
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
1.7.4.rc3.3.g8b2bfe
