From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: load funcname patterns in "basic" config
Date: Fri, 4 Jan 2008 04:19:16 -0500
Message-ID: <20080104091916.GA7569@coredump.intra.peff.net>
References: <20080104091613.GA7535@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 10:19:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAiiO-0002F2-Dt
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbYADJTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 04:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754613AbYADJTS
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 04:19:18 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2790 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090AbYADJTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 04:19:18 -0500
Received: (qmail 16242 invoked by uid 111); 4 Jan 2008 09:19:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 04:19:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 04:19:16 -0500
Content-Disposition: inline
In-Reply-To: <20080104091613.GA7535@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69571>

On Fri, Jan 04, 2008 at 04:16:14AM -0500, Jeff King wrote:

> --- a/diff.c
> +++ b/diff.c
> @@ -179,8 +179,6 @@ #include "run-command.h"

Heh, I had a goofy diff.default.funcname option set up to test this out.
A slightly more readable version of the patch is below.

-- >8 --
diff: load funcname patterns in "basic" config

The funcname patterns influence the "comment" on @@ lines of
the diff. They are safe to use with plumbing since they
don't fundamentally change the meaning of the diff in any
way.

Since all diff users call either diff_ui_config or
diff_basic_config, we can get rid of the lazy reading of the
config.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 6bb0f62..1ea10c8 100644
--- a/diff.c
+++ b/diff.c
@@ -179,8 +179,6 @@ int git_diff_ui_config(const char *var, const char *value)
 		if (ep != var + 4) {
 			if (!strcmp(ep, ".command"))
 				return parse_lldiff_command(var, ep, value);
-			if (!strcmp(ep, ".funcname"))
-				return parse_funcname_pattern(var, ep, value);
 		}
 	}
 
@@ -195,6 +193,14 @@ int git_diff_basic_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!prefixcmp(var, "diff.")) {
+		const char *ep = strrchr(var, '.');
+		if (ep != var + 4) {
+			if (!strcmp(ep, ".funcname"))
+				return parse_funcname_pattern(var, ep, value);
+		}
+	}
+
 	return git_default_config(var, value);
 }
 
@@ -1165,7 +1171,6 @@ static const char *funcname_pattern(const char *ident)
 {
 	struct funcname_pattern *pp;
 
-	read_config_if_needed();
 	for (pp = funcname_pattern_list; pp; pp = pp->next)
 		if (!strcmp(ident, pp->name))
 			return pp->pattern;
-- 
1.5.4.rc2.1124.g7c85e-dirty
