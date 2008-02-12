From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git-status shows bad instructions prior to first commit
Date: Tue, 12 Feb 2008 00:45:18 -0500
Message-ID: <20080212054518.GA24817@sigill.intra.peff.net>
References: <F1B5775C-1C11-4C30-B72E-9EB4076613A5@gmail.com> <7vzlu66f5g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Rhodes, Kate" <masukomi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 06:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOnxt-000349-Ag
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 06:45:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbYBLFpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 00:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752814AbYBLFpX
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 00:45:23 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1341 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752811AbYBLFpW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 00:45:22 -0500
Received: (qmail 20824 invoked by uid 111); 12 Feb 2008 05:45:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 12 Feb 2008 00:45:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Feb 2008 00:45:18 -0500
Content-Disposition: inline
In-Reply-To: <7vzlu66f5g.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73627>

On Mon, Feb 11, 2008 at 07:13:15PM -0800, Junio C Hamano wrote:

> "Rhodes, Kate" <masukomi@gmail.com> writes:
> 
> > While we're at it, can someone please explain to me how to remove a
> > file from the index prior to the first commit? I'm stumped.
> 
> rm --cached

And indeed, some clever person already made this distinction in the
git-status output, but it has been broken for a while. I'm not sure this
is worth a test now that it is fixed (but such a test _would_ have
caught this); I can make one if you like.

-- >8 --
status: suggest "git rm --cached" to unstage for initial commit

It makes no sense to suggest "git reset HEAD" since we have
no HEAD commit. This actually used to work but regressed in
f26a0012.

wt_status_print_cached_header was updated to take the whole
wt_status struct rather than just the reference field.
Previously the various code paths were sometimes sending in
s->reference and sometimes sending in NULL, making the
decision on whether this was an initial commit before we
even got to this function. Now we must check the initial
flag here.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 27b946d..b5ae98d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -60,7 +60,7 @@ static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER);
 	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
-	if (s->reference) {
+	if (!s->is_initial) {
 		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
 	} else {
 		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
-- 
1.5.4.1215.gf7da-dirty
