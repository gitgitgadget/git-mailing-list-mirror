From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] blame,shortlog: don't make local option variables static
Date: Mon, 13 Jun 2016 01:39:28 -0400
Message-ID: <20160613053928.GC23880@sigill.intra.peff.net>
References: <20160613053203.GB3950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 07:39:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCKb1-0004RM-Fd
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 07:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328AbcFMFjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 01:39:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:53627 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750803AbcFMFjb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 01:39:31 -0400
Received: (qmail 26410 invoked by uid 102); 13 Jun 2016 05:39:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:39:31 -0400
Received: (qmail 10382 invoked by uid 107); 13 Jun 2016 05:39:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:39:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 01:39:28 -0400
Content-Disposition: inline
In-Reply-To: <20160613053203.GB3950@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297157>

There's no need for these option variables to be static,
except that they are referenced by the options array itself,
which is static. But having all of this static is simply
unnecessary and confusing (and inconsistent with most other
commands, which either use a static global option list or a
true function-local one).

Note that in some cases we may need to actually initialize
the variables (since we cannot rely on BSS to do so). This
is a net improvement to readability, though, as we can use
the more verbose initializers for our string_lists.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c    | 12 ++++++------
 builtin/shortlog.c |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..80d2431 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2522,12 +2522,12 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	enum object_type type;
 	struct commit *final_commit = NULL;
 
-	static struct string_list range_list;
-	static int output_option = 0, opt = 0;
-	static int show_stats = 0;
-	static const char *revs_file = NULL;
-	static const char *contents_from = NULL;
-	static const struct option options[] = {
+	struct string_list range_list = STRING_LIST_INIT_NODUP;
+	int output_option = 0, opt = 0;
+	int show_stats = 0;
+	const char *revs_file = NULL;
+	const char *contents_from = NULL;
+	const struct option options[] = {
 		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
 		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
 		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index bfc082e..f83984e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -233,11 +233,11 @@ void shortlog_init(struct shortlog *log)
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
 {
-	static struct shortlog log;
-	static struct rev_info rev;
+	struct shortlog log = { STRING_LIST_INIT_NODUP };
+	struct rev_info rev;
 	int nongit = !startup_info->have_repository;
 
-	static const struct option options[] = {
+	const struct option options[] = {
 		OPT_BOOL('n', "numbered", &log.sort_by_number,
 			 N_("sort output according to the number of commits per author")),
 		OPT_BOOL('s', "summary", &log.summary,
-- 
2.9.0.rc2.149.gd580ccd
