From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v2 2/3] config: Introduce diff.algorithm variable
Date: Mon, 14 Jan 2013 20:58:10 +0100
Message-ID: <f76708fc2a1dc33f3f9c67688ef5709302b56cbb.1358193364.git.mprivozn@redhat.com>
References: <cover.1358193364.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, peff@peff.net, trast@student.ethz.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 20:58:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuqBC-0002yZ-K6
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 20:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757984Ab3ANT60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 14:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37882 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756861Ab3ANT6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 14:58:25 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r0EJwI45028650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 14 Jan 2013 14:58:18 -0500
Received: from bart.brq.redhat.com (dhcp-27-249.brq.redhat.com [10.34.27.249])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id r0EJwDVn009934;
	Mon, 14 Jan 2013 14:58:17 -0500
In-Reply-To: <cover.1358193364.git.mprivozn@redhat.com>
In-Reply-To: <cover.1358193364.git.mprivozn@redhat.com>
References: <cover.1358193364.git.mprivozn@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213524>

Some users or projects prefer different algorithms over others, e.g.
patience over myers or similar. However, specifying appropriate
argument every time diff is to be used is impractical. Moreover,
creating an alias doesn't play nicely with other tools based on diff
(git-show for instance). Hence, a configuration variable which is able
to set specific algorithm is needed. For now, these four values are
accepted: 'myers' (which has the same effect as not setting the config
variable at all), 'minimal', 'patience' and 'histogram'.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 Documentation/diff-config.txt          | 17 +++++++++++++++++
 contrib/completion/git-completion.bash |  1 +
 diff.c                                 | 23 +++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 4314ad0..be31276 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -155,3 +155,20 @@ diff.tool::
 	"kompare".  Any other value is treated as a custom diff tool,
 	and there must be a corresponding `difftool.<tool>.cmd`
 	option.
+
+diff.algorithm::
+	Choose a diff algorithm.  The variants are as follows:
++
+--
+`myers`;;
+	The basic greedy diff algorithm.
+`minimal`;;
+	Spend extra time to make sure the smallest possible diff is
+	produced.
+`patience`;;
+	Use "patience diff" algorithm when generating patches.
+`histogram`;;
+	This algorithm extends the patience algorithm to "support
+	low-occurrence common elements".
+--
++
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 383518c..33e25dc 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1839,6 +1839,7 @@ _git_config ()
 		diff.suppressBlankEmpty
 		diff.tool
 		diff.wordRegex
+		diff.algorithm
 		difftool.
 		difftool.prompt
 		fetch.recurseSubmodules
diff --git a/diff.c b/diff.c
index 732d4c2..e9a7e4d 100644
--- a/diff.c
+++ b/diff.c
@@ -36,6 +36,7 @@ static int diff_no_prefix;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
+static long diff_algorithm;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -143,6 +144,20 @@ static int git_config_rename(const char *var, const char *value)
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
 }
 
+static long parse_algorithm_value(const char *value)
+{
+	if (!value || !strcasecmp(value, "myers"))
+		return 0;
+	else if (!strcasecmp(value, "minimal"))
+		return XDF_NEED_MINIMAL;
+	else if (!strcasecmp(value, "patience"))
+		return XDF_PATIENCE_DIFF;
+	else if (!strcasecmp(value, "histogram"))
+		return XDF_HISTOGRAM_DIFF;
+	else
+		return -1;
+}
+
 /*
  * These are to give UI layer defaults.
  * The core-level commands such as git-diff-files should
@@ -196,6 +211,13 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.algorithm")) {
+		diff_algorithm = parse_algorithm_value(value);
+		if (diff_algorithm < 0)
+			return -1;
+		return 0;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -3213,6 +3235,7 @@ void diff_setup(struct diff_options *options)
 	options->add_remove = diff_addremove;
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
+	options->xdl_opts |= diff_algorithm;
 
 	if (diff_no_prefix) {
 		options->a_prefix = options->b_prefix = "";
-- 
1.8.0.2
