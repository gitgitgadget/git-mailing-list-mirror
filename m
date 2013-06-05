From: Ian Kumlien <pomac@vapor.com>
Subject: Re: git-daemon: needs /root/.config/git/config?
Date: Wed, 5 Jun 2013 13:19:18 +0200
Message-ID: <20130605111918.GE22308@pomac.netswarm.net>
References: <20130604141314.GD22308@pomac.netswarm.net>
 <20130604160815.GB15953@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 05 13:31:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkBwM-0004Ap-GR
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 13:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267Ab3FELbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 07:31:38 -0400
Received: from mail.vapor.com ([83.220.149.2]:40588 "EHLO nitrogen.vapor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754145Ab3FELbh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 07:31:37 -0400
Received: from twilight.demius.net (c-297271d5.013-195-6c756e10.cust.bredbandsbolaget.se [213.113.114.41])
	by nitrogen.vapor.com (Postfix) with ESMTPSA id 55AA629AC27;
	Wed,  5 Jun 2013 13:31:25 +0200 (CEST)
Received: by twilight.demius.net (Postfix, from userid 1000)
	id 10D588E36CB; Wed,  5 Jun 2013 13:19:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130604160815.GB15953@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226446>

On Tue, Jun 04, 2013 at 12:08:15PM -0400, Jeff King wrote:
> On Tue, Jun 04, 2013 at 04:13:14PM +0200, Ian Kumlien wrote:
> 
> > Due to the earlier problem I upgraded git on all machines 
> > and eneded up with a ubunut machine running in to problems.
> > 
> > I started getting errors like:
> > "fatal: protocol error: bad line length character: fata"
> > 
> > Which after some head scratching caused me to tell xinetd to directly
> > launch git-daemon, eventually it worked fine, but i did get this error
> > message:
> 
> Looks like your stderr was being redirected to your stdout; this
> particular error aside, that is likely to cause weird protocol problems
> for any error that git outputs.

Yeah =)

> > Jun  4 16:12:05 xyz git-daemon[10246]: unable to access
> > '/root/.config/git/config': Permission denied
> > 
> > It's not the first time i've seen it but i've been able to ignore it
> > before. This is running as a local user (as in not root) and this user
> > shouldn't have access to /root. But i eventually had to do chown o+x
> > /root to workaround this error.
> 
> The problem is that you have presumably dropped privileges in the daemon
> instance, but your $HOME environment variable still points to /root. Git
> cannot read all of its config files (nor even find out if they exist),
> so it bails rather than continue.

Yeah, assumed =P

> Older versions of git silently ignored errors reading config files, but
> it was tightened in v1.8.1.1, as there can be quite serious implications
> to failing to read expected config (e.g., imagine transfer.fsckobjects,
> or receive.deny* is ignored).

Yes, i agree, it's suboptimal but I for one would use getpwuid to get
the home directory of the executing user to avoid this - though i don't
know how portable it is (or if there is any other issues)

It's a bit hard to control this with xinetd doing it behind the
scenes... 

> However, since changing user id and leaving $HOME is so common, there is
> a patch under consideration to loosen the check only for the case of
> EACCES on files in $HOME. That commit is 4698c8f (config: allow
> inaccessible configuration under $HOME, 2013-04-12); it's not yet in any
> released version of git, though.

Ah, ok, thanks, I'll have a look - maybe i can actually contribute
something for once =)

> In the meantime, the suggested workaround is to set $HOME for the
> git-daemon user, rather than loosening /root.

Well, I have no idea of how to control HOME in xinetd - access to the
machine is limited and x doesn't give that much access (nothing really
important is actually stored in /root)

For now, this is the workaround we have =P

> -Peff
