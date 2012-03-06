From: Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH] config: Introduce --patience config variable
Date: Tue,  6 Mar 2012 11:59:42 +0100
Message-ID: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 12:00:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4s7s-0004DQ-Ps
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 12:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997Ab2CFLAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 06:00:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58509 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758978Ab2CFLAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 06:00:09 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q26AxlYG028504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 6 Mar 2012 05:59:47 -0500
Received: from bart.brq.redhat.com (dhcp-27-226.brq.redhat.com [10.34.27.226])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q26AxiZG013849;
	Tue, 6 Mar 2012 05:59:46 -0500
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192331>

Some users like the patience diff more than the bare diff. However,
specifying the '--patience' argument every time diff is to be used
is impractical. Moreover, creating an alias doesn't play with other
tools nice, e.g. git-show; Therefore we need a configuration variable
to turn this on/off across whole git tools.
---
Please keep me CC'ed as I am not signed into list.

 Documentation/diff-config.txt |    3 +++
 diff.c                        |    9 +++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 1aed79e..b72b2fd 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -86,6 +86,9 @@ diff.mnemonicprefix::
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 
+diff.patience:
+    If set, 'git diff' will use patience algorithm.
+
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
 	detection; equivalent to the 'git diff' option '-l'.
diff --git a/diff.c b/diff.c
index a1c06b5..8940d00 100644
--- a/diff.c
+++ b/diff.c
@@ -33,6 +33,7 @@ static int diff_mnemonic_prefix;
 static int diff_no_prefix;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
+static int diff_patience = 0;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -212,6 +213,11 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
+    if (!strcmp(var, "diff.patience")) {
+		diff_patience = git_config_bool(var, value);
+		return 0;
+    }
+
 	return git_default_config(var, value, cb);
 }
 
@@ -3202,6 +3208,9 @@ int diff_setup_done(struct diff_options *options)
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
+    if (diff_patience)
+		DIFF_XDL_SET(options, PATIENCE_DIFF);
+
 	return 0;
 }
 
-- 
1.7.3.4
