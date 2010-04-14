From: Jeff King <peff@peff.net>
Subject: Re: TODO: git should be able to init a remote repo
Date: Wed, 14 Apr 2010 05:40:49 -0400
Message-ID: <20100414094048.GA19344@coredump.intra.peff.net>
References: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 11:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1z66-0007Sj-SP
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 11:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab0DNJlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 05:41:21 -0400
Received: from peff.net ([208.65.91.99]:51088 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564Ab0DNJlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 05:41:20 -0400
Received: (qmail 23660 invoked by uid 107); 14 Apr 2010 09:41:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 14 Apr 2010 05:41:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Apr 2010 05:40:49 -0400
Content-Disposition: inline
In-Reply-To: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144861>

On Tue, Apr 13, 2010 at 01:30:44PM -0400, Jay Soffian wrote:

> $ ssh remote git init --bare myproject.git
> $ git remote add -m master origin remote:myproject.git
> $ git push -u origin master
> 
> But we can do better. I was thinking something like:
> 
> $ git remote init [--push] [--mirror] <name> <ssh_url>

I just reviewed the giant thread from last time this came up:

  http://thread.gmane.org/gmane.comp.version-control.git/111799

A few things I noticed were:

  1. People seemed to want "git push --create". I think integrating it
     with git-remote would be more convenient for most of my use cases,
     but I can also see people wanting a one-off push-create without
     worrying about configured remotes (e.g., because it is just a drop
     point that they are going to delete later). So any code could
     hopefully be used for both cases.

  2. We talked about an "init-serve" program back then. These days, "git
     init $dir" works, so I don't see the need for one. There was some
     concern about having administrators turn this feature on
     explicitly, in case their site needs extra configuration. Thinking
     on it more, I don't know that we need to do anything special there.

     If a user has shell access, then there is no point in protecting the
     site from them. They can already log in and run "git init". For
     restricted users running "git shell", running "git init" is already
     disallowed. We could add an option to enable it (defaulting to
     off), and optionally translate "git init" invocations to something
     else (so a site with special needs could intercept "git init" to
     run their own script which would do whatever site-specific things
     they wanted, as long as a repo existed in the end).

     Similarly, git-daemon and smart http could probably support the
     same thing, defaulting to off.

     So while it looks ssh-specific, I suspect it could actually be
     transport-agnostic. It's just that most transports wouldn't have it
     turned on by default.

Two questions/reservations looking at your prototype:

  1. Should it push just master, or perhaps --all? Should it actually be
     two separate options to "git remote add" (--push and --init?).

  2. The "git init $dir" syntax is what makes it reasonably transport
     agnostic. But that syntax was not introduced until 1.6.5, so you
     will run into problems with remotes running older versions of git.
     I think it is OK to say that this feature is not supported on older
     versions (otherwise we _must_ be ssh-specific), but I'm not sure
     how graceful the failure will be.

-Peff
