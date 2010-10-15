From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC/PATCHv2 5/5] grep: add support for grepping in submodules
Date: Fri, 15 Oct 2010 16:26:44 -0700
Message-ID: <1287185204-843-6-git-send-email-judge.packham@gmail.com>
References: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, gitster@pobox.com,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 16 01:27:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6tgU-0001CE-3j
	for gcvg-git-2@lo.gmane.org; Sat, 16 Oct 2010 01:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab0JOX1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 19:27:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54764 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0JOX1O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 19:27:14 -0400
Received: by mail-pz0-f46.google.com with SMTP id 33so195843pzk.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8yBHaTUoi4yje5+b99HYL8a2eW2i6cfW0soB9aABL8U=;
        b=d/k99mtOY0wQxc/Cr3/NTuFaBszcfRNP/Z1/2andKm1hQruueduzsNrfBTDxA3Fbq6
         yeyFzpa9kaIM3mX6wpNUAiD58rACczzZvSRiPJ0JD6dbxBaYlMznGYDB3slGE7XMjB0z
         NYGgIJ13lvGMmbmJEezdEQjDeFAVFeNJK7OoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=obBn49Z6RP6YTVf+/QyaCT1nmNLLhWA1BuE5xY7i5l9m75agFwj4hr8HsjtsJUtNyi
         HWYWZUDgwM4pyJku/DQb2dwLH1DlTW5unb48LOynf+iuTLdFpX7MqjWftwMuUy7AMj28
         GHbdKzEvxFmhxUNC2OV5oBoHktxNyBrn4CwiY=
Received: by 10.142.134.17 with SMTP id h17mr1171461wfd.124.1287185234028;
        Fri, 15 Oct 2010 16:27:14 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id y42sm10506678wfd.10.2010.10.15.16.27.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 16:27:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1287185204-843-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159146>

When the --recurse-submodules option is given git grep will search in
submodules as they are encountered.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
The refspec from the super project is passed as an environment variable
along with the GIT_DIR and GIT_WORK_TREE. We re-build a command line for
the sub-process grep which works for the basic cases but I need to add
some more complex tests to ensure everything gets passed through
correctly.
    
At the moment I don't alter the pathspec or max-depth option but I'll do
so in a future re-roll.

 builtin/grep.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 grep.h         |    1 +
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 251c4e7..7bcdf05 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -587,6 +587,91 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 	free(argv);
 }
 
+static int pattern_list_to_argv(struct grep_opt *opt, const char **argv, int len)
+{
+	int i = 0;
+	struct grep_pat *p = opt->pattern_list;
+	while(p) {
+		if (i > len)
+			die("grep: not enough space for subprocess args");
+		if (p->token == GREP_PATTERN)
+			argv[i++] = "-e";
+		argv[i++] = p->pattern;
+		p = p->next;
+	}
+	return i;
+}
+
+static const char **create_sub_grep_argv(struct grep_opt *opt,
+		const char *path, const char *sha1, const char *tree_name)
+{
+	#define NUM_ARGS 10
+	struct strbuf buf = STRBUF_INIT;
+	const char **argv;
+	int i = 0;
+
+	argv = xcalloc(NUM_ARGS, sizeof(const char *));
+	argv[i++] = "grep";
+
+	if (opt->linenum)
+		argv[i++] = "-n";
+	if (opt->invert)
+		argv[i++] = "-v";
+	if (opt->ignore_case)
+		argv[i++] = "-i";
+	if (opt->count)
+		argv[i++] = "-c";
+	if (opt->name_only)
+		argv[i++] = "-l";
+	if (opt->recurse_submodules)
+		argv[i++] = "--recursive";
+
+	i += pattern_list_to_argv(opt, &argv[i], NUM_ARGS-(i+1));
+	if (sha1) {
+		argv[i++] = sha1;
+	}
+	argv[i++] = NULL;
+
+	strbuf_release(&buf);
+	return argv;
+}
+
+static int grep_submodule(struct grep_opt *opt, const char *path,
+			  const char *sha1, const char *tree_name)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf pre_buf = STRBUF_INIT;
+	struct child_process cp;
+	const char **argv = create_sub_grep_argv(opt, path, sha1, tree_name);
+	const char *git_dir;
+	int hit = 0;
+	memset(&cp, 0, sizeof(cp));
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile_gently(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_directory(git_dir))
+		goto out_free;
+
+	setenv("GIT_SUPER_REFNAME", tree_name, 1);
+	setenv(GIT_DIR_ENVIRONMENT, git_dir, 1);
+	setenv(GIT_WORK_TREE_ENVIRONMENT, path, 1);
+	cp.argv = argv;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	if (run_command(&cp) == 0)
+		hit = 1;
+out_free:
+	unsetenv("GIT_SUPER_REFNAME");
+	unsetenv(GIT_DIR_ENVIRONMENT);
+	unsetenv(GIT_WORK_TREE_ENVIRONMENT);
+	free(argv);
+	strbuf_release(&buf);
+	strbuf_release(&pre_buf);
+	return hit;
+}
+
 static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
 	int hit = 0;
@@ -597,6 +682,10 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 		struct cache_entry *ce = active_cache[nr];
 		if (!pathspec_matches(paths, ce->name, opt->max_depth))
 			continue;
+		if (S_ISGITLINK(ce->ce_mode) && opt->recurse_submodules) {
+			hit |= grep_submodule(opt, ce->name, NULL, NULL);
+			continue;
+		}
 		if (!S_ISREG(ce->ce_mode))
 			continue;
 		/*
@@ -634,11 +723,16 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 	char *down;
 	int tn_len = strlen(tree_name);
 	struct strbuf pathbuf;
+	const char *refname = getenv("GIT_SUPER_REFNAME");
+	int rn_len = refname ? strlen(refname) : 0;
 
-	strbuf_init(&pathbuf, PATH_MAX + tn_len);
+	strbuf_init(&pathbuf, PATH_MAX + MAX(tn_len, rn_len));
 
 	if (tn_len) {
-		strbuf_add(&pathbuf, tree_name, tn_len);
+		if (refname)
+			strbuf_add(&pathbuf, refname, rn_len);
+		else
+			strbuf_add(&pathbuf, tree_name, tn_len);
 		strbuf_addch(&pathbuf, ':');
 		tn_len = pathbuf.len;
 	}
@@ -664,6 +758,9 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			;
 		else if (S_ISREG(entry.mode))
 			hit |= grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
+		else if (S_ISGITLINK(entry.mode) && opt->recurse_submodules)
+			hit |= grep_submodule(opt, entry.path,
+				sha1_to_hex(entry.sha1), tree_name);
 		else if (S_ISDIR(entry.mode)) {
 			enum object_type type;
 			struct tree_desc sub;
@@ -931,6 +1028,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    "allow calling of grep(1) (ignored by this build)"),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, "show usage",
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
+		OPT_BOOLEAN(0, "recursive", &opt.recurse_submodules,
+			"recurse into submodules"),
 		OPT_END()
 	};
 
diff --git a/grep.h b/grep.h
index 06621fe..d5e2e11 100644
--- a/grep.h
+++ b/grep.h
@@ -101,6 +101,7 @@ struct grep_opt {
 	unsigned post_context;
 	unsigned last_shown;
 	int show_hunk_mark;
+	int recurse_submodules;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
-- 
1.7.3.1
