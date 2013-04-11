From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 13:24:25 -0400
Message-ID: <20130411172424.GC1255@sigill.intra.peff.net>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
 <20130411054207.GE27795@sigill.intra.peff.net>
 <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <bitbucket@online.de>,
	"W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 19:24:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQLEj-0007b7-EP
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 19:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933793Ab3DKRYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 13:24:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40711 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765107Ab3DKRYc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 13:24:32 -0400
Received: (qmail 17080 invoked by uid 107); 11 Apr 2013 17:26:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 13:26:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 13:24:25 -0400
Content-Disposition: inline
In-Reply-To: <7vwqs9jd0t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220896>

On Thu, Apr 11, 2013 at 08:35:46AM -0700, Junio C Hamano wrote:

> > Yeah, I think the bug here is that git-daemon should be setting $HOME
> > when it switches privileges with --user. Does this patch fix it for you?
> [...]
> Yeah, that sounds like the obvious fix to me.

Here it is with a commit message.

-- >8 --
Subject: [PATCH] daemon: set HOME when we switch to --user

If git-daemon is invoked with the "--user foo" option, we
setuid and setgid to the "foo" user. However, we do not
currently touch $HOME or any other environment variables.

This means that a git-daemon (and its git subprocesses)
invoked as root will look at ~root/.gitconfig,
~root/.config/git, etc. This is probably not what the admin
expected; it would make more sense to load user-wide config
from ~foo.

Traditionally this wasn't that big a deal, as most sites do
not put config in either homedir (they would use the
system-wide /etc/gitconfig if they wanted global config).
However, since 96b9e0e (config: treat user and xdg config
permission problems as errors, 2012-10-13), it is now an
error to try to read from an inaccessible config file (which
a file in ~root is very likely to be), meaning that
git-daemon will not run at all in such a case.

We can fix this by setting HOME appropriately when we switch
users. Note that this is a regression for any site that uses
--user but depends on putting config in the $HOME of the
user invoking git-daemon. Since the original behavior was
never documented, and the new behavior is much more
sensible, we can consider this a bugfix.

Reported-by: Mike Galbraith <bitbucket@online.de>
Signed-off-by: Jeff King <peff@peff.net>
---
I don't have any problem calling this a bugfix and claiming that anyone
who was depending on the original behavior is stupid and wrong. But it
should probably get a prominent slot in the ReleaseNotes.

 daemon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/daemon.c b/daemon.c
index 6aeddcb..a4451fd 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1091,6 +1091,7 @@ static void drop_privileges(struct credentials *cred)
 	if (cred && (initgroups(cred->pass->pw_name, cred->gid) ||
 	    setgid (cred->gid) || setuid(cred->pass->pw_uid)))
 		die("cannot drop privileges");
+	setenv("HOME", cred->pass->pw_dir, 1);
 }
 
 static struct credentials *prepare_credentials(const char *user_name,
-- 
1.8.2.rc0.33.gd915649
