From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] teach diffcore-rename to optionally ignore empty content
Date: Thu, 22 Mar 2012 18:52:13 -0400
Message-ID: <20120322225213.GA14902@sigill.intra.peff.net>
References: <20120322224651.GA14874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 23:52:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAqro-0003ll-LQ
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 23:52:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031356Ab2CVWwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 18:52:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57007
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031315Ab2CVWwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 18:52:15 -0400
Received: (qmail 6770 invoked by uid 107); 22 Mar 2012 22:52:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 18:52:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 18:52:13 -0400
Content-Disposition: inline
In-Reply-To: <20120322224651.GA14874@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193725>

Our rename detection is a heuristic, matching pairs of
removed and added files with similar or identical content.
It's unlikely to be wrong when there is actual content to
compare, and we already take care not to do inexact rename
detection when there is not enough content to produce good
results.

However, we always do exact rename detection, even when the
blob is tiny or empty. It's easy to get false positives with
an empty blob, simply because it is an obvious content to
use as a boilerplate (e.g., when telling git that an empty
directory is worth tracking via an empty .gitignore).

This patch lets callers specify whether or not they are
interested in using empty files as rename sources and
destinations. The default is "yes", keeping the original
behavior. It works by detecting the empty-blob sha1 for
rename sources and destinations.

One more flexible alternative would be to allow the caller
to specify a minimum size for a blob to be "interesting" for
rename detection. But that would catch small boilerplate
files, not large ones (e.g., if you had the GPL COPYING file
in many directories).

A better alternative would be to allow a "-rename"
gitattribute to allow boilerplate files to be marked as
such. I'll leave the complexity of that solution until such
time as somebody actually wants it. The complaints we've
seen so far revolve around empty files, so let's start with
the simple thing.

Signed-off-by: Jeff King <peff@peff.net>
---
From the previous discussion, we know we could get away with just
dropping empty files from the rename_src list. However, doing it for
both the src and dst lists is a little more obvious and robust. And
since some of the rename detection is O(src*dst), keeping the lists
as small as possible is a good thing.

I added command-line triggers mostly for testing and debugging, and
didn't bother to advertise them in the documentation. Obviously if we
decide that diff should just have this behavior, this patch can be
even smaller.

 diff.c            |    5 +++++
 diff.h            |    2 +-
 diffcore-rename.c |    6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 377ec1e..0b70aad 100644
--- a/diff.c
+++ b/diff.c
@@ -3136,6 +3136,7 @@ void diff_setup(struct diff_options *options)
 	options->rename_limit = -1;
 	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = 3;
+	DIFF_OPT_SET(options, RENAME_EMPTY);
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
@@ -3506,6 +3507,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	}
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
+	else if (!strcmp(arg, "--rename-empty"))
+		DIFF_OPT_SET(options, RENAME_EMPTY);
+	else if (!strcmp(arg, "--no-rename-empty"))
+		DIFF_OPT_CLR(options, RENAME_EMPTY);
 	else if (!strcmp(arg, "--relative"))
 		DIFF_OPT_SET(options, RELATIVE_NAME);
 	else if (!prefixcmp(arg, "--relative=")) {
diff --git a/diff.h b/diff.h
index cb68743..dd48eca 100644
--- a/diff.h
+++ b/diff.h
@@ -60,7 +60,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_SILENT_ON_REMOVE    (1 <<  5)
 #define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
 #define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
-/* (1 <<  8) unused */
+#define DIFF_OPT_RENAME_EMPTY        (1 <<  8)
 /* (1 <<  9) unused */
 #define DIFF_OPT_HAS_CHANGES         (1 << 10)
 #define DIFF_OPT_QUICK               (1 << 11)
diff --git a/diffcore-rename.c b/diffcore-rename.c
index f639601..216a7a4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -512,9 +512,15 @@ void diffcore_rename(struct diff_options *options)
 			else if (options->single_follow &&
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
+			else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
+				 is_empty_blob_sha1(p->two->sha1))
+				continue;
 			else
 				locate_rename_dst(p->two, 1);
 		}
+		else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
+			 is_empty_blob_sha1(p->one->sha1))
+			continue;
 		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
 			/*
 			 * If the source is a broken "delete", and
-- 
1.7.10.rc0.9.gdcbe9
