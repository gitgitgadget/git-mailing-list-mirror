From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 1/2] update-index: add --clear option
Date: Mon, 16 Apr 2012 12:02:32 -0400
Message-ID: <20120416160232.GA1350@sigill.intra.peff.net>
References: <20120416152737.GB14724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christopher Tiwald <christiwald@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:02:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoO8-0005sm-7A
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab2DPQCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:02:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36321
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890Ab2DPQCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:02:36 -0400
Received: (qmail 25304 invoked by uid 107); 16 Apr 2012 16:02:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 12:02:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 12:02:32 -0400
Content-Disposition: inline
In-Reply-To: <20120416152737.GB14724@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195654>

This just discards existing entries from the index, which
can be useful if you are rewriting all entries with
"--index-info" or similar.

Signed-off-by: Jeff King <peff@peff.net>
---
I tried to make something like:

  git update-index --from-scratch --index-info

work by avoiding reading all entries in the first place. However,
update-index actually processes its arguments sequentially, so we _must_
read the index before we start processing arguments. But because it's
sequential, a "clear" operation makes sense, since you clear, then add
new entries.

 Documentation/git-update-index.txt |    3 +++
 builtin/update-index.c             |   10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index a3081f4..47f0ae6 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -71,6 +71,9 @@ OPTIONS
 --cacheinfo <mode> <object> <path>::
 	Directly insert the specified info into the index.
 
+--clear::
+	Discard all existing entries from the index.
+
 --index-info::
         Read index information from stdin.
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6a23fa..559dfae 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -645,6 +645,13 @@ static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
+static int clear_callback(const struct option *opt,
+			  const char *arg, int unset)
+{
+	discard_cache();
+	return 0;
+}
+
 static int stdin_cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 			      const struct option *opt, int unset)
 {
@@ -774,6 +781,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			"add entries from standard input to the index",
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			(parse_opt_cb *) stdin_cacheinfo_callback},
+		{OPTION_CALLBACK, 0, "clear", NULL, NULL,
+			"drop all index entries", PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			clear_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 0, "unresolve", &has_errors, NULL,
 			"repopulate stages #2 and #3 for the listed paths",
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-- 
1.7.9.6.8.g992e5
