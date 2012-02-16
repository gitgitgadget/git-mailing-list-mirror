From: Jehan Bing <jehan@orb.com>
Subject: [PATCH] Add an option to require a filter to be successful
Date: Thu, 16 Feb 2012 15:18:48 -0800
Message-ID: <1329434328-26621-1-git-send-email-jehan@orb.com>
Mime-Version: 1.0
Cc: jehan@orb.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 00:18:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyAb2-0005qZ-4C
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 00:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754192Ab2BPXSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 18:18:38 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55858 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab2BPXSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 18:18:35 -0500
Received: by pbcun15 with SMTP id un15so3018837pbc.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 15:18:35 -0800 (PST)
Received: by 10.68.217.67 with SMTP id ow3mr18335128pbc.125.1329434315267;
        Thu, 16 Feb 2012 15:18:35 -0800 (PST)
Received: from jehan-Ubuntu-VBox.orb.com (173-167-111-189-sfba.hfc.comcastbusiness.net. [173.167.111.189])
        by mx.google.com with ESMTPS id r10sm15018009pbs.12.2012.02.16.15.18.34
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 15:18:34 -0800 (PST)
X-Mailer: git-send-email 1.7.9
X-Gm-Message-State: ALoCoQlY78TpApITYKIuKd7jRJSm+/2tKucBiQFxwQIYuEbbOdzzqcEfRqGtPY4znnItDjBC0B3H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190920>

By default, if a filter driver fails, the unfiltered content will be
used. This patch adds a "filter.<name>.required" config option. When
set to true, git will abort if the filter fails.

A typical usage would be for a "bigfile" filter, where the smudge
command can fail if the file is not available locally. Without the
"required", the content of repository, i.e. a reference to the real
content, will be checked out. Unless one saves the output logs, it
then fairly easy to lose track of what "bigfile" wasn't checked out
correctly.

Another example would be for an encrypted repository if the clean
command (encryption) fails. Without the "required", an unencrypted
content could be stored in the repository by mistake.

Signed-off-by: Jehan Bing <jehan@orb.com>
---
 Documentation/gitattributes.txt |   14 ++++++++++++
 convert.c                       |   28 +++++++++++++++++++++---
 t/t0021-conversion.sh           |   43 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a85b187..4d1af93 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -305,6 +305,10 @@ intent is that if someone unsets the filter driver definition,
 or does not have the appropriate filter program, the project
 should still be usable.
 
+The exception is if the filter definition has the `required`
+attribute set to `true`. In that case, the filter must apply
+successfully or git will abort the current operation.
+
 For example, in .gitattributes, you would assign the `filter`
 attribute for paths.
 
@@ -335,6 +339,16 @@ input that is already correctly indented.  In this case, the lack of a
 smudge filter means that the clean filter _must_ accept its own output
 without modifying it.
 
+If you do not wish git to continue if `clean` or `smudge` fail, you can
+add a `required` attribute to the filter:
+
+------------------------
+[filter "crypt"]
+	clean = openssl enc ...
+	smudge = openssl enc -d ...
+	required = true
+------------------------
+
 Sequence "%f" on the filter command line is replaced with the name of
 the file the filter is working on.  A filter might use this in keyword
 substitution.  For example:
diff --git a/convert.c b/convert.c
index 12868ed..6c95a90 100644
--- a/convert.c
+++ b/convert.c
@@ -429,6 +429,7 @@ static struct convert_driver {
 	struct convert_driver *next;
 	const char *smudge;
 	const char *clean;
+	int required;
 } *user_convert, **user_convert_tail;
 
 static int read_convert_config(const char *var, const char *value, void *cb)
@@ -472,6 +473,11 @@ static int read_convert_config(const char *var, const char *value, void *cb)
 	if (!strcmp("clean", ep))
 		return git_config_string(&drv->clean, var, value);
 
+	if (!strcmp("required", ep)) {
+		drv->required = git_config_bool(var, value);
+		return 0;
+	}
+
 	return 0;
 }
 
@@ -747,13 +753,19 @@ int convert_to_git(const char *path, const char *src, size_t len,
 {
 	int ret = 0;
 	const char *filter = NULL;
+	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv)
+	if (ca.drv) {
 		filter = ca.drv->clean;
+		required = ca.drv->required;
+	}
 
 	ret |= apply_filter(path, src, len, dst, filter);
+	if (!ret && required)
+		die("required filter '%s' failed", ca.drv->name);
+
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
@@ -771,13 +783,16 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
 					    int normalizing)
 {
-	int ret = 0;
+	int ret = 0, ret_filter = 0;
 	const char *filter = NULL;
+	int required = 0;
 	struct conv_attrs ca;
 
 	convert_attrs(&ca, path);
-	if (ca.drv)
+	if (ca.drv) {
 		filter = ca.drv->smudge;
+		required = ca.drv->required;
+	}
 
 	ret |= ident_to_worktree(path, src, len, dst, ca.ident);
 	if (ret) {
@@ -796,7 +811,12 @@ static int convert_to_working_tree_internal(const char *path, const char *src,
 			len = dst->len;
 		}
 	}
-	return ret | apply_filter(path, src, len, dst, filter);
+
+	ret_filter = apply_filter(path, src, len, dst, filter);
+	if (!ret_filter && required)
+		die("required filter %s failed", ca.drv->name);
+
+	return ret | ret_filter;
 }
 
 int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index f19e651..f80a59f 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -153,4 +153,47 @@ test_expect_success 'filter shell-escaped filenames' '
 	:
 '
 
+test_expect_success 'required filter success' '
+	git config filter.required.smudge cat &&
+	git config filter.required.clean cat &&
+	git config filter.required.required true &&
+
+	{
+	    echo "*.r filter=required"
+	} >.gitattributes &&
+
+	echo test > test.r &&
+	git add test.r &&
+	rm -f test.r &&
+	git checkout -- test.r
+'
+
+test_expect_success 'required filter smudge failure' '
+	git config filter.failsmudge.smudge false &&
+	git config filter.failsmudge.clean cat &&
+	git config filter.failsmudge.required true &&
+
+	{
+	    echo "*.fs filter=failsmudge"
+	} >.gitattributes &&
+
+	echo test > test.fs &&
+	git add test.fs &&
+	rm -f test.fs &&
+	! git checkout -- test.fs
+'
+
+test_expect_success 'required filter clean failure' '
+	git config filter.failclean.smudge cat &&
+	git config filter.failclean.clean false &&
+	git config filter.failclean.required true &&
+
+	{
+	    echo "*.fc filter=failclean"
+	} >.gitattributes &&
+
+	echo test > test.fc &&
+	! git add test.fc
+'
+
 test_done
-- 
1.7.9
