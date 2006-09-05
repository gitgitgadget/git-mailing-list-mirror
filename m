From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/2] rev list add option accepting revision constraints on standard input
Date: Tue, 5 Sep 2006 22:51:57 +0100
Message-ID: <20060905215157.GA29172@shadowen.org>
References: <44FDECD1.2090909@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 05 23:52:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKiqJ-0007mQ-L6
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 23:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbWIEVwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 17:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWIEVwV
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 17:52:21 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:63404
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751506AbWIEVwU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 17:52:20 -0400
Received: from apw by localhost.localdomain with local (Exim 4.62)
	(envelope-from <apw@shadowen.org>)
	id 1GKipp-0007af-Pl; Tue, 05 Sep 2006 22:51:57 +0100
To: git@vger.kernel.org
Content-Disposition: inline
InReply-To: <44FDECD1.2090909@shadowen.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26490>

rev-list: add option accepting revision constraints on standard input

When we are generating packs to update remote repositories we
want to supply as much information as possible about the revisions
that already exist to rev-list in order optimise the pack as much
as possible.  We need to pass two revisions for each branch we are
updating in the remote repository and one for each additional branch.
Where the remote repository has numerous branches we can run out
of command line space to pass them.

Add a --stdin flag which causes rev-list to additionally read
its stdin stream and parse that for revision constraints.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 8437454..0303909 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -304,10 +304,30 @@ static void mark_edges_uninteresting(str
 	}
 }
 
+/*
+ * Parse revision information, filling in the "rev_info" structure,
+ * revisions are taken from stream.
+ */
+static void setup_revisions_stream(FILE *stream, struct rev_info *revs)
+{
+	char line[1000];
+	const char *args[] = { 0, line, 0 };
+
+	while (fgets(line, sizeof(line), stream) != NULL) {
+		line[strlen(line) - 1] = 0;
+
+		if (line[0] == '-')
+			die("options not supported in --stdin mode");
+
+		(void)setup_revisions(2, args, revs, NULL);
+	}
+}
+
 int cmd_rev_list(int argc, const char **argv, const char *prefix)
 {
 	struct commit_list *list;
 	int i;
+	int read_stdin = 0;
 
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
@@ -329,9 +349,15 @@ int cmd_rev_list(int argc, const char **
 			bisect_list = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--stdin")) {
+			read_stdin = 1;
+			continue;
+		}
 		usage(rev_list_usage);
-
 	}
+	if (read_stdin)
+		setup_revisions_stream(stdin, &revs);
+
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
 		hdr_termination = '\n';
