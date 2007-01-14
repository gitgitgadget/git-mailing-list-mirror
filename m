From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/4] Enable output buffering in merge-recursive.
Date: Sun, 14 Jan 2007 00:28:53 -0500
Message-ID: <20070114052853.GC19113@spearce.org>
References: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 06:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5xvq-0006Ma-86
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 06:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbXANF26 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 00:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbXANF26
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 00:28:58 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46635 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXANF24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 00:28:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5xvK-0004jc-Ou; Sun, 14 Jan 2007 00:28:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8C5EC20FBAE; Sun, 14 Jan 2007 00:28:53 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <d352c8adb1ec1c4e74b33d51d397d5756b82ceac.1168752482.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36793>

Buffering all message output until a merge invocation is complete is
necessary to prevent intereferring with a progress meter that would
indicate the number of files completely merged, and how many remain.
This change does not introduce a progress meter, but merely lays
the groundwork to buffer the output.

To aid debugging output buffering is only enabled if verbosity
is lower than 5.  When using verbosity levels above 5 the user is
probably debugging the merge program itself and does not want to
see the output delayed, especially if they are stepping through
portions of the code in a debugger.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 merge-recursive.c |   40 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 39 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 05f9311..c16062b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -67,11 +67,19 @@ struct stage_data
 	unsigned processed:1;
 };
 
+struct output_buffer
+{
+	struct output_buffer *next;
+	char *str;
+};
+
 static struct path_list current_file_set = {NULL, 0, 0, 1};
 static struct path_list current_directory_set = {NULL, 0, 0, 1};
 
 static int call_depth = 0;
 static int verbosity = 2;
+static int buffer_output = 1;
+static struct output_buffer *output_list, *output_end;
 
 static int show (int v)
 {
@@ -82,7 +90,16 @@ static void output(int v, const char *fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	if (show(v)) {
+	if (buffer_output && show(v)) {
+		struct output_buffer *b = xmalloc(sizeof(*b));
+		nfvasprintf(&b->str, fmt, args);
+		b->next = NULL;
+		if (output_end)
+			output_end->next = b;
+		else
+			output_list = b;
+		output_end = b;
+	} else if (show(v)) {
 		int i;
 		for (i = call_depth; i--;)
 			fputs("  ", stdout);
@@ -92,9 +109,27 @@ static void output(int v, const char *fmt, ...)
 	va_end(args);
 }
 
+static void flush_output()
+{
+	struct output_buffer *b, *n;
+	for (b = output_list; b; b = n) {
+		int i;
+		for (i = call_depth; i--;)
+			fputs("  ", stdout);
+		fputs(b->str, stdout);
+		fputc('\n', stdout);
+		n = b->next;
+		free(b->str);
+		free(b);
+	}
+	output_list = NULL;
+	output_end = NULL;
+}
+
 static void output_commit_title(struct commit *commit)
 {
 	int i;
+	flush_output();
 	for (i = call_depth; i--;)
 		fputs("  ", stdout);
 	if (commit->util)
@@ -1175,6 +1210,7 @@ static int merge(struct commit *h1,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
+	flush_output();
 	return clean;
 }
 
@@ -1252,6 +1288,8 @@ int main(int argc, char *argv[])
 
 	branch1 = better_branch_name(branch1);
 	branch2 = better_branch_name(branch2);
+	if (verbosity >= 5)
+		buffer_output = 0;
 	if (show(3))
 		printf("Merging %s with %s\n", branch1, branch2);
 
-- 
1.5.0.rc1.g4494
