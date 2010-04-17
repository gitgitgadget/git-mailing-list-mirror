From: Jeff King <peff@peff.net>
Subject: [PATCH] diff: use 64-bit integers for diffstat calculations
Date: Sat, 17 Apr 2010 06:25:43 -0400
Message-ID: <20100417102543.GB23110@coredump.intra.peff.net>
References: <20100416135948.GA26918@zakalwe.fi>
 <4BC87BE9.9040704@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 12:26:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O35EE-0000S5-MQ
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 12:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab0DQK0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 06:26:17 -0400
Received: from peff.net ([208.65.91.99]:59025 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786Ab0DQK0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 06:26:16 -0400
Received: (qmail 16840 invoked by uid 107); 17 Apr 2010 10:26:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 06:26:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 06:25:43 -0400
Content-Disposition: inline
In-Reply-To: <4BC87BE9.9040704@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145129>

On Fri, Apr 16, 2010 at 05:02:01PM +0200, Tomas Carnecky wrote:

> >commit 6afe3d3c889daa92bd79956c4bb733eb5cb408dc
> >Author: Heikki Orsila<heikki.orsila@iki.fi>
> >Date:   2010-04-16 16:54:52 +0300
> >
> >     test commit
> >
> >  0 |  Bin 0 ->  -2146435072 bytes
> >  1 |  Bin 0 ->  -2146435072 bytes
> >  2 files changed, 0 insertions(+), 0 deletions(-)
> 
> Yep, bug is also in the latest version (1.7.0.5). The code uses 'int'
> instead of something big enough to hold the size of your files.

Yuck, we use "unsigned int" for the actual storage, and then convert to
a regular "int" in some other places. I think we should just do this:

-- >8 --
Subject: [PATCH] diff: use 64-bit integers for diffstat calculations

The diffstat "added" and "changed" fields generally store
line counts; however, for binary files, they store file
sizes. Since we store and print these values as ints, a
diffstat on a file larger than 2G can show a negative size.
Instead, let's explicitly use 64-bit integers.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 7effdac..54933cc 100644
--- a/diff.c
+++ b/diff.c
@@ -936,7 +936,7 @@ struct diffstat_t {
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
-		unsigned int added, deleted;
+		uint64_t added, deleted;
 	} **files;
 };
 
@@ -1028,7 +1028,7 @@ static void fill_print_name(struct diffstat_file *file)
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, len, add, del, adds = 0, dels = 0;
-	int max_change = 0, max_len = 0;
+	uint64_t max_change = 0, max_len = 0;
 	int total_files = data->nr;
 	int width, name_width;
 	const char *reset, *set, *add_c, *del_c;
@@ -1057,7 +1057,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
-		int change = file->added + file->deleted;
+		uint64_t change = file->added + file->deleted;
 		fill_print_name(file);
 		len = strlen(file->print_name);
 		if (max_len < len)
@@ -1085,8 +1085,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->print_name;
-		int added = data->files[i]->added;
-		int deleted = data->files[i]->deleted;
+		uint64_t added = data->files[i]->added;
+		uint64_t deleted = data->files[i]->deleted;
 		int name_len;
 
 		/*
@@ -1107,9 +1107,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (data->files[i]->is_binary) {
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Bin ");
-			fprintf(options->file, "%s%d%s", del_c, deleted, reset);
+			fprintf(options->file, "%s%"PRIu64"%s",
+				del_c, deleted, reset);
 			fprintf(options->file, " -> ");
-			fprintf(options->file, "%s%d%s", add_c, added, reset);
+			fprintf(options->file, "%s%"PRIu64"%s",
+				add_c, added, reset);
 			fprintf(options->file, " bytes");
 			fprintf(options->file, "\n");
 			continue;
@@ -1138,7 +1140,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			del = scale_linear(del, width, max_change);
 		}
 		show_name(options->file, prefix, name, len);
-		fprintf(options->file, "%5d%s", added + deleted,
+		fprintf(options->file, "%5"PRIu64"%s", added + deleted,
 				added + deleted ? " " : "");
 		show_graph(options->file, '+', add, add_c, reset);
 		show_graph(options->file, '-', del, del_c, reset);
@@ -1188,7 +1190,8 @@ static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 			fprintf(options->file, "-\t-\t");
 		else
 			fprintf(options->file,
-				"%d\t%d\t", file->added, file->deleted);
+				"%"PRIu64"\t%"PRIu64"\t",
+				file->added, file->deleted);
 		if (options->line_termination) {
 			fill_print_name(file);
 			if (!file->is_renamed)
-- 
1.7.1.rc1.277.g2c4c9
