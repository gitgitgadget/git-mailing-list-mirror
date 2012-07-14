From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: default in-progress color to header color
Date: Sat, 14 Jul 2012 08:36:38 -0400
Message-ID: <20120714123638.GA10431@sigill.intra.peff.net>
References: <20120714122828.GA6259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 14:36:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq1aZ-0005Wb-Ih
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 14:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320Ab2GNMgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 08:36:42 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:59492
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313Ab2GNMgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 08:36:42 -0400
Received: (qmail 12804 invoked by uid 107); 14 Jul 2012 12:36:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Jul 2012 08:36:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jul 2012 08:36:38 -0400
Content-Disposition: inline
In-Reply-To: <20120714122828.GA6259@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201441>

On Sat, Jul 14, 2012 at 08:28:28AM -0400, Jeff King wrote:

> My intent was that this would also let "color.status.inprogress"
> override it, in case a user really wanted a green message or something.
> However, I notice that the original series did not add such a config
> option, so this color cannot be configured at all. Furthermore, I think
> the color formatting for this message is somewhat buggy.  Even if we set
> it to green, you would end up with (imagine our header color is blue):
> 
>   <blue># On branch master<reset>
>   <green># You are in the middle of a rebase.<reset>
> 
> when what you would probably want is:
> 
>   <blue># On branch master<reset>
>   <blue># <reset><green>You are in the middle of a rebase.<reset>
> 
> I.e., the "#" bit should always be in the header color, and only the
> message text should change colors. This is how the "onbranch" message is
> handled.
> 
> But given that this is not even configurable in the current code, I
> really wonder if it needs to have its own color at all. Do people really
> want to set the color of this message separately? Maybe we should just
> use WT_STATUS_HEADER instead.

And that patch would look like this (directly on top of
lk/more-helpful-status-hints):

-- >8 --
Subject: [PATCH] status: color in-progress message like other header messages

The "status" command recently learned to describe the
in-progress operation in its long output format (e.g.,
rebasing, am, etc). This message gets its own slot in the
color table, even though it is not configurable. As a
result, if the user has set color.status.header to a
non-default value, this message will not match (and cannot
be made to match, as there is no config option).

It is probably more sane to just color it like the rest of
the text (i.e., just use color.status.header). This would
not allow users to customize the color of this message
independently, but it is not likely that anyone will want to
(and they cannot with the current code, anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c | 3 +--
 wt-status.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c749267..c110cbc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -24,7 +24,6 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
-	GIT_COLOR_NORMAL, /* WT_STATUS_IN_PROGRESS */
 };
 
 static const char *color(int slot, struct wt_status *s)
@@ -931,7 +930,7 @@ static void show_bisect_in_progress(struct wt_status *s,
 
 static void wt_status_print_state(struct wt_status *s)
 {
-	const char *state_color = color(WT_STATUS_IN_PROGRESS, s);
+	const char *state_color = color(WT_STATUS_HEADER, s);
 	struct wt_status_state state;
 	struct stat st;
 
diff --git a/wt-status.h b/wt-status.h
index c1066a0..f8fc58c 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -15,7 +15,6 @@ enum color_wt_status {
 	WT_STATUS_LOCAL_BRANCH,
 	WT_STATUS_REMOTE_BRANCH,
 	WT_STATUS_ONBRANCH,
-	WT_STATUS_IN_PROGRESS,
 	WT_STATUS_MAXSLOT
 };
 
-- 
1.7.10.5.40.gbbc17de
