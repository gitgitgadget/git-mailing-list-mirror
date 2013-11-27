From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 09/24] ls-files.c: use index api
Date: Wed, 27 Nov 2013 13:00:44 +0100
Message-ID: <1385553659-9928-10-git-send-email-t.gummerer@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Cc: t.gummerer@gmail.com, gitster@pobox.com, tr@thomasrast.ch,
	mhagger@alum.mit.edu, pclouds@gmail.com,
	robin.rosenberg@dewire.com, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 27 13:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vldog-0001tV-MV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 13:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab3K0MB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 07:01:56 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:50049 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab3K0MBy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 07:01:54 -0500
Received: by mail-lb0-f171.google.com with SMTP id q8so5460668lbi.30
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 04:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G8GtkWON9Xr7peI0L98SFtf1u/V4sfbl1x5lOhFKx8I=;
        b=zASZ12HutymYbUAexB+RtL7qP4ev6ju7Q0PpqEDgIntDUBmETmK69sdAamVDo5IMs8
         kfE/pgFYVCdmxUufnPysE4OySnbbjXjl4t7ZY1D8aaEnaxM39XyL49kcrGSwza9h4AKJ
         pLOgj3IxXcQjfnBL+Ck5vK0Aw2zblQMh3pZeL9GVtlTb33wxm17vIMVWf4Ga6W9X91Yz
         Urw96PnQs+352VF/JX3ypNvXlg49Js+azATbE4gvd/vfK48QKzA+m8IW+C0n5MfRgBLM
         wgkZrkWpGaoMdhhP98+Xyd5V/DkGB50Q2h2mJwsYfgShZu5Bf4UK4uxSP0EcZ1ZLEhU5
         MEnw==
X-Received: by 10.152.140.193 with SMTP id ri1mr29726261lab.18.1385553713029;
        Wed, 27 Nov 2013 04:01:53 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id c10sm42354286lbd.9.2013.11.27.04.01.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2013 04:01:51 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238423>

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/ls-files.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1cf6d8..22fb012 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -290,6 +290,22 @@ static void prune_cache(const char *prefix)
 	active_nr = last;
 }
 
+static int needs_trailing_slash_stripped(void)
+{
+	int i;
+
+	if (!pathspec.nr)
+		return 0;
+
+	for (i = 0; i < pathspec.nr; i++) {
+		int len = strlen(pathspec.items[i].original);
+
+		if (len > 1 && (pathspec.items[i].original)[len - 1] == '/')
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -447,6 +463,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct dir_struct dir;
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct filter_opts *opts = xmalloc(sizeof(*opts));
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			N_("paths are separated with NUL character"),
@@ -512,9 +529,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		prefix_len = strlen(prefix);
 	git_config(git_default_config, NULL);
 
-	if (read_cache() < 0)
-		die("index file corrupt");
-
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
@@ -550,6 +564,24 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
 
+	if (!with_tree && !needs_trailing_slash_stripped()) {
+		memset(opts, 0, sizeof(*opts));
+		opts->pathspec = &pathspec;
+		opts->read_staged = 1;
+		if (show_resolve_undo)
+			opts->read_resolve_undo = 1;
+		if (read_cache_filtered(opts) < 0)
+			die("index file corrupt");
+	} else {
+		if (read_cache() < 0)
+			die("index file corrupt");
+		parse_pathspec(&pathspec, 0,
+			       PATHSPEC_PREFER_CWD |
+			       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+			       prefix, argv);
+
+	}
+
 	/* Find common prefix for all pathspec's */
 	max_prefix = common_prefix(&pathspec);
 	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
-- 
1.8.4.2
