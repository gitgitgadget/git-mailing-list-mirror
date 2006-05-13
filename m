From: Linus Torvalds <torvalds@osdl.org>
Subject: git diff: support "-U" and "--unified" options properly
Date: Sat, 13 May 2006 13:23:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605131317200.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat May 13 22:24:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ff0en-0003CR-3J
	for gcvg-git@gmane.org; Sat, 13 May 2006 22:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWEMUXy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 May 2006 16:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWEMUXy
	(ORCPT <rfc822;git-outgoing>); Sat, 13 May 2006 16:23:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29867 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750861AbWEMUXy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 May 2006 16:23:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4DKNntH014301
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 13 May 2006 13:23:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4DKNnoV020951;
	Sat, 13 May 2006 13:23:49 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.224 required=5 tests=REMOVE_REMOVAL_NEAR
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19944>


We used to parse "-U" and "--unified" as part of the GIT_DIFF_OPTS 
environment variable, but strangely enough we would _not_ parse them as 
part of the normal diff command line (where we only accepted "-u").

This adds parsing of -U and --unified, both with an optional numeric 
argument. So now you can just say

	git diff --unified=5

to get a unified diff with a five-line context, instead of having to do 
something silly like

	GIT_DIFF_OPTS="--unified=5" git diff -u

(that silly format does continue to still work, of course).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

[ Maybe this can still hit 1.3.3? ]

diff --git a/combine-diff.c b/combine-diff.c
index 8a8fe38..64b20cc 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -608,6 +608,7 @@ static int show_patch_diff(struct combin
 	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
 	mmfile_t result_file;
 
+	context = opt->context;
 	/* Read the result of merge first */
 	if (!working_tree_file)
 		result = grab_blob(elem->sha1, &result_size);
diff --git a/diff.c b/diff.c
index 7a7b839..be925a3 100644
--- a/diff.c
+++ b/diff.c
@@ -558,7 +558,7 @@ static void builtin_diff(const char *nam
 
 		ecbdata.label_path = lbl;
 		xpp.flags = XDF_NEED_MINIMAL;
-		xecfg.ctxlen = 3;
+		xecfg.ctxlen = o->context;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (!diffopts)
 			;
@@ -1182,6 +1182,7 @@ void diff_setup(struct diff_options *opt
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
+	options->context = 3;
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
@@ -1222,11 +1223,60 @@ int diff_setup_done(struct diff_options 
 	return 0;
 }
 
+int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
+{
+	char c, *eq;
+	int len;
+
+	if (*arg != '-')
+		return 0;
+	c = *++arg;
+	if (!c)
+		return 0;
+	if (c == arg_short) {
+		c = *++arg;
+		if (!c)
+			return 1;
+		if (val && isdigit(c)) {
+			char *end;
+			int n = strtoul(arg, &end, 10);
+			if (*end)
+				return 0;
+			*val = n;
+			return 1;
+		}
+		return 0;
+	}
+	if (c != '-')
+		return 0;
+	arg++;
+	eq = strchr(arg, '=');
+	if (eq)
+		len = eq - arg;
+	else
+		len = strlen(arg);
+	if (!len || strncmp(arg, arg_long, len))
+		return 0;
+	if (eq) {
+		int n;
+		char *end;
+		if (!isdigit(*++eq))
+			return 0;
+		n = strtoul(eq, &end, 10);
+		if (*end)
+			return 0;
+		*val = n;
+	}
+	return 1;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
 	const char *arg = av[0];
 	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
 		options->output_format = DIFF_FORMAT_PATCH;
+	else if (opt_arg(arg, 'U', "unified", &options->context))
+		options->output_format = DIFF_FORMAT_PATCH;
 	else if (!strcmp(arg, "--patch-with-raw")) {
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_raw = 1;
diff --git a/diff.h b/diff.h
index d052608..bef586d 100644
--- a/diff.h
+++ b/diff.h
@@ -32,6 +32,7 @@ struct diff_options {
 		 full_index:1,
 		 silent_on_remove:1,
 		 find_copies_harder:1;
+	int context;
 	int break_opt;
 	int detect_rename;
 	int line_termination;
