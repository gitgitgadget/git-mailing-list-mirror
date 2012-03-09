From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH] diff: Introduce diff.algorithm variable
Date: Fri,  9 Mar 2012 14:48:03 +0100
Message-ID: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, trast@student.ethz.ch, peff@peff.net,
	Lawrence.Holding@cubic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 14:48:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S60BU-0000XK-2T
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 14:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408Ab2CINsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 08:48:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13448 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932250Ab2CINse (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 08:48:34 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q29DmBEm005139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 9 Mar 2012 08:48:11 -0500
Received: from bart.redhat.com (vpn1-4-110.ams2.redhat.com [10.36.4.110])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q29Dm9jt017071;
	Fri, 9 Mar 2012 08:48:09 -0500
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192719>

Some users have preference over various diff algorithms. However,
now they are forced to use appropriate argument every time they
run git-diff and tools using it. This is impractical. Therefore
create new variable which can set preferred algorithm. Of course,
this can be overridden on command line via --diff-algorithm=*.
Accepted values are myers (default), histogram, minimal, patience.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
This is basically v2 for:

   http://www.spinics.net/lists/git/msg176100.html

As we agreed on list, I've switched from diff.patience to
diff.algorithm and created new argument --diff-algorithm.

Please keep me CC'ed as I am not signed into the list.

 Documentation/diff-config.txt          |   21 +++++++++++++++++++
 Documentation/diff-options.txt         |   23 +++++++++++++++++++++
 contrib/completion/git-completion.bash |   13 +++++++++++
 diff.c                                 |   35 ++++++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 6aa1be0..1047e81 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -1,3 +1,24 @@
+diff.algorithm::
+    Choose a diff algorithm.  The variants are as follows:
++
+--
+histogram::
+    This is the fastest algorithm.
+
+myers::
+    The classical Myers diff algorithm. This is the default.
+
+minimal::
+    Like 'myers', but spend extra time making sure that the diff
+    is the shortest possible for the set of changes performed.
+
+patience::
+    The patience diff algorithm, which first matches unique lines
+    with each other.  This sometimes results in more readable (if
+    longer) patches than the other algorithms.
+--
++
+
 diff.autorefreshindex::
 	When using 'git diff' to compare with work tree
 	files, do not consider stat-only change as changed.
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7d4566f..4e8bc5b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -55,6 +55,29 @@ endif::git-format-patch[]
 --histogram::
 	Generate a diff using the "histogram diff" algorithm.
 
+--diff-algorithm={histogram|myers|minimal|patience}::
+    Choose a diff algorithm. The defaults are controlled
+    by the `diff.algorithm` configuration variable
+    (see linkgit:git-config[1]). The variants are as follows:
++
+--
+histogram::
+    This is the fastest algorithm.
+
+myers::
+    The classical Myers diff algorithm. This is the default.
+
+minimal::
+    Like 'myers', but spend extra time making sure that the diff
+    is the shortest possible for the set of changes performed.
+
+patience::
+    The patience diff algorithm, which first matches unique lines
+    with each other.  This sometimes results in more readable (if
+    longer) patches than the other algorithms.
+--
++
+
 --stat[=<width>[,<name-width>[,<count>]]]::
 	Generate a diffstat. By default, as much space as necessary
 	will be used for the filename part, and the rest for the graph
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fba076d..d54f3a3 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1299,6 +1299,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--raw
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
+			--diff-algorithm=
 "
 
 _git_diff ()
@@ -1306,6 +1307,10 @@ _git_diff ()
 	__git_has_doubledash && return
 
 	case "$cur" in
+	--diff-algorithm=*)
+		__gitcomp "myers histogram minimal patience"
+		return
+		;;
 	--*)
 		__gitcomp "--cached --staged --pickaxe-all --pickaxe-regex
 			--base --ours --theirs --no-index
@@ -1569,6 +1574,10 @@ _git_log ()
 		__gitcomp "long short" "" "${cur##--decorate=}"
 		return
 		;;
+    --diff-algorithm=*)
+		__gitcomp "myers histogram minimal patience"
+		return
+		;;
 	--*)
 		__gitcomp "
 			$__git_log_common_options
@@ -2376,6 +2385,10 @@ _git_show ()
 			" "" "${cur#*=}"
 		return
 		;;
+	--diff-algorithm=*)
+		__gitcomp "myers histogram minimal patience"
+		return
+		;;
 	--*)
 		__gitcomp "--pretty= --format= --abbrev-commit --oneline
 			$__git_diff_common_options
diff --git a/diff.c b/diff.c
index 377ec1e..f5c965b 100644
--- a/diff.c
+++ b/diff.c
@@ -34,6 +34,7 @@ static int diff_no_prefix;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
+static int diff_algorithm = 0;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -47,6 +48,20 @@ static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* FUNCINFO */
 };
 
+static int diff_algorithm_parse(const char *alg)
+{
+	if (!alg || !strcmp(alg, "myers"))
+		return 0;
+	else if (!strcmp(alg, "patience"))
+		return XDF_PATIENCE_DIFF;
+	else if (!strcmp(alg, "histogram"))
+		return XDF_HISTOGRAM_DIFF;
+	else if (!strcmp(alg, "minimal"))
+		return XDF_NEED_MINIMAL;
+
+	return -1;
+}
+
 static int parse_diff_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
@@ -169,6 +184,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "diff.ignoresubmodules"))
 		handle_ignore_submodules_arg(&default_diff_options, value);
 
+	if (!strcmp(var, "diff.algorithm")) {
+		if ((diff_algorithm = diff_algorithm_parse(value)) < 0)
+			die("bad diff.algorithm value: %s", value);
+		return 0;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -3250,6 +3271,9 @@ int diff_setup_done(struct diff_options *options)
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
+	/* set diff algorithm */
+	options->xdl_opts |= diff_algorithm;
+
 	return 0;
 }
 
@@ -3528,6 +3552,17 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, PATIENCE_DIFF);
 	else if (!strcmp(arg, "--histogram"))
 		DIFF_XDL_SET(options, HISTOGRAM_DIFF);
+	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
+		int alg = diff_algorithm_parse(optarg);
+		if (alg < 0)
+			die("unknown algorithm: %s", optarg);
+		DIFF_XDL_CLR(options, NEED_MINIMAL);
+		DIFF_XDL_CLR(options, HISTOGRAM_DIFF);
+		DIFF_XDL_CLR(options, PATIENCE_DIFF);
+		options->xdl_opts |= alg;
+		return argcount;
+	}
+
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
-- 
1.7.8.5
