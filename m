From: Jeff King <peff@peff.net>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Tue, 4 Jun 2013 12:08:15 -0400
Message-ID: <20130604160815.GB15953@sigill.intra.peff.net>
References: <20130604141314.GD22308@pomac.netswarm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Kumlien <pomac@vapor.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 18:08:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjtmZ-0000kF-MO
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 18:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab3FDQIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 12:08:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:42182 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754916Ab3FDQIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 12:08:18 -0400
Received: (qmail 26078 invoked by uid 102); 4 Jun 2013 16:09:04 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 11:09:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 12:08:15 -0400
Content-Disposition: inline
In-Reply-To: <20130604141314.GD22308@pomac.netswarm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226371>

On Tue, Jun 04, 2013 at 04:13:14PM +0200, Ian Kumlien wrote:

> Due to the earlier problem I upgraded git on all machines 
> and eneded up with a ubunut machine running in to problems.
> 
> I started getting errors like:
> "fatal: protocol error: bad line length character: fata"
> 
> Which after some head scratching caused me to tell xinetd to directly
> launch git-daemon, eventually it worked fine, but i did get this error
> message:

Looks like your stderr was being redirected to your stdout; this
particular error aside, that is likely to cause weird protocol problems
for any error that git outputs.

> Jun  4 16:12:05 xyz git-daemon[10246]: unable to access
> '/root/.config/git/config': Permission denied
> 
> It's not the first time i've seen it but i've been able to ignore it
> before. This is running as a local user (as in not root) and this user
> shouldn't have access to /root. But i eventually had to do chown o+x
> /root to workaround this error.

The problem is that you have presumably dropped privileges in the daemon
instance, but your $HOME environment variable still points to /root. Git
cannot read all of its config files (nor even find out if they exist),
so it bails rather than continue.

Older versions of git silently ignored errors reading config files, but
it was tightened in v1.8.1.1, as there can be quite serious implications
to failing to read expected config (e.g., imagine transfer.fsckobjects,
or receive.deny* is ignored).

However, since changing user id and leaving $HOME is so common, there is
a patch under consideration to loosen the check only for the case of
EACCES on files in $HOME. That commit is 4698c8f (config: allow
inaccessible configuration under $HOME, 2013-04-12); it's not yet in any
released version of git, though.

In the meantime, the suggested workaround is to set $HOME for the
git-daemon user, rather than loosening /root.

-Peff
