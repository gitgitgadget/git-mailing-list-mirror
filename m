From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] status -s: obey color.status
Date: Mon, 7 Dec 2009 00:17:15 -0500
Message-ID: <20091207051715.GA17521@coredump.intra.peff.net>
References: <cover.1260025135.git.git@drmicha.warpmail.net>
 <2b987524f57a0ac04e219f82e20e806741ce4eca.1260025135.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 06:17:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHVyZ-00028B-GV
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 06:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbZLGFRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 00:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbZLGFRM
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 00:17:12 -0500
Received: from peff.net ([208.65.91.99]:40292 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921AbZLGFRL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 00:17:11 -0500
Received: (qmail 696 invoked by uid 107); 7 Dec 2009 05:21:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 07 Dec 2009 00:21:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Dec 2009 00:17:15 -0500
Content-Disposition: inline
In-Reply-To: <2b987524f57a0ac04e219f82e20e806741ce4eca.1260025135.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134711>

On Sat, Dec 05, 2009 at 04:04:38PM +0100, Michael J Gruber wrote:

> Make the short version of status obey the color.status boolean. We color
> the status letters only, because they carry the state information and are
> potentially colored differently, such as for a file with staged changes
> as well as changes in the worktree against the index.

This seems to also turn on color for --porcelain in some cases, because
git_status_config unconditionally sets s->use_color if you are using
color.status instead of color.ui. I think we are probably best just
explicitly disabling options for the "porcelain" format rather than
trying to come up with some trickery to make sure they never get set.
Like:

-- >8 --
Subject: [PATCH] status: disable color for porcelain format

The porcelain format is identical to the shortstatus format,
except that it should not respect any user configuration,
including color.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-commit.c |    4 ++--
 wt-status.c      |    6 ++++++
 wt-status.h      |    1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index ddcfffb..88b25aa 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -388,7 +388,7 @@ static int run_status(FILE *fp, const char *index_file, const char *prefix, int
 		wt_shortstatus_print(s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_shortstatus_print(s, null_termination);
+		wt_porcelain_print(s, null_termination);
 		break;
 	case STATUS_FORMAT_LONG:
 		wt_status_print(s);
@@ -1029,7 +1029,7 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		wt_shortstatus_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_PORCELAIN:
-		wt_shortstatus_print(&s, null_termination);
+		wt_porcelain_print(&s, null_termination);
 		break;
 	case STATUS_FORMAT_LONG:
 		s.verbose = verbose;
diff --git a/wt-status.c b/wt-status.c
index a8b6d05..e9bbfbc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -696,3 +696,9 @@ void wt_shortstatus_print(struct wt_status *s, int null_termination)
 		wt_shortstatus_untracked(null_termination, it, s);
 	}
 }
+
+void wt_porcelain_print(struct wt_status *s, int null_termination)
+{
+	s->use_color = 0;
+	wt_shortstatus_print(s, null_termination);
+}
diff --git a/wt-status.h b/wt-status.h
index 39c9aef..a4bddcf 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -57,5 +57,6 @@ void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
 
 void wt_shortstatus_print(struct wt_status *s, int null_termination);
+void wt_porcelain_print(struct wt_status *s, int null_termination);
 
 #endif /* STATUS_H */
-- 
1.6.6.rc1.292.gd8fe.dirty
