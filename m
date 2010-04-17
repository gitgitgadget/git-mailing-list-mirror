From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: use 64-bit integers for diffstat calculations
Date: Sat, 17 Apr 2010 13:41:08 -0400
Message-ID: <20100417174108.GB23642@coredump.intra.peff.net>
References: <20100416135948.GA26918@zakalwe.fi>
 <4BC87BE9.9040704@dbservice.com>
 <20100417102543.GB23110@coredump.intra.peff.net>
 <7vvdbq2ev7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tomas Carnecky <tom@dbservice.com>,
	Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 19:41:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3C1h-0002vL-0t
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 19:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab0DQRlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 13:41:47 -0400
Received: from peff.net ([208.65.91.99]:33386 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713Ab0DQRlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 13:41:42 -0400
Received: (qmail 21168 invoked by uid 107); 17 Apr 2010 17:41:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 13:41:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 13:41:08 -0400
Content-Disposition: inline
In-Reply-To: <7vvdbq2ev7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145163>

On Sat, Apr 17, 2010 at 10:00:44AM -0700, Junio C Hamano wrote:

> > The diffstat "added" and "changed" fields generally store
> > line counts; however, for binary files, they store file
> > sizes. Since we store and print these values as ints, a
> > diffstat on a file larger than 2G can show a negative size.
> > Instead, let's explicitly use 64-bit integers.
> 
> Yes, but we would probably be better off using using uintmax_t for things
> like this if the quantity a variable represents is not closely tied to
> external file format (e.g. the offset field of pack idx file), nor the
> code is only for a particular platform (e.g. compat/win32mmap.c), don't
> you think?

But 640K^W 64-bits should be large enough for anyone! :)

But yes, you're right. Updated patch below.

-- >8 --
Subject: [PATCH] diff: use large integers for diffstat calculations

The diffstat "added" and "changed" fields generally store
line counts; however, for binary files, they store file
sizes. Since we store and print these values as ints, a
diffstat on a file larger than 2G can show a negative size.
Instead, let's use uintmax_t, which should be at least 64
bits on modern platforms.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 7effdac..fbdbd8d 100644
--- a/diff.c
+++ b/diff.c
@@ -936,7 +936,7 @@ struct diffstat_t {
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
-		unsigned int added, deleted;
+		uintmax_t added, deleted;
 	} **files;
 };
 
@@ -1028,7 +1028,7 @@ static void fill_print_name(struct diffstat_file *file)
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, len, add, del, adds = 0, dels = 0;
-	int max_change = 0, max_len = 0;
+	uintmax_t max_change = 0, max_len = 0;
 	int total_files = data->nr;
 	int width, name_width;
 	const char *reset, *set, *add_c, *del_c;
@@ -1057,7 +1057,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
-		int change = file->added + file->deleted;
+		uintmax_t change = file->added + file->deleted;
 		fill_print_name(file);
 		len = strlen(file->print_name);
 		if (max_len < len)
@@ -1085,8 +1085,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	for (i = 0; i < data->nr; i++) {
 		const char *prefix = "";
 		char *name = data->files[i]->print_name;
-		int added = data->files[i]->added;
-		int deleted = data->files[i]->deleted;
+		uintmax_t added = data->files[i]->added;
+		uintmax_t deleted = data->files[i]->deleted;
 		int name_len;
 
 		/*
@@ -1107,9 +1107,11 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (data->files[i]->is_binary) {
 			show_name(options->file, prefix, name, len);
 			fprintf(options->file, "  Bin ");
-			fprintf(options->file, "%s%d%s", del_c, deleted, reset);
+			fprintf(options->file, "%s%"PRIuMAX"%s",
+				del_c, deleted, reset);
 			fprintf(options->file, " -> ");
-			fprintf(options->file, "%s%d%s", add_c, added, reset);
+			fprintf(options->file, "%s%"PRIuMAX"%s",
+				add_c, added, reset);
 			fprintf(options->file, " bytes");
 			fprintf(options->file, "\n");
 			continue;
@@ -1138,7 +1140,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			del = scale_linear(del, width, max_change);
 		}
 		show_name(options->file, prefix, name, len);
-		fprintf(options->file, "%5d%s", added + deleted,
+		fprintf(options->file, "%5"PRIuMAX"%s", added + deleted,
 				added + deleted ? " " : "");
 		show_graph(options->file, '+', add, add_c, reset);
 		show_graph(options->file, '-', del, del_c, reset);
@@ -1188,7 +1190,8 @@ static void show_numstat(struct diffstat_t *data, struct diff_options *options)
 			fprintf(options->file, "-\t-\t");
 		else
 			fprintf(options->file,
-				"%d\t%d\t", file->added, file->deleted);
+				"%"PRIuMAX"\t%"PRIuMAX"\t",
+				file->added, file->deleted);
 		if (options->line_termination) {
 			fill_print_name(file);
 			if (!file->is_renamed)
-- 
1.7.1.rc1.277.g2c4c9
