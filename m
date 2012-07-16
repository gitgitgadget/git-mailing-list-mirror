From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: default in-progress color to header color
Date: Mon, 16 Jul 2012 07:39:54 -0400
Message-ID: <20120716113954.GB4962@sigill.intra.peff.net>
References: <20120714122828.GA6259@sigill.intra.peff.net>
 <20120714123638.GA10431@sigill.intra.peff.net>
 <vpq8vek10xa.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 16 13:40:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sqjel-0007Hs-22
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 13:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671Ab2GPLj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 07:39:58 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:33094
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab2GPLj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 07:39:57 -0400
Received: (qmail 27447 invoked by uid 107); 16 Jul 2012 11:39:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jul 2012 07:39:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2012 07:39:54 -0400
Content-Disposition: inline
In-Reply-To: <vpq8vek10xa.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201501>

On Mon, Jul 16, 2012 at 11:59:45AM +0200, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Subject: [PATCH] status: color in-progress message like other header messages
> 
> My feeling is that these "in progress" messages would deserve to be more
> visible than the usual headers (like "Not currently on any branch.",
> which is both legit and likely to be a user-error). For example, the
> other day, the patch told me I was bisecting. I thought it was a bug in
> the patch, but it was indeed a user-error of mine, I did not end this
> bisect session properly around a month ago ;-).
> 
> This would argue in favor of having a different, configurable color.

Sure, I have no problem with that reasoning. Only the half-done
implementation. :)

> But as the code currently does not allow user-configuration anyway, it's
> probably best to make the code clean and uniform. If someone wants to
> add customizability afterwards, it won't be that hard (it's probably a
> good idea to have people leave with these messages for a while before
> deciding what color it should be).
> 
> This second patch looks better to me, but no strong opinion here.

Let's go with the second patch for now, then. It fixes the immediate
problem, and it does not make it much harder for somebody to do a
separate configurable color on top if they want to do so (now or later).
They would have to re-add the slot, but that is the least of the effort
involved; handling the partial-line coloring and the default-to-header
as ONBRANCH does is the more interesting bit, and the current code does
not do that at all.

Here's a repost with a slightly modified commit message (on top of
lk/more-helpful-status-hints, as before).

-- >8 --
Subject: status: color in-progress message like other header messages

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
independently, but they cannot do that with the current code
anyway, and if somebody wants to build customizable
colorization later, this patch does not make it much harder
to do so.

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
