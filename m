From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 02:32:46 +0100
Message-ID: <20091219013246.GD25474@genesis.frugalware.org>
References: <4B2C0828.4010505@signalbeam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Moe <moe@signalbeam.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 02:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLoBj-0000YN-O2
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 02:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934AbZLSBcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 20:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbZLSBcu
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 20:32:50 -0500
Received: from virgo.iok.hu ([212.40.97.103]:36875 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664AbZLSBct (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 20:32:49 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 79C295809D;
	Sat, 19 Dec 2009 02:32:47 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4D10644965;
	Sat, 19 Dec 2009 02:32:47 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id EEF9C1240014; Sat, 19 Dec 2009 02:32:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B2C0828.4010505@signalbeam.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135454>

This is like GIT_CONFIG but it is not read instead of .git/config, but
in addtition to it.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Dec 18, 2009 at 11:54:32PM +0100, Moe <moe@signalbeam.net> wrote:
> $GIT_CONFIG doesn't work for this purpose because when set
> git will *only* read the referenced file and ignore the
> repository settings.

What about this?

 Documentation/git-config.txt |    3 +++
 builtin-config.c             |    7 ++++++-
 config.c                     |    9 ++++++++-
 t/t1300-repo-config.sh       |   16 ++++++++++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index f68b198..668db3f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -211,6 +211,9 @@ GIT_CONFIG::
 	Using the "--global" option forces this to ~/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
 
+GIT_CONFIG_EXTRA::
+	Take the configuration from the given file in addition to .git/config.
+
 See also <<FILES>>.
 
 
diff --git a/builtin-config.c b/builtin-config.c
index a2d656e..4a702f6 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -142,7 +142,7 @@ static int get_value(const char *key_, const char *regex_)
 	int ret = -1;
 	char *tl;
 	char *global = NULL, *repo_config = NULL;
-	const char *system_wide = NULL, *local;
+	const char *system_wide = NULL, *local, *extra = NULL;
 
 	local = config_exclusive_filename;
 	if (!local) {
@@ -152,6 +152,7 @@ static int get_value(const char *key_, const char *regex_)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
 		if (git_config_system())
 			system_wide = git_etc_gitconfig();
+		extra = getenv("GIT_CONFIG_EXTRA");
 	}
 
 	key = xstrdup(key_);
@@ -185,11 +186,15 @@ static int get_value(const char *key_, const char *regex_)
 		git_config_from_file(show_config, system_wide, NULL);
 	if (do_all && global)
 		git_config_from_file(show_config, global, NULL);
+	if (do_all && extra)
+		git_config_from_file(show_config, extra, NULL);
 	git_config_from_file(show_config, local, NULL);
 	if (!do_all && !seen && global)
 		git_config_from_file(show_config, global, NULL);
 	if (!do_all && !seen && system_wide)
 		git_config_from_file(show_config, system_wide, NULL);
+	if (!do_all && !seen && extra)
+		git_config_from_file(show_config, extra, NULL);
 
 	free(key);
 	if (regexp) {
diff --git a/config.c b/config.c
index 37385ce..cf816ed 100644
--- a/config.c
+++ b/config.c
@@ -700,7 +700,7 @@ int git_config(config_fn_t fn, void *data)
 {
 	int ret = 0, found = 0;
 	char *repo_config = NULL;
-	const char *home = NULL;
+	const char *home = NULL, *extra = NULL;
 
 	/* Setting $GIT_CONFIG makes git read _only_ the given config file. */
 	if (config_exclusive_filename)
@@ -727,6 +727,13 @@ int git_config(config_fn_t fn, void *data)
 		found += 1;
 	}
 	free(repo_config);
+
+	extra = getenv("GIT_CONFIG_EXTRA");
+	if (extra && !access(extra, R_OK)) {
+		ret += git_config_from_file(fn, extra, data);
+		found += 1;
+	}
+
 	if (found == 0)
 		return -1;
 	return ret;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 83b7294..ed7fcb6 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -398,6 +398,22 @@ test_expect_success 'alternative GIT_CONFIG' 'cmp output expect'
 test_expect_success 'alternative GIT_CONFIG (--file)' \
 	'git config --file other-config -l > output && cmp output expect'
 
+cat > extra-config <<EOF
+[extra]
+	config = value
+EOF
+
+cat > expect << EOF
+c
+value
+EOF
+
+test_expect_success 'additional GIT_CONFIG_EXTRA' '
+	GIT_CONFIG_EXTRA=extra-config git config a.b > output &&
+	GIT_CONFIG_EXTRA=extra-config git config extra.config >> output &&
+	cmp output expect
+'
+
 GIT_CONFIG=other-config git config anwohner.park ausweis
 
 cat > expect << EOF
-- 
1.6.5.2
