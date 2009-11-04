From: Jeff King <peff@peff.net>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker
 when options are patch and a stat
Date: Wed, 4 Nov 2009 02:19:40 -0500
Message-ID: <20091104071940.GA15011@coredump.intra.peff.net>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com>
 <7vy6mmltz9.fsf@alter.siamese.dyndns.org>
 <20091104063612.GA24263@coredump.intra.peff.net>
 <20091104071053.GB24263@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5a9m-0004Vh-L0
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbZKDHTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZKDHTj
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:19:39 -0500
Received: from peff.net ([208.65.91.99]:46112 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbZKDHTi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:19:38 -0500
Received: (qmail 8303 invoked by uid 107); 4 Nov 2009 07:23:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 04 Nov 2009 02:23:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Nov 2009 02:19:40 -0500
Content-Disposition: inline
In-Reply-To: <20091104071053.GB24263@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132050>

On Wed, Nov 04, 2009 at 02:10:54AM -0500, Jeff King wrote:

> Subject: [PATCH] format-patch: make "-p" suppress diffstat

Ugh. And here is one that actually compiles. Yes, I actually did test
it, but the one-line typo was sitting uncommitted in my workdir.

-- >8 --
Subject: [PATCH] format-patch: make "-p" suppress diffstat

Once upon a time, format-patch would use its default stat
plus patch format only when no diff format was given on the
command line. This meant that "format-patch -p" would
suppress the stat and show just the patch.

Commit 68daa64 changed this to keep the stat format when we
had an "implicit" patch format, like "-U5". As a side
effect, this meant that an explicit patch format was now
ignored (because cmd_format_patch didn't know the reason
that the format was set way down in diff_opt_parse).

This patch unbreaks what 68daa64 did (while still preserving
what 68daa64 was trying to do), reinstating "-p" to suppress
the default behavior. We do this by parsing "-p" ourselves
in format-patch, and noting whether it was used explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-log.c           |    9 +++++++--
 t/t4014-format-patch.sh |   21 +++++++++++++++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 207a361..0ff032b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -891,6 +891,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct patch_ids ids;
 	char *add_signoff = NULL;
 	struct strbuf buf = STRBUF_INIT;
+	int use_patch_format = 0;
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    "use [PATCH n/m] even with a single patch",
@@ -940,6 +941,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
 			    "enable message threading, styles: shallow, deep",
 			    PARSE_OPT_OPTARG, thread_callback },
+		OPT_BOOLEAN('p', NULL, &use_patch_format,
+			"show patch format instead of default (patch + stat)"),
 		OPT_END()
 	};
 
@@ -1027,8 +1030,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
-	if (!rev.diffopt.output_format
-		|| rev.diffopt.output_format == DIFF_FORMAT_PATCH)
+	if (use_patch_format)
+		rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+	else if (!rev.diffopt.output_format ||
+		  rev.diffopt.output_format == DIFF_FORMAT_PATCH)
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
 
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 531f5b7..cab6ce2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -455,6 +455,27 @@ test_expect_success 'format-patch respects -U' '
 
 '
 
+cat > expect << EOF
+
+diff --git a/file b/file
+index 40f36c6..2dc5c23 100644
+--- a/file
++++ b/file
+@@ -14,3 +14,19 @@ C
+ D
+ E
+ F
++5
+EOF
+
+test_expect_success 'format-patch -p suppresses stat' '
+
+	git format-patch -p -2 &&
+	sed -e "1,/^$/d" -e "/^+5/q" < 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	test_cmp expect output
+
+'
+
 test_expect_success 'format-patch from a subdirectory (1)' '
 	filename=$(
 		rm -rf sub &&
-- 
1.6.5.2.308.g2bb5
