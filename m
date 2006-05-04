From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach fmt-patch to write individual files.
Date: Fri, 5 May 2006 01:16:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605050115440.12795@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 05 01:16:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbn3z-0005wI-A6
	for gcvg-git@gmane.org; Fri, 05 May 2006 01:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWEDXQm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWEDXQm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 19:16:42 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56005 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030313AbWEDXQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 19:16:41 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 47AB52025;
	Fri,  5 May 2006 01:16:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 3BC36203F;
	Fri,  5 May 2006 01:16:40 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 1FC532025;
	Fri,  5 May 2006 01:16:40 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19584>


When called with "--stdout", it still writes to standard output.

Notable differences to git-format-patch:

	- since fmt-patch uses the standardized logging machinery, it is
	  no longer "From nobody", but "From <commit_sha1>",

	- the empty lines before and after the "---" just before the
	  diffstat are no longer there,

	- git-format-patch outputs the commit_sha1 just before the first
	  diff, which fmt-patch does not,

	- the file names are no longer output to stdout, but to stderr
	  (since stdout is freopen()ed all the time), and

	- "git fmt-patch HEAD^" does not work as expected: it outputs
	  *all* commits reachable from HEAD^!

The last one is possibly a showstopper. At least I used to call that
command quite often...

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	I forgot to "git-update-index builtin-log.c"...

 builtin-log.c |   72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index a39aed6..576703c 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -69,12 +69,65 @@ int cmd_log(int argc, const char **argv,
 	return cmd_log_wc(argc, argv, envp, &rev);
 }
 
+static int istitlechar(char c)
+{
+	return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') ||
+		(c >= '0' && c <= '9') || c == '.' || c == '_';
+}
+
+static void reopen_stdout(struct commit *commit, int nr)
+{
+	char filename[1024];
+	char *sol;
+	int len;
+
+
+	sprintf(filename, "%04d", nr);
+	len = strlen(filename);
+
+	sol = strstr(commit->buffer, "\n\n");
+	if (sol) {
+		int j, space = 1;
+
+		sol += 2;
+		/* strip [PATCH] or [PATCH blabla] */
+		if (!strncmp(sol, "[PATCH", 6)) {
+			char *eos = strchr(sol + 6, ']');
+			if (eos) {
+				while (isspace(*eos))
+					eos++;
+				sol = eos;
+			}
+		}
+
+		for (j = 0; len < 1024 - 6 && sol[j] && sol[j] != '\n'; j++) {
+			if (istitlechar(sol[j])) {
+				if (space) {
+					filename[len++] = '-';
+					space = 0;
+				}
+				filename[len++] = sol[j];
+				if (sol[j] == '.')
+					while (sol[j + 1] == '.')
+						j++;
+			} else
+				space = 1;
+		}
+		while (filename[len - 1] == '.' || filename[len - 1] == '-')
+			len--;
+	}
+	strcpy(filename + len, ".txt");
+	fprintf(stderr, "%s\n", filename);
+	freopen(filename, "w", stdout);
+}
+
 int cmd_format_patch(int argc, const char **argv, char **envp)
 {
 	struct commit *commit;
 	struct commit **list = NULL;
 	struct rev_info rev;
-	int nr = 0;
+	int nr = 0, total;
+	int use_stdout = 0;
 
 	init_revisions(&rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
@@ -87,20 +140,37 @@ int cmd_format_patch(int argc, const cha
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
 
+	while (argc > 1) {
+		if (!strcmp(argv[1], "--stdout"))
+			use_stdout = 1;
+		else
+			die ("unrecognized argument: %s", argv[1]);
+		argc--;
+		argv++;
+	}
+
 	prepare_revision_walk(&rev);
 	while ((commit = get_revision(&rev)) != NULL) {
+		/* ignore merges */
+		if (commit->parents && commit->parents->next)
+			continue;
 		nr++;
 		list = realloc(list, nr * sizeof(list[0]));
 		list[nr - 1] = commit;
 	}
+	total = nr;
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
+		if (!use_stdout)
+			reopen_stdout(commit, total - nr);
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
 		if (shown)
 			printf("-- \n%s\n\n", git_version_string);
+		if (!use_stdout)
+			fclose(stdout);
 	}
 	free(list);
 	return 0;
-- 
1.3.1.g42859-dirty
