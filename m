From: Chris Packham <judge.packham@gmail.com>
Subject: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Wed, 29 Sep 2010 13:28:54 -0700
Message-ID: <1285792134-26339-4-git-send-email-judge.packham@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Wed Sep 29 22:29:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P13H6-000285-LL
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 22:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab0I2U3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 16:29:09 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:60120 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab0I2U3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 16:29:07 -0400
Received: by pwj5 with SMTP id 5so80109pwj.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lhKiUqOIKDj+Lsfr0++uKziAgAvGrzmLWA/aDcQdY0w=;
        b=v7hfFNTPMzI8+rFk01XlT6zV8g6EFw1XnE7yfgkmHEAu1GxyfcvBK9RODKazHsLUNZ
         HVOzW6M9eqxsnBNFAk1NJxlrdma+N8ukfY1RaRszMmTsp9uwKREXCV/+6g2kqWriXBZ3
         eLAV7esDncCT8DBJLh45jeRfA8iaZH7G3P9BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mIXyl4JWOCWUnLHLkMbL8F8v1/2b00l6yMiJhh18ijQ1crvEhivBUferN+wUeY80b/
         rcoDXtCRVXT3IxoNQNfKct6Oj36cyTcPQurBMysvb6z35FPZvVEm124ZcoKeLUvN4RR2
         oYbRsHThQgVTM3VlZTpaAZXdrYhq3mB2PgivI=
Received: by 10.114.52.2 with SMTP id z2mr2660045waz.84.1285792147472;
        Wed, 29 Sep 2010 13:29:07 -0700 (PDT)
Received: from localhost.localdomain (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm15169981wal.9.2010.09.29.13.29.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 13:29:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.dirty
In-Reply-To: <1285792134-26339-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157600>

When the --recurse-submodules option is given git grep will search in
submodules as they are encountered.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
 builtin/grep.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 grep.h         |    1 +
 2 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8315ff0..c9befdc 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -30,6 +30,9 @@ static char const * const grep_usage[] = {
 
 static int use_threads = 1;
 
+static int saved_argc;
+static const char **saved_argv;
+
 #ifndef NO_PTHREADS
 #define THREADS 8
 static pthread_t threads[THREADS];
@@ -585,6 +588,67 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 	free(argv);
 }
 
+static const char **create_sub_grep_argv(struct grep_opt *opt, const char *path)
+{
+	#define NUM_ARGS 10
+	struct strbuf buf = STRBUF_INIT;
+	const char **argv;
+	int i = 0;
+
+	argv = xcalloc(NUM_ARGS, sizeof(const char *));
+	argv[i++] = "grep";
+	strbuf_addf(&buf, "--submodule-prefix=\\\"%s\\\"", path);
+	//argv[i++] = buf.buf;
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
+
+	argv[i++] = saved_argv[0];
+	argv[i++] = NULL;
+
+	strbuf_release(&buf);
+	return argv;
+}
+
+static int grep_submodule(struct grep_opt *opt, const char *path)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct child_process cp;	
+	const char **argv = create_sub_grep_argv(opt, path);
+	const char *git_dir;
+	int hit = 0;
+
+	strbuf_addf(&buf, "%s/.git", path);
+	git_dir = read_gitfile_gently(buf.buf);
+	if (!git_dir)
+		git_dir = buf.buf;
+	if (!is_directory(git_dir)) {
+		warning("submodule %s has not been initialized\n", path);
+		goto out_free;
+	}
+
+	memset(&cp, 0, sizeof(cp));
+	cp.argv = argv;
+	cp.env = local_repo_env;
+	cp.git_cmd = 1;
+	cp.no_stdin = 1;
+	cp.dir = path;
+	if (run_command(&cp) == 0)
+		hit = 1;
+out_free:
+	free(argv);
+	strbuf_release(&buf);
+	return hit;
+}
+
 static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 {
 	int hit = 0;
@@ -593,6 +657,10 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 
 	for (nr = 0; nr < active_nr; nr++) {
 		struct cache_entry *ce = active_cache[nr];
+		if (S_ISGITLINK(ce->ce_mode) && opt->recurse_submodules) {
+			hit |= grep_submodule(opt, ce->name);
+			continue;
+		}
 		if (!S_ISREG(ce->ce_mode))
 			continue;
 		if (!pathspec_matches(paths, ce->name, opt->max_depth))
@@ -929,9 +997,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_STRING(0, "submodule-prefix", &opt.submodule_prefix, "DIR",
 			"prepend this to submodule path output"),
+		OPT_BOOLEAN(0, "recurse-submodules", &opt.recurse_submodules,
+			"recurse into submodules"),
 		OPT_END()
 	};
 
+	saved_argc = argc;
+	saved_argv = argv;
 	/*
 	 * 'git grep -h', unlike 'git grep -h <pattern>', is a request
 	 * to show usage information and exit.
diff --git a/grep.h b/grep.h
index d918da4..e3199c9 100644
--- a/grep.h
+++ b/grep.h
@@ -102,6 +102,7 @@ struct grep_opt {
 	unsigned post_context;
 	unsigned last_shown;
 	int show_hunk_mark;
+	int recurse_submodules;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);
-- 
1.7.3.dirty
