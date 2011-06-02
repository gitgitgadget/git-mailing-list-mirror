From: Jeff King <peff@peff.net>
Subject: Re: git status --ignored
Date: Thu, 2 Jun 2011 01:54:49 -0400
Message-ID: <20110602055449.GA28292@sigill.intra.peff.net>
References: <4DE712CE.20509@vpac.org>
 <7vr57cerxo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Spiers <aspiers@vpac.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 07:54:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS0rx-0007Pw-JU
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 07:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753767Ab1FBFyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 01:54:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36689
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab1FBFyw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 01:54:52 -0400
Received: (qmail 25252 invoked by uid 107); 2 Jun 2011 05:54:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 01:54:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 01:54:49 -0400
Content-Disposition: inline
In-Reply-To: <7vr57cerxo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174929>

On Wed, Jun 01, 2011 at 10:13:55PM -0700, Junio C Hamano wrote:

> Andrew Spiers <aspiers@vpac.org> writes:
> 
> > This looks like a bug in git 1.7.4.1.
> >
> > git status --ignored does not show my ignored files and
> > directories. git status -h suggests it should.
> > git status --ignored -h does show my ignored files and directories.
> 
> Does not reproduce for me. With --ignored (with or without -s), I see all
> the dot-o files that are ignored by .gitignore rules that are usually
> omitted from status output without --ignored.
> 
>   $ make >/dev/null 2>&1
>   $ rungit v1.7.3 status | grep -F git.o
>   $ rungit v1.7.3 status --ignored | grep -F git.o
>   #       git.o
>   $ rungit v1.7.3 status -s --ignored | grep -F git.o
>   !! git.o

I can reproduce here. The faulty logic means the bug only shows when you
actually have no real untracked files. You should keep your git
directory cleaner. ;)

-- >8 --
Subject: [PATCH] status: fix bug with missing --ignore files

Commit 1b908b6 (wt-status: rename and restructure
status-print-untracked, 2010-04-10) converted the
wt_status_print_untracked function into
wt_status_print_other, taking a string_list of either
untracked or ignored items to print. However, the "nothing
to show" early return still checked the wt_status->untracked
list instead of the passed-in list.

That meant that if we had ignored items to show, but no
untracked items, we would erroneously exit early and fail to
show the ignored items.

Signed-off-by: Jeff King <peff@peff.net>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 9f4e0ba..0237772 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -642,7 +642,7 @@ static void wt_status_print_other(struct wt_status *s,
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (!s->untracked.nr)
+	if (!l->nr)
 		return;
 
 	wt_status_print_other_header(s, what, how);
-- 
1.7.6.rc0.34.gc8c48c.dirty
