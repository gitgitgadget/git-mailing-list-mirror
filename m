From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] update-index: teach --cacheinfo a new syntax "mode,sha1,path"
Date: Mon, 24 Mar 2014 10:52:04 -0700
Message-ID: <1395683525-2868-3-git-send-email-gitster@pobox.com>
References: <1395481654-5920-1-git-send-email-ilya.bobyr@gmail.com>
 <1395683525-2868-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 18:52:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS92w-00038Z-05
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbaCXRwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:52:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692AbaCXRwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 13:52:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EEF875B1A;
	Mon, 24 Mar 2014 13:52:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OEkT
	xSM8au2WALzQu35usVrfIhE=; b=NmCscz98V/kyfF38yPXbXfBqS9VcZmEQvjUi
	mVGdm9Ct0drjPWseTTsqsZ6Np/bqgpSwGGGm9GSdG99bn5VVD3MK0Sk43/eyh9xk
	LUt9zZJ1Optg9bl7GnwlyZrARsJ82UUKVarU5W2OZx59lPEcM2ijT4fKiD2nU3hs
	1SKduWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=L3pmaV
	1HpT4xkvFY07/LfoTvAUapk8mGf1FyYJsRoDFCtdlQ8Z0GHyqSTe6PkoW/j0iefb
	BeMbqnjmSSYNY5ysJdP1FF0PQOcjbbCCs9GREWr8Sk4WaYPOyGB0N7UaiiE2/RC8
	c0Oidih0MzQG2rGyrDS1IUGehFJZ0+JkfTzJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BF3A75B19;
	Mon, 24 Mar 2014 13:52:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B761875B17;
	Mon, 24 Mar 2014 13:52:14 -0400 (EDT)
X-Mailer: git-send-email 1.9.1-471-g8d9dec6
In-Reply-To: <1395683525-2868-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 08961BC6-B37D-11E3-B37A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244827>

The "--cacheinfo" option is unusual in that it takes three option
parameters.  An option with an optional parameter is bad enough.  An
option with multiple parameters is simply insane.

Introduce a new syntax that takes these three things concatenated
together with a comma, which makes the command line syntax more
uniform across subcommands, while retaining the traditional syntax
for backward compatiblity.

If we were designing the "update-index" subcommand from scratch
today, it may probably have made sense to make this option (and
possibly others) a command mode option that does not take any option
parameter (hence no need for arg-help).  But we do not live in such
an ideal world, and as far as I can tell, the command still supports
(and must support) mixed command modes in a single invocation, e.g.

    $ git update-index path1 --add path2 \
        --cacheinfo 100644 $(git hash-object --stdin -w <path3) path3 \
	path4

must make sure path1 is already in the index and update all of these
four paths.  So this is probably as far as we can go to fix this issue
without risking to break people's existing scripts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt |  8 ++++++--
 builtin/update-index.c             | 34 +++++++++++++++++++++++++++++++---
 t/t2107-update-index-basic.sh      | 13 +++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e0a8702..d6de4a0 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git update-index'
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
-	     [(--cacheinfo <mode> <object> <file>)...]
+	     [(--cacheinfo <mode>,<object>,<file>)...]
 	     [--chmod=(+|-)x]
 	     [--[no-]assume-unchanged]
 	     [--[no-]skip-worktree]
@@ -68,8 +68,12 @@ OPTIONS
 --ignore-missing::
 	Ignores missing files during a --refresh
 
+--cacheinfo <mode>,<object>,<path>::
 --cacheinfo <mode> <object> <path>::
-	Directly insert the specified info into the index.
+	Directly insert the specified info into the index.  For
+	backward compatibility, you can also give these three
+	arguments as three separate parameters, but new users are
+	encouraged to use a single-parameter form.
 
 --index-info::
         Read index information from stdin.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d12ad95..ba54e19 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -629,14 +629,42 @@ static int resolve_undo_clear_callback(const struct option *opt,
 	return 0;
 }
 
+static int parse_new_style_cacheinfo(const char *arg,
+				     unsigned int *mode,
+				     unsigned char sha1[],
+				     const char **path)
+{
+	unsigned long ul;
+	char *endp;
+
+	errno = 0;
+	ul = strtoul(arg, &endp, 8);
+	if (errno || endp == arg || *endp != ',' || (unsigned int) ul != ul)
+		return -1; /* not a new-style cacheinfo */
+	*mode = ul;
+	endp++;
+	if (get_sha1_hex(endp, sha1) || endp[40] != ',')
+		return -1;
+	*path = endp + 41;
+	return 0;
+}
+
 static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 				const struct option *opt, int unset)
 {
 	unsigned char sha1[20];
 	unsigned int mode;
+	const char *path;
 
+	if (!parse_new_style_cacheinfo(ctx->argv[1], &mode, sha1, &path)) {
+		if (add_cacheinfo(mode, sha1, path, 0))
+			die("git update-index: --cacheinfo cannot add %s", path);
+		ctx->argv++;
+		ctx->argc--;
+		return 0;
+	}
 	if (ctx->argc <= 3)
-		return error("option 'cacheinfo' expects three arguments");
+		return error("option 'cacheinfo' expects <mode>,<sha1>,<path>");
 	if (strtoul_ui(*++ctx->argv, 8, &mode) ||
 	    get_sha1_hex(*++ctx->argv, sha1) ||
 	    add_cacheinfo(mode, sha1, *++ctx->argv, 0))
@@ -740,9 +768,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			really_refresh_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
-			N_("<mode> <object> <path>"),
+			N_("<mode>,<object>,<path>"),
 			N_("add the specified entry to the index"),
-			PARSE_OPT_NOARG |	/* disallow --cacheinfo=<mode> form */
+			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			(parse_opt_cb *) cacheinfo_callback},
 		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
index a6405d3..fe2fb17 100755
--- a/t/t2107-update-index-basic.sh
+++ b/t/t2107-update-index-basic.sh
@@ -48,4 +48,17 @@ test_expect_success '--cacheinfo does not accept gitlink null sha1' '
 	test_cmp expect actual
 '
 
+test_expect_success '--cacheinfo mode,sha1,path (new syntax)' '
+	echo content >file &&
+	git hash-object -w --stdin <file >expect &&
+
+	git update-index --add --cacheinfo 100644 "$(cat expect)" file &&
+	git rev-parse :file >actual &&
+	test_cmp expect actual &&
+
+	git update-index --add --cacheinfo "100644,$(cat expect),elif" &&
+	git rev-parse :elif >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.9.1-471-gcccbd8b
