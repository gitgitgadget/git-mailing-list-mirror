From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] status -s: obey color.status
Date: Mon, 7 Dec 2009 00:26:25 -0500
Message-ID: <20091207052625.GB17521@coredump.intra.peff.net>
References: <cover.1260025135.git.git@drmicha.warpmail.net>
 <2b987524f57a0ac04e219f82e20e806741ce4eca.1260025135.git.git@drmicha.warpmail.net>
 <20091207051715.GA17521@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 06:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHW7F-0004Kk-2f
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 06:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbZLGF0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 00:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbZLGF0V
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 00:26:21 -0500
Received: from peff.net ([208.65.91.99]:51976 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbZLGF0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 00:26:20 -0500
Received: (qmail 734 invoked by uid 107); 7 Dec 2009 05:30:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Dec 2009 00:30:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2009 00:26:25 -0500
Content-Disposition: inline
In-Reply-To: <20091207051715.GA17521@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134712>

On Mon, Dec 07, 2009 at 12:17:15AM -0500, Jeff King wrote:

> This seems to also turn on color for --porcelain in some cases, because
> git_status_config unconditionally sets s->use_color if you are using
> color.status instead of color.ui. I think we are probably best just
> explicitly disabling options for the "porcelain" format rather than
> trying to come up with some trickery to make sure they never get set.

Also, this means we can hoist repeated code out of the switch statement,
like this:

-- >8 --
Subject: [PATCH] status: reduce duplicated setup code

We have three output formats: short, porcelain, and long.
The short and long formats respect user-config, and the
porcelain one does not. This led to us repeating
config-related setup code for the short and long formats.

Since the last commit, color config is explicitly cleared
when showing the porcelain format. Let's do the same with
relative-path configuration, which enables us to hoist the
duplicated code from the switch statement in cmd_status.

As a bonus, this fixes "commit --dry-run --porcelain", which
was unconditionally setting up that configuration, anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-commit.c |   19 +++++++------------
 wt-status.c      |    2 ++
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 88b25aa..a11e585 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1018,14 +1018,15 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;
 	wt_status_collect(&s);
 
+	if (s.relative_paths)
+		s.prefix = prefix;
+	if (s.use_color == -1)
+		s.use_color = git_use_color_default;
+	if (diff_use_color_default == -1)
+		diff_use_color_default = git_use_color_default;
+
 	switch (status_format) {
 	case STATUS_FORMAT_SHORT:
-		if (s.relative_paths)
-			s.prefix = prefix;
-		if (s.use_color == -1)
-			s.use_color = git_use_color_default;
-		if (diff_use_color_default == -1)
-			diff_use_color_default = git_use_color_default;
 		wt_shortstatus_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
@@ -1033,12 +1034,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
-		if (s.relative_paths)
-			s.prefix = prefix;
-		if (s.use_color == -1)
-			s.use_color = git_use_color_default;
-		if (diff_use_color_default == -1)
-			diff_use_color_default = git_use_color_default;
 		wt_status_print(&s);
 		break;
 	}
diff --git a/wt-status.c b/wt-status.c
index e9bbfbc..55b6696 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -700,5 +700,7 @@ void wt_shortstatus_print(struct wt_status *s, int null_termination)
 void wt_porcelain_print(struct wt_status *s, int null_termination)
 {
 	s->use_color = 0;
+	s->relative_paths = 0;
+	s->prefix = NULL;
 	wt_shortstatus_print(s, null_termination);
 }
-- 
1.6.6.rc1.292.gd8fe.dirty
