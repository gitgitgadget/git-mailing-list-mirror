From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] diff: allow turning on textconv explicitly for plumbing
Date: Sun, 7 Dec 2008 21:57:01 -0500
Message-ID: <20081208025700.GB22072@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 03:58:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9WKI-0003XE-Tr
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 03:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbYLHC5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 21:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbYLHC5F
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 21:57:05 -0500
Received: from peff.net ([208.65.91.99]:3974 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbYLHC5E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 21:57:04 -0500
Received: (qmail 21421 invoked by uid 111); 8 Dec 2008 02:57:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 07 Dec 2008 21:57:02 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Dec 2008 21:57:01 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102521>

Some history viewers use the diff plumbing to generate diffs
rather than going through the "git diff" porcelain.
Currently, there is no way for them to specify that they
would like to see the text-converted version of the diff.

This patch adds a "--textconv" option to allow such a
plumbing user to allow text conversion.  The user can then
tell the viewer whether or not they would like text
conversion enabled.

While it may be tempting add a configuration option rather
than requiring each plumbing user to be configured to pass
--textconv, that is somewhat dangerous. Text-converted diffs
generally cannot be applied directly, so each plumbing user
should "opt in" to generating such a diff, either by
explicit request of the user or by confirming that their
output will not be fed to patch.

Signed-off-by: Jeff King <peff@peff.net>
---
My ultimate goal is to see these diffs in gitk, which is implemented in
3/3. As a bonus side effect, the --no-textconv option can be used with
"git diff" or "git log" if you really don't want to see them there
(e.g., because you are abusing "git log" to produce a binary patch you
mean to apply).

I know this is not strictly a bugfix and we are in -rc, but:

  1. It is an enhancement to a previously unreleased feature, and
     shouldn't affect anything outside of that.

  2. It affects the scripting interface to textconv, so I would like to
     get it in before textconv is ever released so that it is always the
     "right way" to turn text conversion off or on.

 diff.c |    4 ++++
 diff.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index f644947..e21af3b 100644
--- a/diff.c
+++ b/diff.c
@@ -2477,6 +2477,10 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
 		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
+	else if (!strcmp(arg, "--textconv"))
+		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
+	else if (!strcmp(arg, "--no-textconv"))
+		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules"))
 		DIFF_OPT_SET(options, IGNORE_SUBMODULES);
 
-- 
1.6.1.rc2.285.gc1cf2
