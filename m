From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/12] merge.conflictstyle: choose between "merge" and "diff3
 -m" styles
Date: Fri, 29 Aug 2008 17:42:38 -0700
Message-ID: <1220056963-2352-8-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <1220056963-2352-5-git-send-email-gitster@pobox.com>
 <1220056963-2352-6-git-send-email-gitster@pobox.com>
 <1220056963-2352-7-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZu-00076v-8n
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbYH3AnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYH3AnK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:43:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYH3AnF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:43:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EBAC66DC0C
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0B1036DC0B for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:03
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-7-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9B6B3754-762C-11DD-AABF-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94343>

This teaches "git merge-file" to honor merge.conflictstyle configuration
variable, whose value can be "merge" (default) or "diff3".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    8 ++++++++
 builtin-merge-file.c     |    9 +++++++++
 t/t6023-merge-file.sh    |    9 ++++++++-
 xdiff-interface.c        |   20 ++++++++++++++++++++
 xdiff-interface.h        |    2 ++
 5 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af57d94..cb4c4ca 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -893,6 +893,14 @@ man.<tool>.path::
 	Override the path for the given tool that may be used to
 	display help in the 'man' format. See linkgit:git-help[1].
 
+merge.conflictstyle::
+	Specify the style in which conflicted hunks are written out to
+	working tree files upon merge.  The default is "merge", which
+	shows `<<<<<<<` conflict marker, change made by one side,
+	`=======` marker, change made by the other side, and then
+	`>>>>>>>` marker.  An alternate style, "diff3", adds `|||||||`
+	marker and the original text before `=======` marker.
+
 mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 1e92510..f009e73 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -15,6 +15,15 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	int ret = 0, i = 0, to_stdout = 0;
 	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
 	int merge_style = 0;
+	int nongit;
+
+	prefix = setup_git_directory_gently(&nongit);
+	if (!nongit) {
+		/* Read the configuration file */
+		git_config(git_xmerge_config, NULL);
+		if (git_xmerge_style > 0)
+			merge_style = git_xmerge_style;
+	}
 
 	while (argc > 4) {
 		if (!strcmp(argv[1], "-L") && i < 3) {
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index f3484e3..93ec517 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -192,10 +192,17 @@ non timebo mala, quoniam TU mecum es:
 virga tua et baculus tuus ipsa me consolata sunt.
 EOF
 
-test_expect_success '"diff3 -m" style output' '
+test_expect_success '"diff3 -m" style output (1)' '
 	test_must_fail git merge-file -p --diff3 \
 		new8.txt new5.txt new9.txt >actual &&
 	test_cmp expect actual
 '
 
+test_expect_success '"diff3 -m" style output (2)' '
+	git config merge.conflictstyle diff3 &&
+	test_must_fail git merge-file -p \
+		new8.txt new5.txt new9.txt >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 944ad98..8457601 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -249,3 +249,23 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value)
 		value = ep + 1;
 	}
 }
+
+int git_xmerge_style = -1;
+
+int git_xmerge_config(const char *var, const char *value, void *cb)
+{
+	if (!strcasecmp(var, "merge.conflictstyle")) {
+		if (!value)
+			die("'%s' is not a boolean", var);
+		if (!strcmp(value, "diff3"))
+			git_xmerge_style = XDL_MERGE_DIFF3;
+		else if (!strcmp(value, "merge"))
+			git_xmerge_style = 0;
+		else
+			die("unknown style '%s' given for '%s'",
+			    value, var);
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 558492b..b3b5c93 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -17,5 +17,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename);
 int buffer_is_binary(const char *ptr, unsigned long size);
 
 extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line);
+extern int git_xmerge_config(const char *var, const char *value, void *cb);
+extern int git_xmerge_style;
 
 #endif
-- 
1.6.0.1.149.ga4c44
