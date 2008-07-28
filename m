From: Jeff King <peff@peff.net>
Subject: Re: Git's config core.pager doesn't respect color.pager
Date: Mon, 28 Jul 2008 03:25:02 -0400
Message-ID: <20080728072502.GA13040@sigill.intra.peff.net>
References: <d129c0140807221910j37f40e72se9f411d6424077de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Benjamin Kudria <ben@kudria.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 09:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNN7O-0006wl-AP
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 09:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYG1HZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 03:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYG1HZG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 03:25:06 -0400
Received: from peff.net ([208.65.91.99]:4039 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbYG1HZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 03:25:04 -0400
Received: (qmail 30066 invoked by uid 111); 28 Jul 2008 07:25:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 28 Jul 2008 03:25:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jul 2008 03:25:02 -0400
Content-Disposition: inline
In-Reply-To: <d129c0140807221910j37f40e72se9f411d6424077de@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90427>

On Tue, Jul 22, 2008 at 10:10:17PM -0400, Benjamin Kudria wrote:

> [core]
> 	pager = tig
> 
> [color]
> 	diff = auto
> 	pager = false
[...]
> So, with the above config, when I do:
> 
> git diff | tig
> 
> Everything works correctly - git sends no color codes, because of
> color.pager = false.

Actually, it works because of color.diff = auto. Stdout is not a tty,
therefore color does not kick in. The point of color.pager is to say
"since git started a pager on behalf of the user, the tty test is
pointless. What we really want to know is whether the pager can handle
colors."

> However, if I do just:
> 
> git diff
> 
> git uses core.pager to display the output, but still sends color
> codes, which is OK for, say, less, bit not so good for tig, which does
> it's own colorizing, and displays the color codes git sends as-is.

And this is a bug, but one that only affects "diff". It's an ordering
problem in looking at the config and starting the pager (diff is unlike
most other commands in that we cannot decide immediately if we want the
pager, in the case that --exit-code is used). So we make the color
decision before we have started the pager.

Unfortunately, it is not quite as simple as just flipping the order.
Starting the pager depends on knowing that we are using --exit-code,
which depends on doing the diff options parsing and setup, which depends
on reading the config, which then depends on the pager setup.

The patch below should fix it, but it really leaves a bad taste in my
mouth. However, breaking the dependency chain would require some pretty
major surgery, I think. It is a little worrisome to me that
git_config_colorbool depends on the value of pager_use_color, another
config variable, at all; that means that ordering in the config file
could change the outcome. It happens to work because we read the config
several times, and we pick up pager.color on a previous read. I think
the "right" solution would be refactoring the color stuff to make the
decision closer to the point of use. But that is definitely not -rc
material, so perhaps this should go in, ugly as it is.

---
 builtin-diff.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin-diff.c b/builtin-diff.c
index 7ffea97..564984e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -301,6 +301,21 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	/*
+	 * Special case: we have already examined the config for
+	 * color, but we didn't know at that point whether we were
+	 * going to start a pager. The only case that we care about is
+	 * when we turned on color, but shouldn't have (we will never
+	 * "should have but didn't" because of the pager, since
+	 * a lack of a pager implies either the tty is stdout, in
+	 * which case we do turn on color, or it is not, in which
+	 * case we don't start a pager).
+	 */
+	if (DIFF_OPT_TST(&rev.diffopt, COLOR_DIFF) &&
+	    pager_in_use() &&
+	    !pager_use_color)
+		DIFF_OPT_CLR(&rev.diffopt, COLOR_DIFF);
+
+	/*
 	 * Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
-- 
1.6.0.rc1.155.gd3310.dirty
