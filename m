From: Jeff King <peff@peff.net>
Subject: Re: fetch refspec foo/* matches foo*
Date: Sat, 26 Jul 2008 04:33:57 -0400
Message-ID: <20080726083356.GB10104@sigill.intra.peff.net>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com> <20080725204051.GB23202@spearce.org> <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org> <20080726082405.GA10104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 10:35:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMfEz-0001Ns-IE
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 10:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbYGZIeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 04:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYGZIeB
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 04:34:01 -0400
Received: from peff.net ([208.65.91.99]:4091 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbYGZIeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 04:34:00 -0400
Received: (qmail 8485 invoked by uid 111); 26 Jul 2008 08:33:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 26 Jul 2008 04:33:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jul 2008 04:33:57 -0400
Content-Disposition: inline
In-Reply-To: <20080726082405.GA10104@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90201>

On Sat, Jul 26, 2008 at 04:24:05AM -0400, Jeff King wrote:

> > If not, I think I probably need to take a look at this, reproducing and
> > possibly fixing, before applying non-fix patches.
> 
> I have been meaning to look at it for days, so I finally took a peek.  I
> was able to reproduce the problem easily. I think it is (almost) as
> simple as the patch below. In the refspec parsing, we already require
> globs to come after '/', so this is the analagous check during match.

Also, while I have your attention, Junio, here is another bug fix
that should go into 1.6.0. I posted the patch as a "how about this" deep
in a thread and got no response (which means no complaints, right?).

-- >8 --
init: handle empty "template" parameter

If a user passes "--template=", then our template parameter
is blank. Unfortunately, copy_templates() assumes it has at
least one character, and does all sorts of bad things like
reading from template[-1] and then proceeding to link all of
'/' into the .git directory.

This patch just checks for that condition in copy_templates
and aborts. As a side effect, this means that --template=
now has the meaning "don't copy any templates."
---
I don't really care about the "side effect" behavior, but it seems
reasonable. The other obvious option is to simply die(). Certainly
either is better than the current bug.

 builtin-init-db.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 38b4fcb..baf0d09 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -117,6 +117,8 @@ static void copy_templates(const char *template_dir)
 		template_dir = getenv(TEMPLATE_DIR_ENVIRONMENT);
 	if (!template_dir)
 		template_dir = system_path(DEFAULT_GIT_TEMPLATE_DIR);
+	if (!template_dir[0])
+		return;
 	strcpy(template_path, template_dir);
 	template_len = strlen(template_path);
 	if (template_path[template_len-1] != '/') {
-- 
1.6.0.rc0.233.gb3fd2
