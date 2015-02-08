From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/21] nd/list-files updates
Date: Sun,  8 Feb 2015 16:01:18 +0700
Message-ID: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:02:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNl5-0005g9-P4
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:02:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbbBHJCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 04:02:21 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:48987 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbBHJCT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:02:19 -0500
Received: by mail-pa0-f54.google.com with SMTP id kx10so11829357pab.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=tzpWKRhHw4YBiSIHSG0AprIuNslYkg0lHx7OKHwgPB8=;
        b=l13JRelE1ub9JqmktEflVw5NekKNsLEQzD4NIwnQiUvWIdk/4+udyeX6RRY6V93h4V
         jM98lKCEBT1t2E7Z2k9hcajkZV0TKWsurzHCvownPmCIo6MNgnoGKVoZ1FVm6Vzt3Yjl
         mwR9uPRF3wufrl8r7LtapHjT3ffwRtHcf2dUob/KwbSDbfOpNhmLMAUeMwGgPXdi8ipo
         GxgdbA8/95WCq+sC2gcKZgg569WqNA9q5Xjk/moMroki1gmEg5LlcABShn1WdjTorb4H
         YTQyx7u6El3s5sJE3KkbuwJn6bYRkQGBsCM/JCO6GSrZaQuexr56qtBGlHPzhzfSfXP8
         fWog==
X-Received: by 10.66.149.98 with SMTP id tz2mr19062716pab.63.1423386138726;
        Sun, 08 Feb 2015 01:02:18 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id ci17sm12943968pdb.70.2015.02.08.01.02.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:02:18 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:02:26 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263487>

- 02/21: fix a bug that ignores config keys if $LS_COLORS is not defined
- 09/21: use listFiles instead of list-files in config keys
- 17/21: incorporate match_pathspec changes from Junio,
    use strbuf_swap in show_as_directory()
- 21/21: use test_decode_color and test_when_finished in t3080

Full diff of changes is

-- 8< --
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 74da715..2dc4788 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -940,7 +940,7 @@ color.status.<slot>::
 	to red). The values of these variables may be specified as in
 	color.branch.<slot>.
 
-color.list-files::
+color.listFiles::
 	A boolean to enable/disable color in the output of
 	linkgit:git-list-files[1]. May be set to `always`, `false` (or
 	`never`) or `auto` (or `true`), in which case colors are used
@@ -1018,7 +1018,7 @@ column.clean::
 	Specify the layout when list items in `git clean -i`, which always
 	shows files and directories in columns. See `column.ui` for details.
 
-column.list-files::
+column.listFiles::
 	Specify whether to output tag listing in `git list-files` in columns.
 	See `column.ui` for details.
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b04c712..b5e1a59 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -229,8 +229,8 @@ static int show_as_directory(const struct cache_entry *ce)
 		if (want_color(use_color)) {
 			struct strbuf sb3 = STRBUF_INIT;
 			color_filename(&sb3, ce->name, sb2.buf, S_IFDIR, 1);
-			strbuf_release(&sb2);
-			sb2 = sb3;
+			strbuf_swap(&sb2, &sb3);
+			strbuf_release(&sb3);
 		}
 		if (show_tag)
 			strbuf_insert(&sb2, 0, tag_cached, strlen(tag_cached));
@@ -258,33 +258,41 @@ static void write_ce_name(struct strbuf *sb, const struct cache_entry *ce)
 	strbuf_release(&quoted);
 }
 
+static int match_pathspec_with_depth(struct pathspec *ps,
+				     const char *name, int namelen,
+				     int prefix, char *seen, int is_dir,
+				     const int *custom_depth)
+{
+	int saved_depth = ps->max_depth;
+	int result;
+
+	if (custom_depth)
+		ps->max_depth = *custom_depth;
+	result = match_pathspec(ps, name, namelen, prefix, seen, is_dir);
+	if (custom_depth)
+		ps->max_depth = saved_depth;
+	return result;
+}
+
 static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 {
 	static struct strbuf sb = STRBUF_INIT;
-	int len = max_prefix_len, saved_max_depth;
+	static const int infinite_depth = -1;
+	int len = max_prefix_len;
 
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (show_dirs) {
-		/* ignore depth to catch dirs that contain matched entries */
-		saved_max_depth = pathspec.max_depth;
-		pathspec.max_depth = -1;
-	}
-
-	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-			    len, ps_matched,
-			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
+	if (!match_pathspec_with_depth(&pathspec, ce->name, ce_namelen(ce),
+				       len, ps_matched,
+				       S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode),
+				       show_dirs ? &infinite_depth : NULL))
 		return;
 
-	if (show_dirs) {
-		pathspec.max_depth = saved_max_depth;
-		if (strchr(ce->name, '/') &&
-		    !match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-				    prefix_len, NULL, 1) &&
-		    show_as_directory(ce))
-			return;
-	}
+	if (show_dirs &&strchr(ce->name, '/') &&
+	    !match_pathspec(&pathspec, ce->name, ce_namelen(ce), prefix_len, NULL, 1) &&
+	    show_as_directory(ce))
+		return;
 
 	if (tag && *tag && show_valid_bit &&
 	    (ce->ce_flags & CE_VALID)) {
@@ -697,8 +705,8 @@ static int option_parse_exclude_standard(const struct option *opt,
 static int git_ls_config(const char *var, const char *value, void *cb)
 {
 	if (starts_with(var, "column."))
-		return git_column_config(var, value, "list-files", &colopts);
-	if (!strcmp(var, "color.list-files")) {
+		return git_column_config(var, value, "listfiles", &colopts);
+	if (!strcmp(var, "color.listfiles")) {
 		use_color = git_config_colorbool(var, value);
 		return 0;
 	}
diff --git a/ls_colors.c b/ls_colors.c
index 9259ad3..011a8b9 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -326,8 +326,10 @@ void parse_ls_color(void)
 	char *start;
 	size_t len;
 
-	if ((p = getenv("LS_COLORS")) == NULL || *p == '\0')
+	if ((p = getenv("LS_COLORS")) == NULL || *p == '\0') {
+		git_config(ls_colors_config, NULL);
 		return;
+	}
 
 	ext = NULL;
 	strcpy(label, "??");
diff --git a/t/t3080-list-files.sh b/t/t3080-list-files.sh
index 6313dd9..01b9662 100755
--- a/t/t3080-list-files.sh
+++ b/t/t3080-list-files.sh
@@ -15,16 +15,26 @@ test_expect_success 'setup' '
 
 test_expect_success 'LS_COLORS env variable' '
 	LS_COLORS="rs=0:fi=31:di=32" \
-		git list-files --color=always | grep -v gitlink >actual &&
-	test_cmp "$TEST_DIRECTORY"/t3080/ls_colors actual
+		git list-files --color=always | test_decode_color | \
+		grep -v gitlink >actual &&
+	cat >expected <<-\EOF &&
+	<GREEN>dir<RESET>
+	<RED>file<RESET>
+	EOF
+	test_cmp expected actual
 '
 
 test_expect_success 'color.ls.*' '
 	test_config color.ls.file red &&
 	test_config color.ls.directory green &&
 	test_config color.ls.submodule yellow &&
-	git list-files --color=always >actual &&
-	test_cmp "$TEST_DIRECTORY"/t3080/color_ls actual
+	git list-files --color=always | test_decode_color >actual &&
+	cat >expected <<-\EOF &&
+	<GREEN>dir<RESET>
+	<RED>file<RESET>
+	<YELLOW>gitlink<RESET>
+	EOF
+	test_cmp expected actual
 '
 
 test_expect_success 'column output' '
@@ -78,6 +88,7 @@ test_expect_success 'globbing' '
 '
 
 test_expect_success 'no dups' '
+	test_when_finished "git checkout file" &&
 	echo dirty >>file &&
 	git list-files -m file >actual &&
 	echo "file" >expected &&
@@ -100,6 +111,7 @@ test_expect_success '--classify' '
 '
 
 test_expect_success 'diff-cached' '
+	test_when_finished "git checkout file" &&
 	echo dirty >>file &&
 	git add file &&
 	git list-files -M >actual &&
diff --git a/t/t3080/color_ls b/t/t3080/color_ls
deleted file mode 100644
index 47f77ad..0000000
--- a/t/t3080/color_ls
+++ /dev/null
@@ -1,3 +0,0 @@
-[32mdir[m
-[31mfile[m
-[33mgitlink[m
diff --git a/t/t3080/ls_colors b/t/t3080/ls_colors
deleted file mode 100644
index 423c016..0000000
--- a/t/t3080/ls_colors
+++ /dev/null
@@ -1,2 +0,0 @@
-[32mdir[m
-[31mfile[m
-- 8< --
-- 
2.3.0.rc1.137.g477eb31
