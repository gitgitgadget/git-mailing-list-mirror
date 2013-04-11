From: Jeff King <peff@peff.net>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Thu, 11 Apr 2013 01:42:07 -0400
Message-ID: <20130411054207.GE27795@sigill.intra.peff.net>
References: <1365572015.4658.51.camel@marge.simpson.net>
 <20130410135605.GB4694@odin.tremily.us>
 <1365651583.19620.8.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "W. Trevor King" <wking@tremily.us>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Mike Galbraith <bitbucket@online.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 07:42:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQAHF-0004p2-2R
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 07:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab3DKFmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 01:42:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39751 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752756Ab3DKFmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 01:42:14 -0400
Received: (qmail 12068 invoked by uid 107); 11 Apr 2013 05:44:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 11 Apr 2013 01:44:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Apr 2013 01:42:07 -0400
Content-Disposition: inline
In-Reply-To: <1365651583.19620.8.camel@marge.simpson.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220825>

On Thu, Apr 11, 2013 at 05:39:43AM +0200, Mike Galbraith wrote:

> >   ALLOWED_ENV="PATH HOME"
> >   HOME=/
> 
> I can work around it by changing the init script to use su - git -c "bla
> bla" to launch the thing, instead of using --user=git --group=daemon,
> but that's just a bandaid for the busted environment setup those
> switches were supposed to make happen, no?

Yeah, I think the bug here is that git-daemon should be setting $HOME
when it switches privileges with --user. Does this patch fix it for you?

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

I guess that would technically break anybody who was trying to do
something clever with HOME (i.e., point it somewhere besides --user's
HOME where they had put some config files). But the obvious clever
thing would be to also set the user's passwd homedir to the same place.

-Peff
