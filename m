From: jehan@orb.com
Subject: [PATCH v2] Add a setting to require a filter to be successful
Date: Thu, 16 Feb 2012 17:19:03 -0800
Message-ID: <4f3daaf7.e302440a.02ba.fffff463@mx.google.com>
References: <7vobsywck1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Cc: git@vger.kernel.org, jehan@orb.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 17 02:19:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyCTf-0002tO-MH
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 02:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab2BQBSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 20:18:49 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52041 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab2BQBSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 20:18:48 -0500
Received: by pbcun15 with SMTP id un15so3114801pbc.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 17:18:47 -0800 (PST)
Received: by 10.68.225.231 with SMTP id rn7mr3796154pbc.64.1329441527852;
        Thu, 16 Feb 2012 17:18:47 -0800 (PST)
Received: from jehan-Ubuntu-VBox.orb.com (173-167-111-189-sfba.hfc.comcastbusiness.net. [173.167.111.189])
        by mx.google.com with ESMTPS id 3sm3696437pbx.66.2012.02.16.17.18.46
        (version=SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 17:18:47 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <7vobsywck1.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQl9Dzi2wT+XPRwUB7sWee1kq8hozXHiFw8UTF3SDU3sUr+U4jAfaVS4rWbk7wgr7IlPyKsp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190928>

From: Jehan Bing <jehan@orb.com>

By default, if a filter driver fails, the unfiltered content will be
used. This is because the content filtering is done to massage the
content into a shape that is more convenient for the platform,
filesystem, and the user to use. The key phrase here is "more
convenient" and not "turning something unusable into usable".

However, another use of the content filtering is to store the content
that cannot be directly used in the repository (e.g. an UUID that
refers to the true content stored outside git, or an encrypted
content) and turn it into a usable form upon checkout (e.g. download
the external content, decrypt the encrypted content).
In this situation, it is preferable to have git fail instead of using
the unfiltered content.

This patch adds an optional "filter.<filtername>.required"
configuration variable. When missing or set to false, git will use
the unfiltered content if the filter driver fails (old behavior).
When set to true, git will instead abort the current operation.

Signed-off-by: Jehan Bing <jehan@orb.com>
---
Thanks Junio for your comment. This version use your version of
gitattributes.txt and I rewrote the commit message to be
stronger.

-Jehan

 Documentation/gitattributes.txt |   35 +++++++++++++++++++++++--------
 convert.c                       |   28 +++++++++++++++++++++---
 t/t0021-conversion.sh           |   43 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 13 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index a85b187..6abaf9a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -294,16 +294,23 @@ output is used to update the worktree file.  Similarly, the
 `clean` command is used to convert the contents of worktree file
 upon checkin.
 
-A missing filter driver definition in the config is not an error
-but makes the filter a no-op passthru.
+One use of the content filtering is to massage the content into a shape
+that is more convenient for the platform, filesystem, and the user to use.
 
-The content filtering is done to massage the content into a
-shape that is more convenient for the platform, filesystem, and
-the user to use.  The key phrase here is "more convenient" and not
-"turning something unusable into usable".  In other words, the
-intent is that if someone unsets the filter driver definition,
-or does not have the appropriate filter program, the project
-should still be usable.
+Another use of the content filtering is to store the content that cannot
+be directly used in the repository (e.g. an UUID that refers to the true
+content stored outside git, or an encrypted content) and turn it into a
+usable form upon checkout (e.g. download the external content, decrypt the
+encrypted content).
+
+These two filters behave differently, and by default, a filter is taken as
+the former, massaging the contents into more convenient shape.  A missing
+filter driver definition in the config, or a filter driver that exits with
+a non-zero status, is not an error but makes the filter a no-op passthru.
+
+You can declare that a filter turns a content that by itself is unusable
+into usable by setting filter.<drivername>.required configuration variable
+to `true`.
 
 For example, in .gitattributes, you would assign the `filter`
 attribute for paths.
@@ -335,6 +342,16 @@ input that is already correctly indented.  In this case, the lack of a
 smudge filter means that the clean filter _must_ accept its own output
 without modifying it.
 
+If a filter _must_ succeed in order to make the stored contents usable,
+you can declare that the filter is `required`, in the configuration:
+
+------------------------
+[filter "crypt"]
+	clean = openssl enc ...
+	smudge = openssl enc -d ...
+	required
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
