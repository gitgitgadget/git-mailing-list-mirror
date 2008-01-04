From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 4 Jan 2008 04:45:31 -0500
Message-ID: <20080104094531.GA30122@coredump.intra.peff.net>
References: <20080104081429.GA30635@coredump.intra.peff.net> <7vabnmm1ww.fsf@gitster.siamese.dyndns.org> <20080104083252.GB3300@coredump.intra.peff.net> <7vsl1ekmg5.fsf@gitster.siamese.dyndns.org> <20080104085934.GA3706@coredump.intra.peff.net> <20080104092505.GA2320@coredump.intra.peff.net> <7vodc2kk2d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 10:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAj7p-000122-5B
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753433AbYADJpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 04:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYADJpe
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 04:45:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2537 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752804AbYADJpe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 04:45:34 -0500
Received: (qmail 16416 invoked by uid 111); 4 Jan 2008 09:45:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 04 Jan 2008 04:45:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Jan 2008 04:45:31 -0500
Content-Disposition: inline
In-Reply-To: <7vodc2kk2d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69574>

On Fri, Jan 04, 2008 at 01:37:46AM -0800, Junio C Hamano wrote:

> > And it looks like the second call is already OK. We don't try parsing
> > the config to get the external diff command unless ALLOW_EXTERNAL is
> > set, which the plumbing already disallows (though I am still confused
> > why it would need to be loaded lazily in the first place -- I wonder if
> > read_config_if_needed is needed at all).
> 
> I think that was a premature optimization without benching.  It
> is expected that most trees would not have attributes to define
> custom low-level diff types, and without them we do not need to
> parse the configuration to find out the external commands to be
> used.

Ah. But we were parsing them anyway in git_diff_ui_config at the
beginning of the program (and we need to, since you will always have
diff.default.*). So I think this is safe to do, and can replace my other
"only read config once" patch from a few minutes ago:

-- >8 --
diff: remove lazy config loading

There is no point to this. Either:

  1. The program has already loaded git_diff_ui_config, in
     which case this is a noop.
  2. The program didn't, which means it is plumbing that
     does not _want_ git_diff_ui_config to be loaded.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index ecf2fd6..2c78d74 100644
--- a/diff.c
+++ b/diff.c
@@ -59,17 +59,6 @@ static struct ll_diff_driver {
 	char *cmd;
 } *user_diff, **user_diff_tail;
 
-static void read_config_if_needed(void)
-{
-	static int done = 0;
-	if (done)
-		return;
-
-	user_diff_tail = &user_diff;
-	git_config(git_diff_ui_config);
-	done = 1;
-}
-
 /*
  * Currently there is only "diff.<drivername>.command" variable;
  * because there are "diff.color.<slot>" variables, we are parsing
@@ -1825,7 +1814,6 @@ static const char *external_diff_attr(const char *name)
 		    !ATTR_UNSET(value)) {
 			struct ll_diff_driver *drv;
 
-			read_config_if_needed();
 			for (drv = user_diff; drv; drv = drv->next)
 				if (!strcmp(drv->name, value))
 					return drv->cmd;
-- 
1.5.4.rc2.1125.ga305e-dirty
