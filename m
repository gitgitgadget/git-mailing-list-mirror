From: Jeff King <peff@peff.net>
Subject: [PATCH] git-describe: allow reflogs as reference points
Date: Sat, 30 Sep 2006 18:29:04 -0400
Message-ID: <20060930222903.GA11252@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 00:29:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTnKZ-0002hI-BN
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 00:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWI3W3H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 18:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWI3W3H
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 18:29:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4555 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751483AbWI3W3G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 18:29:06 -0400
Received: (qmail 16005 invoked from network); 30 Sep 2006 18:29:04 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 30 Sep 2006 18:29:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2006 18:29:04 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28155>


Signed-off-by: Jeff King <peff@peff.net>
---
It's basically impossible to use this in the git repository, since we
prefer tags to reflogs. Should --reflog turn off tag matching? Should
there be a command line option to turn off tags?

 Documentation/git-describe.txt |    9 ++++++-
 describe.c                     |   51 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 2700f35..975da0f 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -8,7 +8,7 @@ git-describe - Show the most recent tag 
 
 SYNOPSIS
 --------
-'git-describe' [--all] [--tags] [--abbrev=<n>] <committish>...
+'git-describe' [--all] [--tags] [--reflog] [--abbrev=<n>] <committish>...
 
 DESCRIPTION
 -----------
@@ -31,6 +31,13 @@ OPTIONS
 	Instead of using only the annotated tags, use any tag
 	found in `.git/refs/tags`.
 
+--reflog=<fmt>::
+	Instead of using only the annotated tags, use reference dates
+	marked in branch reflogs. The output will be of the form
+	'branch@{date}' where the format of date is specified by <fmt>, which
+	must be one of 'relative', '822', 'git'. If no format is specified,
+	the default is 'relative'.
+
 --abbrev=<n>::
 	Instead of using the default 8 hexadecimal digits as the
 	abbreviated object name, use <n> digits.
diff --git a/describe.c b/describe.c
index f4029ee..1dc5209 100644
--- a/describe.c
+++ b/describe.c
@@ -6,11 +6,16 @@ #include "refs.h"
 #define SEEN (1u << 0)
 
 static const char describe_usage[] =
-"git-describe [--all] [--tags] [--abbrev=<n>] <committish>*";
+"git-describe [--all] [--tags] [--reflog] [--abbrev=<n>] <committish>*";
 
 static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
 
+#define FMT_DATE_822 1
+#define FMT_DATE_GIT 2
+#define FMT_DATE_REL 3
+static int reflog;
+
 static int abbrev = DEFAULT_ABBREV;
 
 static int names, allocs;
@@ -85,6 +90,35 @@ static int get_name(const char *path, co
 	return 0;
 }
 
+static int get_reflog_name(const char *ref, const unsigned char *head_sha1,
+		int flag, void *cb_data)
+{
+	unsigned char sha1[20];
+	char buf[1024];
+	struct reflog log;
+	struct reflog_entry c;
+
+	snprintf(buf, sizeof(buf), "refs/heads/%s", ref);
+	if (reflog_open(&log, buf) < 0) {
+		if (errno == ENOENT)
+			return 0;
+		die("unable to read log %s: %s\n", log.file, strerror(errno));
+	}
+	reflog_start(&log);
+	while (reflog_next(&log, &c)) {
+		snprintf(buf, sizeof(buf), "%s@{%s}",
+			ref,
+			reflog == FMT_DATE_REL ? show_date(c.date, 0, 1) :
+			reflog == FMT_DATE_GIT ? show_date(c.date, c.tz, 0) :
+			show_rfc2822_date(c.date, c.tz));
+		reflog_entry_to(&c, sha1);
+		add_to_known_names(buf, lookup_commit_reference(sha1), 0);
+	}
+	reflog_close(&log);
+	return 0;
+}
+
+
 static int compare_names(const void *_a, const void *_b)
 {
 	struct commit_name *a = *(struct commit_name **)_a;
@@ -114,6 +148,8 @@ static void describe(const char *arg, in
 	if (!initialized) {
 		initialized = 1;
 		for_each_ref(get_name, NULL);
+		if (reflog)
+			for_each_branch_ref(get_reflog_name, NULL);
 		qsort(name_array, names, sizeof(*name_array), compare_names);
 	}
 
@@ -152,6 +188,19 @@ int main(int argc, char **argv)
 			all = 1;
 		else if (!strcmp(arg, "--tags"))
 			tags = 1;
+		else if (!strncmp(arg, "--reflog=", 9)) {
+			if (!strcmp(arg+9, "2822") || !strcmp(arg+9, "822"))
+				reflog = FMT_DATE_822;
+			else if (!strcmp(arg+9, "git"))
+				reflog = FMT_DATE_GIT;
+			else if (!strcmp(arg+9, "relative"))
+				reflog = FMT_DATE_REL;
+			else
+				usage(describe_usage);
+		}
+		else if (!strcmp(arg, "--reflog")) {
+			reflog = FMT_DATE_REL;
+		}
 		else if (!strncmp(arg, "--abbrev=", 9)) {
 			abbrev = strtoul(arg + 9, NULL, 10);
 			if (abbrev < MINIMUM_ABBREV || 40 < abbrev)
-- 
1.4.2.1.gd4f1-dirty
