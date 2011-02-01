From: Libor Pechacek <lpechacek@suse.cz>
Subject: [PATCH v4] Disallow empty section and variable names
Date: Tue, 1 Feb 2011 08:13:47 +0100
Message-ID: <20110201071347.GH24297@fm.suse.cz>
References: <20110108144644.GA11019@localhost.suse.cz> <20110127145253.GD6312@fm.suse.cz> <20110130203445.GA9689@fm.suse.cz> <4D46694F.5070208@viscovery.net> <20110131091728.GB24297@fm.suse.cz> <4D468109.8020409@viscovery.net> <20110131130855.GC24297@fm.suse.cz> <4D46E7E7.4010805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 01 08:13:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkAR1-0003Pk-3t
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 08:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450Ab1BAHNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 02:13:49 -0500
Received: from cantor2.suse.de ([195.135.220.15]:33897 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167Ab1BAHNt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 02:13:49 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 339BB89994;
	Tue,  1 Feb 2011 08:13:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D46E7E7.4010805@web.de>
User-Agent: Mutt/1.5.18-muttng (2008-05-17-r1399)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165796>

It is possible to break your repository config by creating an invalid key.  The
config parser in turn chokes on it.

$ git init
Initialized empty Git repository in /tmp/gittest/.git/
$ git config .foo false
$ git config core.bare
fatal: bad config file line 6 in .git/config

This patch makes git-config reject keys which start or end with a dot and adds
tests for these cases.

Signed-off-by: Libor Pechacek <lpechacek@suse.cz>
---

Fix in t5526-fetch-submodules.sh was posted separately by Jens Lehmann.
Applies on top "Sanity-check config variable names".

 config.c               |   10 ++++++++--
 t/t1300-repo-config.sh |    4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index fde91f5..5eb89a7 100644
--- a/config.c
+++ b/config.c
@@ -1113,6 +1113,7 @@ int git_config_set(const char *key, const char *value)
 int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 {
 	int i, dot, baselen;
+	int keylen = strlen(key);
 	const char *last_dot = strrchr(key, '.');
 
 	/*
@@ -1120,11 +1121,16 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	 * key name separated by a dot, we have to know where the dot is.
 	 */
 
-	if (last_dot == NULL) {
+	if (last_dot == NULL || *key == '.') {
 		error("key does not contain a section: %s", key);
 		return -2;
 	}
 
+	if (keylen && key[keylen-1] == '.') {
+		error("key does not contain variable name: %s", key);
+		return -2;
+	}
+
 	baselen = last_dot - key;
 	if (baselen_)
 		*baselen_ = baselen;
@@ -1132,7 +1138,7 @@ int git_config_parse_key(const char *key, char **store_key, int *baselen_)
 	/*
 	 * Validate the key and while at it, lower case it for matching.
 	 */
-	*store_key = xmalloc(strlen(key) + 1);
+	*store_key = xmalloc(keylen + 1);
 
 	dot = 0;
 	for (i = 0; key[i]; i++) {
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index c3d91d1..53fb822 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -889,6 +889,10 @@ test_expect_success 'key sanity-checking' '
 	test_must_fail git config foo.1bar &&
 	test_must_fail git config foo."ba
 				z".bar &&
+	test_must_fail git config . false &&
+	test_must_fail git config .foo false &&
+	test_must_fail git config foo. false &&
+	test_must_fail git config .foo. false &&
 	git config foo.bar true &&
 	git config foo."ba =z".bar false
 '
-- 
1.7.4.rc3.11.g863f7
