From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/4] Hash tags by commit SHA1 in git-describe.
Date: Sat, 13 Jan 2007 17:28:16 -0500
Message-ID: <20070113222816.GB18011@spearce.org>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 23:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5rMQ-0002Bn-42
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 23:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbXAMW2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 17:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030527AbXAMW2V
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 17:28:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36006 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030526AbXAMW2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 17:28:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5rM8-0000KI-8U; Sat, 13 Jan 2007 17:28:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2F37520FBAE; Sat, 13 Jan 2007 17:28:16 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36779>

If a project has a very large number of tags then git-describe
will spend a good part of its time looping over the tags testing
them one at a time to determine if it matches a given commit.
For 10 tags this is not a big deal, but for hundreds of tags the
time could become considerable if we don't find an exact match for
the input commit and we need to walk back along the history chain.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-describe.c |   29 +++++++++++++++++------------
 1 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index ad672aa..582ef02 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -12,20 +12,20 @@ static const char describe_usage[] =
 
 static int all;	/* Default to annotated tags only */
 static int tags;	/* But allow any tags if --tags is specified */
-
 static int abbrev = DEFAULT_ABBREV;
 
-static int names, allocs;
+static unsigned int names[256], allocs[256];
 static struct commit_name {
 	struct commit *commit;
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
 	char path[FLEX_ARRAY]; /* more */
-} **name_array = NULL;
+} **name_array[256];
 
 static struct commit_name *match(struct commit *cmit)
 {
-	int i = names;
-	struct commit_name **p = name_array;
+	unsigned char m = cmit->object.sha1[0];
+	unsigned int i = names[m];
+	struct commit_name **p = name_array[m];
 
 	while (i-- > 0) {
 		struct commit_name *n = *p++;
@@ -42,17 +42,19 @@ static void add_to_known_names(const char *path,
 	int idx;
 	int len = strlen(path)+1;
 	struct commit_name *name = xmalloc(sizeof(struct commit_name) + len);
+	unsigned char m = commit->object.sha1[0];
 
 	name->commit = commit;
 	name->prio = prio;
 	memcpy(name->path, path, len);
-	idx = names;
-	if (idx >= allocs) {
-		allocs = (idx + 50) * 3 / 2;
-		name_array = xrealloc(name_array, allocs*sizeof(*name_array));
+	idx = names[m];
+	if (idx >= allocs[m]) {
+		allocs[m] = (idx + 50) * 3 / 2;
+		name_array[m] = xrealloc(name_array[m],
+			allocs[m] * sizeof(*name_array));
 	}
-	name_array[idx] = name;
-	names = ++idx;
+	name_array[m][idx] = name;
+	names[m] = ++idx;
 }
 
 static int get_name(const char *path, const unsigned char *sha1, int flag, void *cb_data)
@@ -121,9 +123,12 @@ static void describe(const char *arg, int last_one)
 		die("%s is not a valid '%s' object", arg, commit_type);
 
 	if (!initialized) {
+		unsigned int m;
 		initialized = 1;
 		for_each_ref(get_name, NULL);
-		qsort(name_array, names, sizeof(*name_array), compare_names);
+		for (m = 0; m < ARRAY_SIZE(name_array); m++)
+			qsort(name_array[m], names[m],
+				sizeof(*name_array[m]), compare_names);
 	}
 
 	n = match(cmit);
-- 
1.5.0.rc1.g4494
