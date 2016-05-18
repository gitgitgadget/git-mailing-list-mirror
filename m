From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] cat-file: default to --buffer when --batch-all-objects
 is used
Date: Wed, 18 May 2016 12:56:14 -0400
Message-ID: <20160518165613.GB5607@sigill.intra.peff.net>
References: <20160518165411.GA5563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 18:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34lh-0006BE-06
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752772AbcERQ4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:56:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:41328 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751992AbcERQ4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:56:16 -0400
Received: (qmail 12107 invoked by uid 102); 18 May 2016 16:56:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:56:16 -0400
Received: (qmail 24325 invoked by uid 107); 18 May 2016 16:56:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:56:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 12:56:14 -0400
Content-Disposition: inline
In-Reply-To: <20160518165411.GA5563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294978>

Traditionally cat-file's batch-mode does not do any output
buffering. The reason is that a caller may have pipes
connected to its input and output, and would want to use
cat-file interactively, getting output immediately for each
input it sends.

This may involve a lot of small write() calls, which can be
slow. So we introduced --buffer to improve this, but we
can't turn it on by default, as it would break the
interactive case above.

However, when --batch-all-objects is used, we do not read
stdin at all. We generate the output ourselves as quickly as
possible, and then exit. In this case buffering is a strict
win, and it is simply a hassle for the user to have to
remember to specify --buffer.

This patch makes --buffer the default when --batch-all-objects
is used. Specifying "--buffer" manually is still OK, and you
can even override it with "--no-buffer" if you're a
masochist (or debugging).

For some real numbers, running:

  git cat-file --batch-all-objects --batch-check='%(objectname)'

on torvalds/linux goes from:

  real    0m1.464s
  user    0m1.208s
  sys     0m0.252s

to:

  real    0m1.230s
  user    0m1.172s
  sys     0m0.056s

for a 16% speedup.

Suggested-by: Charles Bailey <charles@hashpling.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5d3180e..618103f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -504,6 +504,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 
 	git_config(git_cat_file_config, NULL);
 
+	batch.buffer_output = -1;
 	argc = parse_options(argc, argv, prefix, options, cat_file_usage, 0);
 
 	if (opt) {
@@ -527,6 +528,9 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		usage_with_options(cat_file_usage, options);
 	}
 
+	if (batch.buffer_output < 0)
+		batch.buffer_output = batch.all_objects;
+
 	if (batch.enabled)
 		return batch_objects(&batch);
 
-- 
2.8.2.888.gecb1fe3
