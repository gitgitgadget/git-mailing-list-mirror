From: Jeff King <peff@peff.net>
Subject: Re: feature request - have git honor nested .gitconfig files
Date: Sat, 23 Mar 2013 04:06:38 -0400
Message-ID: <20130323080638.GB29768@sigill.intra.peff.net>
References: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
 <20130322182211.GD12223@google.com>
 <20130322183306.GA32448@sigill.intra.peff.net>
 <878v5ezlo1.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Josh Sharpe <josh.m.sharpe@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 23 09:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJJTz-0004Yf-FW
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 09:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab3CWIGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 04:06:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36646 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab3CWIGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 04:06:47 -0400
Received: (qmail 8735 invoked by uid 107); 23 Mar 2013 08:08:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Mar 2013 04:08:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Mar 2013 04:06:38 -0400
Content-Disposition: inline
In-Reply-To: <878v5ezlo1.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218897>

On Sat, Mar 23, 2013 at 07:15:42AM +0100, Thomas Rast wrote:

> > It involves a shell invocation, but it's not like we parse config in a
> > tight loop. Bonus points if git provides the name of the current config
> > file, so exec can use relative paths like:
> 
> We do, however, parse config more than once:
> 
>   $ strace git log -1 2>&1 | grep 'open.*config'
>   open("/home/thomas/.gitconfig", O_RDONLY) = 3
>   open(".git/config", O_RDONLY)           = 3
>   open("/home/thomas/.gitconfig", O_RDONLY) = 3
>   open(".git/config", O_RDONLY)           = 3
>   open("/home/thomas/.gitconfig", O_RDONLY) = 3
>   open(".git/config", O_RDONLY)           = 3
>   open("/home/thomas/.gitconfig", O_RDONLY) = 3
>   open(".git/config", O_RDONLY)           = 3
> 
> git-log might be somewhat of an extreme example, but I suspect it's at
> least twice for all commands (once for repo detection and once for
> actual parsing).  So I further suspect that the slowdown in git's own
> shellscripts (rebase) would be quite large if you actually spawned two
> extra shells every time someone says 'git rev-parse ...'.

Yeah, I knew we parsed multiple times in some cases, but I don't think
it's that big a deal for a single command. But yeah, it might be
noticeable for a shell script which runs lots of git commands. Still, it
would only affect people who used the feature. And there is no reason
the config system could not learn to cache the results across a single
invocation, which would at least drop it to one shell per git command.

-Peff
