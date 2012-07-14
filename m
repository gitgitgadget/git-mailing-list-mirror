From: Jeff King <peff@peff.net>
Subject: [PATCH] status: default in-progress color to header color
Date: Sat, 14 Jul 2012 08:28:29 -0400
Message-ID: <20120714122828.GA6259@sigill.intra.peff.net>
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
X-From: git-owner@vger.kernel.org Sat Jul 14 14:29:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq1Td-0002hG-UH
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 14:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab2GNM2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 08:28:37 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:59465
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab2GNM2g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 08:28:36 -0400
Received: (qmail 12706 invoked by uid 107); 14 Jul 2012 12:28:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Jul 2012 08:28:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jul 2012 08:28:29 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201440>

The "status" command recently learned to describe the
in-progress operation in its long output format (e.g.,
rebasing, am, etc). The color for this message defaults to
"normal" (i.e., no color). However, if the user has set
their default header color to something besides normal, then
the message sticks out. A much saner default is to pick the
user's header color, making this message match the rest of
the header.

We already do the same trick with the "onbranch" message.
Rather than expand the current conditional to list all types
of messages which will default back to the header color, we
can just default all "nil" colors to do so, simplifying the
code. That encompasses all of the current nil color slots,
and will likely cover any future ones that will be added.

Signed-off-by: Jeff King <peff@peff.net>
---
This goes on top of lk/more-helpful-status-hints.

My intent was that this would also let "color.status.inprogress"
override it, in case a user really wanted a green message or something.
However, I notice that the original series did not add such a config
option, so this color cannot be configured at all. Furthermore, I think
the color formatting for this message is somewhat buggy.  Even if we set
it to green, you would end up with (imagine our header color is blue):

  <blue># On branch master<reset>
  <green># You are in the middle of a rebase.<reset>

when what you would probably want is:

  <blue># On branch master<reset>
  <blue># <reset><green>You are in the middle of a rebase.<reset>

I.e., the "#" bit should always be in the header color, and only the
message text should change colors. This is how the "onbranch" message is
handled.

But given that this is not even configurable in the current code, I
really wonder if it needs to have its own color at all. Do people really
want to set the color of this message separately? Maybe we should just
use WT_STATUS_HEADER instead.

 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c749267..2f724b4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -24,7 +24,7 @@ static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,  /* WT_STATUS_LOCAL_BRANCH */
 	GIT_COLOR_RED,    /* WT_STATUS_REMOTE_BRANCH */
 	GIT_COLOR_NIL,    /* WT_STATUS_ONBRANCH */
-	GIT_COLOR_NORMAL, /* WT_STATUS_IN_PROGRESS */
+	GIT_COLOR_NIL,    /* WT_STATUS_IN_PROGRESS */
 };
 
 static const char *color(int slot, struct wt_status *s)
@@ -32,7 +32,7 @@ static const char *color(int slot, struct wt_status *s)
 	const char *c = "";
 	if (want_color(s->use_color))
 		c = s->color_palette[slot];
-	if (slot == WT_STATUS_ONBRANCH && color_is_nil(c))
+	if (color_is_nil(c))
 		c = s->color_palette[WT_STATUS_HEADER];
 	return c;
 }
-- 
1.7.10.5.40.gbbc17de
